-- ======================
-- PIXEL PAINTER CENTRAL (DELTA)
-- HUD compacta, flutuante, móvel
-- ======================

local player = game.Players.LocalPlayer
local remote = game.ReplicatedStorage:FindFirstChild("UpdateBoard")
    or game.Workspace:FindFirstChild("UpdateBoard", true)

local GRID = 32
local TOTAL = GRID * GRID

-- UTIL: índice lógico -> board (espelho X)
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

}
-- ⬆⬆⬆ FIM DOS SLOTS ⬆⬆⬆
-- ======================

-- ======================
-- ART BUFFER
-- ======================
local art = {}
for i = 1, TOTAL do art[i] = "FFFFFF" end

-- ======================
-- PARSER DE MAP
-- ======================
local function parseTextToArt(text)
    for i = 1, TOTAL do art[i] = "FFFFFF" end
    if not text then return 0 end
    local count = 0
    for idx, hex in text:gmatch("Pixel%s+(%d+).-=%s*([A-Fa-f0-9]+)") do
        local n = tonumber(idx)
        if n and n >= 1 and n <= TOTAL then
            art[n] = hex:upper()
            count = count + 1
        end
    end
    return count
end

-- ======================
-- VARIÁVEL GLOBAL PARA A ARTE SELECIONADA
-- ======================
local selectedMap = nil

-- ======================
-- GUI MÓVEL
-- ======================
local gui = Instance.new("ScreenGui")
gui.Name = "PixelPainterHUD"
gui.Parent = player:WaitForChild("PlayerGui")

-- Botão flutuante
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 35, 0, 30)
toggleBtn.Position = UDim2.new(1, -45, 0, 15)
toggleBtn.Text = "🎨"
toggleBtn.Font = Enum.Font.SourceSans
toggleBtn.TextSize = 20
toggleBtn.BackgroundColor3 = Color3.fromRGB(55,55,55)
toggleBtn.BorderSizePixel = 0
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.AnchorPoint = Vector2.new(0,0)

-- Frame HUD compacto e móvel
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 160)
frame.Position = UDim2.new(1, -250, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Active = true
frame.Draggable = true

-- Header
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,20)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "Pixel Painter"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 14
title.TextColor3 = Color3.new(1,1,1)

-- Lista de artes (scroll)
local artList = Instance.new("ScrollingFrame", frame)
artList.Size = UDim2.new(1,-10,0,90)
artList.Position = UDim2.new(0,5,0,25)
artList.BackgroundTransparency = 0.2
artList.BackgroundColor3 = Color3.fromRGB(40,40,40)
artList.BorderSizePixel = 0
artList.CanvasSize = UDim2.new(0,0,0,0)
artList.ScrollBarThickness = 6
local uiLayout = Instance.new("UIListLayout", artList)
uiLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiLayout.Padding = UDim.new(0,2)

-- Preview (apenas identificação)
local preview = Instance.new("TextLabel", frame)
preview.Size = UDim2.new(1,-10,0,20)
preview.Position = UDim2.new(0,5,0,120)
preview.BackgroundColor3 = Color3.fromRGB(48,48,48)
preview.TextColor3 = Color3.new(1,1,1)
preview.Font = Enum.Font.Code
preview.TextSize = 12
preview.TextWrapped = true
preview.Text = "Preview: (clique em arte)"
preview.TextXAlignment = Enum.TextXAlignment.Left

-- Botão Começar/Parar
local startBtn = Instance.new("TextButton", frame)
startBtn.Size = UDim2.new(1,-10,0,20)
startBtn.Position = UDim2.new(0,5,0,135)
startBtn.Text = "COMEÇAR"
startBtn.Font = Enum.Font.SourceSansBold
startBtn.TextSize = 12
startBtn.BackgroundColor3 = Color3.fromRGB(180,50,50)
startBtn.TextColor3 = Color3.new(1,1,1)
startBtn.BorderSizePixel = 0

-- ======================
-- Funções HUD
-- ======================
local loopActive = false
startBtn.MouseButton1Click:Connect(function()
    loopActive = not loopActive
    if loopActive then
        startBtn.Text = "PARAR"
        startBtn.BackgroundColor3 = Color3.fromRGB(50,180,50)
    else
        startBtn.Text = "COMEÇAR"
        startBtn.BackgroundColor3 = Color3.fromRGB(180,50,50)
    end
end)

toggleBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- Limpar lista
local function clearArtList()
    for _,c in ipairs(artList:GetChildren()) do
        if c~=uiLayout then c:Destroy() end
    end
    artList.CanvasSize = UDim2.new(0,0,0,0)
end

-- Adicionar artes na lista
local function addArt(name,map)
    local btn = Instance.new("TextButton", artList)
    btn.Size = UDim2.new(1,0,0,20)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = name
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 12
    btn.AutoButtonColor = true
    btn.BorderSizePixel = 0

    btn.MouseButton1Click:Connect(function()
        preview.Text = "Preview: AQUI"
        selectedMap = map  -- variável separada
    end)

    artList.CanvasSize = UDim2.new(0,0,0,uiLayout.AbsoluteContentSize.Y + 4)
end

clearArtList()
for _,entry in ipairs(ARTS) do
    addArt(entry.name, entry.map)
end

-- ======================
-- LOOP DE PINTURA
-- ======================
task.spawn(function()
    while true do
        if loopActive and selectedMap and selectedMap ~= "" then
            parseTextToArt(selectedMap)
            local packet = {}
            local count = 0
            for i = 1, TOTAL do
                local realIndex = logicalToBoardIndex(i)
                packet[tostring(realIndex)] = art[i]
                count = count + 1
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
