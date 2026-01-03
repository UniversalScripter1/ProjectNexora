repeat
    task.wait()
until game:IsLoaded()

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:AddTheme({
    ["Name"] = "Dark",
    ["Accent"] = "#18181b",
    ["Dialog"] = "#18181b",
    ["Outline"] = "#FFFFFF",
    ["Text"] = "#FFFFFF",
    ["Placeholder"] = "#999999",
    ["Background"] = "#0e0e10",
    ["Button"] = "#52525b",
    ["Icon"] = "#a1a1aa"
})

WindUI:AddTheme({
    ["Name"] = "Light",
    ["Accent"] = "#f4f4f5",
    ["Dialog"] = "#f4f4f5",
    ["Outline"] = "#000000",
    ["Text"] = "#000000",
    ["Placeholder"] = "#666666",
    ["Background"] = "#ffffff",
    ["Button"] = "#e4e4e7",
    ["Icon"] = "#52525b"
})

WindUI:AddTheme({
    ["Name"] = "Gray",
    ["Accent"] = "#374151",
    ["Dialog"] = "#374151",
    ["Outline"] = "#d1d5db",
    ["Text"] = "#f9fafb",
    ["Placeholder"] = "#9ca3af",
    ["Background"] = "#1f2937",
    ["Button"] = "#4b5563",
    ["Icon"] = "#d1d5db"
})

WindUI:AddTheme({
    ["Name"] = "Blue",
    ["Accent"] = "#1e40af",
    ["Dialog"] = "#1e3a8a",
    ["Outline"] = "#93c5fd",
    ["Text"] = "#f0f9ff",
    ["Placeholder"] = "#60a5fa",
    ["Background"] = "#1e293b",
    ["Button"] = "#3b82f6",
    ["Icon"] = "#93c5fd"
})

WindUI:AddTheme({
    ["Name"] = "Green",
    ["Accent"] = "#059669",
    ["Dialog"] = "#047857",
    ["Outline"] = "#6ee7b7",
    ["Text"] = "#ecfdf5",
    ["Placeholder"] = "#34d399",
    ["Background"] = "#064e3b",
    ["Button"] = "#10b981",
    ["Icon"] = "#6ee7b7"
})

WindUI:AddTheme({
    ["Name"] = "Purple",
    ["Accent"] = "#7c3aed",
    ["Dialog"] = "#6d28d9",
    ["Outline"] = "#c4b5fd",
    ["Text"] = "#faf5ff",
    ["Placeholder"] = "#a78bfa",
    ["Background"] = "#581c87",
    ["Button"] = "#8b5cf6",
    ["Icon"] = "#c4b5fd"
})

WindUI:SetNotificationLower(true)

local ThemesList = {
    "Dark",
    "Light",
    "Gray",
    "Blue",
    "Green",
    "Purple"
}

local CurrentThemeIndex = 1

if not getgenv().TransparencyEnabled then
    getgenv().TransparencyEnabled = false
end

game.StarterGui:SetCore("SendNotification", {
    ["Title"] = "Project Nexora",
    ["Text"] = "Toggle Keybind: ( R )",
    ["Duration"] = 30,
    ["Icon"] = "rbxassetid://89804924525665"
})

local MainWindow = WindUI:CreateWindow({
    ["Title"] = "Project Nexora",
    ["Icon"] = "zap",
    ["Author"] = "Murder Mystery 2",
    ["Folder"] = "Project Nexora",
    ["Size"] = UDim2.fromOffset(500, 350),
    ["Transparent"] = getgenv().TransparencyEnabled,
    ["Theme"] = "Light",
    ["Resizable"] = true,
    ["SideBarWidth"] = 150,
    ["BackgroundImageTransparency"] = 0.8,
    ["HideSearchBar"] = false,
    ["ScrollBarEnabled"] = true,
    ["User"] = {
        ["Enabled"] = false,
        ["Anonymous"] = false,
        ["Callback"] = function()
            CurrentThemeIndex = CurrentThemeIndex + 1
            if CurrentThemeIndex > #ThemesList then
                CurrentThemeIndex = 1
            end
            local NewTheme = ThemesList[CurrentThemeIndex]
            WindUI:SetTheme(NewTheme)
            WindUI:Notify({
                ["Title"] = "Theme Changed",
                ["Content"] = "Switched to " .. NewTheme .. " theme!",
                ["Duration"] = 2,
                ["Icon"] = "palette"
            })
        end
    }
})

-- Force transparency setting to true immediately
getgenv().TransparencyEnabled = true

-- Execute transparency right after GUI creation
pcall(function()
    MainWindow:ToggleTransparency(true)
end)

function getMap()
    for _, Child in ipairs(workspace:GetChildren()) do
        if Child:FindFirstChild("CoinContainer") and Child:FindFirstChild("Spawns") then
            return Child
        end
    end
    return nil
end

loadstring(game:HttpGet("https://pastefy.app/hcVkWhQF/raw"))()

MainWindow:EditOpenButton({
    ["Title"] = "Project Nexora",
    ["CornerRadius"] = UDim.new(0, 6),
    ["StrokeThickness"] = 2,
    ["Color"] = ColorSequence.new(Color3.fromRGB(30, 30, 30), Color3.fromRGB(255, 255, 255)),
    ["Draggable"] = true
})

MainWindow.ToggleKey = Enum.KeyCode.R

local Tabs = {}

Tabs.Main = MainWindow:Tab({
    ["Title"] = "Main",
    ["Icon"] = "eye",
    ["Desc"] = "Project Nexora"
})

Tabs.Misc = MainWindow:Tab({
    ["Title"] = "Misc",
    ["Icon"] = "sparkles",
    ["Desc"] = "Project Nexora"
})

Tabs.ESP = MainWindow:Tab({
    ["Title"] = "ESP",
    ["Icon"] = "eye",
    ["Desc"] = "Project Nexora"
})

Tabs.Farm = MainWindow:Tab({
    ["Title"] = "Farm",
    ["Icon"] = "wrench",
    ["Desc"] = "Project Nexora"
})

Tabs.Place = MainWindow:Tab({
    ["Title"] = "Teleport",
    ["Icon"] = "map",
    ["Desc"] = "Project Nexora"
})

Tabs.Fling = MainWindow:Tab({
    ["Title"] = "Fling",
    ["Icon"] = "user",
    ["Desc"] = "Project Nexora"
})

Tabs.Info = MainWindow:Tab({
    ["Title"] = "Information",
    ["Icon"] = "badge-info",
    ["Desc"] = "Project Nexora"
})

MainWindow:SelectTab(7)

Tabs.Main:Section({
    ["Title"] = "Murder",
    ["Icon"] = "sword"
})

Tabs.Main:Button({
    ["Title"] = "Kill All (hold knife)",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://pastefy.app/2eOpHYrg/raw"))("true")
    end
})

Tabs.Main:Button({
    ["Title"] = "Kill Sheriff (hold knife)",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://pastefy.app/YBXds1as/raw"))("true")
    end
})

