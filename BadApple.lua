-- =====================================================
-- BAD APPLE PLAYER — V1.0
-- =====================================================
--  Reproduz o vídeo Bad Apple no quadro 32×32.
--  Requer: BadApple.lua no GitHub (gerado pelo script Python).
--  Funciona com Delta Mobile (usa syn.request).
-- =====================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ==================== CONSTANTES ====================
local GITHUB_RAW_URL = "https://raw.githubusercontent.com/prozin666/Arte-fofa-1/main/BadApple.lua"
local GAMEPASS_ID = 681945725          -- ID da gamepass para quadro 32×32
local REMOTE_NAME = "UpdateBoard"      -- Remote usado pelo jogo
local UPGRADE_REMOTE = "UpgradeCanvasSize"

-- ==================== UI ====================
local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "BadApplePlayer"
gui.ResetOnSpawn = false

-- Janela principal
local window = Instance.new("Frame", gui)
window.Size = UDim2.new(0, 320, 0, 220)
window.Position = UDim2.new(0.5, -160, 0.5, -110)
window.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
window.BackgroundTransparency = 0.2
window.BorderSizePixel = 0
window.Active = true
window.Draggable = true

local UICorner = Instance.new("UICorner", window)
UICorner.CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke", window)
UIStroke.Color = Color3.fromRGB(45, 45, 55)
UIStroke.Thickness = 2

-- Barra de título
local titleBar = Instance.new("Frame", window)
titleBar.Size = UDim2.new(1, 0, 0, 32)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
titleBar.BorderSizePixel = 0
local titleCorner = Instance.new("UICorner", titleBar)
titleCorner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🎬 Bad Apple Player"
title.Font = Enum.Font.FredokaOne
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(240, 240, 240)
title.TextXAlignment = Enum.TextXAlignment.Left

-- Botão fechar
local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -30, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
closeBtn.Text = "×"
closeBtn.Font = Enum.Font.FredokaOne
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
closeBtn.AutoButtonColor = true
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(1, 0)
closeBtn.MouseButton1Click:Connect(function() window.Visible = false end)

-- Conteúdo
local content = Instance.new("Frame", window)
content.Size = UDim2.new(1, -2, 1, -34)
content.Position = UDim2.new(0, 1, 0, 33)
content.BackgroundTransparency = 1

-- ==================== ELEMENTOS DA UI ====================
-- Thumbnail (imagem estática)
local thumb = Instance.new("ImageLabel", content)
thumb.Size = UDim2.new(0, 80, 0, 80)
thumb.Position = UDim2.new(0, 15, 0, 15)
thumb.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
thumb.Image = "rbxassetid://0"   -- Substitua pelo ID de uma imagem real (ex: print do Bad Apple)
thumb.ScaleType = Enum.ScaleType.Fit
local thumbCorner = Instance.new("UICorner", thumb)
thumbCorner.CornerRadius = UDim.new(0, 8)

-- Status
local statusLabel = Instance.new("TextLabel", content)
statusLabel.Size = UDim2.new(0, 190, 0, 20)
statusLabel.Position = UDim2.new(0, 105, 0, 15)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Pronto para carregar."
statusLabel.Font = Enum.Font.FredokaOne
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextSize = 13
statusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Barra de progresso
local progressBar = Instance.new("Frame", content)
progressBar.Size = UDim2.new(0, 190, 0, 12)
progressBar.Position = UDim2.new(0, 105, 0, 45)
progressBar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
local progressCorner = Instance.new("UICorner", progressBar)
progressCorner.CornerRadius = UDim.new(0, 6)
local progressFill = Instance.new("Frame", progressBar)
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
local fillCorner = Instance.new("UICorner", progressFill)
fillCorner.CornerRadius = UDim.new(0, 6)

-- Botão Carregar
local loadBtn = Instance.new("TextButton", content)
loadBtn.Size = UDim2.new(0, 100, 0, 28)
loadBtn.Position = UDim2.new(0, 105, 0, 70)
loadBtn.Text = "Carregar"
loadBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
loadBtn.TextColor3 = Color3.new(1,1,1)
loadBtn.Font = Enum.Font.FredokaOne
loadBtn.TextSize = 13
addCorner(loadBtn, UDim.new(0, 6))

