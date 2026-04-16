-- ======================
-- PIXEL PAINTER PRO (V6.0 - GIF & ANIMATION SUPPORT)
-- ======================

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local GRID = 32
local TOTAL = GRID * GRID

-- ⬇⬇⬇ SLOTS (BOT EDITA AQUI) ⬇⬇⬇
local ARTS = {
    {
        name = "Exemplo Base (32x32)",
        playlist = "Todas",
        map = [[Pixel 1 (0,0) = FF0000 | Pixel 2 (1,0) = 00FF00 | Pixel 1024 (31,31) = 0000FF]]
    },
}
-- ⬆⬆⬆ FIM DOS SLOTS ⬆⬆⬆

local PLAYLISTS = {"Todas", "Aleatórias", "NSFW", "Memes", "Players", "GIFs"}

local selectedArt = nil -- Agora guarda o objeto todo da arte
local isPainting = false
local currentPlaylist = "Todas"
local animationActive = false

local remote = game.ReplicatedStorage:FindFirstChild("UpdateBoard") or game.Workspace:FindFirstChild("UpdateBoard", true)

-- ======================
-- UTILITÁRIOS
-- ======================

local function logicalToBoardIndex(pixel)
    local zero = pixel - 1
    local y = math.floor(zero / GRID)
    local x = zero % GRID
    local boardIdx = y * GRID + ((GRID - 1) - x) + 1
    return boardIdx
end

local function getMyBoard()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "1" and obj:IsA("BasePart") and obj.Parent:FindFirstChild(tostring(TOTAL)) then
            return obj.Parent
        end
    end
    return nil
end

local function parseTextToArt(text)
    local art = {}
    if not text then return art end
    for idx, hex in text:gmatch("Pixel%s+(%d+)[^=]*=%s*([A-Fa-f0-9]+)") do
        local n = tonumber(idx)
        if n and n >= 1 and n <= TOTAL then 
            art[n] = hex:upper() 
        end
    end
    return art
end

local function hexToColor3(hex)
    local r = tonumber(hex:sub(1,2),16)
    local g = tonumber(hex:sub(3,4),16)
    local b = tonumber(hex:sub(5,6),16)
    return Color3.fromRGB(r or 255, g or 255, b or 255)
end

-- ======================
-- LÓGICA DE PINTURA E ANIMAÇÃO
-- ======================

local function startPainting(updateBar, setProgress)
    if isPainting or not selectedArt or not remote then return end
    
    isPainting = true
    local board = getMyBoard()
    if not board then 
        setProgress("❌ QUADRO NÃO ENCONTRADO")
        isPainting = false
        return 
    end

    -- MODO GIF
    if selectedArt.isGif then
        animationActive = true
        setProgress("🎬 Rodando Animação...")
        
        while animationActive and selectedArt and selectedArt.isGif do
            for i, frameText in ipairs(selectedArt.frames) do
                if not animationActive then break end
                
                local frameData = parseTextToArt(frameText)
                local packet = {}
                
                for pixId, hex in pairs(frameData) do
                    local bIdx = logicalToBoardIndex(pixId)
                    packet[tostring(bIdx)] = hex
                end
                
                if next(packet) then
                    pcall(function() remote:InvokeServer(packet) end)
                end
                
                -- Se for o primeiro frame, bota um delayzinho pra carregar a base
                if i == 1 then task.wait(0.1) end
                
                task.wait(1 / (selectedArt.fps or 10))
            end
            task.wait(0.01)
        end
    
    -- MODO ESTÁTICO (Smart Paint original)
    else
        local artData = parseTextToArt(selectedArt.map)
        local needUpdate = {}
        
        setProgress("🔍 Escaneando...")
        for i, desiredHex in pairs(artData) do
            local boardIdx = logicalToBoardIndex(i)
            local pixelPart = board:FindFirstChild(tostring(boardIdx))
            if pixelPart and pixelPart:IsA("BasePart") then
                local targetColor = hexToColor3(desiredHex)
                local diff = (pixelPart.Color.R - targetColor.R)^2 + (pixelPart.Color.G - targetColor.G)^2 + (pixelPart.Color.B - targetColor.B)^2
                if diff > 0.001 then
                    table.insert(needUpdate, {id = tostring(boardIdx), color = desiredHex})
                end
            end
        end

        local total = #needUpdate
        if total == 0 then
            setProgress("Arte Feita ✅")
        else
            local packet = {}
            for i, data in ipairs(needUpdate) do
                packet[data.id] = data.color
                if #packet >= 128 or i == total then
                    pcall(function() remote:InvokeServer(packet) end)
                    packet = {}
                    updateBar(i/total)
                    setProgress("Pintando... " .. math.floor((i/total)*100) .. "%")
                    task.wait(0.02)
                end
            end
            setProgress("Arte Feita ✅")
        end
    end
    
    isPainting = false
end