Tabs.Main:Button({
    ["Title"] = "Kill Innocents (hold knife)",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://pastefy.app/vmG5vtCc/raw"))("true")
    end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local HitboxSettings = {
    ["Hitbox"] = {
        ["Enabled"] = false,
        ["Size"] = 5,
        ["Color"] = Color3.new(1, 0, 0),
        ["Adornments"] = {},
        ["Connection"] = nil
    }
}

local function UpdateHitboxes()
    if HitboxSettings.Hitbox.Enabled then
        for _, Player in pairs(Players:GetPlayers()) do
            if Player ~= LocalPlayer then
                local Character = Player.Character
                local Adornment = HitboxSettings.Hitbox.Adornments[Player]
                if Character and HitboxSettings.Hitbox.Enabled then
                    local RootPart = Character:FindFirstChild("HumanoidRootPart")
                    if RootPart then
                        if Adornment then
                            Adornment.Size = Vector3.new(HitboxSettings.Hitbox.Size, HitboxSettings.Hitbox.Size, HitboxSettings.Hitbox.Size)
                            Adornment.Color3 = HitboxSettings.Hitbox.Color
                        else
                            local NewAdornment = Instance.new("BoxHandleAdornment")
                            NewAdornment.Adornee = RootPart
                            NewAdornment.Size = Vector3.new(HitboxSettings.Hitbox.Size, HitboxSettings.Hitbox.Size, HitboxSettings.Hitbox.Size)
                            NewAdornment.Color3 = HitboxSettings.Hitbox.Color
                            NewAdornment.Transparency = 0.4
                            NewAdornment.ZIndex = 10
                            NewAdornment.Parent = RootPart
                            HitboxSettings.Hitbox.Adornments[Player] = NewAdornment
                        end
                    end
                elseif Adornment then
                    Adornment:Destroy()
                    HitboxSettings.Hitbox.Adornments[Player] = nil
                end
            end
        end
    end
end

Tabs.Main:Toggle({
    ["Title"] = "Hitboxes",
    ["Callback"] = function(State)
        HitboxSettings.Hitbox.Enabled = State
        if State then
            if not HitboxSettings.Hitbox.Connection then
                HitboxSettings.Hitbox.Connection = RunService.Heartbeat:Connect(UpdateHitboxes)
            end
        else
            if HitboxSettings.Hitbox.Connection then
                HitboxSettings.Hitbox.Connection:Disconnect()
                HitboxSettings.Hitbox.Connection = nil
            end
            for _, Adornment in pairs(HitboxSettings.Hitbox.Adornments) do
                if Adornment then
                    Adornment:Destroy()
                end
            end
            HitboxSettings.Hitbox.Adornments = {}
        end
    end
})

Tabs.Main:Slider({
    ["Title"] = "Hitbox size",
    ["Value"] = {
        ["Min"] = 1,
        ["Max"] = 20,
        ["Default"] = 5
    },
    ["Callback"] = function(Value)
        HitboxSettings.Hitbox.Size = Value
    end
})

Tabs.Main:Colorpicker({
    ["Title"] = "Hitbox color",
    ["Default"] = Color3.new(1, 0, 0),
    ["Callback"] = function(Color)
        HitboxSettings.Hitbox.Color = Color
    end
})

Tabs.Main:Section({
    ["Title"] = "Sheriff",
    ["Icon"] = "heart"
})

Tabs.Main:Button({
    ["Title"] = "Shoot Murderer",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://pastefy.app/IeVSJS2e/raw"))("true")
    end
})

local PlayersService = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = PlayersService.LocalPlayer
local Camera = Workspace.CurrentCamera

local AimbotMasterToggle = false
local AimbotActive = false
local AimbotConnection = nil
local CurrentTarget = nil
local screenGui = nil

-- Function to find the player closest to the center of the screen
local function GetClosestPlayerToCursor()
    local Target = nil
    local ShortestDistance = math.huge
    local MousePos = Camera.ViewportSize / 2

    for _, Player in ipairs(PlayersService:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local RootPart = Player.Character.HumanoidRootPart
            local Pos, OnScreen = Camera:WorldToViewportPoint(RootPart.Position)

            if OnScreen then
                local Distance = (Vector2.new(Pos.X, Pos.Y) - MousePos).Magnitude
                if Distance < ShortestDistance then
                    Target = Player
                    ShortestDistance = Distance
                end
            end
        end
    end
    return Target
end

-- Logic to handle the hard lock-on
local function StartAimbot()
    if AimbotConnection then AimbotConnection:Disconnect() end
    AimbotConnection = RunService.RenderStepped:Connect(function()
        if AimbotMasterToggle and AimbotActive and CurrentTarget and CurrentTarget.Character and CurrentTarget.Character:FindFirstChild("Head") then
            -- Hard lock the camera to the head
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, CurrentTarget.Character.Head.Position)
        elseif AimbotActive and not CurrentTarget then
            CurrentTarget = GetClosestPlayerToCursor()
        end
    end)
end

-- WinUI Toggle Integration
Tabs.Main:Toggle({
    ["Title"] = "Camera Hard-Lock GUI",
    ["Value"] = false,
    ["Callback"] = function(State)
        AimbotMasterToggle = State
        
        if State then
            -- GUI Setup (Exact Original Design)
            local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
            screenGui = Instance.new("ScreenGui")
            screenGui.Name = "CustomJumpGui"
            screenGui.ResetOnSpawn = false
            screenGui.Parent = PlayerGui

            local VERTICAL_OFFSET = 0.10

            local jumpButton = Instance.new("TextButton")
            jumpButton.Name = "JumpButton"
            jumpButton.Size = UDim2.new(0, 90, 0, 90)
            jumpButton.AnchorPoint = Vector2.new(1, 0.5) 
            jumpButton.Position = UDim2.new(1, -10, VERTICAL_OFFSET, 0)
            jumpButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20) 
            jumpButton.BackgroundTransparency = 0.5
            jumpButton.Text = ""
            jumpButton.AutoButtonColor = true
            jumpButton.Parent = screenGui

            local uiCorner = Instance.new("UICorner")
            uiCorner.CornerRadius = UDim.new(1, 0)
            uiCorner.Parent = jumpButton

            local insetStrokeFrame = Instance.new("Frame")
            insetStrokeFrame.Name = "InsetStroke"
            insetStrokeFrame.Size = UDim2.new(0.9, 0, 0.9, 0) 
            insetStrokeFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
            insetStrokeFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            insetStrokeFrame.BackgroundTransparency = 1 
            insetStrokeFrame.Parent = jumpButton

            local insetCorner = Instance.new("UICorner")
            insetCorner.CornerRadius = UDim.new(1, 0)
            insetCorner.Parent = insetStrokeFrame

            local uiStroke = Instance.new("UIStroke")
            uiStroke.Thickness = 2 
            uiStroke.Color = Color3.fromRGB(255, 255, 255) 
            uiStroke.Transparency = 0.5 
            uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            uiStroke.Parent = insetStrokeFrame

            local arrowIcon = Instance.new("ImageLabel")
            arrowIcon.Name = "ArrowIcon"
            arrowIcon.Size = UDim2.new(0.7, 0, 0.7, 0) 
            arrowIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
            arrowIcon.AnchorPoint = Vector2.new(0.5, 0.5)
            arrowIcon.BackgroundTransparency = 1
            arrowIcon.Image = "rbxassetid://17544521115"
            arrowIcon.ImageColor3 = Color3.fromRGB(255, 255, 255) 
            arrowIcon.ImageTransparency = 0.5 
            arrowIcon.Parent = jumpButton

            -- Button Functionality
            jumpButton.MouseButton1Click:Connect(function()
                AimbotActive = not AimbotActive
                
                if AimbotActive then
                    CurrentTarget = GetClosestPlayerToCursor()
                    arrowIcon.ImageColor3 = Color3.fromRGB(255, 0, 0)
                    StarterGui:SetCore("SendNotification", {
                        Title = "Aimbot",
                        Text = "Locked On",
                        Duration = 2
                    })
                    if not AimbotConnection then
                        StartAimbot()
                    end
                else
                    CurrentTarget = nil
                    arrowIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
                end
            end)
        else
            -- Cleanup when toggle is turned OFF
            AimbotActive = false
            CurrentTarget = nil
            if screenGui then
                screenGui:Destroy()
                screenGui = nil
            end
            if AimbotConnection then
                AimbotConnection:Disconnect()
                AimbotConnection = nil
            end
        end
    end
})

local PlayersGun = game:GetService("Players")
local RunServiceGun = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayerGun = PlayersGun.LocalPlayer

_G.GunAimbotArgs = nil
local GunAimbotEnabled = false
local GunAimbotConnection = nil
local InputConnection = nil
local TouchConnection = nil

-- The function that actually fires the gun using your specific remote
local function FireAtMurderer()
    if not GunAimbotEnabled or not _G.GunAimbotArgs then return end
    
    local Character = LocalPlayerGun.Character
    local Gun = Character and Character:FindFirstChild("Gun")
    local ShootRemote = Gun and Gun:FindFirstChild("Shoot")
    
    if ShootRemote then
        -- We use the pre-calculated args from the RenderStepped loop
        ShootRemote:FireServer(unpack(_G.GunAimbotArgs))
    end
end

Tabs.Main:Toggle({
    ["Title"] = "Gun Aimbot (Auto-Target Murderer)",
    ["Value"] = false,
    ["Callback"] = function(State)
        GunAimbotEnabled = State
        
        -- Clean up existing connections to prevent lag/double-firing
        if GunAimbotConnection then GunAimbotConnection:Disconnect() end
        if InputConnection then InputConnection:Disconnect() end
        if TouchConnection then TouchConnection:Disconnect() end

        if State then
            -- Constant Loop to track the Murderer's position
            GunAimbotConnection = RunServiceGun.RenderStepped:Connect(function()
                local TargetPlayer = nil
                for _, Player in ipairs(PlayersGun:GetPlayers()) do
                    if Player ~= LocalPlayerGun then
                        local Backpack = Player:FindFirstChild("Backpack")
                        local Char = Player.Character
                        -- Detection Logic
                        if (Backpack and Backpack:FindFirstChild("Knife")) or (Char and Char:FindFirstChild("Knife")) then
                            TargetPlayer = Player
                            break
                        end
                    end
                end

                if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local MyRoot = LocalPlayerGun.Character and LocalPlayerGun.Character:FindFirstChild("HumanoidRootPart")
                    local TargetRoot = TargetPlayer.Character.HumanoidRootPart
                    
                    if MyRoot then
                        -- PREDICTION: Current Pos + (Velocity * Lead Factor)
                        local PredictedPos = TargetRoot.CFrame + (TargetRoot.Velocity * 0.125)
                        
                        -- Update Global Args for the click event
                        _G.GunAimbotArgs = {
                            MyRoot.CFrame,
                            PredictedPos
                        }
                    end
                else
                    _G.GunAimbotArgs = nil
                end
            end)

            -- Desktop Click Detection
            InputConnection = UserInputService.InputBegan:Connect(function(Input, Processed)
                if not Processed and Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    FireAtMurderer()
                end
            end)

            -- Mobile Tap Detection
            TouchConnection = UserInputService.TouchTap:Connect(function()
                FireAtMurderer()
            end)
        else
            _G.GunAimbotArgs = nil
        end
    end
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

local AutoShootEnabled = false
local currentScreenGui = nil
local inventoryCheckConnection = nil
local hasNotifiedSuccess = false
local hasNotifiedFailure = false

-- Function to send notifications
local function Notify(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

-- Function to find the murderer
local function GetMurderer()
    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character then
            local Knife = Player.Backpack:FindFirstChild("Knife") or Player.Character:FindFirstChild("Knife")
            if Knife then return Player end
        end
    end
    return nil
end

-- The specific combat sequence
local function InstantShootSequence()
    local Character = LocalPlayer.Character
    local Backpack = LocalPlayer:FindFirstChild("Backpack")
    if not Character or not Backpack then return end

    local Gun = Backpack:FindFirstChild("Gun") or Character:FindFirstChild("Gun")
    
    if Gun then
        Gun.Parent = Character
        task.wait()
        
        local ShootRemote = Gun:FindFirstChild("Shoot")
        local Murderer = GetMurderer()
        
        if ShootRemote and Murderer and Murderer.Character:FindFirstChild("HumanoidRootPart") then
            local TargetRoot = Murderer.Character.HumanoidRootPart
            local MyRoot = Character:FindFirstChild("HumanoidRootPart")
            
            if MyRoot then
                local PredictedPos = TargetRoot.CFrame + (TargetRoot.Velocity * 0.125)
                local args = { MyRoot.CFrame, PredictedPos }
                ShootRemote:FireServer(unpack(args))
            end
        end
        
        task.wait()
        Gun.Parent = Backpack
    end
end

-- Function to build your exact GUI
local function CreateCombatGui()
    if currentScreenGui then return end
    
    currentScreenGui = Instance.new("ScreenGui")
    currentScreenGui.Name = "CustomJumpGui"
    currentScreenGui.ResetOnSpawn = false
    currentScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local jumpButton = Instance.new("TextButton")
    jumpButton.Name = "JumpButton"
    jumpButton.Size = UDim2.new(0, 90, 0, 90)
    jumpButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20) 
    jumpButton.BackgroundTransparency = 0.5
    jumpButton.Text = ""
    jumpButton.AutoButtonColor = true
    jumpButton.Parent = currentScreenGui

    local function alignToMobile()
        local touchGui = LocalPlayer.PlayerGui:FindFirstChild("TouchGui")
        if touchGui then
            local controlFrame = touchGui:FindFirstChild("TouchControlFrame")
            local jumpControl = controlFrame and controlFrame:FindFirstChild("JumpButton")
            if jumpControl then
                jumpButton.Position = UDim2.new(
                    jumpControl.Position.X.Scale, 
                    jumpControl.Position.X.Offset - 110, 
                    jumpControl.Position.Y.Scale, 
                    jumpControl.Position.Y.Offset - 110
                )
            end
        else
            jumpButton.Position = UDim2.new(0.85, 0, 0.7, 0)
        end
    end
    alignToMobile()

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = jumpButton

    local insetStrokeFrame = Instance.new("Frame")
    insetStrokeFrame.Name = "InsetStroke"
    insetStrokeFrame.Size = UDim2.new(0.9, 0, 0.9, 0) 
    insetStrokeFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    insetStrokeFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    insetStrokeFrame.BackgroundTransparency = 1 
    insetStrokeFrame.Parent = jumpButton

    local insetCorner = Instance.new("UICorner")
    insetCorner.CornerRadius = UDim.new(1, 0)
    insetCorner.Parent = insetStrokeFrame

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 2 
    uiStroke.Color = Color3.fromRGB(255, 255, 255) 
    uiStroke.Transparency = 0.5 
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Parent = insetStrokeFrame

    local arrowIcon = Instance.new("ImageLabel")
    arrowIcon.Name = "ArrowIcon"
    arrowIcon.Size = UDim2.new(0.7, 0, 0.7, 0) 
    arrowIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    arrowIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    arrowIcon.BackgroundTransparency = 1
    arrowIcon.Image = "rbxassetid://139650104834071"
    arrowIcon.ImageColor3 = Color3.fromRGB(255, 255, 255) 
    arrowIcon.ImageTransparency = 0.5 
    arrowIcon.Parent = jumpButton

    jumpButton.MouseButton1Click:Connect(function()
        InstantShootSequence()
    end)
end

Tabs.Main:Toggle({
    ["Title"] = "Flick Shot Gui",
    ["Value"] = false,
    ["Callback"] = function(State)
        AutoShootEnabled = State
        hasNotifiedSuccess = false
        hasNotifiedFailure = false
        
        if State then
            -- Connection to check for Gun inventory status
            inventoryCheckConnection = RunService.Heartbeat:Connect(function()
                if not AutoShootEnabled then return end
                
                local Backpack = LocalPlayer:FindFirstChild("Backpack")
                local Character = LocalPlayer.Character
                local Gun = (Backpack and Backpack:FindFirstChild("Gun")) or (Character and Character:FindFirstChild("Gun"))
                
                if Gun then
                    if not currentScreenGui then
                        CreateCombatGui()
                        if not hasNotifiedSuccess then
                            Notify("Gun Detected", "Combat Button is now visible.")
                            hasNotifiedSuccess = true
                            hasNotifiedFailure = false -- Reset failure for next time
                        end
                    end
                else
                    if currentScreenGui then
                        currentScreenGui:Destroy()
                        currentScreenGui = nil
                    end
                    if not hasNotifiedFailure then
                        Notify("Ammunition Needed", "You need a Gun to use this feature.")
                        hasNotifiedFailure = true
                        hasNotifiedSuccess = false -- Reset success for next time
                    end
                end
            end)
        else
            -- Cleanup everything
            if inventoryCheckConnection then inventoryCheckConnection:Disconnect() end
            if currentScreenGui then currentScreenGui:Destroy() currentScreenGui = nil end
        end
    end
})


Tabs.Main:Toggle({
    ["Title"] = "Mobile Murderer Button",
    ["Value"] = false,
    ["Callback"] = function(State)
        AutoShootEnabled = State
        
        if State then
            -- EXACT REPLICATION OF YOUR GUI CODE
            currentScreenGui = Instance.new("ScreenGui")
            currentScreenGui.Name = "CustomJumpGui"
            currentScreenGui.ResetOnSpawn = false
            currentScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

            local jumpButton = Instance.new("TextButton")
            jumpButton.Name = "JumpButton"
            jumpButton.Size = UDim2.new(0, 90, 0, 90)
            jumpButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20) 
            jumpButton.BackgroundTransparency = 0.5
            jumpButton.Text = ""
            jumpButton.AutoButtonColor = true
            jumpButton.Parent = currentScreenGui

            -- Positioning Logic: Target the default Mobile Jump Button
            local function alignToMobile()
                local touchGui = LocalPlayer.PlayerGui:FindFirstChild("TouchGui")
                if touchGui then
                    local controlFrame = touchGui:FindFirstChild("TouchControlFrame")
                    local jumpControl = controlFrame and controlFrame:FindFirstChild("JumpButton")
                    if jumpControl then
                        jumpButton.Position = UDim2.new(
                            jumpControl.Position.X.Scale, 
                            jumpControl.Position.X.Offset - 110, 
                            jumpControl.Position.Y.Scale, 
                            jumpControl.Position.Y.Offset - 110
                        )
                    end
                else
                    jumpButton.Position = UDim2.new(0.85, 0, 0.7, 0)
                end
            end
            alignToMobile()

            local uiCorner = Instance.new("UICorner")
            uiCorner.CornerRadius = UDim.new(1, 0)
            uiCorner.Parent = jumpButton

            local insetStrokeFrame = Instance.new("Frame")
            insetStrokeFrame.Name = "InsetStroke"
            insetStrokeFrame.Size = UDim2.new(0.9, 0, 0.9, 0) 
            insetStrokeFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
            insetStrokeFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            insetStrokeFrame.BackgroundTransparency = 1 
            insetStrokeFrame.Parent = jumpButton

            local insetCorner = Instance.new("UICorner")
            insetCorner.CornerRadius = UDim.new(1, 0)
            insetCorner.Parent = insetStrokeFrame

            local uiStroke = Instance.new("UIStroke")
            uiStroke.Thickness = 2 
            uiStroke.Color = Color3.fromRGB(255, 255, 255) 
            uiStroke.Transparency = 0.5 
            uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            uiStroke.Parent = insetStrokeFrame

            local arrowIcon = Instance.new("ImageLabel")
            arrowIcon.Name = "ArrowIcon"
            arrowIcon.Size = UDim2.new(0.7, 0, 0.7, 0) 
            arrowIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
            arrowIcon.AnchorPoint = Vector2.new(0.5, 0.5)
            arrowIcon.BackgroundTransparency = 1
            arrowIcon.Image = "rbxassetid://139650104834071"
            arrowIcon.ImageColor3 = Color3.fromRGB(255, 255, 255) 
            arrowIcon.ImageTransparency = 0.5 
            arrowIcon.Parent = jumpButton

            -- CONNECTING THE ACTION
            jumpButton.MouseButton1Click:Connect(function()
                InstantShootSequence()
            end)
        else
            -- Cleanup
            if currentScreenGui then
                currentScreenGui:Destroy()
                currentScreenGui = nil
            end
        end
    end
})

Tabs.Main:Section({
    ["Title"] = "Innocent",
    ["Icon"] = "eye"
})

local PlayersInvis = game:GetService("Players")
local RunServiceInvis = game:GetService("RunService")
local LocalPlayerInvis = PlayersInvis.LocalPlayer
local InvisAnimationId = "90878454666108"
local InvisAnimTimePos = 0.2
local InvisAnimSpeed = 0
local InvisibilityEnabled = false
local CurrentInvisAnimation = nil
local AnimationBlockConnection = nil
local HeartbeatConnection = nil
local CollisionConnection = nil

local function SetCharacterTransparency(Character, Transparency)
    if Character then
        local BodyParts = {
            "Head",
            "UpperTorso",
            "LowerTorso",
            "LeftUpperArm",
            "LeftLowerArm",
            "LeftHand",
            "RightUpperArm",
            "RightLowerArm",
            "RightHand",
            "LeftUpperLeg",
            "LeftLowerLeg",
            "LeftFoot",
            "RightUpperLeg",
            "RightLowerLeg",
            "RightFoot"
        }
        for _, PartName in ipairs(BodyParts) do
            local Part = Character:FindFirstChild(PartName)
            if Part and Part:IsA("BasePart") then
                Part.Transparency = Transparency
            end
        end
    end
end

local function PlayInvisAnimation(Animator)
    if Animator then
        if not (CurrentInvisAnimation and CurrentInvisAnimation.IsPlaying) then
            local Animation = Instance.new("Animation")
            Animation.AnimationId = "rbxassetid://" .. InvisAnimationId
            CurrentInvisAnimation = Animator:LoadAnimation(Animation)
            CurrentInvisAnimation:Play()
            CurrentInvisAnimation.TimePosition = InvisAnimTimePos
            CurrentInvisAnimation:AdjustSpeed(InvisAnimSpeed)
        end
    end
end

local function StopInvisAnimation()
    if CurrentInvisAnimation then
        CurrentInvisAnimation:Stop()
        CurrentInvisAnimation = nil
    end
end

local function BlockOtherAnimations(Humanoid)
    if Humanoid then
        if AnimationBlockConnection then
            AnimationBlockConnection:Disconnect()
        end
        AnimationBlockConnection = Humanoid.AnimationPlayed:Connect(function(AnimTrack)
            if AnimTrack.Animation.AnimationId:match("%d+") ~= InvisAnimationId then
                AnimTrack:Stop()
            end
        end)
    end
end

local function UnblockAnimations()
    if AnimationBlockConnection then
        AnimationBlockConnection:Disconnect()
        AnimationBlockConnection = nil
    end
end

local function StartInvisibility(Character)
    if Character then
        local Humanoid = Character:WaitForChild("Humanoid")
        local Animator
        if Humanoid then
            Animator = Humanoid:FindFirstChildOfClass("Animator")
        else
            Animator = Humanoid
        end
        if Humanoid and Animator then
            SetCharacterTransparency(Character, 0.5)
            BlockOtherAnimations(Humanoid)
            if HeartbeatConnection then
                HeartbeatConnection:Disconnect()
            end
            HeartbeatConnection = RunServiceInvis.Heartbeat:Connect(function()
                if InvisibilityEnabled then
                    PlayInvisAnimation(Animator)
                end
            end)
        end
    else
        return
    end
end

local function StopInvisibility(Character)
    StopInvisAnimation()
    UnblockAnimations()
    SetCharacterTransparency(Character, 0)
    if HeartbeatConnection then
        HeartbeatConnection:Disconnect()
        HeartbeatConnection = nil
    end
end

local function DisableCollision(Character)
    if Character then
        if CollisionConnection then
            CollisionConnection:Disconnect()
        end
        CollisionConnection = RunServiceInvis.Stepped:Connect(function()
            if Character then
                for _, Descendant in ipairs(Character:GetDescendants()) do
                    if Descendant:IsA("BasePart") and Descendant.Name ~= "HumanoidRootPart" then
                        Descendant.CanCollide = false
                    end
                end
            end
        end)
    end
end

local function EnableCollision(Character)
    if CollisionConnection then
        CollisionConnection:Disconnect()
        CollisionConnection = nil
    end
    if Character then
        for _, Descendant in ipairs(Character:GetDescendants()) do
            if Descendant:IsA("BasePart") then
                Descendant.CanCollide = true
            end
        end
    end
end

local function EnableFullInvisibility(Character)
    StartInvisibility(Character)
    DisableCollision(Character)
end

local function DisableFullInvisibility(Character)
    StopInvisibility(Character)
    EnableCollision(Character)
end

local function OnCharacterAddedInvis(NewCharacter)
    DisableFullInvisibility(LocalPlayerInvis.Character)
    if InvisibilityEnabled then
        task.wait(0.5)
        EnableFullInvisibility(NewCharacter)
    end
    NewCharacter:WaitForChild("Humanoid").Died:Connect(function()
        DisableFullInvisibility(NewCharacter)
    end)
end

Tabs.Main:Toggle({
    ["Title"] = "invisibility",
    ["Value"] = false,
    ["Callback"] = function(State)
        InvisibilityEnabled = State
        local Character = LocalPlayerInvis.Character
        if InvisibilityEnabled then
            EnableFullInvisibility(Character)
        else
            DisableFullInvisibility(Character)
        end
    end
})

LocalPlayerInvis.CharacterAdded:Connect(OnCharacterAddedInvis)

if LocalPlayerInvis.Character then
    OnCharacterAddedInvis(LocalPlayerInvis.Character)
end

local AutoGetGunEnabled = false

Tabs.Main:Toggle({
    ["Title"] = "Auto Get Gun",
    ["Value"] = false,
    ["Callback"] = function(State)
        AutoGetGunEnabled = State
        if State then
            task.spawn(function()
                while AutoGetGunEnabled do
                    local Character = game.Players.LocalPlayer.Character
                    if Character and Character:FindFirstChild("HumanoidRootPart") then
                        local OriginalPosition = Character.HumanoidRootPart.Position
                        local NearestGun = nil
                        local NearestDistance = math.huge
                        for _, Descendant in pairs(workspace:GetDescendants()) do
                            if Descendant.Name == "GunDrop" and Descendant:IsA("BasePart") then
                                local Distance = (Character.HumanoidRootPart.Position - Descendant.Position).Magnitude
                                if Distance < NearestDistance then
                                    NearestGun = Descendant
                                    NearestDistance = Distance
                                end
                            end
                        end
                        if NearestGun then
                            Character.HumanoidRootPart.CFrame = NearestGun.CFrame
                            task.wait(0.1)
                            Character.HumanoidRootPart.CFrame = CFrame.new(OriginalPosition)
                        end
                    end
                    task.wait(1)
                end
            end)
        end
    end
})

Tabs.Main:Button({
    ["Title"] = "Get Second Life (unstable)",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://pastefy.app/FHl36Zg1/raw"))("true")
    end
})

Tabs.Main:Section({
    ["Title"] = "Fly",
    ["Icon"] = "utensils"
})

local PlayersFly = game:GetService("Players")
local UserInputServiceFly = game:GetService("UserInputService")
local StarterGuiFly = game:GetService("StarterGui")
local LocalPlayerFly = PlayersFly.LocalPlayer
local FlySpeed = 50
local FlyEnabled = false
local MobilePadEnabled = false
local InputBeganConnection = nil
local InputEndedConnection = nil
local CharacterAddedConnection = nil

local FlyDirection = {
    ["f"] = 0,
    ["b"] = 0,
    ["l"] = 0,
    ["r"] = 0
}

local function PlayFlyAnimation(AnimationId, TimePosition, Speed)
    pcall(function()
        if LocalPlayerFly.Character then
            LocalPlayerFly.Character.Animate.Disabled = true
            local Humanoid = LocalPlayerFly.Character:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                for _, Track in ipairs(Humanoid:GetPlayingAnimationTracks()) do
                    Track:Stop(0)
                end
                local Animation = Instance.new("Animation")
                Animation.AnimationId = "rbxassetid://" .. AnimationId
                local AnimTrack = Humanoid:LoadAnimation(Animation)
                AnimTrack:Play(0.1)
                AnimTrack.TimePosition = TimePosition
                AnimTrack:AdjustSpeed(Speed)
            end
        else
            return
        end
    end)
end

local function StopAllAnimations()
    pcall(function()
        if LocalPlayerFly.Character then
            local Humanoid = LocalPlayerFly.Character:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                for _, Track in ipairs(Humanoid:GetPlayingAnimationTracks()) do
                    Track:Stop(0.1)
                end
                LocalPlayerFly.Character.Animate.Disabled = false
            end
        else
            return
        end
    end)
end

local FlyPadGui = Instance.new("ScreenGui")
FlyPadGui.Name = "FlyPadGui_Gemini"
FlyPadGui.Parent = game.CoreGui
FlyPadGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
FlyPadGui.Enabled = false

local FlyPad = Instance.new("ImageButton")
FlyPad.Name = "Fly_Pad"
FlyPad.Parent = FlyPadGui
FlyPad.BackgroundTransparency = 1
FlyPad.Position = UDim2.new(0.1, 0, 0.6, 0)
FlyPad.Size = UDim2.new(0, 100, 0, 100)
FlyPad.ZIndex = 2
FlyPad.Image = "rbxassetid://6764432293"
FlyPad.ImageRectOffset = Vector2.new(713, 315)
FlyPad.ImageRectSize = Vector2.new(75, 75)

local LeftButton = Instance.new("TextButton")
LeftButton.Parent = FlyPad
LeftButton.BackgroundTransparency = 1
LeftButton.Size = UDim2.new(0, 30, 0, 40)
LeftButton.Position = UDim2.new(0, 0, 0, 30)
LeftButton.Text = ""

local RightButton = Instance.new("TextButton")
RightButton.Parent = FlyPad
RightButton.BackgroundTransparency = 1
RightButton.Size = UDim2.new(0, 30, 0, 40)
RightButton.Position = UDim2.new(0, 70, 0, 30)
RightButton.Text = ""

local ForwardButton = Instance.new("TextButton")
ForwardButton.Parent = FlyPad
ForwardButton.BackgroundTransparency = 1
ForwardButton.Size = UDim2.new(0, 40, 0, 30)
ForwardButton.Position = UDim2.new(0, 30, 0, 0)
ForwardButton.Text = ""

local BackwardButton = Instance.new("TextButton")
BackwardButton.Parent = FlyPad
BackwardButton.BackgroundTransparency = 1
BackwardButton.Size = UDim2.new(0, 40, 0, 30)
BackwardButton.Position = UDim2.new(0, 30, 0, 70)
BackwardButton.Text = ""

ForwardButton.MouseButton1Down:Connect(function()
    if typeof(keypress) == "function" then
        keypress("0x57")
    end
end)

ForwardButton.MouseButton1Up:Connect(function()
    if typeof(keyrelease) == "function" then
        keyrelease("0x57")
    end
end)

BackwardButton.MouseButton1Down:Connect(function()
    if typeof(keypress) == "function" then
        keypress("0x53")
    end
end)

BackwardButton.MouseButton1Up:Connect(function()
    if typeof(keyrelease) == "function" then
        keyrelease("0x53")
    end
end)

LeftButton.MouseButton1Down:Connect(function()
    if typeof(keypress) == "function" then
        keypress("0x41")
    end
end)

LeftButton.MouseButton1Up:Connect(function()
    if typeof(keyrelease) == "function" then
        keyrelease("0x41")
    end
end)

RightButton.MouseButton1Down:Connect(function()
    if typeof(keypress) == "function" then
        keypress("0x44")
    end
end)

RightButton.MouseButton1Up:Connect(function()
    if typeof(keyrelease) == "function" then
        keyrelease("0x44")
    end
end)

local function StartFlying(Character)
    if Character and Character:FindFirstChild("UpperTorso") then
        local Torso = Character.UpperTorso
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            for _, Child in pairs(Torso:GetChildren()) do
                if Child.Name == "GeminiFlyMover" then
                    Child:Destroy()
                end
            end
            local BodyGyro = Instance.new("BodyGyro", Torso)
            BodyGyro.Name = "GeminiFlyMover"
            BodyGyro.P = 20000
            BodyGyro.maxTorque = Vector3.new(math.huge, math.huge, math.huge)
            BodyGyro.cframe = Torso.CFrame
            local BodyVelocity = Instance.new("BodyVelocity", Torso)
            BodyVelocity.Name = "GeminiFlyMover"
            BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
            BodyVelocity.maxForce = Vector3.new(math.huge, math.huge, math.huge)
            PlayFlyAnimation(10714347256, 4, 0)
            while true do
                task.wait()
                pcall(function()
                    if Character.Parent and Humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
                        Humanoid.PlatformStand = true
                        local Camera = workspace.CurrentCamera
                        local Direction = Vector3.new(FlyDirection.l + FlyDirection.r, 0, FlyDirection.f + FlyDirection.b)
                        local WorldDirection = Camera.CFrame:VectorToWorldSpace(Direction).Unit
                        if Direction.Magnitude <= 0 then
                            BodyVelocity.Velocity = Vector3.new(0, 0.1, 0)
                        else
                            BodyVelocity.Velocity = WorldDirection * FlySpeed
                        end
                        local TiltX = math.rad(-75) * -(FlyDirection.f + FlyDirection.b)
                        local TiltZ = math.rad(30) * -(FlyDirection.l + FlyDirection.r)
                        BodyGyro.CFrame = Camera.CFrame * CFrame.Angles(TiltX, 0, TiltZ)
                    else
                        FlyEnabled = false
                    end
                end)
                if not (FlyEnabled and Humanoid) then
                    break
                end
                if Humanoid:GetState() == Enum.HumanoidStateType.Dead then
                    break
                end
            end
            pcall(function()
                BodyGyro:Destroy()
                BodyVelocity:Destroy()
                Humanoid.PlatformStand = false
                StopAllAnimations()
            end)
        end
    else
        return
    end
end

function updateMobilePadVisibility()
    local ShouldShow = FlyEnabled and MobilePadEnabled
    if ShouldShow then
        ShouldShow = UserInputServiceFly.TouchEnabled
    end
    FlyPadGui.Enabled = ShouldShow
end

Tabs.Main:Input({
    ["Title"] = "Fly Speed",
    ["Placeholder"] = tostring(FlySpeed),
    ["Callback"] = function(Text)
        local NewSpeed = tonumber(Text)
        if NewSpeed and 0 < NewSpeed then
            FlySpeed = NewSpeed
            StarterGuiFly:SetCore("SendNotification", {
                ["Title"] = "VexonFly",
                ["Text"] = "Speed set to: " .. FlySpeed,
                ["Icon"] = "rbxassetid://89804924525665",
                ["Duration"] = 2
            })
        else
            StarterGuiFly:SetCore("SendNotification", {
                ["Title"] = "VexonFly",
                ["Text"] = "Invalid speed. Please enter a number greater than 0.",
                ["Icon"] = "rbxassetid://89804924525665",
                ["Duration"] = 3
            })
        end
    end
})

Tabs.Main:Toggle({
    ["Title"] = "Mobile Fly Panel",
    ["Value"] = MobilePadEnabled,
    ["Callback"] = function(State)
        MobilePadEnabled = State
        updateMobilePadVisibility()
    end
})

Tabs.Main:Toggle({
    ["Title"] = "Fly",
    ["Value"] = FlyEnabled,
    ["Callback"] = function(State)
        FlyEnabled = State
        if FlyEnabled then
            InputBeganConnection = UserInputServiceFly.InputBegan:Connect(function(Input, GameProcessed)
                if not GameProcessed then
                    if Input.UserInputType == Enum.UserInputType.Keyboard then
                        local Key = Input.KeyCode.Name:lower()
                        if Key == "w" then
                            FlyDirection.f = -1
                            PlayFlyAnimation(10714177846, 4.65, 0)
                        elseif Key == "s" then
                            FlyDirection.b = 1
                            PlayFlyAnimation(10147823318, 4.11, 0)
                        elseif Key == "a" then
                            FlyDirection.l = -1
                            PlayFlyAnimation(10147823318, 3.55, 0)
                        elseif Key == "d" then
                            FlyDirection.r = 1
                            PlayFlyAnimation(10147823318, 4.81, 0)
                        end
                    end
                end
            end)
            InputEndedConnection = UserInputServiceFly.InputEnded:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.Keyboard then
                    local Key = Input.KeyCode.Name:lower()
                    if Key == "w" then
                        FlyDirection.f = 0
                        PlayFlyAnimation(10714347256, 4, 0)
                    elseif Key == "s" then
                        FlyDirection.b = 0
                        PlayFlyAnimation(10714347256, 4, 0)
                    elseif Key == "a" then
                        FlyDirection.l = 0
                        PlayFlyAnimation(10714347256, 4, 0)
                    elseif Key == "d" then
                        FlyDirection.r = 0
                        PlayFlyAnimation(10714347256, 4, 0)
                    end
                end
            end)
            CharacterAddedConnection = LocalPlayerFly.CharacterAdded:Connect(function(NewCharacter)
                task.wait(0.5)
                if FlyEnabled then
                    task.spawn(StartFlying, NewCharacter)
                end
            end)
            if LocalPlayerFly.Character then
                task.spawn(StartFlying, LocalPlayerFly.Character)
            end
        else
            if InputBeganConnection then
                InputBeganConnection:Disconnect()
                InputBeganConnection = nil
            end
            if InputEndedConnection then
                InputEndedConnection:Disconnect()
                InputEndedConnection = nil
            end
            if CharacterAddedConnection then
                CharacterAddedConnection:Disconnect()
                CharacterAddedConnection = nil
            end
            FlyDirection = {
                ["f"] = 0,
                ["b"] = 0,
                ["l"] = 0,
                ["r"] = 0
            }
            if LocalPlayerFly.Character then
                for _, Child in pairs(LocalPlayerFly.Character.UpperTorso:GetChildren()) do
                    if Child.Name == "GeminiFlyMover" then
                        Child:Destroy()
                    end
                end
                StopAllAnimations()
            end
        end
        updateMobilePadVisibility()
    end
})

Tabs.Main:Section({
    ["Title"] = "Movement",
    ["Icon"] = "settings"
})

local function ToggleSpeedBypass(State)
    speedToggle = State
    getgenv().WalkspeedBypass = speedToggle
    if State then
        task.spawn(function()
            while getgenv().WalkspeedBypass and (character and character.Parent) do
                local Humanoid = character:FindFirstChildOfClass("Humanoid")
                if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
                    character:TranslateBy(Humanoid.MoveDirection * speedValue * RunService.Heartbeat:Wait() * 7)
                else
                    task.wait()
                end
            end
        end)
    end
end

Tabs.Main:Toggle({
    ["Title"] = "Speed (V Key On/Off)",
    ["Value"] = false,
    ["Callback"] = ToggleSpeedBypass
})

Tabs.Main:Slider({
    ["Title"] = "Speed Boost Value",
    ["step"] = 1,
    ["Value"] = {
        ["Min"] = 1,
        ["Max"] = 100,
        ["Default"] = 9
    },
    ["Callback"] = function(Value)
        speedValue = Value
    end
})

UserInputServiceFly.InputBegan:Connect(function(Input, GameProcessed)
    if Input.KeyCode == Enum.KeyCode.V and not GameProcessed then
        ToggleSpeedBypass(not speedToggle)
    end
end)

Tabs.Main:Toggle({
    ["Title"] = "Jump",
    ["Value"] = false,
    ["Callback"] = function(State)
        getgenv().JumpPowerBypass = State
        if State then
            task.spawn(function()
                while getgenv().JumpPowerBypass do
                    if humanoid and humanoid:GetState() == Enum.HumanoidStateType.Jumping then
                        character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, jumpValue, 0)
                    end
                    task.wait()
                end
            end)
        end
    end
})

