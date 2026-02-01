-- ======================
-- PIXEL PAINTER CENTRAL (DELTA)
-- GUI FIXA / SLOTS INFINITOS
-- FORMATO INLINE SUPORTADO (|)
-- SISTEMA ANTI-MORTE (HUD PERSISTENTE)
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
        name = "teste",
        map = [[
Pixel 1 (0,0) = FCFCFC | Pixel 2 (1,0) = FDFDFD | Pixel 3 (2,0) = FDFDFD | Pixel 4 (3,0) = FDFDFD | Pixel 5 (4,0) = FDFDFD | Pixel 6 (5,0) = FDFDFD | Pixel 7 (6,0) = FDFDFD | Pixel 8 (7,0) = FDFDFD | Pixel 9 (8,0) = FDFDFD | Pixel 10 (9,0) = FDFDFD | Pixel 11 (10,0) = FDFDFD | Pixel 12 (11,0) = FDFDFD | Pixel 13 (12,0) = FEFEFC | Pixel 14 (13,0) = FDFDFD | Pixel 15 (14,0) = FDFDFD | Pixel 16 (15,0) = FDFDFD
Pixel 17 (0,1) = F8F8F8 | Pixel 18 (1,1) = F8F8F6 | Pixel 19 (2,1) = F8F8F8 | Pixel 20 (3,1) = F8F8F8 | Pixel 21 (4,1) = F8F8F8 | Pixel 22 (5,1) = F9F9F7 | Pixel 23 (6,1) = FAF9F7 | Pixel 24 (7,1) = FAF9F7 | Pixel 25 (8,1) = FAF9F7 | Pixel 26 (9,1) = FAF9F7 | Pixel 27 (10,1) = F9F8F6 | Pixel 28 (11,1) = F8F8F8 | Pixel 29 (12,1) = F8F8F8 | Pixel 30 (13,1) = F8F8F8 | Pixel 31 (14,1) = F9F7F8 | Pixel 32 (15,1) = F8F8F8
Pixel 33 (0,2) = F2F2F2 | Pixel 34 (1,2) = F2F2F2 | Pixel 35 (2,2) = 876B53 | Pixel 36 (3,2) = 8C6E52 | Pixel 37 (4,2) = 896E53 | Pixel 38 (5,2) = 896B51 | Pixel 39 (6,2) = 84694E | Pixel 40 (7,2) = 81664B | Pixel 41 (8,2) = 85674D | Pixel 42 (9,2) = 8F7157 | Pixel 43 (10,2) = A17F63 | Pixel 44 (11,2) = BB9274 | Pixel 45 (12,2) = D2A882 | Pixel 46 (13,2) = F3C299 | Pixel 47 (14,2) = F3F3F3 | Pixel 48 (15,2) = F2F2F2
Pixel 49 (0,3) = EEEEEE | Pixel 50 (1,3) = C3B0A1 | Pixel 51 (2,3) = A48163 | Pixel 52 (3,3) = A38062 | Pixel 53 (4,3) = 9E7C60 | Pixel 54 (5,3) = 9B795D | Pixel 55 (6,3) = 97785B | Pixel 56 (7,3) = 927357 | Pixel 57 (8,3) = 8B6D53 | Pixel 58 (9,3) = 82674C | Pixel 59 (10,3) = 7F634B | Pixel 60 (11,3) = 8A6C54 | Pixel 61 (12,3) = A68365 | Pixel 62 (13,3) = BF9975 | Pixel 63 (14,3) = E7BA91 | Pixel 64 (15,3) = EDEDED
Pixel 65 (0,4) = E9E9E9 | Pixel 66 (1,4) = C4B1A0 | Pixel 67 (2,4) = A88464 | Pixel 68 (3,4) = A58264 | Pixel 69 (4,4) = A38062 | Pixel 70 (5,4) = 9E7D5E | Pixel 71 (6,4) = 9C795D | Pixel 72 (7,4) = 96775A | Pixel 73 (8,4) = 917256 | Pixel 74 (9,4) = 8A6C52 | Pixel 75 (10,4) = 85674F | Pixel 76 (11,4) = 7C6048 | Pixel 77 (12,4) = 9F7D61 | Pixel 78 (13,4) = B89170 | Pixel 79 (14,4) = E1B48D | Pixel 80 (15,4) = E8E8E8
Pixel 81 (0,5) = E4E4E4 | Pixel 82 (1,5) = C5B09F | Pixel 83 (2,5) = AA8666 | Pixel 84 (3,5) = A38668 | Pixel 85 (4,5) = 1D1E20 | Pixel 86 (5,5) = 232524 | Pixel 87 (6,5) = 766450 | Pixel 88 (7,5) = 91775E | Pixel 89 (8,5) = 917256 | Pixel 90 (9,5) = 866D57 | Pixel 91 (10,5) = 574B3F | Pixel 92 (11,5) = 151618 | Pixel 93 (12,5) = 1D1D1B | Pixel 94 (13,5) = AD8F73 | Pixel 95 (14,5) = DCB491 | Pixel 96 (15,5) = E4E4E4
Pixel 97 (0,6) = DEDEDE | Pixel 98 (1,6) = C9BBAE | Pixel 99 (2,6) = A48266 | Pixel 100 (3,6) = A28162 | Pixel 101 (4,6) = 876951 | Pixel 102 (5,6) = 614C37 | Pixel 103 (6,6) = 5F4836 | Pixel 104 (7,6) = 947559 | Pixel 105 (8,6) = 917256 | Pixel 106 (9,6) = 8B6D53 | Pixel 107 (10,6) = 513E2F | Pixel 108 (11,6) = 4D3A2B | Pixel 109 (12,6) = 99775C | Pixel 110 (13,6) = 6F5F50 | Pixel 111 (14,6) = D9B291 | Pixel 112 (15,6) = DDDDDD
Pixel 113 (0,7) = DADADA | Pixel 114 (1,7) = C7B9AC | Pixel 115 (2,7) = AA8666 | Pixel 116 (3,7) = 886A4E | Pixel 117 (4,7) = AEAEA6 | Pixel 118 (5,7) = 1D1D1B | Pixel 119 (6,7) = 55524B | Pixel 120 (7,7) = 5C4734 | Pixel 121 (8,7) = 917256 | Pixel 122 (9,7) = 483727 | Pixel 123 (10,7) = 4D3B2D | Pixel 124 (11,7) = 000000 | Pixel 125 (12,7) = A7A6A1 | Pixel 126 (13,7) = B28F6F | Pixel 127 (14,7) = D9B291 | Pixel 128 (15,7) = D9D9D9
Pixel 129 (0,8) = D5D5D5 | Pixel 130 (1,8) = C4B7A7 | Pixel 131 (2,8) = AA8666 | Pixel 132 (3,8) = A88464 | Pixel 133 (4,8) = A38062 | Pixel 134 (5,8) = 9E7B5D | Pixel 135 (6,8) = 99775B | Pixel 136 (7,8) = 937458 | Pixel 137 (8,8) = 907256 | Pixel 138 (9,8) = 8C6E54 | Pixel 139 (10,8) = 87694F | Pixel 140 (11,8) = 7D634A | Pixel 141 (12,8) = 95765A | Pixel 142 (13,8) = B38F6D | Pixel 143 (14,8) = D9B38F | Pixel 144 (15,8) = D4D4D4
Pixel 145 (0,9) = D0D0D2 | Pixel 146 (1,9) = C2B2A5 | Pixel 147 (2,9) = AA8666 | Pixel 148 (3,9) = A68363 | Pixel 149 (4,9) = A38062 | Pixel 150 (5,9) = 9D7B5F | Pixel 151 (6,9) = 96775B | Pixel 152 (7,9) = 937458 | Pixel 153 (8,9) = 907256 | Pixel 154 (9,9) = 8C6E54 | Pixel 155 (10,9) = 886A50 | Pixel 156 (11,9) = 7F634B | Pixel 157 (12,9) = 98795C | Pixel 158 (13,9) = B99271 | Pixel 159 (14,9) = D9B38F | Pixel 160 (15,9) = CFCFD1
Pixel 161 (0,10) = D1D1D3 | Pixel 162 (1,10) = C2B2A5 | Pixel 163 (2,10) = AB8767 | Pixel 164 (3,10) = A68365 | Pixel 165 (4,10) = A18061 | Pixel 166 (5,10) = 9C7A5E | Pixel 167 (6,10) = 96775B | Pixel 168 (7,10) = 937458 | Pixel 169 (8,10) = 907155 | Pixel 170 (9,10) = 8C6E54 | Pixel 171 (10,10) = 896B51 | Pixel 172 (11,10) = 83684D | Pixel 173 (12,10) = 947559 | Pixel 174 (13,10) = BB9473 | Pixel 175 (14,10) = D9B090 | Pixel 176 (15,10) = CFCFD1
Pixel 177 (0,11) = D0D0D0 | Pixel 178 (1,11) = C2B2A3 | Pixel 179 (2,11) = AA8666 | Pixel 180 (3,11) = A78464 | Pixel 181 (4,11) = A18061 | Pixel 182 (5,11) = 9D7C5D | Pixel 183 (6,11) = 96775A | Pixel 184 (7,11) = 937458 | Pixel 185 (8,11) = 907256 | Pixel 186 (9,11) = 8D6F53 | Pixel 187 (10,11) = 896B51 | Pixel 188 (11,11) = 81654D | Pixel 189 (12,11) = 896B51 | Pixel 190 (13,11) = BA9470 | Pixel 191 (14,11) = DAB191 | Pixel 192 (15,11) = CFCFCF
Pixel 193 (0,12) = D1D1D1 | Pixel 194 (1,12) = C7BAB2 | Pixel 195 (2,12) = AC8868 | Pixel 196 (3,12) = A88464 | Pixel 197 (4,12) = A07F60 | Pixel 198 (5,12) = 9C7A5E | Pixel 199 (6,12) = 96775B | Pixel 200 (7,12) = 947559 | Pixel 201 (8,12) = 917256 | Pixel 202 (9,12) = 8D6F53 | Pixel 203 (10,12) = 896B51 | Pixel 204 (11,12) = 80644C | Pixel 205 (12,12) = 6E5843 | Pixel 206 (13,12) = B89170 | Pixel 207 (14,12) = D2B397 | Pixel 208 (15,12) = CECECE
Pixel 209 (0,13) = D0D0D2 | Pixel 210 (1,13) = D0D0D0 | Pixel 211 (2,13) = B79373 | Pixel 212 (3,13) = AD8967 | Pixel 213 (4,13) = A38062 | Pixel 214 (5,13) = 9B795D | Pixel 215 (6,13) = 95765A | Pixel 216 (7,13) = 937458 | Pixel 217 (8,13) = 907155 | Pixel 218 (9,13) = 8D6F53 | Pixel 219 (10,13) = 8A6C52 | Pixel 220 (11,13) = 83684D | Pixel 221 (12,13) = 403020 | Pixel 222 (13,13) = AD8969 | Pixel 223 (14,13) = D0CECF | Pixel 224 (15,13) = CFCFD1
Pixel 225 (0,14) = D1D1D3 | Pixel 226 (1,14) = D0D0D0 | Pixel 227 (2,14) = D1D1D1 | Pixel 228 (3,14) = B99D85 | Pixel 229 (4,14) = B58E6D | Pixel 230 (5,14) = A98467 | Pixel 231 (6,14) = A58264 | Pixel 232 (7,14) = A28162 | Pixel 233 (8,14) = 9D7B5F | Pixel 234 (9,14) = 9D7B5F | Pixel 235 (10,14) = 9A785D | Pixel 236 (11,14) = 927356 | Pixel 237 (12,14) = 846850 | Pixel 238 (13,14) = D1CDCA | Pixel 239 (14,14) = D0D0D0 | Pixel 240 (15,14) = CFCFCF
Pixel 241 (0,15) = D0D0D0 | Pixel 242 (1,15) = D0D0D0 | Pixel 243 (2,15) = D1D1D1 | Pixel 244 (3,15) = D1D1D1 | Pixel 245 (4,15) = C1B8B1 | Pixel 246 (5,15) = C59D7A | Pixel 247 (6,15) = BF9774 | Pixel 248 (7,15) = 9F7D61 | Pixel 249 (8,15) = 8D6F53 | Pixel 250 (9,15) = AF8C6E | Pixel 251 (10,15) = E2B58E | Pixel 252 (11,15) = DBC8B7 | Pixel 253 (12,15) = D0D0D0 | Pixel 254 (13,15) = D0D0D0 | Pixel 255 (14,15) = CFCFCF | Pixel 256 (15,15) = CFCFCF
        ]]
    },
}
-- ======================
-- ⬆⬆⬆ FIM DOS SLOTS ⬆⬆⬆
-- ======================