-- Botão Iniciar/Pausar
local playBtn = Instance.new("TextButton", content)
playBtn.Size = UDim2.new(0, 70, 0, 28)
playBtn.Position = UDim2.new(0, 15, 0, 120)
playBtn.Text = "▶ Iniciar"
playBtn.BackgroundColor3 = Color3.fromRGB(70, 150, 70)
playBtn.TextColor3 = Color3.new(1,1,1)
playBtn.Font = Enum.Font.FredokaOne
playBtn.TextSize = 13
addCorner(playBtn, UDim.new(0, 6))

-- Botão Parar
local stopBtn = Instance.new("TextButton", content)
stopBtn.Size = UDim2.new(0, 70, 0, 28)
stopBtn.Position = UDim2.new(0, 90, 0, 120)
stopBtn.Text = "⏹ Parar"
stopBtn.BackgroundColor3 = Color3.fromRGB(150, 70, 70)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.FredokaOne
stopBtn.TextSize = 13
addCorner(stopBtn, UDim.new(0, 6))

-- Controle de velocidade
local fpsLabel = Instance.new("TextLabel", content)
fpsLabel.Size = UDim2.new(0, 30, 0, 20)
fpsLabel.Position = UDim2.new(0, 15, 0, 160)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS:"
fpsLabel.Font = Enum.Font.FredokaOne
fpsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
fpsLabel.TextSize = 11

local fpsInput = Instance.new("TextBox", content)
fpsInput.Size = UDim2.new(0, 40, 0, 20)
fpsInput.Position = UDim2.new(0, 45, 0, 160)
fpsInput.Text = "10"
fpsInput.Font = Enum.Font.FredokaOne
fpsInput.TextColor3 = Color3.new(1,1,1)
fpsInput.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
addCorner(fpsInput, UDim.new(0, 4))

-- ==================== LÓGICA DO PLAYER ====================
local updateBoard = ReplicatedStorage:FindFirstChild(REMOTE_NAME) or Workspace:FindFirstChild(REMOTE_NAME, true)
local upgradeCanvas = ReplicatedStorage:FindFirstChild(UPGRADE_REMOTE) or Workspace:FindFirstChild(UPGRADE_REMOTE, true)

local framesData = nil       -- { SIZE=32, FRAME_COUNT, FRAMES }
local currentFrame = 1
local isPlaying = false
local fps = 10

-- Helpers
local function addCorner(parent, radius)
    local c = Instance.new("UICorner", parent)
    c.CornerRadius = radius
    return c
end

local function getMyBoard()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name == "1" and obj:IsA("BasePart") then
            local container = obj.Parent
            if container and container:FindFirstChild("1024") then
                return container
            end
        end
    end
    return nil
end

local function hexToColor3(hex)
    local r = tonumber(hex:sub(1,2),16)/255
    local g = tonumber(hex:sub(3,4),16)/255
    local b = tonumber(hex:sub(5,6),16)/255
    return Color3.new(r, g, b)
end

-- Converter índice linear Python para índice físico do quadro
local function logicalToBoardIndex(i, size)
    local zero = i - 1
    local y = math.floor(zero / size)
    local x = zero % size
    local flippedX = (size - 1) - x
    return y * size + flippedX + 1
end

local function paintFrame(frameIndex)
    if not framesData or not updateBoard then return end
    local frameStr = framesData.FRAMES[frameIndex]
    if not frameStr then return end
    local size = framesData.SIZE
    local packet = {}
    for i = 1, size * size do
        local hex = frameStr:sub((i-1)*6+1, i*6)
        local boardIdx = logicalToBoardIndex(i, size)
        packet[tostring(boardIdx)] = hex
    end
    pcall(function()
        updateBoard:InvokeServer(packet)
    end)
end

local function stopPlayback()
    isPlaying = false
    playBtn.Text = "▶ Iniciar"
end

