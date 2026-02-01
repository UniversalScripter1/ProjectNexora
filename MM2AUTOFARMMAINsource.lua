--// BACKGROUND AUTO-REJOIN MODULE
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer

local function onErrorMessageChanged(errorMessage)
    if errorMessage and errorMessage ~= "" then
        if player then
            task.wait(1)
            TeleportService:Teleport(game.PlaceId, player)
        end
    end
end
GuiService.ErrorMessageChanged:Connect(onErrorMessageChanged)

--// ==================== PROJECT NEXORA - COIN FARM ====================
-- STYLE: macOS Full Logic | REVISED: Logic Cleanup | VERSION: 5.2.1

local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local StartTime = os.time()

-- Logic Variables
local FarmEnabled = false
local MenuOpen = false
local AutoResetEnabled = true
local ActiveNotifications = {}

-- Config
local Config = {
    FarmSpeed = 28, 
    MaxDistance = 500,
    FileName = "AutoFarmNexora.lua",
    MainFont = Enum.Font.GothamMedium,
    BoldFont = Enum.Font.GothamBold,
    GoldColor = Color3.fromRGB(255, 215, 0)
}

--// 1. GLOBAL NOTIFICATION SYSTEM
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NexoraUI_V52"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local NotifContainer = Instance.new("Frame")
NotifContainer.Size = UDim2.new(0, 280, 1, -40)
NotifContainer.Position = UDim2.new(1, -290, 0, 20)
NotifContainer.BackgroundTransparency = 1
NotifContainer.Parent = ScreenGui

local function SendMacNotif(title, msg, iconId)
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Size = UDim2.new(1, 0, 0, 65)
    NotifFrame.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
    NotifFrame.Position = UDim2.new(1.5, 0, 0, 0)
    NotifFrame.BorderSizePixel = 0
    NotifFrame.Parent = NotifContainer
    
    Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0, 12)
    local Stroke = Instance.new("UIStroke", NotifFrame)
    Stroke.Color = Color3.fromRGB(220, 220, 220)

    local T = Instance.new("TextLabel")
    T.Text = title
    T.Size = UDim2.new(1, -20, 0, 25)
    T.Position = UDim2.new(0, 10, 0, 8)
    T.Font = Config.BoldFont
    T.TextColor3 = Color3.fromRGB(50, 50, 50)
    T.TextSize = 13
    T.BackgroundTransparency = 1
    T.TextXAlignment = Enum.TextXAlignment.Left
    T.Parent = NotifFrame

    local M = Instance.new("TextLabel")
    M.Text = msg
    M.Size = UDim2.new(1, -20, 0, 20)
    M.Position = UDim2.new(0, 10, 0, 28)
    M.Font = Config.MainFont
    M.TextColor3 = Color3.fromRGB(100, 100, 100)
    M.TextSize = 11
    M.BackgroundTransparency = 1
    M.TextXAlignment = Enum.TextXAlignment.Left
    M.TextWrapped = true
    M.Parent = NotifFrame

    table.insert(ActiveNotifications, 1, NotifFrame)
    for i, v in ipairs(ActiveNotifications) do
        TweenService:Create(v, TweenInfo.new(0.4), {Position = UDim2.new(0, 0, 0, (i - 1) * 75)}):Play()
    end
    
    task.delay(5, function()
        local slide = TweenService:Create(NotifFrame, TweenInfo.new(0.5), {Position = UDim2.new(1.5, 0, 0, NotifFrame.Position.Y.Offset)})
        slide:Play()
        slide.Completed:Wait()
        for i, v in ipairs(ActiveNotifications) do if v == NotifFrame then table.remove(ActiveNotifications, i) break end end
        NotifFrame:Destroy()
    end)
end

--// 2. UTILS
local function ApplyHapticEffect(button, originalColor)
    local originalSize = button.Size
    local targetSize = UDim2.new(originalSize.X.Scale, originalSize.X.Offset - 6, originalSize.Y.Scale, originalSize.Y.Offset - 4)
    TweenService:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Back), {Size = targetSize, BackgroundColor3 = Config.GoldColor}):Play()
    task.delay(0.1, function()
        TweenService:Create(button, TweenInfo.new(0.15), {Size = originalSize, BackgroundColor3 = originalColor}):Play()
    end)
end

