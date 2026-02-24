-- Eliana Hub | God Mode - Enhanced UI
-- Purple theme, mobile optimized, draggable, minimizable

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- UI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ElianaHub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = game.CoreGui

-- Main Frame (Mobile optimized - bigger touch targets)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 15, 35)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Rounded corners
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = mainFrame

-- Purple gradient background
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 20, 60)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 15, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 25, 80))
})
gradient.Rotation = 45
gradient.Parent = mainFrame

-- Purple border glow
local borderFrame = Instance.new("Frame")
borderFrame.Name = "Border"
borderFrame.Size = UDim2.new(1, 4, 1, 4)
borderFrame.Position = UDim2.new(0, -2, 0, -2)
borderFrame.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
borderFrame.BackgroundTransparency = 0.8
borderFrame.BorderSizePixel = 0
borderFrame.ZIndex = -1
borderFrame.Parent = mainFrame

local borderCorner = Instance.new("UICorner")
borderCorner.CornerRadius = UDim.new(0, 18)
borderCorner.Parent = borderFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 20, 55)
titleBar.BackgroundTransparency = 0.2
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 16)
titleCorner.Parent = titleBar

-- Fix bottom corners of title bar
local titleBottomFix = Instance.new("Frame")
titleBottomFix.Size = UDim2.new(1, 0, 0, 20)
titleBottomFix.Position = UDim2.new(0, 0, 1, -20)
titleBottomFix.BackgroundColor3 = Color3.fromRGB(35, 20, 55)
titleBottomFix.BackgroundTransparency = 0.2
titleBottomFix.BorderSizePixel = 0
titleBottomFix.Parent = titleBar

-- Title Text
local titleText = Instance.new("TextLabel")
titleText.Name = "Title"
titleText.Size = UDim2.new(0.5, 0, 0.6, 0)
titleText.Position = UDim2.new(0.05, 0, 0.1, 0)
titleText.Text = "Eliana Hub"
titleText.TextColor3 = Color3.fromRGB(216, 180, 254)
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 20
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.BackgroundTransparency = 1
titleText.Parent = titleBar

-- Subtitle
local subtitleText = Instance.new("TextLabel")
subtitleText.Name = "Subtitle"
subtitleText.Size = UDim2.new(0.5, 0, 0.4, 0)
subtitleText.Position = UDim2.new(0.05, 0, 0.55, 0)
subtitleText.Text = "God Mode"
subtitleText.TextColor3 = Color3.fromRGB(168, 85, 247)
subtitleText.Font = Enum.Font.Gotham
subtitleText.TextSize = 12
subtitleText.TextXAlignment = Enum.TextXAlignment.Left
subtitleText.BackgroundTransparency = 1
subtitleText.Parent = titleBar

-- Minimize Button
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 40, 0, 40)
minimizeBtn.Position = UDim2.new(1, -90, 0, 5)
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 40, 90)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 24
minimizeBtn.Parent = titleBar

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 10)
minimizeCorner.Parent = minimizeBtn

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 80)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 24
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeBtn

-- Content Container (for minimize animation)
local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, 0, 1, -50)
contentFrame.Position = UDim2.new(0, 0, 0, 50)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Status Indicator
local statusFrame = Instance.new("Frame")
statusFrame.Name = "Status"
statusFrame.Size = UDim2.new(0.9, 0, 0, 45)
statusFrame.Position = UDim2.new(0.05, 0, 0.08, 0)
statusFrame.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
statusFrame.BorderSizePixel = 0
statusFrame.Parent = contentFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 10)
statusCorner.Parent = statusFrame

local statusGlow = Instance.new("Frame")
statusGlow.Size = UDim2.new(1, 4, 1, 4)
statusGlow.Position = UDim2.new(0, -2, 0, -2)
statusGlow.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
statusGlow.BackgroundTransparency = 0.9
statusGlow.BorderSizePixel = 0
statusGlow.ZIndex = -1
statusGlow.Parent = statusFrame

local statusGlowCorner = Instance.new("UICorner")
statusGlowCorner.CornerRadius = UDim.new(0, 12)
statusGlowCorner.Parent = statusGlow

local statusDot = Instance.new("Frame")
statusDot.Name = "Dot"
statusDot.Size = UDim2.new(0, 14, 0, 14)
statusDot.Position = UDim2.new(0, 15, 0.5, -7)
statusDot.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
statusDot.BorderSizePixel = 0
statusDot.Parent = statusFrame

local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = statusDot

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "Label"
statusLabel.Size = UDim2.new(0.7, 0, 1, 0)
statusLabel.Position = UDim2.new(0, 40, 0, 0)
statusLabel.Text = "Status: Inactive"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.Font = Enum.Font.GothamSemibold
statusLabel.TextSize = 15
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.BackgroundTransparency = 1
statusLabel.Parent = statusFrame

-- God Mode Button
local godmodeBtn = Instance.new("TextButton")
godmodeBtn.Name = "GodmodeBtn"
godmodeBtn.Size = UDim2.new(0.9, 0, 0, 60)
godmodeBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
godmodeBtn.Text = "Enable God Mode"
godmodeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
godmodeBtn.BackgroundColor3 = Color3.fromRGB(88, 28, 135)
godmodeBtn.Font = Enum.Font.GothamBold
godmodeBtn.TextSize = 18
godmodeBtn.Parent = contentFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 12)
btnCorner.Parent = godmodeBtn

-- Button gradient
local btnGradient = Instance.new("UIGradient")
btnGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 50, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(88, 28, 135))
})
btnGradient.Rotation = 90
btnGradient.Parent = godmodeBtn

