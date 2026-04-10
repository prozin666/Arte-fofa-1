-- ======================
-- PIXEL PAINTER CENTRAL (DELTA) - Versão Melhorada
-- GUI mais bonita + Scroll corrigido + Anti-Morte
-- ======================

local player = game.Players.LocalPlayer
local remote = game.ReplicatedStorage:FindFirstChild("UpdateBoard")
    or game.Workspace:FindFirstChild("UpdateBoard", true)

local GRID = 32
local TOTAL = GRID * GRID

-- ======================
-- UTIL: índice lógico -> board (espelho X)
-- ======================
local function logicalToBoardIndex(pixel)
    local zero = pixel - 1
    local y = math.floor(zero / GRID)
    local x = zero % GRID
    local flippedX = (GRID - 1) - x
    return y * GRID + flippedX + 1
end

-- ======================
-- ⬇⬇⬇ SLOTS (BOT EDITA AQUI) ⬇⬇⬇
-- ======================
local ARTS = {
    {
        name = "Slot 1",
        map = [[
       ]]
    },
    {
        name = "Slot 2",
        map = [[
        ]]
    },
    -- Adicione quantos slots quiser aqui ↓
}

-- ======================
-- ART BUFFER
-- ======================
local art = {}
for i = 1, TOTAL do
    art[i] = "FFFFFF"
end

-- ======================
-- PARSER UNIVERSAL
-- ======================
local function parseTextToArt(text)
    for i = 1, TOTAL do
        art[i] = "FFFFFF"
    end

    if not text or text == "" then return 0 end

    local count = 0
    for idx, hex in text:gmatch("Pixel%s+(%d+)[^=]*=%s*([A-Fa-f0-9]+)") do
        local n = tonumber(idx)
        if n and n >= 1 and n <= TOTAL then
            art[n] = hex:upper()
            count += 1
        end
    end
    return count
end

-- ======================
-- ESTADO
-- ======================
local selectedMap = nil
local loopActive = false
local gui = nil
local frame = nil
local startBtn = nil
local preview = nil