--// 3. MAIN WINDOW
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 180)
MainFrame.Position = UDim2.new(0.5, -130, 0.4, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundTransparency = 1
TitleBar.Parent = MainFrame

local function CreateLight(color, pos)
    local light = Instance.new("Frame")
    light.Size = UDim2.new(0, 11, 0, 11)
    light.Position = pos
    light.BackgroundColor3 = color
    light.Parent = TitleBar
    Instance.new("UICorner", light).CornerRadius = UDim.new(1, 0)
end
CreateLight(Color3.fromRGB(255, 95, 87), UDim2.new(0, 12, 0, 12))
CreateLight(Color3.fromRGB(255, 189, 46), UDim2.new(0, 28, 0, 12))

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Text = "Project Nexora | Coin farm"
TitleLabel.Size = UDim2.new(1, -80, 0, 35)
TitleLabel.Position = UDim2.new(0, 45, 0, 0)
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.TextColor3 = Color3.fromRGB(40, 40, 40)
TitleLabel.TextSize = 12
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.BackgroundTransparency = 1
TitleLabel.Parent = TitleBar

local MoreBtn = Instance.new("TextButton")
MoreBtn.Size = UDim2.new(0, 30, 0, 30)
MoreBtn.Position = UDim2.new(1, -35, 0, 2)
MoreBtn.BackgroundTransparency = 1
MoreBtn.Text = "•••"
MoreBtn.Font = Config.BoldFont
MoreBtn.TextSize = 18
MoreBtn.TextColor3 = Color3.fromRGB(100, 100, 100)
MoreBtn.Parent = TitleBar

--// 4. LABELS
local SessionLabel = Instance.new("TextLabel", MainFrame)
SessionLabel.Size = UDim2.new(1, -40, 0, 20)
SessionLabel.Position = UDim2.new(0, 20, 0, 45)
SessionLabel.BackgroundTransparency = 1
SessionLabel.Font = Config.MainFont
SessionLabel.TextSize = 11
SessionLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
SessionLabel.TextXAlignment = Enum.TextXAlignment.Left
SessionLabel.Text = "Session: 00:00:00"

local StatusText = Instance.new("TextLabel", MainFrame)
StatusText.Size = UDim2.new(1, -40, 0, 20)
StatusText.Position = UDim2.new(0, 20, 0, 65)
StatusText.BackgroundTransparency = 1
StatusText.Font = Config.MainFont
StatusText.TextSize = 11
StatusText.TextColor3 = Color3.fromRGB(100, 100, 100)
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Text = "Status: Idle"

--// 5. SIDEBAR
local SideMenu = Instance.new("ScrollingFrame")
SideMenu.Size = UDim2.new(0, 160, 0, 210)
SideMenu.Position = UDim2.new(1, 8, 0, 0)
SideMenu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SideMenu.Visible = false
SideMenu.ScrollBarThickness = 2
SideMenu.CanvasSize = UDim2.new(0, 0, 0, 380)
SideMenu.Parent = MainFrame
Instance.new("UICorner", SideMenu).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", SideMenu).Color = Color3.fromRGB(210, 210, 210)

local SideLayout = Instance.new("UIListLayout", SideMenu)
SideLayout.Padding = UDim.new(0, 5)
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function CreateSideBtn(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    btn.Text = text
    btn.Font = Config.BoldFont
    btn.TextSize = 11
    btn.TextColor3 = Color3.fromRGB(60, 60, 60)
    btn.Parent = SideMenu
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function() 
        ApplyHapticEffect(btn, Color3.fromRGB(245, 245, 245))
        callback() 
    end)
    return btn
end

-- Speed Input
local SpeedLabel = Instance.new("TextLabel", SideMenu)
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Text = "Farm Speed"
SpeedLabel.Font = Config.BoldFont
SpeedLabel.TextSize = 11
SpeedLabel.TextColor3 = Color3.fromRGB(80, 80, 80)
SpeedLabel.BackgroundTransparency = 1

local SpeedInput = Instance.new("TextBox", SideMenu)
SpeedInput.Size = UDim2.new(1, -16, 0, 30)
SpeedInput.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
SpeedInput.Text = tostring(Config.FarmSpeed)
SpeedInput.Font = Config.MainFont
SpeedInput.TextSize = 12
SpeedInput.TextColor3 = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", SpeedInput).CornerRadius = UDim.new(0, 6)

SpeedInput.FocusLost:Connect(function()
    local val = tonumber(SpeedInput.Text)
    if val then
        Config.FarmSpeed = val
        SendMacNotif("Speed Updated", "Set to: "..val)
    else
        SpeedInput.Text = tostring(Config.FarmSpeed)
    end
end)

CreateSideBtn("Auto Execute", function()
    if writefile then writefile(Config.FileName, [[loadstring(game:HttpGet("https://pastefy.app/YtiaY6EJ/raw"))()]]) end
    SendMacNotif("System", "Auto-execute saved.")
end)

local ResetToggle = CreateSideBtn("Auto Reset: ON", function()
    AutoResetEnabled = not AutoResetEnabled
    ResetToggle.Text = "Auto Reset: " .. (AutoResetEnabled and "ON" or "OFF")
end)

CreateSideBtn("Server Hop", function() TeleportService:Teleport(game.PlaceId) end)
CreateSideBtn("Destroy GUI", function() ScreenGui:Destroy() end)

MoreBtn.MouseButton1Click:Connect(function() MenuOpen = not MenuOpen SideMenu.Visible = MenuOpen end)

--// 6. TOGGLE
local ToggleBtn = Instance.new("TextButton", MainFrame)
ToggleBtn.Size = UDim2.new(0, 220, 0, 45)
ToggleBtn.Position = UDim2.new(0.5, -110, 0, 110)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(210, 210, 210)
ToggleBtn.Text = "START FARM"
ToggleBtn.Font = Config.BoldFont
ToggleBtn.TextColor3 = Color3.fromRGB(60, 60, 60)
ToggleBtn.TextSize = 14
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 10)