-- Button glow effect
local btnGlow = Instance.new("Frame")
btnGlow.Size = UDim2.new(1, 6, 1, 6)
btnGlow.Position = UDim2.new(0, -3, 0, -3)
btnGlow.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
btnGlow.BackgroundTransparency = 0.9
btnGlow.BorderSizePixel = 0
btnGlow.ZIndex = -1
btnGlow.Parent = godmodeBtn

local btnGlowCorner = Instance.new("UICorner")
btnGlowCorner.CornerRadius = UDim.new(0, 14)
btnGlowCorner.Parent = btnGlow

-- Info Label
local infoLabel = Instance.new("TextLabel")
infoLabel.Name = "Info"
infoLabel.Size = UDim2.new(0.9, 0, 0, 25)
infoLabel.Position = UDim2.new(0.05, 0, 0.82, 0)
infoLabel.Text = "Tap button to toggle invincibility"
infoLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 12
infoLabel.TextXAlignment = Enum.TextXAlignment.Center
infoLabel.BackgroundTransparency = 1
infoLabel.Parent = contentFrame

-- Minimize Logic
local isMinimized = false
local originalSize = mainFrame.Size
local minimizedSize = UDim2.new(0, 300, 0, 50)

minimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    
    if isMinimized then
        -- Minimize
        minimizeBtn.Text = "+"
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
            Size = minimizedSize
        }):Play()
        contentFrame.Visible = false
        borderFrame.Visible = false
    else
        -- Restore
        minimizeBtn.Text = "−"
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
            Size = originalSize
        }):Play()
        contentFrame.Visible = true
        borderFrame.Visible = true
    end
end)

-- Close Logic
closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.2), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    wait(0.2)
    screenGui:Destroy()
end)

-- Smooth Dragging Logic (Mobile + PC)
local dragging = false
local dragStart = nil
local startPos = nil

local function updateInput(input)
    if dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
                     input.UserInputType == Enum.UserInputType.Touch) then
        updateInput(input)
    end
end)

-- Hover Effects
local function addHoverEffect(button, originalColor, hoverColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = hoverColor
        }):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = originalColor
        }):Play()
    end)
end

addHoverEffect(minimizeBtn, Color3.fromRGB(60, 40, 90), Color3.fromRGB(80, 60, 120))
addHoverEffect(closeBtn, Color3.fromRGB(180, 50, 80), Color3.fromRGB(220, 70, 100))

-- God Mode Logic
local isGodmode = false
local ghostClone = nil
local connection = nil
local noclipConn = nil

local function cleanup()
    isGodmode = false
    
    -- Update UI
    godmodeBtn.Text = "Enable God Mode"
    godmodeBtn.BackgroundColor3 = Color3.fromRGB(88, 28, 135)
    btnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 50, 180)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(88, 28, 135))
    })
    statusDot.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
    statusLabel.Text = "Status: Inactive"
    TweenService:Create(statusDot, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    
    if connection then connection:Disconnect() connection = nil end
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    
    local char = player.Character
    if char then
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then 
                v.CanCollide = true 
                v.Velocity = Vector3.zero 
            end
        end
        
        if ghostClone and root then
            root.CFrame = ghostClone.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0)
        end
        
        if hum then 
            hum.PlatformStand = false
            hum:ChangeState(Enum.HumanoidStateType.Landed)
            camera.CameraSubject = hum
        end
    end

    if ghostClone then 
        ghostClone:Destroy() 
        ghostClone = nil 
    end
end

godmodeBtn.MouseButton1Click:Connect(function()
    isGodmode = not isGodmode
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    
    if isGodmode and root and hum then
        -- Enable God Mode
        godmodeBtn.Text = "Disable God Mode"
        godmodeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 80)
        btnGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 70, 100)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 50, 80))
        })
        statusDot.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
        statusLabel.Text = "Status: Active"
        
        -- Pulsing effect for status dot
        spawn(function()
            while isGodmode do
                TweenService:Create(statusDot, TweenInfo.new(0.5), {BackgroundTransparency = 0.3}):Play()
                wait(0.5)
                if not isGodmode then break end
                TweenService:Create(statusDot, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
                wait(0.5)
            end
        end)
        
        char.Archivable = true
        ghostClone = char:Clone()
        ghostClone.Parent = workspace
        char.Archivable = false
        
        for _, v in pairs(ghostClone:GetDescendants()) do
            if v:IsA("BasePart") then 
                v.Transparency = 0.5 
                v.CanCollide = true 
            end
        end

        hum.PlatformStand = true
        camera.CameraSubject = ghostClone.Humanoid
        
        noclipConn = RunService.Stepped:Connect(function()
            if isGodmode and char then
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then 
                        v.CanCollide = false 
                    end 
                end
            end
        end)

        connection = RunService.Heartbeat:Connect(function()
            if ghostClone and char:FindFirstChild("HumanoidRootPart") then
                ghostClone.Humanoid:Move(hum.MoveDirection)
                ghostClone.Humanoid.Jump = hum.Jump
                root.CFrame = ghostClone.HumanoidRootPart.CFrame * CFrame.new(0, -10, 0)
                root.AssemblyLinearVelocity = Vector3.zero
            else
                cleanup()
            end
        end)
    else
        cleanup()
    end
end)

-- Button press animation
godmodeBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        TweenService:Create(godmodeBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.85, 0, 0, 55)}):Play()
    end
end)

godmodeBtn.InputEnded:Connect(function(input)
    TweenService:Create(godmodeBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.9, 0, 0, 60)}):Play()
end)