-- ======================
-- CRIAR/ATUALIZAR GUI (Mais Bonita)
-- ======================
local function createOrUpdateGUI()
    if gui and gui.Parent then
        return gui
    end

    gui = Instance.new("ScreenGui")
    gui.Name = "PixelPainterHUD"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    -- Toggle Button
    local toggleBtn = Instance.new("TextButton", gui)
    toggleBtn.Size = UDim2.new(0, 40, 0, 40)
    toggleBtn.Position = UDim2.new(1, -55, 0, 15)
    toggleBtn.Text = "🎨"
    toggleBtn.TextSize = 24
    toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    toggleBtn.TextColor3 = Color3.new(1, 1, 1)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.AutoButtonColor = false

    local toggleCorner = Instance.new("UICorner", toggleBtn)
    toggleCorner.CornerRadius = UDim.new(0, 8)

    -- Main Frame
    frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 220, 0, 160)
    frame.Position = UDim2.new(1, -250, 0, 65)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 33)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Visible = false

    local mainCorner = Instance.new("UICorner", frame)
    mainCorner.CornerRadius = UDim.new(0, 10)

    -- Title
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 25)
    title.Text = "Pixel Painter"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1

    -- Lista de Artes (Scroll corrigido!)
    local artList = Instance.new("ScrollingFrame", frame)
    artList.Size = UDim2.new(1, -10, 0, 85)
    artList.Position = UDim2.new(0, 5, 0, 30)
    artList.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    artList.BorderSizePixel = 0
    artList.ScrollBarThickness = 5
    artList.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
    artList.AutomaticCanvasSize = Enum.AutomaticSize.Y   -- ← Correção principal
    artList.CanvasSize = UDim2.new(0, 0, 0, 0)

    local listCorner = Instance.new("UICorner", artList)
    listCorner.CornerRadius = UDim.new(0, 6)

    local layout = Instance.new("UIListLayout", artList)
    layout.Padding = UDim.new(0, 3)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Preview
    preview = Instance.new("TextLabel", frame)
    preview.Size = UDim2.new(1, -10, 0, 22)
    preview.Position = UDim2.new(0, 5, 0, 120)
    preview.Text = "Preview: nenhuma arte selecionada"
    preview.Font = Enum.Font.Code
    preview.TextSize = 12
    preview.TextColor3 = Color3.fromRGB(200, 200, 200)
    preview.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    preview.TextTruncate = Enum.TextTruncate.AtEnd

    local previewCorner = Instance.new("UICorner", preview)
    previewCorner.CornerRadius = UDim.new(0, 4)

    -- Start Button
    startBtn = Instance.new("TextButton", frame)
    startBtn.Size = UDim2.new(1, -10, 0, 23)
    startBtn.Position = UDim2.new(0, 5, 0, 147)
    startBtn.Text = "COMEÇAR"
    startBtn.Font = Enum.Font.GothamBold
    startBtn.TextSize = 13
    startBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    startBtn.TextColor3 = Color3.new(1, 1, 1)
    startBtn.BorderSizePixel = 0

    local btnCorner = Instance.new("UICorner", startBtn)
    btnCorner.CornerRadius = UDim.new(0, 6)

    -- ======================
    -- Hover Effects
    -- ======================
    toggleBtn.MouseEnter:Connect(function() toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70) end)
    toggleBtn.MouseLeave:Connect(function() toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50) end)

    -- ======================
    -- Conexões
    -- ======================
    toggleBtn.MouseButton1Click:Connect(function()
        frame.Visible = not frame.Visible
    end)

    startBtn.MouseButton1Click:Connect(function()
        loopActive = not loopActive
        if loopActive then
            startBtn.Text = "PARAR"
            startBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
        else
            startBtn.Text = "COMEÇAR"
            startBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        end
    end)

    -- Popular lista de artes
    for i, slot in ipairs(ARTS) do
        local btn = Instance.new("TextButton", artList)
        btn.Size = UDim2.new(1, -8, 0, 22)
        btn.Text = "  " .. slot.name
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 12
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = false

        local btnCorner2 = Instance.new("UICorner", btn)
        btnCorner2.CornerRadius = UDim.new(0, 5)

        btn.MouseButton1Click:Connect(function()
            selectedMap = slot.map
            preview.Text = "Preview: " .. slot.name
        end)

        -- Hover no botão da arte
        btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(70, 70, 80) end)
        btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(50, 50, 55) end)
    end

    -- Restaurar estado visual
    if selectedMap then
        preview.Text = "Preview: " .. (selectedMap.name or "arte_selecionada")
    end
    if loopActive then
        startBtn.Text = "PARAR"
        startBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
    end

    return gui
end

-- ======================
-- ANTI-MORTE (Monitoramento)
-- ======================
local function monitorGUI()
    while true do
        local playerGui = player:FindFirstChild("PlayerGui")
        if playerGui and not playerGui:FindFirstChild("PixelPainterHUD") then
            createOrUpdateGUI()
            warn("[Pixel Painter] GUI recriada após morte/respawn")
        end
        task.wait(2)
    end
end

-- ======================
-- INICIALIZAÇÃO
-- ======================
if not player:FindFirstChild("PlayerGui") then
    player.CharacterAdded:Wait()
    task.wait(1)
end

createOrUpdateGUI()
task.spawn(monitorGUI)

-- ======================
-- LOOP DE PINTURA
-- ======================
task.spawn(function()
    while true do
        if loopActive and selectedMap then
            parseTextToArt(selectedMap)

            local packet = {}
            local count = 0

            for i = 1, TOTAL do
                packet[tostring(logicalToBoardIndex(i))] = art[i]
                count += 1

                if count >= 64 then
                    pcall(function()
                        if remote then remote:InvokeServer(packet) end
                    end)
                    packet = {}
                    count = 0
                    task.wait(0.01)
                end
            end

            if count > 0 then
                pcall(function()
                    if remote then remote:InvokeServer(packet) end
                end)
            end

            task.wait(0.5)
        else
            task.wait(0.2)
        end
    end
end)

-- Reconexão ao respawn
player.CharacterAdded:Connect(function()
    task.wait(1)
    if player:FindFirstChild("PlayerGui") and not player.PlayerGui:FindFirstChild("PixelPainterHUD") then
        createOrUpdateGUI()
    end
end)

print("🎨 Pixel Painter HUD carregada (versão melhorada + scroll corrigido)")