ToggleBtn.MouseButton1Click:Connect(function()
    FarmEnabled = not FarmEnabled
    local baseCol = FarmEnabled and Color3.fromRGB(0, 122, 255) or Color3.fromRGB(210, 210, 210)
    ApplyHapticEffect(ToggleBtn, baseCol)
    ToggleBtn.Text = FarmEnabled and "STOP FARM" or "START FARM"
    ToggleBtn.BackgroundColor3 = baseCol
    ToggleBtn.TextColor3 = FarmEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 60, 60)
    StatusText.Text = FarmEnabled and "Status: Farming..." or "Status: Idle"
end)

--// 7. MAIN LOOPS
task.spawn(function()
    while task.wait(1) do
        if not ScreenGui.Parent then break end
        local sec = os.time() - StartTime
        SessionLabel.Text = string.format("Session Time: %02d:%02d:%02d", math.floor(sec/3600), math.floor((sec%3600)/60), sec%60)
    end
end)

task.spawn(function()
    while task.wait(0.2) do
        if not ScreenGui.Parent then break end
        if FarmEnabled then
            pcall(function()
                local char = Player.Character
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp and char.Humanoid.Health > 0 then
                    local container = nil
                    for _, v in workspace:GetChildren() do if v:IsA("Model") and v:FindFirstChild("CoinContainer") then container = v.CoinContainer break end end
                    if container then
                        local coin, shortDist = nil, Config.MaxDistance
                        for _, c in pairs(container:GetChildren()) do
                            if c:IsA("BasePart") and c:FindFirstChild("TouchInterest") then
                                local d = (hrp.Position - c.Position).Magnitude
                                if d < shortDist then shortDist = d coin = c end
                            end
                        end
                        if coin then
                            local t = math.clamp(shortDist/Config.FarmSpeed, 0.4, 3.5)
                            TweenService:Create(hrp, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame = CFrame.new(coin.Position + Vector3.new(0, 2, 0))}):Play()
                            task.wait(t + 0.05)
                            firetouchinterest(hrp, coin, 0)
                            firetouchinterest(hrp, coin, 1)
                        end
                    end
                end
            end)
        end
    end
end)

SendMacNotif("Welcome!", "Project Nexora V5.2.1 Loaded.")
    T.Size = UDim2.new(1, -20, 0, 25)
    T.Position = UDim2.new(0, 10, 0, 8)
    T.Font = Config.BoldFont
    T.TextColor3 = Color3.fromRGB(50, 50, 50)
    T.TextSize = 13
    T.BackgroundTransparency = 1
    T.TextXAlignment = Enum.TextXAlignment.Left
    T.Parent = NotifFrame

    local M = Instance.new("TextLabel")
    M.Text = msg
    M.Size = UDim2.new(1, -20, 0, 20)
    M.Position = UDim2.new(0, 10, 0, 28)
    M.Font = Config.MainFont
    M.TextColor3 = Color3.fromRGB(100, 100, 100)
    M.TextSize = 11
    M.BackgroundTransparency = 1
    M.TextXAlignment = Enum.TextXAlignment.Left
    M.Parent = NotifFrame

    table.insert(ActiveNotifications, 1, NotifFrame)
    for i, v in ipairs(ActiveNotifications) do
        TweenService:Create(v, TweenInfo.new(0.4), {Position = UDim2.new(0, 0, 0, (i - 1) * 75)}):Play()
    end
    task.delay(4, function() NotifFrame:Destroy() end)