-- Loop principal
local function playLoop()
    while isPlaying and framesData do
        paintFrame(currentFrame)
        progressFill.Size = UDim2.new(currentFrame / framesData.FRAME_COUNT, 0, 1, 0)
        statusLabel.Text = string.format("Frame %d/%d", currentFrame, framesData.FRAME_COUNT)

        currentFrame = currentFrame + 1
        if currentFrame > framesData.FRAME_COUNT then
            stopPlayback()
            statusLabel.Text = "Reprodução concluída!"
            break
        end
        task.wait(1 / fps)
    end
end

-- Carregar tabela do GitHub
local function loadFrames()
    statusLabel.Text = "Baixando frames..."
    loadBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    local success, result = pcall(function()
        return syn.request({ Url = GITHUB_RAW_URL, Method = "GET" })
    end)
    if not success or result.StatusCode ~= 200 then
        statusLabel.Text = "Falha ao baixar arquivo."
        loadBtn.BackgroundColor3 = Color3.fromRGB(150, 70, 70)
        return
    end

    local ok, data = pcall(function()
        return loadstring(result.Body)()
    end)
    if not ok or not data or not data.FRAMES then
        statusLabel.Text = "Arquivo inválido."
        loadBtn.BackgroundColor3 = Color3.fromRGB(150, 70, 70)
        return
    end

    framesData = data
    currentFrame = 1
    fps = tonumber(fpsInput.Text) or 10

    -- Verificar/atualizar quadro para 32×32
    local board = getMyBoard()
    if board then
        local maxIdx = 0
        for _, child in ipairs(board:GetChildren()) do
            if child:IsA("BasePart") then
                local num = tonumber(child.Name)
                if num and num > maxIdx then maxIdx = num end
            end
        end
        if maxIdx < 1024 and data.SIZE == 32 then
            statusLabel.Text = "Expandindo quadro..."
            if upgradeCanvas then
                local hasPass = false
                pcall(function()
                    hasPass = game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.UserId, GAMEPASS_ID)
                end)
                if hasPass then
                    upgradeCanvas:FireServer()
                    repeat task.wait(0.2) board = getMyBoard() until (board and board:FindFirstChild("1024"))
                    statusLabel.Text = "Quadro pronto."
                else
                    statusLabel.Text = "Gamepass necessária para 32×32!"
                    loadBtn.BackgroundColor3 = Color3.fromRGB(150, 70, 70)
                    return
                end
            else
                statusLabel.Text = "Remote de upgrade não encontrado."
                loadBtn.BackgroundColor3 = Color3.fromRGB(150, 70, 70)
                return
            end
        end
    else
        statusLabel.Text = "Quadro não encontrado!"
        loadBtn.BackgroundColor3 = Color3.fromRGB(150, 70, 70)
        return
    end

    statusLabel.Text = string.format("Carregado: %d frames (%dx%d)", data.FRAME_COUNT, data.SIZE, data.SIZE)
    loadBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
end

-- Eventos dos botões
loadBtn.MouseButton1Click:Connect(loadFrames)

playBtn.MouseButton1Click:Connect(function()
    if not framesData then
        statusLabel.Text = "Carregue o vídeo primeiro!"
        return
    end
    if isPlaying then
        -- Pausar
        stopPlayback()
    else
        if currentFrame > framesData.FRAME_COUNT then
            currentFrame = 1
        end
        isPlaying = true
        playBtn.Text = "⏸ Pausar"
        fps = tonumber(fpsInput.Text) or 10
        task.spawn(playLoop)
    end
end)

stopBtn.MouseButton1Click:Connect(function()
    stopPlayback()
    currentFrame = 1
    progressFill.Size = UDim2.new(0, 0, 1, 0)
    statusLabel.Text = "Parado."
end)

fpsInput.FocusLost:Connect(function()
    local n = tonumber(fpsInput.Text)
    if n and n > 0 then
        fps = n
    else
        fpsInput.Text = tostring(fps)
    end
end)

-- Parar ao fechar janela
window:GetPropertyChangedSignal("Visible"):Connect(function()
    if not window.Visible then
        stopPlayback()
    end
end)

print("Bad Apple Player carregado. Abra a janela e clique em Carregar.")