-- ======================
-- ART BUFFER
-- ======================
local art = {}
for i = 1, TOTAL do
    art[i] = "FFFFFF"
end

-- ======================
-- PARSER UNIVERSAL (linha OU inline)
-- ======================
local function parseTextToArt(text)
    for i = 1, TOTAL do
        art[i] = "FFFFFF"
    end

    if not text or text == "" then
        return 0
    end

    local count = 0

    -- aceita:
    -- Pixel 1 (0,0) = FFFFFF
    -- Pixel 1 = FFFFFF
    -- Pixel 1 (0,0) = FFFFFF | Pixel 2 ...
    for idx, hex in text:gmatch("Pixel%s+(%d+)[^=]*=%s*([A-Fa-f0-9]+)") do
        local n = tonumber(idx)
        if n and n >= 1 and n <= TOTAL then
            art[n] = hex:upper()
            count = count + 1
        end
    end

    return count
end

-- ======================
-- ESTADO (PERSISTENTE)
-- ======================
local selectedMap = nil
local loopActive = false
local gui = nil
local frame = nil
local startBtn = nil
local preview = nil

-- ======================
-- FUNÇÃO PARA CRIAR/ATUALIZAR GUI
-- ======================
local function createOrUpdateGUI()
    -- Se a GUI já existe, apenas garanta que está no PlayerGui
    if gui and gui.Parent then
        return gui
    end
    
    -- Se foi destruída, cria novamente
    gui = Instance.new("ScreenGui")
    gui.Name = "PixelPainterHUD"
    gui.ResetOnSpawn = false -- IMPEDE QUE SEJA DESTRUÍDA AO RENASCER
    gui.Parent = player:WaitForChild("PlayerGui")

    local toggleBtn = Instance.new("TextButton", gui)
    toggleBtn.Size = UDim2.new(0, 35, 0, 30)
    toggleBtn.Position = UDim2.new(1, -45, 0, 15)
    toggleBtn.Text = "🎨"
    toggleBtn.TextSize = 20
    toggleBtn.BackgroundColor3 = Color3.fromRGB(55,55,55)
    toggleBtn.TextColor3 = Color3.new(1,1,1)
    toggleBtn.BorderSizePixel = 0

    frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 220, 0, 160)
    frame.Position = UDim2.new(1, -250, 0, 50)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.Active = true
    frame.Draggable = true

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,20)
    title.Text = "Pixel Painter"
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 14
    title.TextColor3 = Color3.new(1,1,1)
    title.BackgroundTransparency = 1

    local artList = Instance.new("ScrollingFrame", frame)
    artList.Size = UDim2.new(1,-10,0,90)
    artList.Position = UDim2.new(0,5,0,25)
    artList.BackgroundColor3 = Color3.fromRGB(40,40,40)
    artList.BorderSizePixel = 0
    artList.ScrollBarThickness = 6

    local layout = Instance.new("UIListLayout", artList)
    layout.Padding = UDim.new(0,2)

    preview = Instance.new("TextLabel", frame)
    preview.Size = UDim2.new(1,-10,0,20)
    preview.Position = UDim2.new(0,5,0,120)
    preview.Text = "Preview: selecione"
    preview.Font = Enum.Font.Code
    preview.TextSize = 12
    preview.TextColor3 = Color3.new(1,1,1)
    preview.BackgroundColor3 = Color3.fromRGB(48,48,48)

    startBtn = Instance.new("TextButton", frame)
    startBtn.Size = UDim2.new(1,-10,0,20)
    startBtn.Position = UDim2.new(0,5,0,135)
    startBtn.Text = "COMEÇAR"
    startBtn.BackgroundColor3 = Color3.fromRGB(180,50,50)
    startBtn.TextColor3 = Color3.new(1,1,1)
    startBtn.BorderSizePixel = 0

    -- ======================
    -- CONEXÕES DE EVENTOS
    -- ======================
    toggleBtn.MouseButton1Click:Connect(function()
        frame.Visible = not frame.Visible
    end)

    startBtn.MouseButton1Click:Connect(function()
        loopActive = not loopActive
        startBtn.Text = loopActive and "PARAR" or "COMEÇAR"
        startBtn.BackgroundColor3 = loopActive
            and Color3.fromRGB(50,180,50)
            or Color3.fromRGB(180,50,50)
    end)

    -- ======================
    -- POPULAR LISTA DE ARTES
    -- ======================
    for _, slot in ipairs(ARTS) do
        local btn = Instance.new("TextButton", artList)
        btn.Size = UDim2.new(1,0,0,20)
        btn.Text = slot.name
        btn.TextSize = 12
        btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.BorderSizePixel = 0

        btn.MouseButton1Click:Connect(function()
            selectedMap = slot.map
            preview.Text = "Preview: "..slot.name
        end)
    end

    -- ======================
    -- RESTAURAR ESTADO
    -- ======================
    if selectedMap then
        preview.Text = "Preview: "..(selectedMap.name or "arte_selecionada")
    end
    
    if loopActive then
        startBtn.Text = "PARAR"
        startBtn.BackgroundColor3 = Color3.fromRGB(50,180,50)
    else
        startBtn.Text = "COMEÇAR"
        startBtn.BackgroundColor3 = Color3.fromRGB(180,50,50)
    end

    return gui