Tabs.Main:Slider({
    ["Title"] = "Jump Boost Value",
    ["step"] = 1,
    ["Value"] = {
        ["Min"] = 1,
        ["Max"] = 1000,
        ["Default"] = 200
    },
    ["Callback"] = function(Value)
        jumpValue = Value
    end
})

Tabs.Misc:Section({
    ["Title"] = "Universal Scripts",
    ["Icon"] = "flame"
})

Tabs.Misc:Button({
    ["Title"] = "Inf Yield",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

Tabs.Misc:Button({
    ["Title"] = "Dex Explorer",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Classic-Dex-Explorer-21009"))()
    end
})

Tabs.Misc:Button({
    ["Title"] = "Remote Spy",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))()
    end
})

Tabs.Misc:Button({
    ["Title"] = "Keyboard",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
    end
})

Tabs.Misc:Button({
    ["Title"] = "Anim Logger",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://pastefy.app/juBGMpCZ/raw"))()
    end
})

Tabs.Misc:Button({
    ["Title"] = "f3x",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/refs/heads/main/f3x.lua"))()
    end
})

Tabs.Misc:Button({
    ["Title"] = "Fly V3",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/xuSMWfDu"))()
    end
})

Tabs.Misc:Button({
    ["Title"] = "VFX Logger",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/2uXfJqdU"))()
    end
})