end

--// 2. MAIN WINDOW
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 180)
MainFrame.Position = UDim2.new(0.5, -130, 0.4, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundTransparency = 1
TitleBar.Parent = MainFrame

local function CreateLight(color, pos)
    local light = Instance.new("Frame")
    light.Size = UDim2.new(0, 11, 0, 11)
    light.Position = pos
    light.BackgroundColor3 = color
    light.Parent = TitleBar
    Instance.new("UICorner", light).CornerRadius = UDim.new(1, 0)
end
CreateLight(Color3.fromRGB(255, 95, 87), UDim2.new(0, 12, 0, 12))
CreateLight(Color3.fromRGB(255, 189, 46), UDim2.new(0, 28, 0, 12))

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Text = "Project Nexora | Coin farm"
TitleLabel.Size = UDim2.new(1, -80, 0, 35)
TitleLabel.Position = UDim2.new(0, 45, 0, 0)
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.TextColor3 = Color3.fromRGB(40, 40, 40)
TitleLabel.TextSize = 12
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.BackgroundTransparency = 1
TitleLabel.Parent = TitleBar

local MoreBtn = Instance.new("TextButton")
MoreBtn.Size = UDim2.new(0, 30, 0, 30)
MoreBtn.Position = UDim2.new(1, -35, 0, 2)
MoreBtn.BackgroundTransparency = 1
MoreBtn.Text = "•••"
MoreBtn.Font = Config.BoldFont
MoreBtn.TextSize = 18
MoreBtn.TextColor3 = Color3.fromRGB(100, 100, 100)
MoreBtn.Parent = TitleBar

--// 3. STATUS LABELS
local SessionLabel = Instance.new("TextLabel", MainFrame)
SessionLabel.Size = UDim2.new(1, -40, 0, 20)
SessionLabel.Position = UDim2.new(0, 20, 0, 45)
SessionLabel.BackgroundTransparency = 1
SessionLabel.Font = Config.MainFont
SessionLabel.TextSize = 11
SessionLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
SessionLabel.TextXAlignment = Enum.TextXAlignment.Left
SessionLabel.Text = "Session Time: 00:00:00"

local StatusText = Instance.new("TextLabel", MainFrame)
StatusText.Size = UDim2.new(1, -40, 0, 20)
StatusText.Position = UDim2.new(0, 20, 0, 65)
StatusText.BackgroundTransparency = 1
StatusText.Font = Config.MainFont
StatusText.TextSize = 11
StatusText.TextColor3 = Color3.fromRGB(100, 100, 100)
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Text = "Status: Idle"

--// 4. SIDE MENU (3 DOTS)
local SideMenu = Instance.new("ScrollingFrame")
SideMenu.Size = UDim2.new(0, 160, 0, 210) -- Increased height for input
SideMenu.Position = UDim2.new(1, 8, 0, 0)
SideMenu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SideMenu.Visible = false
SideMenu.ScrollBarThickness = 2
SideMenu.CanvasSize = UDim2.new(0, 0, 0, 350)
SideMenu.Parent = MainFrame
Instance.new("UICorner", SideMenu).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", SideMenu).Color = Color3.fromRGB(210, 210, 210)

local SideLayout = Instance.new("UIListLayout", SideMenu)
SideLayout.Padding = UDim.new(0, 5)
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- SPEED INPUT MODULE
local SpeedLabel = Instance.new("TextLabel", SideMenu)
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Text = "Farm Speed"
SpeedLabel.Font = Config.BoldFont
SpeedLabel.TextSize = 11
SpeedLabel.TextColor3 = Color3.fromRGB(80, 80, 80)
SpeedLabel.BackgroundTransparency = 1

local SpeedInput = Instance.new("TextBox", SideMenu)
SpeedInput.Size = UDim2.new(1, -16, 0, 30)
SpeedInput.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
SpeedInput.Text = tostring(Config.FarmSpeed)
SpeedInput.Font = Config.MainFont
SpeedInput.TextSize = 12
SpeedInput.TextColor3 = Color3.fromRGB(50, 50, 50)
SpeedInput.PlaceholderText = "Enter Speed..."
Instance.new("UICorner", SpeedInput).CornerRadius = UDim.new(0, 6)

SpeedInput.FocusLost:Connect(function(enterPressed)
    local val = tonumber(SpeedInput.Text)
    if val then
        Config.FarmSpeed = val
        SendMacNotif("Speed Updated", "Speed set to: "..val)
    else
        SpeedInput.Text = tostring(Config.FarmSpeed)
    end
end)

local function CreateSideBtn(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    btn.Text = text
    btn.Font = Config.BoldFont
    btn.TextSize = 11
    btn.TextColor3 = Color3.fromRGB(60, 60, 60)
    btn.Parent = SideMenu
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

CreateSideBtn("Auto Execute", function()
    if writefile then writefile(Config.FileName, [[loadstring(game:HttpGet("https://pastefy.app/YtiaY6EJ/raw"))()]]) end
    SendMacNotif("System", "Auto-execute saved.")
end)
CreateSideBtn("Fling Panel", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/UniversalScripter1/ProjectNexora/refs/heads/main/UltraFling.lua"))() end)
CreateSideBtn("Server Hop", function() TeleportService:Teleport(game.PlaceId) end)
CreateSideBtn("Destroy GUI", function() ScreenGui:Destroy() end)

MoreBtn.MouseButton1Click:Connect(function() MenuOpen = not MenuOpen SideMenu.Visible = MenuOpen end)

--// 5. MAIN TOGGLE
local ToggleBtn = Instance.new("TextButton", MainFrame)
ToggleBtn.Size = UDim2.new(0, 220, 0, 45)
ToggleBtn.Position = UDim2.new(0.5, -110, 0, 110)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(210, 210, 210)
ToggleBtn.Text = "START FARM"
ToggleBtn.Font = Config.BoldFont
ToggleBtn.TextColor3 = Color3.fromRGB(60, 60, 60)
ToggleBtn.TextSize = 14
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 10)

ToggleBtn.MouseButton1Click:Connect(function()
    FarmEnabled = not FarmEnabled
    ToggleBtn.Text = FarmEnabled and "STOP FARM" or "START FARM"
    ToggleBtn.BackgroundColor3 = FarmEnabled and Color3.fromRGB(0, 122, 255) or Color3.fromRGB(210, 210, 210)
    ToggleBtn.TextColor3 = FarmEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 60, 60)
    StatusText.Text = FarmEnabled and "Status: Farming..." or "Status: Idle"
    
    if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character.Humanoid.AutoRotate = not FarmEnabled
        Player.DevCameraOcclusionMode = FarmEnabled and Enum.DevCameraOcclusionMode.Invisicam or Enum.DevCameraOcclusionMode.Zoom
    end
end)

--// 6. AUTO RESET LOGIC
local Remote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Gameplay") and ReplicatedStorage.Remotes.Gameplay:FindFirstChild("CoinCollected")
if Remote then
    Remote.OnClientEvent:Connect(function(_, current, max)
        if FarmEnabled and current >= max then
            StatusText.Text = "Status: Bag Full! Resetting..."
            SendMacNotif("Inventory", "Bag full! Resetting.")
            task.wait(0.5)
            if Player.Character then Player.Character:BreakJoints() end
        end
    end)
end

--// 7. LOOPS
task.spawn(function()
    while task.wait(1) do
        local sec = os.time() - StartTime
        SessionLabel.Text = string.format("Session Time: %02d:%02d:%02d", math.floor(sec/3600), math.floor((sec%3600)/60), sec%60)
    end
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if FarmEnabled then
            pcall(function()
                local char = Player.Character
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp and char.Humanoid.Health > 0 then
                    local container = nil
                    for _, v in workspace:GetChildren() do if v:IsA("Model") and v:FindFirstChild("CoinContainer") then container = v.CoinContainer break end end
                    if container then
                        local coin, shortDist = nil, Config.MaxDistance
                        for _, c in pairs(container:GetChildren()) do
                            if c:IsA("BasePart") and c:FindFirstChild("TouchInterest") then
                                local d = (hrp.Position - c.Position).Magnitude
                                if d < shortDist then shortDist = d coin = c end
                            end
                        end
                        if coin then
                            local t = (hrp.Position - coin.Position).Magnitude / Config.FarmSpeed
                            local tween = TweenService:Create(hrp, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame = CFrame.new(coin.Position)})
                            tween:Play()
                            local conn = RunService.Heartbeat:Connect(function()
                                hrp.Velocity, hrp.RotVelocity = Vector3.zero, Vector3.zero
                            end)
                            tween.Completed:Wait()
                            conn:Disconnect()
                            firetouchinterest(hrp, coin, 0)
                            firetouchinterest(hrp, coin, 1)
                        end
                    end
                end
            end)
        end
    end
end)