end

-- ======================
-- SISTEMA DE MONITORAMENTO ANTI-MORTE
-- ======================
local function monitorGUI()
    while true do
        -- Verifica se o PlayerGui existe
        local playerGui = player:FindFirstChild("PlayerGui")
        if not playerGui then
            task.wait(1)
            continue
        end

        -- Verifica se a GUI ainda está no PlayerGui
        local existingGui = playerGui:FindFirstChild("PixelPainterHUD")
        if not existingGui then
            -- Recria a GUI
            createOrUpdateGUI()
            warn("[Pixel Painter] GUI recriada após morte/respawn")
        end

        task.wait(2) -- Verifica a cada 2 segundos
    end
end

-- ======================
-- INICIALIZAÇÃO
-- ======================
-- Espera o PlayerGui estar disponível
if not player:FindFirstChild("PlayerGui") then
    player.CharacterAdded:Wait()
    task.wait(1)
end

-- Cria a GUI inicial
createOrUpdateGUI()

-- Inicia o monitoramento
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

-- ======================
-- CONEXÃO PARA RENASCIMENTO
-- ======================
player.CharacterAdded:Connect(function()
    task.wait(1) -- Espera o PlayerGui ser recriado
    if not player.PlayerGui:FindFirstChild("PixelPainterHUD") then
        createOrUpdateGUI()
        warn("[Pixel Painter] GUI recriada após respawn do personagem")
    end
end)

-- Garante que a GUI seja recriada se o PlayerGui for resetado
player:GetPropertyChangedSignal("PlayerGui"):Connect(function()
    task.wait(0.5)
    if not player.PlayerGui:FindFirstChild("PixelPainterHUD") then
        createOrUpdateGUI()
        warn("[Pixel Painter] GUI recriada após mudança no PlayerGui")
    end
end)

print("🎨 Pixel Painter HUD carregada (sistema anti-morte ativado)")