Tabs.Misc:Section({
    ["Title"] = "Player",
    ["Icon"] = "star"
})

Tabs.Misc:Button({
    ["Title"] = "ServerHop",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://pastefy.app/uTXUoORd/raw"))()
    end
})

Tabs.Misc:Button({
    ["Title"] = "Rejoin",
    ["Locked"] = false,
    ["Callback"] = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
})

Tabs.Misc:Button({
    ["Title"] = "Reset",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://pastefy.app/YPv8xrYN/raw"))()
    end
})

Tabs.Misc:Button({
    ["Title"] = "Fixcam",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://pastefy.app/IrvnCaF2/raw"))()
    end
})

Tabs.Misc:Section({
    ["Title"] = "Tools",
    ["Icon"] = "sword"
})

Tabs.Misc:Button({
    ["Title"] = "Teleport Tool",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://pastefy.app/ZLpXLAeF/raw"))()
    end
})

Tabs.Misc:Button({
    ["Title"] = "Jerk Off Tool",
    ["Locked"] = false,
    ["Callback"] = function()
        loadstring(game:HttpGet("https://pastefy.app/LcC6ZrhN/raw"))()
    end
})

Tabs.ESP:Section({
    ["Title"] = "ESP",
    ["Icon"] = "package"
})

-- WindUI ESP Module (Project Nexora Integration)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ESP Master State
local ESP_Active = false

-- Color Configuration (Your Specific Requests)
local RoleColors = {
    ["Murder_Seen"] = Color3.fromRGB(255, 0, 0),    -- Red
    ["Murder_Hidden"] = Color3.fromRGB(255, 120, 0),-- Orange
    ["Sheriff_Seen"] = Color3.fromRGB(0, 150, 255), -- Blue
    ["Sheriff_Hidden"] = Color3.fromRGB(130, 0, 255),-- Purple
    ["Innocent_Seen"] = Color3.fromRGB(0, 255, 100),-- Light Green
    ["Innocent_Hidden"] = Color3.fromRGB(0, 100, 50),-- Dark Green
    ["Gun_Seen"] = Color3.fromRGB(255, 255, 0),     -- Yellow
    ["Gun_Hidden"] = Color3.fromRGB(255, 255, 255)  -- White
}

-- Detection Logic
local function GetPlayerRole(Player)
    local Character = Player.Character
    local Backpack = Player:FindFirstChild("Backpack")
    
    local function CheckForWeapon(Container)
        if not Container then return nil end
        for _, Item in pairs(Container:GetChildren()) do
            if Item:IsA("Tool") then
                if Item.Name == "Knife" or Item:FindFirstChild("Knife") or Item.Name:lower():find("knife") then
                    return "Murder"
                elseif Item.Name == "Gun" or Item:FindFirstChild("Gun") or Item.Name:lower():find("gun") then
                    return "Sheriff"
                end
            end
        end
        return nil
    end
    return CheckForWeapon(Character) or CheckForWeapon(Backpack) or "Innocent"
end

local function IsVisible(TargetInstance)
    local TargetPos = TargetInstance:IsA("Player") and TargetInstance.Character and TargetInstance.Character:FindFirstChild("HumanoidRootPart") and TargetInstance.Character.HumanoidRootPart.Position or (TargetInstance:IsA("BasePart") and TargetInstance.Position)
    if not TargetPos then return false end
    
    local _, OnScreen = Camera:WorldToViewportPoint(TargetPos)
    if not OnScreen then return false end

    local RayParams = RaycastParams.new()
    RayParams.FilterType = Enum.RaycastFilterType.Exclude
    RayParams.FilterDescendantsInstances = {LocalPlayer.Character, (TargetInstance:IsA("Player") and TargetInstance.Character or TargetInstance)}
    
    local Result = workspace:Raycast(Camera.CFrame.Position, (TargetPos - Camera.CFrame.Position), RayParams)
    return Result == nil
end

-- Cleanup Function
local function RemoveAllESP()
    for _, Player in pairs(Players:GetPlayers()) do
        if Player.Character then
            local Highlight = Player.Character:FindFirstChild("NexoraESP")
            if Highlight then Highlight:Destroy() end
        end
    end
    for _, Obj in pairs(workspace:GetDescendants()) do
        if Obj.Name == "GunDrop" then
            local Highlight = Obj:FindFirstChild("GunESP")
            if Highlight then Highlight:Destroy() end
        end
    end
end