SendMacNotif("Project Nexora", "V5.2: Speed Input added to Sidebar.")
    NotifFrame.Position = UDim2.new(1.5, 0, 0, 0)
    NotifFrame.BorderSizePixel = 0
    NotifFrame.ZIndex = 1000
    NotifFrame.Parent = NotifContainer
    
    Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0, 12)
    local Stroke = Instance.new("UIStroke", NotifFrame)
    Stroke.Color = Color3.fromRGB(220, 220, 220)
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local Icon = Instance.new("ImageLabel")
    Icon.Size = UDim2.new(0, 35, 0, 35)
    Icon.Position = UDim2.new(0, 10, 0.5, -17)
    Icon.BackgroundTransparency = 1
    Icon.Image = iconId or "rbxassetid://6031289232"
    Icon.ZIndex = 1001
    Icon.Parent = NotifFrame

    local T = Instance.new("TextLabel")
    T.Text = title
    T.Size = UDim2.new(1, -60, 0, 25)
    T.Position = UDim2.new(0, 55, 0, 8)
    T.Font = Config.BoldFont
    T.TextColor3 = Color3.fromRGB(50, 50, 50)
    T.TextSize = 13
    T.TextXAlignment = Enum.TextXAlignment.Left
    T.BackgroundTransparency = 1
    T.ZIndex = 1001
    T.Parent = NotifFrame

    local M = Instance.new("TextLabel")
    M.Text = msg
    M.Size = UDim2.new(1, -60, 0, 20)
    M.Position = UDim2.new(0, 55, 0, 28)
    M.Font = Config.MainFont
    M.TextColor3 = Color3.fromRGB(100, 100, 100)
    M.TextSize = 11
    M.TextXAlignment = Enum.TextXAlignment.Left
    M.TextWrapped = true
    M.BackgroundTransparency = 1
    M.ZIndex = 1001
    M.Parent = NotifFrame

    table.insert(ActiveNotifications, 1, NotifFrame)
    for i, v in ipairs(ActiveNotifications) do
        TweenService:Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, (i - 1) * 75)}):Play()
    end

    task.delay(5, function()
        pcall(function()
            local slide = TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1.5, 0, 0, NotifFrame.Position.Y.Offset)})
            slide:Play()
            slide.Completed:Wait()
            for i, v in ipairs(ActiveNotifications) do if v == NotifFrame then table.remove(ActiveNotifications, i) break end end
            NotifFrame:Destroy()
        end)
    end)