-- ======================
-- INTERFACE
-- ======================
local function createGUI()
    if playerGui:FindFirstChild("PixelPainterHUD") then playerGui.PixelPainterHUD:Destroy() end
    local gui = Instance.new("ScreenGui", playerGui); gui.Name = "PixelPainterHUD"; gui.ResetOnSpawn = false

    local toggle = Instance.new("TextButton", gui)
    toggle.Size = UDim2.new(0, 40, 0, 40); toggle.Position = UDim2.new(1, -50, 0, 20); toggle.Text = "🎨"; toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 40); toggle.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", toggle)

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, 280, 0, 325); main.Position = UDim2.new(1, -10, 0.5, 0); main.AnchorPoint = Vector2.new(1, 0.5); main.BackgroundColor3 = Color3.fromRGB(20, 20, 25); main.Visible = false; Instance.new("UICorner", main)
    toggle.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)

    local artScroll = Instance.new("ScrollingFrame", main)
    artScroll.Size = UDim2.new(0, 120, 0, 200); artScroll.Position = UDim2.new(0, 10, 0, 50); artScroll.BackgroundColor3 = Color3.fromRGB(15, 15, 20); artScroll.ScrollBarThickness = 2; Instance.new("UIListLayout", artScroll).Padding = UDim.new(0, 2)

    local previewHUD = Instance.new("Frame", main)
    previewHUD.Size = UDim2.new(0, 130, 0, 130); previewHUD.Position = UDim2.new(0, 140, 0, 50); previewHUD.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    local previewGrid = Instance.new("UIGridLayout", previewHUD); previewGrid.CellSize = UDim2.new(0, 4, 0, 4); previewGrid.CellPadding = UDim2.new(0, 0, 0, 0)

    local pixels = {}
    for i = 1, TOTAL do
        local p = Instance.new("Frame", previewHUD); p.BorderSizePixel = 0; p.BackgroundColor3 = Color3.fromRGB(40, 40, 40); pixels[i] = p
    end

    local progBg = Instance.new("Frame", main); progBg.Size = UDim2.new(0, 130, 0, 15); progBg.Position = UDim2.new(0, 140, 0, 190); progBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45); Instance.new("UICorner", progBg)
    local progBar = Instance.new("Frame", progBg); progBar.Size = UDim2.new(0, 0, 1, 0); progBar.BackgroundColor3 = Color3.fromRGB(0, 255, 120); Instance.new("UICorner", progBar)
    local progTxt = Instance.new("TextLabel", progBg); progTxt.Size = UDim2.new(1, 0, 1, 0); progTxt.BackgroundTransparency = 1; progTxt.Text = "Aguardando..."; progTxt.TextColor3 = Color3.new(1,1,1); progTxt.TextSize = 11; progTxt.Font = Enum.Font.GothamSemibold

    local startBtn = Instance.new("TextButton", main); startBtn.Size = UDim2.new(0, 130, 0, 35); startBtn.Position = UDim2.new(0, 140, 0, 215); startBtn.Text = "INICIAR"; startBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50); startBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", startBtn)

    local infoLabel = Instance.new("TextLabel", main); infoLabel.Size = UDim2.new(0, 130, 0, 75); infoLabel.Position = UDim2.new(0, 140, 0, 255); infoLabel.BackgroundTransparency = 1; infoLabel.TextColor3 = Color3.new(0.9, 0.9, 0.9); infoLabel.TextSize = 12; infoLabel.Font = Enum.Font.GothamMedium; infoLabel.TextXAlignment = Enum.TextXAlignment.Left; infoLabel.TextYAlignment = Enum.TextYAlignment.Top; infoLabel.TextWrapped = true

    -- Lógica de Preview Animado
    local function runPreviewAnimation()
        task.spawn(function()
            while true do
                if selectedArt and selectedArt.isGif then
                    for _, frameText in ipairs(selectedArt.frames) do
                        if not selectedArt or not selectedArt.isGif then break end
                        local frameData = parseTextToArt(frameText)
                        for pixId, hex in pairs(frameData) do
                            if pixels[pixId] then pixels[pixId].BackgroundColor3 = Color3.fromHex(hex) end
                        end
                        task.wait(1 / (selectedArt.fps or 10))
                    end
                else
                    task.wait(0.5)
                end
            end
        end)
    end

    local function loadArts()
        for _, c in ipairs(artScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
        for _, art in ipairs(ARTS) do
            if currentPlaylist == "Todas" or art.playlist == currentPlaylist then
                local btn = Instance.new("TextButton", artScroll)
                btn.Size = UDim2.new(1, -5, 0, 25); btn.Text = art.name; btn.BackgroundColor3 = Color3.fromRGB(45, 45, 50); btn.TextColor3 = Color3.new(1,1,1); btn.TextSize = 10; Instance.new("UICorner", btn)

                btn.MouseButton1Click:Connect(function()
                    animationActive = false -- Para animação atual se houver
                    selectedArt = art
                    infoLabel.Text = "Nome: " .. art.name .. "\nTipo: " .. (art.isGif and "GIF" or "Estática") .. "\nPlaylist: " .. art.playlist
                    
                    if not art.isGif then
                        -- Preview estático
                        local data = parseTextToArt(art.map)
                        for i = 1, TOTAL do pixels[i].BackgroundColor3 = Color3.fromRGB(40,40,40) end
                        for pixId, hex in pairs(data) do pixels[pixId].BackgroundColor3 = Color3.fromHex(hex) end
                    end
                end)
            end
        end
    end

    -- Playlists
    local plFrame = Instance.new("ScrollingFrame", main); plFrame.Size = UDim2.new(1, -20, 0, 30); plFrame.Position = UDim2.new(0, 10, 0, 10); plFrame.BackgroundTransparency = 1; plFrame.ScrollBarThickness = 0; plFrame.CanvasSize = UDim2.new(2, 0, 0, 0)
    local plLayout = Instance.new("UIListLayout", plFrame); plLayout.FillDirection = Enum.FillDirection.Horizontal; plLayout.Padding = UDim.new(0, 5)

    for _, name in ipairs(PLAYLISTS) do
        local b = Instance.new("TextButton", plFrame); b.Size = UDim2.new(0, 65, 1, 0); b.Text = name; b.TextSize = 9; b.BackgroundColor3 = Color3.fromRGB(45, 45, 50); b.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(function()
            currentPlaylist = name
            loadArts()
        end)
    end

    startBtn.MouseButton1Click:Connect(function()
        startPainting(function(p) progBar.Size = UDim2.new(p,0,1,0) end, function(t) progTxt.Text = t end)
    end)

    loadArts()
    runPreviewAnimation()
end

createGUI()