-- Main Render Engine
local function RunESP()
    if not ESP_Active then return end
    
    -- 1. Players
    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character then
            local Role = GetPlayerRole(Player)
            local Visible = IsVisible(Player)
            local ColorKey = Role .. (Visible and "_Seen" or "_Hidden")
            
            local Highlight = Player.Character:FindFirstChild("NexoraESP") or Instance.new("Highlight")
            Highlight.Name = "NexoraESP"
            Highlight.Parent = Player.Character
            Highlight.Adornee = Player.Character
            Highlight.FillColor = RoleColors[ColorKey] or Color3.new(1,1,1)
            Highlight.OutlineColor = Highlight.FillColor
            Highlight.FillTransparency = 0.5
            Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        end
    end

    -- 2. Dropped Gun
    for _, Obj in pairs(workspace:GetDescendants()) do
        if Obj.Name == "GunDrop" and Obj:IsA("BasePart") then
            local Visible = IsVisible(Obj)
            local ColorKey = "Gun" .. (Visible and "_Seen" or "_Hidden")
            
            local Highlight = Obj:FindFirstChild("GunESP") or Instance.new("Highlight")
            Highlight.Name = "GunESP"
            Highlight.Parent = Obj
            Highlight.Adornee = Obj
            Highlight.FillColor = RoleColors[ColorKey]
            Highlight.OutlineColor = Highlight.FillColor
            Highlight.FillTransparency = 0.4
            Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        end
    end
end

-- WindUI Toggle Implementation
Tabs.ESP:Toggle({
    ["Title"] = "HIGHLIGHT ESP",
    ["Value"] = false,
    ["Callback"] = function(State)
        ESP_Active = State
        if not State then
            RemoveAllESP()
        end
    end
})

-- Background Execution Loop
task.spawn(function()
    while true do
        if ESP_Active then
            pcall(RunESP)
        end
        task.wait(0.2)
    end
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Configuration (Internal Settings Unchanged)
local Settings = {
    TracerThickness = 4.5,
    TracerTransparency = 0.85,
    BoxThickness = 1.8,
    TextSize = 18,
    Font = 2, 
    Enabled = false -- Controlled by Toggle now
}

-- Colors (Unchanged)
local RoleColors = {
    ["Murder"] = Color3.fromRGB(255, 0, 0),      
    ["Sheriff"] = Color3.fromRGB(0, 150, 255),    
    ["Innocent"] = Color3.fromRGB(0, 255, 100),   
    ["DroppedGun"] = Color3.fromRGB(255, 255, 0)  
}

local Visuals = {}

-- MM2 Deep Scan (Unchanged)
local function GetPlayerRole(Player)
    local Character = Player.Character
    local Backpack = Player:FindFirstChild("Backpack")
    local function CheckForWeapon(Container)
        if not Container then return nil end
        for _, Item in pairs(Container:GetChildren()) do
            if Item:IsA("Tool") then
                if Item.Name == "Knife" or Item:FindFirstChild("Knife") or Item.Name:lower():find("knife") then
                    return "Murder"
                elseif Item.Name == "Gun" or Item:FindFirstChild("Gun") or Item.Name:lower():find("gun") then
                    return "Sheriff"
                end
            end
        end
        return nil
    end
    return CheckForWeapon(Character) or CheckForWeapon(Backpack) or "Innocent"
end

-- Create Drawing Objects (Unchanged)
local function CreateVisuals(Player)
    local Data = {
        Tracer = Drawing.new("Line"),
        Box = Drawing.new("Square"),
        Text = Drawing.new("Text")
    }
    Data.Tracer.Thickness = Settings.TracerThickness
    Data.Tracer.Transparency = Settings.TracerTransparency
    Data.Box.Thickness = Settings.BoxThickness
    Data.Box.Filled = false
    Data.Text.Size = Settings.TextSize
    Data.Text.Center = true
    Data.Text.Outline = true
    Data.Text.Font = Settings.Font
    Visuals[Player] = Data
    return Data
end

-- Clear Visuals Function
local function ClearVisuals()
    for _, Data in pairs(Visuals) do
        Data.Tracer.Visible = false
        Data.Box.Visible = false
        Data.Text.Visible = false
    end
end

-- Render Engine (Unchanged Logic)
local function UpdateESP()
    if not Settings.Enabled then 
        ClearVisuals()
        return 
    end

    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer then
            local Character = Player.Character
            local Root = Character and Character:FindFirstChild("HumanoidRootPart")
            local Hum = Character and Character:FindFirstChild("Humanoid")
            
            if Character and Root and Hum and Hum.Health > 0 then
                local RootPos, OnScreen = Camera:WorldToViewportPoint(Root.Position)
                
                if OnScreen then
                    local Data = Visuals[Player] or CreateVisuals(Player)
                    local Role = GetPlayerRole(Player)
                    local Color = RoleColors[Role]
                    
                    local Head = Character:FindFirstChild("Head")
                    if Head then
                        local HeadPos = Camera:WorldToViewportPoint(Head.Position + Vector3.new(0, 0.5, 0))
                        local LegPos = Camera:WorldToViewportPoint(Root.Position - Vector3.new(0, 3, 0))
                        local BoxHeight = math.abs(HeadPos.Y - LegPos.Y)
                        local BoxWidth = BoxHeight / 1.5
                        
                        Data.Box.Visible = true
                        Data.Box.Size = Vector2.new(BoxWidth, BoxHeight)
                        Data.Box.Position = Vector2.new(RootPos.X - BoxWidth / 2, RootPos.Y - BoxHeight / 2)
                        Data.Box.Color = Color
                        
                        Data.Text.Visible = true
                        Data.Text.Text = "[ " .. Role:upper() .. " ]"
                        Data.Text.Position = Vector2.new(RootPos.X, RootPos.Y - BoxHeight / 2 - 25)
                        Data.Text.Color = Color
                    end

                    Data.Tracer.Visible = true
                    Data.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    Data.Tracer.To = Vector2.new(RootPos.X, RootPos.Y)
                    Data.Tracer.Color = Color
                else
                    if Visuals[Player] then
                        Visuals[Player].Tracer.Visible = false
                        Visuals[Player].Box.Visible = false
                        Visuals[Player].Text.Visible = false
                    end
                end
            elseif Visuals[Player] then
                Visuals[Player].Tracer.Visible = false
                Visuals[Player].Box.Visible = false
                Visuals[Player].Text.Visible = false
            end
        end
    end
end

-- WINDUI TOGGLE INTEGRATION
Tabs.ESP:Toggle({
    ["Title"] = "Master ESP (Tracers & Boxes)",
    ["Value"] = false,
    ["Callback"] = function(State)
        Settings.Enabled = State
        if not State then
            ClearVisuals()
        end
    end
})

-- Execution
RunService.RenderStepped:Connect(function()
    pcall(UpdateESP)
end)

-- Cleanup on Player Leave
Players.PlayerRemoving:Connect(function(Player)
    if Visuals[Player] then
        Visuals[Player].Tracer:Remove()
        Visuals[Player].Box:Remove()
        Visuals[Player].Text:Remove()
        Visuals[Player] = nil
    end
end)

Tabs.ESP:Section({
    ["Title"] = "Expose Roles",
    ["Icon"] = "info"
})

local PlayersExpose = game:GetService("Players")
local RunServiceExpose = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

local function SendChatMessage(Message)
    if TextChatService and TextChatService:FindFirstChild("ChatInputBarConfiguration") then
        local TextChannels = TextChatService:FindFirstChild("TextChannels")
        if TextChannels and TextChannels:FindFirstChild("RBXGeneral") then
            TextChannels.RBXGeneral:SendAsync(Message)
        end
    else
        local ChatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if ChatEvents then
            ChatEvents.SayMessageRequest:FireServer(Message, "All")
        end
    end
end

local function ExposeRole(WeaponName, RoleName)
    for _, Player in pairs(PlayersExpose:GetPlayers()) do
        local Character = Player.Character
        local Backpack = Player.Backpack
        if Character and Character:FindFirstChild(WeaponName) or Backpack and Backpack:FindFirstChild(WeaponName) then
            SendChatMessage(RoleName .. ": " .. Player.Name)
            return true
        end
    end
    return false
end

local function CreateAutoExposeToggle(Title, WeaponName, RoleName)
    local ExposeConnection = nil
    Tabs.ESP:Toggle({
        ["Title"] = Title,
        ["Value"] = false,
        ["Callback"] = function(State)
            if State then
                ExposeConnection = RunServiceExpose.Heartbeat:Connect(function()
                    if ExposeRole(WeaponName, RoleName) and ExposeConnection then
                        ExposeConnection:Disconnect()
                        ExposeConnection = nil
                    end
                end)
            elseif ExposeConnection then
                ExposeConnection:Disconnect()
                ExposeConnection = nil
            end
        end
    })
end

Tabs.ESP:Button({
    ["Title"] = "Expose Murderer",
    ["Callback"] = function()
        ExposeRole("Knife", "Murderer")
    end
})

Tabs.ESP:Button({
    ["Title"] = "Expose Sheriff",
    ["Callback"] = function()
        ExposeRole("Gun", "Sheriff")
    end
})

CreateAutoExposeToggle("Auto Expose Murderer", "Knife", "Murderer")
CreateAutoExposeToggle("Auto Expose Sheriff", "Gun", "Sheriff")

Tabs.ESP:Section({
    ["Title"] = "Notify",
    ["Icon"] = "alert-circle"
})

local PlayersNotify = game:GetService("Players")
local RunServiceNotify = game:GetService("RunService")

local function SendNotification(Message)
    game.StarterGui:SetCore("SendNotification", {
        ["Title"] = "Project Nexora",
        ["Text"] = Message,
        ["Icon"] = "http://www.roblox.com/asset/?id=89804924525665",
        ["Duration"] = 5
    })
end

local function NotifyRole(WeaponName, RoleName)
    for _, Player in pairs(PlayersNotify:GetPlayers()) do
        if Player.Character and Player.Character:FindFirstChild(WeaponName) or Player.Backpack and Player.Backpack:FindFirstChild(WeaponName) then
            SendNotification(RoleName .. ": " .. Player.Name)
            return true
        end
    end
    return false
end

local function CreateAutoNotifyToggle(Title, WeaponName, RoleName)
    local NotifyConnection = nil
    Tabs.ESP:Toggle({
        ["Title"] = Title,
        ["Value"] = false,
        ["Callback"] = function(State)
            if State then
                NotifyConnection = RunServiceNotify.Heartbeat:Connect(function()
                    if NotifyRole(WeaponName, RoleName) and NotifyConnection then
                        NotifyConnection:Disconnect()
                        NotifyConnection = nil
                    end
                end)
            elseif NotifyConnection then
                NotifyConnection:Disconnect()
                NotifyConnection = nil
            end
        end
    })
end

Tabs.ESP:Button({
    ["Title"] = "Notify Murderer",
    ["Callback"] = function()
        NotifyRole("Knife", "Murderer")
    end
})

Tabs.ESP:Button({
    ["Title"] = "Notify Sheriff",
    ["Callback"] = function()
        NotifyRole("Gun", "Sheriff")
    end
})

CreateAutoNotifyToggle("Auto Notify Murderer", "Knife", "Murderer")
CreateAutoNotifyToggle("Auto Notify Sheriff", "Gun", "Sheriff")

Tabs.ESP:Section({
    ["Title"] = "Spectate",
    ["Icon"] = "eye"
})

local PlayersSpectate = game:GetService("Players")
local LocalPlayerSpectate = PlayersSpectate.LocalPlayer
local CameraSpectate = game.Workspace.CurrentCamera

local function FindMurdererCharacter()
    for _, Player in pairs(PlayersSpectate:GetPlayers()) do
        if Player ~= LocalPlayerSpectate and Player.Character and (Player.Backpack:FindFirstChild("Knife") or Player.Character:FindFirstChild("Knife")) then
            return Player.Character
        end
    end
    return nil
end

Tabs.ESP:Button({
    ["Title"] = "Spectate Murderer",
    ["Locked"] = false,
    ["Callback"] = function()
        local MurdererCharacter = FindMurdererCharacter()
        if MurdererCharacter and MurdererCharacter:FindFirstChild("HumanoidRootPart") then
            CameraSpectate.CameraSubject = MurdererCharacter:FindFirstChild("Humanoid")
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                ["Title"] = "Project Nexora",
                ["Text"] = "Murder Not Found!",
                ["Duration"] = 1,
                ["Callback"] = AllowRunServiceBind
            })
        end
    end
})

local PlayersSpectate2 = game:GetService("Players")
local LocalPlayerSpectate2 = PlayersSpectate2.LocalPlayer
local CameraSpectate2 = game.Workspace.CurrentCamera
game:GetService("StarterGui")

local function FindSheriffCharacter()
    for _, Player in pairs(PlayersSpectate2:GetPlayers()) do
        if Player ~= LocalPlayerSpectate2 and Player.Character and (Player.Backpack:FindFirstChild("Gun") or Player.Character:FindFirstChild("Gun")) then
            return Player.Character
        end
    end
    return nil
end

Tabs.ESP:Button({
    ["Title"] = "Spectate Sheriff",
    ["Locked"] = false,
    ["Callback"] = function()
        local SheriffCharacter = FindSheriffCharacter()
        if SheriffCharacter and SheriffCharacter:FindFirstChild("Humanoid") then
            CameraSpectate2.CameraSubject = SheriffCharacter:FindFirstChild("Humanoid")
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                ["Title"] = "Project Nexora",
                ["Text"] = "Sheriff Not Found",
                ["Duration"] = 10,
                ["Callback"] = AllowRunServiceBind
            })
        end
    end
})