end

--// 2. HAPTIC LOGIC
local function ApplyHapticEffect(button, originalColor)
    local originalSize = button.Size
    local targetSize = UDim2.new(originalSize.X.Scale, originalSize.X.Offset - 6, originalSize.Y.Scale, originalSize.Y.Offset - 4)
    TweenService:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = targetSize, BackgroundColor3 = Config.GoldColor}):Play()
    task.delay(0.1, function()
        TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = originalSize, BackgroundColor3 = originalColor or Color3.fromRGB(245, 245, 245)}):Play()
    end)
end

--// 3. MAIN WINDOW
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 180)
MainFrame.Position = UDim2.new(0.5, -130, 0.4, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundTransparency = 1
TitleBar.ZIndex = 10
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Text = "Project Nexora | Coin farm"
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Position = UDim2.new(0, 45, 0, 0)
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.TextColor3 = Color3.fromRGB(40, 40, 40)
TitleLabel.TextSize = 12
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.BackgroundTransparency = 1
TitleLabel.ZIndex = 11
TitleLabel.Parent = TitleBar

local function CreateLight(color, pos)
    local light = Instance.new("Frame")
    light.Size = UDim2.new(0, 11, 0, 11)
    light.Position = pos
    light.BackgroundColor3 = color
    light.ZIndex = 12
    light.Parent = TitleBar
    Instance.new("UICorner", light).CornerRadius = UDim.new(1, 0)
end
CreateLight(Color3.fromRGB(255, 95, 87), UDim2.new(0, 12, 0, 12))
CreateLight(Color3.fromRGB(255, 189, 46), UDim2.new(0, 28, 0, 12))

local MoreBtn = Instance.new("TextButton")
MoreBtn.Size = UDim2.new(0, 30, 0, 30)
MoreBtn.Position = UDim2.new(1, -35, 0, 2)
MoreBtn.BackgroundTransparency = 1
MoreBtn.Text = "•••"
MoreBtn.Font = Config.BoldFont
MoreBtn.TextSize = 18
MoreBtn.TextColor3 = Color3.fromRGB(100, 100, 100)
MoreBtn.ZIndex = 12
MoreBtn.Parent = TitleBar

--// 4. SIDEBAR (RESIZED & FONT UPDATED)
local SideMenu = Instance.new("ScrollingFrame")
SideMenu.Size = UDim2.new(0, 160, 0, 200)
SideMenu.Position = UDim2.new(1, 8, 0, 0)
SideMenu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SideMenu.BorderSizePixel = 0
SideMenu.Visible = false
SideMenu.ScrollBarThickness = 3
SideMenu.CanvasSize = UDim2.new(0, 0, 0, 420)
SideMenu.ZIndex = 15
SideMenu.Parent = MainFrame
Instance.new("UICorner", SideMenu).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", SideMenu).Color = Color3.fromRGB(210, 210, 210)

local SideLayout = Instance.new("UIListLayout", SideMenu)
SideLayout.Padding = UDim.new(0, 8)
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function CreateSideBtn(text, order, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    btn.Text = text
    btn.Font = Config.BoldFont
    btn.TextSize = 11
    btn.TextColor3 = Color3.fromRGB(60, 60, 60)
    btn.LayoutOrder = order
    btn.ZIndex = 16
    btn.Parent = SideMenu
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(function() ApplyHapticEffect(btn, Color3.fromRGB(245, 245, 245)) callback() end)
    return btn
end

-- FIXED QUOTATION ERROR BELOW
CreateSideBtn("Auto Execute", 1, function()
    if writefile then 
        writefile(Config.FileName, [[loadstring(game:HttpGet("https://pastefy.app/YtiaY6EJ/raw"))()]]) 
    end
    SendMacNotif("System", "Script saved to executor folder.", "rbxassetid://6023426926")
end)

local ResetToggle = CreateSideBtn("Auto Reset: ON", 2, function()
    AutoResetEnabled = not AutoResetEnabled
    ResetToggle.Text = "Auto Reset: " .. (AutoResetEnabled and "ON" or "OFF")
    ResetToggle.BackgroundColor3 = AutoResetEnabled and Color3.fromRGB(220, 255, 220) or Color3.fromRGB(255, 220, 220)
    SendMacNotif("Settings", "Auto Reset is now "..(AutoResetEnabled and "Enabled" or "Disabled"), "rbxassetid://6023426915")
end)

CreateSideBtn("Fling Panel", 3, function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/UniversalScripter1/ProjectNexora/refs/heads/main/UltraFling.lua"))()
    SendMacNotif("Module Loaded", "Fling Panel has been executed.", "rbxassetid://6023426917")
end)

CreateSideBtn("Destroy GUI", 4, function()
    FarmEnabled = false
    ScreenGui:Destroy()
end)

local SpeedLabel = Instance.new("TextLabel", SideMenu)
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Text = "Farm Speed (Risky)"
SpeedLabel.Font = Config.BoldFont
SpeedLabel.TextSize = 11
SpeedLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.LayoutOrder = 5

local SpeedInput = Instance.new("TextBox", SideMenu)
SpeedInput.Size = UDim2.new(1, -16, 0, 36)
SpeedInput.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
SpeedInput.Text = tostring(Config.FarmSpeed)
SpeedInput.Font = Config.MainFont
SpeedInput.TextSize = 12
SpeedInput.TextColor3 = Color3.fromRGB(50, 50, 50)
SpeedInput.LayoutOrder = 6
SpeedInput.ZIndex = 16
Instance.new("UICorner", SpeedInput).CornerRadius = UDim.new(0, 8)

SpeedInput.FocusLost:Connect(function()
    local val = tonumber(SpeedInput.Text)
    if val then
        Config.FarmSpeed = val
        SendMacNotif("Speed Config", "Speed set to: "..val, "rbxassetid://6023426917")
    else SpeedInput.Text = tostring(Config.FarmSpeed) end
end)

CreateSideBtn("Server Hop", 7, function() TeleportService:Teleport(game.PlaceId) end)
CreateSideBtn("Rejoin", 8, function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId) end)

MoreBtn.MouseButton1Click:Connect(function() MenuOpen = not MenuOpen SideMenu.Visible = MenuOpen end)

--// 5. TOGGLE BUTTON & LABELS
local SessionLabel = Instance.new("TextLabel", MainFrame)
SessionLabel.Size = UDim2.new(1, -40, 0, 20)
SessionLabel.Position = UDim2.new(0, 20, 0, 45)
SessionLabel.BackgroundTransparency = 1
SessionLabel.Font = Config.MainFont
SessionLabel.TextSize = 11
SessionLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
SessionLabel.TextXAlignment = Enum.TextXAlignment.Left

local TimeLabel = Instance.new("TextLabel", MainFrame)
TimeLabel.Size = UDim2.new(1, -40, 0, 20)
TimeLabel.Position = UDim2.new(0, 20, 0, 65)
TimeLabel.BackgroundTransparency = 1
TimeLabel.Font = Config.MainFont
TimeLabel.TextSize = 11
TimeLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
TimeLabel.TextXAlignment = Enum.TextXAlignment.Left

local ToggleBtn = Instance.new("TextButton", MainFrame)
ToggleBtn.Size = UDim2.new(0, 220, 0, 45)
ToggleBtn.Position = UDim2.new(0.5, -110, 0, 110)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(210, 210, 210)
ToggleBtn.Text = "START FARM"
ToggleBtn.Font = Config.BoldFont
ToggleBtn.TextColor3 = Color3.fromRGB(60, 60, 60)
ToggleBtn.TextSize = 14
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 10)