Tabs.ESP:Button({
    ["Title"] = "Spectate Random",
    ["Locked"] = false,
    ["Callback"] = function()
        local PlayersRandom = game:GetService("Players")
        local LocalPlayerRandom = PlayersRandom.LocalPlayer
        local AllPlayers = PlayersRandom:GetPlayers()
        if #AllPlayers <= 1 then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                ["Title"] = "Project Nexora",
                ["Text"] = "There must be at least 2 people on the server",
                ["Duration"] = 1,
                ["Callback"] = AllowRunServiceBind
            })
        else
            repeat
                local RandomPlayer = AllPlayers[math.random(1, #AllPlayers)]
            until RandomPlayer ~= LocalPlayerRandom and RandomPlayer.Character and RandomPlayer.Character:FindFirstChild("Humanoid")
            workspace.CurrentCamera.CameraSubject = RandomPlayer.Character:FindFirstChild("Humanoid")
        end
    end
})

local LocalPlayerStopSpectate = game:GetService("Players").LocalPlayer
local CameraStopSpectate = game.Workspace.CurrentCamera

Tabs.ESP:Button({
    ["Title"] = "Stop Spectating",
    ["Locked"] = false,
    ["Callback"] = function()
        if LocalPlayerStopSpectate.Character and LocalPlayerStopSpectate.Character:FindFirstChild("Humanoid") then
            CameraStopSpectate.CameraSubject = LocalPlayerStopSpectate.Character:FindFirstChild("Humanoid")
        end
    end
})

Tabs.Farm:Section({
    ["Title"] = "Coin Farm",
    ["Icon"] = "package"
})

local PlayersFarm = game:GetService("Players")
local RunServiceFarm = game:GetService("RunService")
local WorkspaceFarm = game:GetService("Workspace")
local CoinFarmEnabled = false
local TeleportWalkEnabled = false
local CoinFarmMode = "Nearest"
local TeleportInterval = 3
local WalkCoinRadius = 15
local LastTeleportTime = 0
local LastTeleportedCoin = nil
local CurrentWalkTarget = nil
local CoinContainer = nil

local function FindTargetCoin(RootPart)
    local NearestDistance = math.huge
    local AllCoins = {}
    local NearestCoin = nil
    for _, Child in ipairs(CoinContainer:GetChildren()) do
        local CoinPart = nil
        if Child:IsA("BasePart") then
            CoinPart = Child
        elseif Child:IsA("Model") and Child.PrimaryPart then
            CoinPart = Child.PrimaryPart
        end
        if CoinPart and (CoinPart.Parent and CoinPart ~= LastTeleportedCoin) then
            if CoinFarmMode ~= "Nearest" then
                table.insert(AllCoins, CoinPart)
            else
                local Distance = (RootPart.Position - CoinPart.Position).Magnitude
                if Distance < NearestDistance then
                    NearestCoin = CoinPart
                    NearestDistance = Distance
                end
            end
        end
    end
    if CoinFarmMode == "Nearest" then
        return NearestCoin
    end
    if #AllCoins > 0 then
        return AllCoins[math.random(1, #AllCoins)]
    end
end

local function FindNearbyCoin(RootPart)
    local SearchRadius = WalkCoinRadius
    local CurrentPosition = RootPart.Position
    local NearestCoin = nil
    local NearestDistance = SearchRadius
    for _, Child in ipairs(CoinContainer:GetChildren()) do
        local CoinPart = nil
        if Child:IsA("BasePart") then
            CoinPart = Child
        elseif Child:IsA("Model") and Child.PrimaryPart then
            CoinPart = Child.PrimaryPart
        end
        if CoinPart and (CoinPart.Parent and (CoinPart ~= LastTeleportedCoin and CoinPart ~= CurrentWalkTarget)) then
            local Distance = (CurrentPosition - CoinPart.Position).Magnitude
            if Distance < NearestDistance then
                NearestCoin = CoinPart
                NearestDistance = Distance
            end
        end
    end
    return NearestCoin
end

RunServiceFarm.Heartbeat:Connect(function()
    if not (CoinContainer and CoinContainer.Parent) then
        CoinContainer = WorkspaceFarm:FindFirstChild("CoinContainer", true)
    end
    local LocalPlayerFarm = PlayersFarm.LocalPlayer
    if CoinFarmEnabled and (LocalPlayerFarm and CoinContainer) then
        local Character = LocalPlayerFarm.Character
        if Character then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            local RootPart = Character:FindFirstChild("HumanoidRootPart")
            if Humanoid and (Humanoid.Health > 0 and RootPart) then
                local CurrentTime = os.clock()
                if TeleportWalkEnabled then
                    if TeleportInterval > CurrentTime - LastTeleportTime then
                        local NearbyCoin = not (CurrentWalkTarget and CurrentWalkTarget.Parent) and FindNearbyCoin(RootPart)
                        if NearbyCoin then
                            CurrentWalkTarget = NearbyCoin
                            Humanoid:MoveTo(NearbyCoin.Position)
                            Humanoid.MoveToFinished:Wait()
                            CurrentWalkTarget = nil
                        end
                    else
                        local TargetCoin = FindTargetCoin(RootPart)
                        if TargetCoin then
                            RootPart.CFrame = TargetCoin.CFrame
                            LastTeleportedCoin = TargetCoin
                            CurrentWalkTarget = nil
                            LastTeleportTime = CurrentTime
                        end
                    end
                else
                    local TargetCoin = TeleportInterval <= CurrentTime - LastTeleportTime and FindTargetCoin(RootPart)
                    if TargetCoin then
                        RootPart.CFrame = TargetCoin.CFrame
                        LastTeleportedCoin = TargetCoin
                        LastTeleportTime = CurrentTime
                    end
                end
            end
        else
            return
        end
    else
        return
    end
end)

Tabs.Farm:Toggle({
    ["Title"] = "Auto Farm Coin",
    ["Value"] = false,
    ["Callback"] = function(State)
        CoinFarmEnabled = State
        if not State then
            LastTeleportedCoin = nil
            CurrentWalkTarget = nil
        end
    end
})

Tabs.Farm:Toggle({
    ["Title"] = "Teleport + Walk",
    ["Value"] = false,
    ["Callback"] = function(State)
        TeleportWalkEnabled = State
    end
})

Tabs.Farm:Dropdown({
    ["Title"] = "Coin Farm Mode",
    ["Desc"] = "Ana hedef coin'i nasıl seçeceğini belirle",
    ["Values"] = { "Nearest", "Random" },
    ["Value"] = "Nearest",
    ["Callback"] = function(Value)
        CoinFarmMode = Value
    end
})

Tabs.Farm:Slider({
    ["Title"] = "Teleport Interval",
    ["step"] = 1,
    ["Value"] = {
        ["Min"] = 3,
        ["Max"] = 10,
        ["Default"] = 4
    },
    ["Callback"] = function(Value)
        TeleportInterval = tonumber(Value) or 3
    end
})

local RunServiceSpin = game:GetService("RunService")
local SpinEnabled = false
local SpinSpeed = 5
local SpinConnection = nil

Tabs.Farm:Toggle({
    ["Title"] = "Spin (spin for getting coins easily)",
    ["Value"] = false,
    ["Callback"] = function(State)
        if State then
            SpinEnabled = true
            local RootPart = (game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
            SpinConnection = RunServiceSpin.RenderStepped:Connect(function(_)
                if SpinEnabled and RootPart then
                    RootPart.CFrame = RootPart.CFrame * CFrame.Angles(0, math.rad(SpinSpeed), 0)
                end
            end)
        else
            SpinEnabled = false
            if SpinConnection then
                SpinConnection:Disconnect()
                SpinConnection = nil
            end
        end
    end
})

local AntiAFKConnection = nil

Tabs.Farm:Toggle({
    ["Title"] = "Anti-AFK",
    ["Value"] = false,
    ["Callback"] = function(State)
        if State then
            AntiAFKConnection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
                game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                task.wait(10)
                game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        elseif AntiAFKConnection then
            AntiAFKConnection:Disconnect()
            AntiAFKConnection = nil
        end
    end
})


Tabs.Place:Button({
    ["Title"] = "Teleport To Sheriff",
    ["Callback"] = function()
        loadstring(game:HttpGet("https://pastefy.app/62Z9VRVr/raw"))("ture")
    end
})

Tabs.Place:Button({
    ["Title"] = "Teleport To Murderer",
    ["Callback"] = function()
        loadstring(game:HttpGet("https://pastefy.app/IrRhoidd/raw"))("true")
    end
})

local PlayersPlace = game:GetService("Players")
local LocalPlayerPlace = PlayersPlace.LocalPlayer
local LoopTeleportAllEnabled = false
originalPosition = nil

Tabs.Place:Toggle({
    ["Title"] = "Loop Teleport Everyone",
    ["Value"] = false,
    ["Callback"] = function(State)
        LoopTeleportAllEnabled = State
        if State then
            if LocalPlayerPlace.Character and LocalPlayerPlace.Character:FindFirstChild("HumanoidRootPart") then
                originalPosition = LocalPlayerPlace.Character.HumanoidRootPart.CFrame
            end
            startTeleporting()
        elseif originalPosition and LocalPlayerPlace.Character and LocalPlayerPlace.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayerPlace.Character.HumanoidRootPart.CFrame = originalPosition
        end
    end
})

function startTeleporting()
    task.spawn(function()
        while LoopTeleportAllEnabled do
            for _, Player in ipairs(PlayersPlace:GetPlayers()) do
                if Player ~= LocalPlayerPlace and Player.Character and (Player.Character:FindFirstChild("HumanoidRootPart") and LocalPlayerPlace.Character and LocalPlayerPlace.Character:FindFirstChild("HumanoidRootPart")) then
                    LocalPlayerPlace.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame
                    task.wait(0.1)
                end
            end
            task.wait(0.1)
        end
    end)
end

LocalPlayerPlace.CharacterAdded:Connect(function()
    if LoopTeleportAllEnabled then
        startTeleporting()
    end
end)

Tabs.Place:Button({
    ["Title"] = "Teleport To Lobby",
    ["Callback"] = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108.5, 142, 0.6)
    end
})

Tabs.Place:Button({
    ["Title"] = "Teleport To Map",
    ["Callback"] = function()
        loadstring(game:HttpGet("https://pastefy.app/lvZs7ugv/raw"))("true")
    end
})

Tabs.Fling:Button({
    ["Title"] = "Fling Sheriff",
    ["Callback"] = function()
        local PlayersFling = game:GetService("Players")
        local LocalPlayerFling = PlayersFling.LocalPlayer
        local TargetPlayer = nil
        for _, Player in pairs(PlayersFling:GetPlayers()) do
            if Player ~= LocalPlayerFling and Player.Character then
                local Backpack = Player:FindFirstChild("Backpack")
                if Backpack and Backpack:FindFirstChild("Gun") then
                    TargetPlayer = Player
                    break
                end
            end
        end
        if TargetPlayer then
            miniFling(TargetPlayer)
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                ["Title"] = "Project Nexora",
                ["Text"] = "Sheriff Not found!",
                ["Duration"] = 1
            })
        end
    end
})

Tabs.Fling:Button({
    ["Title"] = "Fling Murderer",
    ["Callback"] = function()
        local PlayersFling = game:GetService("Players")
        local LocalPlayerFling = PlayersFling.LocalPlayer
        local TargetPlayer = nil
        for _, Player in pairs(PlayersFling:GetPlayers()) do
            if Player ~= LocalPlayerFling and Player.Character then
                local Backpack = Player:FindFirstChild("Backpack")
                if Backpack and Backpack:FindFirstChild("Knife") then
                    TargetPlayer = Player
                    break
                end
            end
        end
        if TargetPlayer then
            miniFling(TargetPlayer)
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                ["Title"] = "Project Nexora",
                ["Text"] = "Murderer Not Found",
                ["Duration"] = 1,
                ["Callback"] = AllowRunServiceBind
            })
        end
    end
})

Tabs.Fling:Button({
    ["Title"] = "Fix fling teleport bug",
    ["Callback"] = function()
        local RootPart = game:GetService("Players").LocalPlayer.Character
        if RootPart then
            RootPart = RootPart:FindFirstChild("HumanoidRootPart")
        end
        if RootPart then
            if getgenv().OldPos then
                getgenv().OldPos = RootPart.CFrame
                game.StarterGui:SetCore("SendNotification", {
                    ["Title"] = "Project Nexora",
                    ["Text"] = "Teleport bug fixed!",
                    ["Icon"] = "http://www.roblox.com/asset/?id=89804924525665",
                    ["Duration"] = 5
                })
            else
                game.StarterGui:SetCore("SendNotification", {
                    ["Title"] = "Project Nexora",
                    ["Text"] = "Didn't find any teleport bug?",
                    ["Icon"] = "http://www.roblox.com/asset/?id=89804924525665",
                    ["Duration"] = 5
                })
            end
        end
    end
})


local StarterGuiPlayer = game:GetService("StarterGui")
local PlayersPlayer = game:GetService("Players")
local RunServicePlayer = game:GetService("RunService")
local LocalPlayerPlayer = PlayersPlayer.LocalPlayer
local CameraPlayer = workspace.CurrentCamera
local OriginalCameraSubject = CameraPlayer.CameraSubject
local SelectedPlayer = nil
local DeathNotifyConnection = nil
local OrbitHeartbeatConnection = nil
local OrbitRenderConnection = nil
local ESPRenderConnection = nil
local ESPBillboards = {}
local ESPEnabled = false

local PlayerActions = {
    ["teleport"] = false,
    ["fling"] = false,
    ["view"] = false,
    ["aimLockCam"] = false,
    ["aimLockChar"] = false,
    ["orbit"] = false,
    ["notifyOnDeath"] = false
}

local function SendPlayerNotification(Title, Text, Icon, Duration)
    StarterGuiPlayer:SetCore("SendNotification", {
        ["Title"] = Title or "Project Nexora",
        ["Text"] = Text,
        ["Icon"] = Icon or "rbxassetid://89804924525665",
        ["Duration"] = Duration or 5
    })
end

local function AimCameraAtPlayer(Player)
    if Player then
        Player = Player.Character
    end
    if Player then
        Player = Player:FindFirstChild("Head")
    end
    if Player then
        CameraPlayer.CFrame = CFrame.new(CameraPlayer.CFrame.Position, Player.Position)
    end
end

local function AimCharacterAtPlayer(Player)
    local MyRootPart = LocalPlayerPlayer.Character
    if MyRootPart then
        MyRootPart = MyRootPart:FindFirstChild("HumanoidRootPart")
    end
    if Player then
        Player = Player.Character
    end
    if Player then
        Player = Player:FindFirstChild("HumanoidRootPart")
    end
    if MyRootPart and Player then
        MyRootPart.CFrame = CFrame.new(MyRootPart.Position, Player.Position)
    end
end

local function SetupDeathNotification()
    if DeathNotifyConnection then
        DeathNotifyConnection:Disconnect()
        DeathNotifyConnection = nil
    end
    if PlayerActions.notifyOnDeath and SelectedPlayer then
        local Character = SelectedPlayer.Character or SelectedPlayer.CharacterAdded:Wait()
        if Character then
            Character = Character:FindFirstChildOfClass("Humanoid")
        end
        if Character then
            DeathNotifyConnection = Character.Died:Connect(function()
                SendPlayerNotification("Project Nexora", SelectedPlayer.DisplayName .. " Died")
            end)
        end
    end
end

local function SelectPlayer(PlayerName)
    if DeathNotifyConnection then
        DeathNotifyConnection:Disconnect()
        DeathNotifyConnection = nil
    end
    SelectedPlayer = nil
    if not PlayerName or PlayerName == "" then
        SendPlayerNotification("Project Nexora", "No One Selected")
        return
    end
    local LowerName = string.lower(PlayerName)
    local FoundPlayer = nil
    for _, Player in ipairs(PlayersPlayer:GetPlayers()) do
        if string.find(string.lower(Player.Name), LowerName, 1, true) or string.find(string.lower(Player.DisplayName), LowerName, 1, true) then
            FoundPlayer = Player
            break
        end
    end
    if FoundPlayer then
        SelectedPlayer = FoundPlayer
        SendPlayerNotification("Project Nexora", "Selected: " .. FoundPlayer.DisplayName, "https://www.roblox.com/headshot-thumbnail/image?userId=" .. FoundPlayer.UserId .. "&width=420&height=420&format=png", 10)
        SetupDeathNotification()
    else
        SendPlayerNotification("Project Nexora", "Player Not Found...")
    end
end

function createEspForPlayer(Player)
    local Head = Player.Character
    if Head then
        Head = Player.Character:FindFirstChild("Head")
    end
    if Head then
        local Billboard = Instance.new("BillboardGui")
        Billboard.Name = "ESP_Billboard"
        Billboard.Size = UDim2.new(0, 200, 0, 50)
        Billboard.Adornee = Head
        Billboard.AlwaysOnTop = true
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, 0, 1, 0)
        Frame.BackgroundColor3 = Color3.new(0.8, 0, 0)
        Frame.BackgroundTransparency = 0.6
        Frame.Parent = Billboard
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 8)
        Corner.Parent = Frame
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 1, 0)
        Label.BackgroundTransparency = 1
        Label.TextColor3 = Color3.new(1, 1, 1)
        Label.Text = Player.DisplayName
        Label.Font = Enum.Font.SourceSansBold
        Label.TextSize = 16
        Label.Parent = Frame
        ESPBillboards[Player] = {
            ["billboard"] = Billboard
        }
        Billboard.Parent = LocalPlayerPlayer.PlayerGui
    end
end

function updateEspForPlayer(Player)
    local Data = ESPBillboards[Player]
    if Data and Data.billboard then
        local Head = Player.Character
        if Head then
            Head = Head:FindFirstChild("Head")
        end
        if Head and Data.billboard.Adornee ~= Head then
            Data.billboard.Adornee = Head
        end
    end
end

function removeEspForPlayer(Player)
    if ESPBillboards[Player] then
        if ESPBillboards[Player].billboard then
            ESPBillboards[Player].billboard:Destroy()
        end
        ESPBillboards[Player] = nil
    end
end

function runEspLoop()
    for _, Player in ipairs(PlayersPlayer:GetPlayers()) do
        if Player == LocalPlayerPlayer or not Player.Character or not Player.Character:FindFirstChild("Head") then
            if ESPBillboards[Player] then
                removeEspForPlayer(Player)
            end
        elseif ESPBillboards[Player] then
            updateEspForPlayer(Player)
        else
            createEspForPlayer(Player)
        end
    end
end

Tabs.Fling:Section({
    ["Title"] = "Player Selection",
    ["Icon"] = "eye"
})

Tabs.Fling:Input({
    ["Title"] = "Select Player",
    ["Desc"] = "Enter Player Name To Select Target",
    ["Placeholder"] = "PlayerName",
    ["Callback"] = function(Text)
        SelectPlayer(Text)
    end
})

Tabs.Fling:Section({
    ["Title"] = "Player Actions"
})

Tabs.Fling:Button({
    ["Title"] = "Teleport to Player",
    ["Callback"] = function()
        if SelectedPlayer then
            local MyRootPart = LocalPlayerPlayer.Character
            if MyRootPart then
                MyRootPart = MyRootPart:FindFirstChild("HumanoidRootPart")
            end
            local TargetRootPart = SelectedPlayer.Character
            if TargetRootPart then
                TargetRootPart = TargetRootPart:FindFirstChild("HumanoidRootPart")
            end
            if MyRootPart and TargetRootPart then
                MyRootPart.CFrame = TargetRootPart.CFrame
            else
                SendPlayerNotification("Project Nexora", "Could not find character to teleport.")
            end
        else
            SendPlayerNotification("Project Nexora", "No One Selected")
        end
    end
})

Tabs.Fling:Toggle({
    ["Title"] = "Loop Teleport",
    ["Value"] = PlayerActions.teleport,
    ["Callback"] = function(State)
        PlayerActions.teleport = State
        if State then
            if SelectedPlayer then
                task.spawn(function()
                    while PlayerActions.teleport and (SelectedPlayer and SelectedPlayer.Parent) do
                        local MyRootPart = LocalPlayerPlayer.Character
                        if MyRootPart then
                            MyRootPart = MyRootPart:FindFirstChild("HumanoidRootPart")
                        end
                        local TargetRootPart = SelectedPlayer.Character
                        if TargetRootPart then
                            TargetRootPart = TargetRootPart:FindFirstChild("HumanoidRootPart")
                        end
                        if not (MyRootPart and TargetRootPart) then
                            PlayerActions.teleport = false
                            break
                        end
                        MyRootPart.CFrame = TargetRootPart.CFrame
                        task.wait()
                    end
                end)
            else
                SendPlayerNotification("Project Nexora", "No One Selected")
                PlayerActions.teleport = false
            end
        else
            return
        end
    end
})

Tabs.Fling:Button({
    ["Title"] = "Fling Player",
    ["Callback"] = function()
        if SelectedPlayer then
            miniFling(SelectedPlayer)
        else
            SendPlayerNotification("Project Nexora", "No One Selected")
        end
    end
})

Tabs.Fling:Toggle({
    ["Title"] = "Loop Fling",
    ["Value"] = PlayerActions.fling,
    ["Callback"] = function(State)
        PlayerActions.fling = State
        if State then
            if SelectedPlayer then
                task.spawn(function()
                    while PlayerActions.fling and (SelectedPlayer and SelectedPlayer.Parent) do
                        miniFling(SelectedPlayer)
                        task.wait(0.5)
                    end
                end)
            else
                SendPlayerNotification("Project Nexora", "No One Selected")
                PlayerActions.fling = false
            end
        else
            return
        end
    end
})

Tabs.Fling:Button({
    ["Title"] = "View Player (3 sec)",
    ["Callback"] = function()
        if SelectedPlayer then
            local TargetHumanoid = SelectedPlayer.Character
            if TargetHumanoid then
                TargetHumanoid = TargetHumanoid:FindFirstChildOfClass("Humanoid")
            end
            if TargetHumanoid then
                CameraPlayer.CameraSubject = TargetHumanoid
                task.delay(3, function()
                    if CameraPlayer.CameraSubject == TargetHumanoid then
                        CameraPlayer.CameraSubject = OriginalCameraSubject
                    end
                end)
            else
                SendPlayerNotification("Project Nexora", "Could not find the player's character to view.")
            end
        else
            SendPlayerNotification("Project Nexora", "No One Selected")
        end
    end
})

Tabs.Fling:Toggle({
    ["Title"] = "Loop View",
    ["Value"] = PlayerActions.view,
    ["Callback"] = function(State)
        PlayerActions.view = State
        if State then
            if SelectedPlayer then
                task.spawn(function()
                    while PlayerActions.view and (SelectedPlayer and SelectedPlayer.Parent) do
                        local TargetHumanoid = SelectedPlayer.Character
                        if TargetHumanoid then
                            TargetHumanoid = TargetHumanoid:FindFirstChildOfClass("Humanoid")
                        end
                        if TargetHumanoid then
                            CameraPlayer.CameraSubject = TargetHumanoid
                        end
                        task.wait(0.1)
                    end
                    CameraPlayer.CameraSubject = OriginalCameraSubject
                end)
            else
                SendPlayerNotification("Project Nexora", "No One Selected")
                PlayerActions.view = false
            end
        else
            CameraPlayer.CameraSubject = OriginalCameraSubject
            return
        end
    end
})

Tabs.Fling:Toggle({
    ["Title"] = "AimLock (Camera)",
    ["Value"] = PlayerActions.aimLockCam,
    ["Callback"] = function(State)
        PlayerActions.aimLockCam = State
        if State then
            if SelectedPlayer then
                task.spawn(function()
                    while PlayerActions.aimLockCam and (SelectedPlayer and SelectedPlayer.Parent) do
                        AimCameraAtPlayer(SelectedPlayer)
                        RunServicePlayer.RenderStepped:Wait()
                    end
                end)
            else
                SendPlayerNotification("Project Nexora", "No One Selected")
                PlayerActions.aimLockCam = false
            end
        else
            return
        end
    end
})

Tabs.Fling:Toggle({
    ["Title"] = "AimLock (Character)",
    ["Value"] = PlayerActions.aimLockChar,
    ["Callback"] = function(State)
        PlayerActions.aimLockChar = State
        if State then
            if SelectedPlayer then
                task.spawn(function()
                    while PlayerActions.aimLockChar and (SelectedPlayer and SelectedPlayer.Parent) do
                        AimCharacterAtPlayer(SelectedPlayer)
                        RunServicePlayer.Heartbeat:Wait()
                    end
                end)
            else
                SendPlayerNotification("Project Nexora", "No One Selected")
                PlayerActions.aimLockChar = false
            end
        else
            return
        end
    end
})

Tabs.Fling:Toggle({
    ["Title"] = "ESP",
    ["Value"] = ESPEnabled,
    ["Callback"] = function(State)
        ESPEnabled = State
        if ESPEnabled then
            if not ESPRenderConnection then
                ESPRenderConnection = RunServicePlayer.RenderStepped:Connect(runEspLoop)
            end
        else
            if ESPRenderConnection then
                ESPRenderConnection:Disconnect()
                ESPRenderConnection = nil
            end
            for Player, _ in pairs(ESPBillboards) do
                removeEspForPlayer(Player)
            end
            table.clear(ESPBillboards)
        end
    end
})

Tabs.Fling:Toggle({
    ["Title"] = "Orbit Player",
    ["Value"] = PlayerActions.orbit,
    ["Callback"] = function(State)
        PlayerActions.orbit = State
        if OrbitHeartbeatConnection then
            OrbitHeartbeatConnection:Disconnect()
            OrbitHeartbeatConnection = nil
        end
        if OrbitRenderConnection then
            OrbitRenderConnection:Disconnect()
            OrbitRenderConnection = nil
        end
        if State then
            if SelectedPlayer then
                task.spawn(function()
                    local OrbitAngle = 0
                    local OrbitSpeed = 8
                    local OrbitRadius = 10
                    OrbitHeartbeatConnection = RunServicePlayer.Heartbeat:Connect(function()
                        if PlayerActions.orbit and (SelectedPlayer and SelectedPlayer.Parent) then
                            local MyRootPart = LocalPlayerPlayer.Character
                            if MyRootPart then
                                MyRootPart = MyRootPart:FindFirstChild("HumanoidRootPart")
                            end
                            local TargetRootPart = SelectedPlayer.Character
                            if TargetRootPart then
                                TargetRootPart = TargetRootPart:FindFirstChild("HumanoidRootPart")
                            end
                            if MyRootPart and TargetRootPart then
                                OrbitAngle = OrbitAngle + OrbitSpeed
                                MyRootPart.CFrame = CFrame.new(TargetRootPart.Position) * CFrame.Angles(0, math.rad(OrbitAngle), 0) * CFrame.new(OrbitRadius, 0, 0)
                            else
                                PlayerActions.orbit = false
                            end
                        else
                            if OrbitHeartbeatConnection then
                                OrbitHeartbeatConnection:Disconnect()
                                OrbitHeartbeatConnection = nil
                            end
                            if OrbitRenderConnection then
                                OrbitRenderConnection:Disconnect()
                                OrbitRenderConnection = nil
                            end
                            return
                        end
                    end)
                    OrbitRenderConnection = RunServicePlayer.RenderStepped:Connect(function()
                        if PlayerActions.orbit and (SelectedPlayer and SelectedPlayer.Parent) then
                            local MyRootPart = LocalPlayerPlayer.Character
                            if MyRootPart then
                                MyRootPart = MyRootPart:FindFirstChild("HumanoidRootPart")
                            end
                            local TargetRootPart = SelectedPlayer.Character
                            if TargetRootPart then
                                TargetRootPart = TargetRootPart:FindFirstChild("HumanoidRootPart")
                            end
                            if MyRootPart and TargetRootPart then
                                MyRootPart.CFrame = CFrame.new(MyRootPart.Position, TargetRootPart.Position)
                            else
                                PlayerActions.orbit = false
                            end
                        else
                            if OrbitHeartbeatConnection then
                                OrbitHeartbeatConnection:Disconnect()
                                OrbitHeartbeatConnection = nil
                            end
                            if OrbitRenderConnection then
                                OrbitRenderConnection:Disconnect()
                                OrbitRenderConnection = nil
                            end
                            return
                        end
                    end)
                end)
            else
                SendPlayerNotification("Project Nexora", "No One Selected")
                PlayerActions.orbit = false
            end
        else
            return
        end
    end
})