ToggleBtn.MouseButton1Click:Connect(function()
    FarmEnabled = not FarmEnabled
    local baseCol = FarmEnabled and Color3.fromRGB(0, 122, 255) or Color3.fromRGB(210, 210, 210)
    ApplyHapticEffect(ToggleBtn, baseCol)
    ToggleBtn.Text = FarmEnabled and "STOP FARM" or "START FARM"
    ToggleBtn.BackgroundColor3 = baseCol
    ToggleBtn.TextColor3 = FarmEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 60, 60)
    SendMacNotif("Farm Status", FarmEnabled and "Automated farm started." or "Automated farm stopped.", FarmEnabled and "rbxassetid://6023426917" or "rbxassetid://6023426923")
end)

--// 6. LOGIC LOOPS
local Remote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Gameplay") and ReplicatedStorage.Remotes.Gameplay:FindFirstChild("CoinCollected")
if Remote then
    Remote.OnClientEvent:Connect(function(_, current, max)
        if FarmEnabled and AutoResetEnabled and current >= max then
            SendMacNotif("Bag Status", "Bag full. Resetting character...", "rbxassetid://6023426923")
            task.wait(0.5)
            if Player.Character then Player.Character:BreakJoints() end
        end
    end)
end

task.spawn(function()
    while task.wait(1) do
        if not ScreenGui or not ScreenGui.Parent then break end
        local sec = os.time() - StartTime
        SessionLabel.Text = string.format("Session Time: %02d:%02d:%02d", math.floor(sec/3600), math.floor((sec%3600)/60), sec%60)
        TimeLabel.Text = "Current Time: " .. os.date("%X")
    end
end)