Tabs.Fling:Toggle({
    ["Title"] = "Notify On Death",
    ["Value"] = PlayerActions.notifyOnDeath,
    ["Callback"] = function(State)
        PlayerActions.notifyOnDeath = State
        SetupDeathNotification()
    end
})

PlayersPlayer.PlayerRemoving:Connect(function(Player)
    if SelectedPlayer and Player == SelectedPlayer then
        SendPlayerNotification("Project Nexora", Player.DisplayName .. " left the game")
        SelectedPlayer = nil
        for Key, _ in pairs(PlayerActions) do
            PlayerActions[Key] = false
        end
    end
    removeEspForPlayer(Player)
end)

Tabs.Fling:Section({
    ["Title"] = "Fling",
    ["Icon"] = "utensils"
})

local FlingAuraEnabled = false
local FlingAuraPlayer = game.Players.LocalPlayer

Tabs.Fling:Toggle({
    ["Title"] = "Fling Aura",
    ["Value"] = false,
    ["Callback"] = function(State)
        FlingAuraEnabled = State
        if State then
            task.spawn(function()
                while FlingAuraEnabled do
                    if FlingAuraPlayer.Character and FlingAuraPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        for _, Player in pairs(game.Players:GetPlayers()) do
                            if Player ~= FlingAuraPlayer and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                                local TargetRootPart = Player.Character.HumanoidRootPart
                                if (FlingAuraPlayer.Character.HumanoidRootPart.Position - TargetRootPart.Position).Magnitude <= 10 then
                                    miniFling(Player)
                                end
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

FlingAuraPlayer.CharacterAdded:Connect(function()
    FlingAuraEnabled = false
end)

local PlayersClickFling = game:GetService("Players")
local UserInputServiceClick = game:GetService("UserInputService")
local LocalPlayerClickFling = PlayersClickFling.LocalPlayer
local MouseClickFling = LocalPlayerClickFling:GetMouse()
local CameraClickFling = workspace.CurrentCamera
local ClickFlingEnabled = false

Tabs.Fling:Toggle({
    ["Title"] = "Click Fling",
    ["Value"] = false,
    ["Callback"] = function(State)
        ClickFlingEnabled = State
    end
})

local function GetPlayerFromPart(Part)
    if Part and Part.Parent and Part.Parent:IsA("Model") then
        local _ = PlayersClickFling.GetPlayerFromCharacter
        local _ = Part.Parent
    end
end

MouseClickFling.Button1Down:Connect(function()
    if ClickFlingEnabled then
        local TargetPlayer = GetPlayerFromPart(MouseClickFling.Target)
        if TargetPlayer and TargetPlayer ~= LocalPlayerClickFling then
            miniFling(TargetPlayer)
        end
    end
end)

UserInputServiceClick.TouchTap:Connect(function(TouchPositions, GameProcessed)
    if ClickFlingEnabled and not GameProcessed then
        local TouchPosition = TouchPositions[1]
        local CameraPosition = CameraClickFling.CFrame.Position
        local RayDirection = CameraClickFling:ViewportPointToRay(TouchPosition.X, TouchPosition.Y).Direction * 500
        local RayParams = RaycastParams.new()
        RayParams.FilterDescendantsInstances = { LocalPlayerClickFling.Character }
        RayParams.FilterType = Enum.RaycastFilterType.Blacklist
        local RayResult = workspace:Raycast(CameraPosition, RayDirection, RayParams)
        local HitInstance
        if RayResult then
            HitInstance = RayResult.Instance
        end
        local TargetPlayer = GetPlayerFromPart(HitInstance)
        if TargetPlayer and TargetPlayer ~= LocalPlayerClickFling then
            miniFling(TargetPlayer)
        end
    end
end)

local FlingAllEnabled = false
local PlayersFlingAll = game:GetService("Players")
local LocalPlayerFlingAll = PlayersFlingAll.LocalPlayer
local OriginalCFrameFlingAll = (LocalPlayerFlingAll.Character or LocalPlayerFlingAll.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
local SavedCFrameFlingAll
if OriginalCFrameFlingAll then
    SavedCFrameFlingAll = OriginalCFrameFlingAll.CFrame
else
    SavedCFrameFlingAll = OriginalCFrameFlingAll
end

Tabs.Fling:Toggle({
    ["Title"] = "Fling All (Buggy?)",
    ["Value"] = false,
    ["Callback"] = function(State)
        FlingAllEnabled = State
        if State then
            task.spawn(function()
                while FlingAllEnabled do
                    for _, Player in pairs(PlayersFlingAll:GetPlayers()) do
                        if Player ~= LocalPlayerFlingAll then
                            miniFling(Player)
                        end
                    end
                    task.wait(0.5)
                end
            end)
        elseif SavedCFrameFlingAll and OriginalCFrameFlingAll then
            OriginalCFrameFlingAll.CFrame = SavedCFrameFlingAll
        end
    end
})

local _ = game.Players.LocalPlayer
game:GetService("UserInputService")

local TouchFlingEnabled
if game:GetService("ReplicatedStorage"):FindFirstChild("juisdfj0i32i0eidsuf0iok") then
    TouchFlingEnabled = false
else
    local Decal = Instance.new("Decal")
    Decal.Name = "juisdfj0i32i0eidsuf0iok"
    Decal.Parent = game:GetService("ReplicatedStorage")
    TouchFlingEnabled = false
end

local function TouchFlingLoop()
    local Character = nil
    local RootPart = nil
    local ToggleValue = 0.1
    while TouchFlingEnabled do
        game:GetService("RunService").Heartbeat:Wait()
        local LocalPlayerTouch = game.Players.LocalPlayer
        while TouchFlingEnabled and not (Character and (Character.Parent and (RootPart and RootPart.Parent))) do
            game:GetService("RunService").Heartbeat:Wait()
            Character = LocalPlayerTouch.Character
            RootPart = Character:FindFirstChild("HumanoidRootPart") or (Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso"))
        end
        if TouchFlingEnabled then
            local CurrentVelocity = RootPart.Velocity
            RootPart.Velocity = CurrentVelocity * 10000 + Vector3.new(0, 10000, 0)
            game:GetService("RunService").RenderStepped:Wait()
            if Character and (Character.Parent and (RootPart and RootPart.Parent)) then
                RootPart.Velocity = CurrentVelocity
            end
            game:GetService("RunService").Stepped:Wait()
            if Character and (Character.Parent and (RootPart and RootPart.Parent)) then
                RootPart.Velocity = CurrentVelocity + Vector3.new(0, ToggleValue, 0)
                ToggleValue = ToggleValue * -1
            end
        end
    end
end

Tabs.Fling:Toggle({
    ["Title"] = "Touch Fling",
    ["Value"] = false,
    ["Callback"] = function(State)
        if State then
            TouchFlingEnabled = true
            coroutine.wrap(TouchFlingLoop)()
        else
            TouchFlingEnabled = false
        end
    end
})

local AntiFlingEnabled = false
local AntiFlingConnections = {}

local function DisablePlayerCollision(Player)
    if AntiFlingEnabled and Player.Character then
        for _, Descendant in pairs(Player.Character:GetDescendants()) do
            if Descendant:IsA("BasePart") and Descendant.CanCollide then
                Descendant.CanCollide = false
            end
        end
    end
end

local function EnableAllPlayerCollisions()
    for _, Player in pairs(game.Players:GetPlayers()) do
        if Player ~= game.Players.LocalPlayer and Player.Character then
            for _, Descendant in pairs(Player.Character:GetDescendants()) do
                if Descendant:IsA("BasePart") then
                    Descendant.CanCollide = true
                end
            end
        end
    end
end

local function StartAntiFling()
    for _, Player in pairs(game.Players:GetPlayers()) do
        if Player ~= game.Players.LocalPlayer then
            local Connection = game:GetService("RunService").Stepped:Connect(function()
                DisablePlayerCollision(Player)
            end)
            table.insert(AntiFlingConnections, Connection)
        end
    end
    game.Players.PlayerAdded:Connect(function(Player)
        if Player ~= game.Players.LocalPlayer then
            local Connection = game:GetService("RunService").Stepped:Connect(function()
                DisablePlayerCollision(Player)
            end)
            table.insert(AntiFlingConnections, Connection)
        end
    end)
end

local function StopAntiFling()
    for _, Connection in pairs(AntiFlingConnections) do
        Connection:Disconnect()
    end
    table.clear(AntiFlingConnections)
    EnableAllPlayerCollisions()
end

Tabs.Fling:Toggle({
    ["Title"] = "Anti Fling",
    ["Value"] = false,
    ["Callback"] = function(State)
        AntiFlingEnabled = State
        if State then
            StartAntiFling()
        else
            StopAntiFling()
        end
    end
})

local CustomFlingPower = 1000

local CustomTouchFlingEnabled
if game:GetService("ReplicatedStorage"):FindFirstChild("juisdfj0i32i0eidsuf0iok") then
    CustomTouchFlingEnabled = false
else
    local Decal = Instance.new("Decal")
    Decal.Name = "juisdfj0i32i0eidsuf0iok"
    Decal.Parent = game:GetService("ReplicatedStorage")
    CustomTouchFlingEnabled = false
end

local function CustomTouchFlingLoop()
    local Character = nil
    local RootPart = nil
    local ToggleValue = 0.1
    while CustomTouchFlingEnabled do
        game:GetService("RunService").Heartbeat:Wait()
        local LocalPlayerCustom = game.Players.LocalPlayer
        while CustomTouchFlingEnabled and not (Character and (Character.Parent and (RootPart and RootPart.Parent))) do
            game:GetService("RunService").Heartbeat:Wait()
            Character = LocalPlayerCustom.Character
            RootPart = Character:FindFirstChild("HumanoidRootPart") or (Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso"))
        end
        if CustomTouchFlingEnabled then
            local CurrentVelocity = RootPart.Velocity
            RootPart.Velocity = CurrentVelocity * CustomFlingPower + Vector3.new(0, 100, 0)
            game:GetService("RenderStepped"):Wait()
            if Character and (Character.Parent and (RootPart and RootPart.Parent)) then
                RootPart.Velocity = CurrentVelocity
            end
            game:GetService("RunService").Stepped:Wait()
            if Character and (Character.Parent and (RootPart and RootPart.Parent)) then
                RootPart.Velocity = CurrentVelocity + Vector3.new(0, ToggleValue, 0)
                ToggleValue = ToggleValue * -1
            end
        end
    end
end

Tabs.Fling:Toggle({
    ["Title"] = "Costum Touch Fling Power",
    ["Value"] = false,
    ["Callback"] = function(State)
        if State then
            CustomTouchFlingEnabled = true
            coroutine.wrap(CustomTouchFlingLoop)()
        else
            CustomTouchFlingEnabled = false
        end
    end
})

Tabs.Fling:Slider({
    ["Title"] = "Fling Power Value",
    ["Value"] = {
        ["Min"] = 1,
        ["Max"] = 10000,
        ["Default"] = 100
    },
    ["Callback"] = function(Value)
        CustomFlingPower = Value
    end
})

-- Info Tab Configuration
local Info = Tabs.Info

Info:Section({
    ["Title"] = "Project Nexora Features",
    ["TextXAlignment"] = "Center"
})

Info:Paragraph({
    ["Title"] = "Current Features",
    ["Desc"] = "• Auto shoot\n• ESP\n• Fling GUI\nAuto shoot Gui\nAuto Kill All",
    ["Image"] = "rbxassetid://89804924525665",
    ["ImageSize"] = 30
})

Info:Divider()

Info:Section({
    ["Title"] = "Social Media",
    ["TextXAlignment"] = "Center"
})

Info:Paragraph({
    ["Title"] = "TikTok Page : Naytansu1",
    ["Desc"] = "Follow our TikTok for more reworks!",
    ["Image"] = "rbxassetid://89804924525665",
    ["ImageSize"] = 30
})