task.spawn(function()
    while true do
        task.wait(0.2)
        if not ScreenGui or not ScreenGui.Parent then break end
        if FarmEnabled then
            pcall(function()
                local char = Player.Character
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local container = nil
                    for _, v in workspace:GetChildren() do if v:IsA("Model") and v:FindFirstChild("CoinContainer") then container = v.CoinContainer break end end
                    if container then
                        local coin, shortDist = nil, Config.MaxDistance
                        for _, c in pairs(container:GetChildren()) do
                            if c:IsA("BasePart") and c:FindFirstChild("TouchInterest") then
                                local d = (hrp.Position - c.Position).Magnitude
                                if d < shortDist then shortDist = d coin = c end
                            end
                        end
                        if coin then
                            local t = math.clamp(shortDist/Config.FarmSpeed, 0.4, 3.5)
                            TweenService:Create(hrp, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame = CFrame.new(coin.Position + Vector3.new(0, 4, 0)) * CFrame.Angles(math.rad(-90), 0, 0)}):Play()
                            task.wait(t + 0.05)
                            firetouchinterest(hrp, coin, 0)
                            firetouchinterest(hrp, coin, 1)
                        end
                    end
                end
            end)
        end
    end
end)

--// 7. INITIALIZE
SendMacNotif("Welcome!", "Made by @naytansu1\nFollow for more updates!", "rbxassetid://6023426915")
