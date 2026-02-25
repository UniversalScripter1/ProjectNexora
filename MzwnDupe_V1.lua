--[[
    Mzwn Scripts - Custom Draggable GUI
    Pure Roblox implementation, no external libraries
    V1: Fixed Minimize & Notifications
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Configuration
local CONFIG = {
    Colors = {
        Background = Color3.fromRGB(25, 25, 35),
        Header = Color3.fromRGB(35, 35, 50),
        Accent = Color3.fromRGB(120, 80, 200),
        AccentHover = Color3.fromRGB(140, 100, 230),
        Text = Color3.fromRGB(255, 255, 255),
        TextDim = Color3.fromRGB(180, 180, 200),
        Success = Color3.fromRGB(80, 200, 120),
        Error = Color3.fromRGB(200, 80, 80)
    },
    CornerRadius = UDim.new(0, 12),
    AnimationSpeed = 0.3
}

-- Utility Functions
local function CreateTween(instance, properties, duration, easingStyle, easingDirection)
    local tween = TweenService:Create(
        instance,
        TweenInfo.new(duration or CONFIG.AnimationSpeed, easingStyle or Enum.EasingStyle.Quart, easingDirection or Enum.EasingDirection.Out),
        properties
    )
    tween:Play()
    return tween
end

local function MakeDraggable(frame, dragHandle)
    local dragging = false
    local dragStart = nil
    local startPos = nil

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            frame.ZIndex = 100
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            frame.ZIndex = 10
        end
    end)
end

-- ─────────────────────────────────────────────
-- NOTIFICATION SYSTEM (Fixed)
-- ─────────────────────────────────────────────
local NotificationContainer = nil

local function InitNotifications()
    if NotificationContainer then return end

    NotificationContainer = Instance.new("ScreenGui")
    NotificationContainer.Name = "MzwnNotifications"
    NotificationContainer.Parent = PlayerGui
    NotificationContainer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    NotificationContainer.DisplayOrder = 999
    NotificationContainer.ResetOnSpawn = false

    -- Anchor frame: bottom-right corner, stacks upward
    local listFrame = Instance.new("Frame")
    listFrame.Name = "Container"
    listFrame.Size = UDim2.new(0, 320, 1, 0)
    listFrame.Position = UDim2.new(1, -330, 0, 0)
    listFrame.BackgroundTransparency = 1
    listFrame.ClipsDescendants = false
    listFrame.Parent = NotificationContainer

    local uiList = Instance.new("UIListLayout")
    uiList.Padding = UDim.new(0, 8)
    uiList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiList.VerticalAlignment = Enum.VerticalAlignment.Bottom  -- stack from bottom
    uiList.SortOrder = Enum.SortOrder.LayoutOrder
    uiList.FillDirection = Enum.FillDirection.Vertical
    uiList.Parent = listFrame

    local padding = Instance.new("UIPadding")
    padding.PaddingBottom = UDim.new(0, 20)
    padding.Parent = listFrame
end

local function Notify(data)
    if not NotificationContainer then InitNotifications() end

    local container = NotificationContainer:FindFirstChild("Container")
    if not container then return end

    -- Wrapper to handle slide-in without fighting UIListLayout
    local wrapper = Instance.new("Frame")
    wrapper.Name = "NotifWrapper"
    wrapper.Size = UDim2.new(1, 0, 0, 80)
    wrapper.BackgroundTransparency = 1
    wrapper.ClipsDescendants = true
    wrapper.LayoutOrder = -tick()  -- newest on top (bottom stack)
    wrapper.Parent = container

    local notif = Instance.new("Frame")
    notif.Name = "Notification"
    notif.Size = UDim2.new(1, 0, 1, 0)
    notif.Position = UDim2.new(1, 10, 0, 0)  -- start off-screen to the right (inside wrapper)
    notif.BackgroundColor3 = CONFIG.Colors.Background
    notif.BorderSizePixel = 0
    notif.Parent = wrapper

    local corner = Instance.new("UICorner")
    corner.CornerRadius = CONFIG.CornerRadius
    corner.Parent = notif

    local stroke = Instance.new("UIStroke")
    stroke.Color = CONFIG.Colors.Accent
    stroke.Thickness = 2
    stroke.Parent = notif

    local accentBar = Instance.new("Frame")
    accentBar.Name = "AccentBar"
    accentBar.Size = UDim2.new(0, 4, 1, 0)
    accentBar.Position = UDim2.new(0, 0, 0, 0)
    accentBar.BackgroundColor3 = CONFIG.Colors.Accent
    accentBar.BorderSizePixel = 0
    accentBar.Parent = notif

    local accentCorner = Instance.new("UICorner")
    accentCorner.CornerRadius = UDim.new(0, 4)
    accentCorner.Parent = accentBar

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Name = "Title"
    titleLbl.Size = UDim2.new(1, -50, 0, 25)
    titleLbl.Position = UDim2.new(0, 15, 0, 10)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = data.Title or "Notification"
    titleLbl.TextColor3 = CONFIG.Colors.Text
    titleLbl.TextSize = 15
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = notif

    local contentLbl = Instance.new("TextLabel")
    contentLbl.Name = "Content"
    contentLbl.Size = UDim2.new(1, -20, 0, 35)
    contentLbl.Position = UDim2.new(0, 15, 0, 36)
    contentLbl.BackgroundTransparency = 1
    contentLbl.Text = data.Content or ""
    contentLbl.TextColor3 = CONFIG.Colors.TextDim
    contentLbl.TextSize = 13
    contentLbl.Font = Enum.Font.Gotham
    contentLbl.TextXAlignment = Enum.TextXAlignment.Left
    contentLbl.TextWrapped = true
    contentLbl.Parent = notif

    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "Close"
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(1, -30, 0, 6)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "×"
    closeBtn.TextColor3 = CONFIG.Colors.TextDim
    closeBtn.TextSize = 20
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = notif

    closeBtn.MouseEnter:Connect(function()
        CreateTween(closeBtn, {TextColor3 = CONFIG.Colors.Error}, 0.15)
    end)
    closeBtn.MouseLeave:Connect(function()
        CreateTween(closeBtn, {TextColor3 = CONFIG.Colors.TextDim}, 0.15)
    end)

    -- Slide in from right
    CreateTween(notif, {Position = UDim2.new(0, 0, 0, 0)}, 0.35, Enum.EasingStyle.Back)

    local removing = false
    local function RemoveNotif()
        if removing then return end
        removing = true

        -- Slide out to the right
        local t = CreateTween(notif, {Position = UDim2.new(1, 10, 0, 0)}, 0.3, Enum.EasingStyle.Quart)
        t.Completed:Wait()

        -- Collapse wrapper height smoothly
        local t2 = CreateTween(wrapper, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
        t2.Completed:Wait()

        if wrapper and wrapper.Parent then
            wrapper:Destroy()
        end
    end

    closeBtn.MouseButton1Click:Connect(RemoveNotif)

    -- Progress bar at bottom of notification
    local progress = Instance.new("Frame")
    progress.Name = "Progress"
    progress.Size = UDim2.new(1, 0, 0, 3)
    progress.Position = UDim2.new(0, 0, 1, -3)
    progress.BackgroundColor3 = CONFIG.Colors.Accent
    progress.BorderSizePixel = 0
    progress.Parent = notif

    local progCorner = Instance.new("UICorner")
    progCorner.CornerRadius = UDim.new(0, 2)
    progCorner.Parent = progress

    local dur = data.Duration or 3
    -- Animate progress bar shrink
    CreateTween(progress, {Size = UDim2.new(0, 0, 0, 3)}, dur, Enum.EasingStyle.Linear)

    -- Auto remove after duration
    task.delay(dur, function()
        if wrapper and wrapper.Parent and not removing then
            RemoveNotif()
        end
    end)
end

-- ─────────────────────────────────────────────
-- MAIN GUI
-- ─────────────────────────────────────────────
local function CreateMainGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MzwnScriptsDupe"
    screenGui.Parent = PlayerGui
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainWindow"
    mainFrame.Size = UDim2.new(0, 350, 0, 200)
    mainFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
    mainFrame.BackgroundColor3 = CONFIG.Colors.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.ZIndex = 10
    mainFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = CONFIG.CornerRadius
    corner.Parent = mainFrame

    -- Shadow
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 40, 1, 40)
    shadow.Position = UDim2.new(0, -20, 0, -20)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://5554236805"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.6
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    shadow.ZIndex = 9
    shadow.Parent = mainFrame

    -- Header
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 50)
    header.BackgroundColor3 = CONFIG.Colors.Header
    header.BorderSizePixel = 0
    header.ZIndex = 11
    header.Parent = mainFrame

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 12)
    headerCorner.Parent = header

    local bottomCover = Instance.new("Frame")
    bottomCover.Size = UDim2.new(1, 0, 0, 12)
    bottomCover.Position = UDim2.new(0, 0, 1, -12)
    bottomCover.BackgroundColor3 = CONFIG.Colors.Header
    bottomCover.BorderSizePixel = 0
    bottomCover.ZIndex = 11
    bottomCover.Parent = header

    -- Icon
    local icon = Instance.new("ImageLabel")
    icon.Name = "Icon"
    icon.Size = UDim2.new(0, 24, 0, 24)
    icon.Position = UDim2.new(0, 15, 0, 13)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://7733965118"
    icon.ImageColor3 = CONFIG.Colors.Accent
    icon.ZIndex = 12
    icon.Parent = header

    -- Title
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Name = "Title"
    titleLbl.Size = UDim2.new(1, -100, 0, 25)
    titleLbl.Position = UDim2.new(0, 50, 0, 5)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = "Mzwn Scripts - Dupe"
    titleLbl.TextColor3 = CONFIG.Colors.Text
    titleLbl.TextSize = 18
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 12
    titleLbl.Parent = header

    local author = Instance.new("TextLabel")
    author.Name = "Author"
    author.Size = UDim2.new(1, -100, 0, 15)
    author.Position = UDim2.new(0, 50, 0, 28)
    author.BackgroundTransparency = 1
    author.Text = "by Mzwn"
    author.TextColor3 = CONFIG.Colors.TextDim
    author.TextSize = 12
    author.Font = Enum.Font.Gotham
    author.TextXAlignment = Enum.TextXAlignment.Left
    author.ZIndex = 12
    author.Parent = header

    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "Close"
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -40, 0, 10)
    closeBtn.BackgroundColor3 = CONFIG.Colors.Error
    closeBtn.BackgroundTransparency = 0.9
    closeBtn.Text = "×"
    closeBtn.TextColor3 = CONFIG.Colors.TextDim
    closeBtn.TextSize = 20
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.ZIndex = 12
    closeBtn.Parent = header

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn

    closeBtn.MouseEnter:Connect(function()
        CreateTween(closeBtn, {BackgroundTransparency = 0, TextColor3 = CONFIG.Colors.Text}, 0.2)
    end)
    closeBtn.MouseLeave:Connect(function()
        CreateTween(closeBtn, {BackgroundTransparency = 0.9, TextColor3 = CONFIG.Colors.TextDim}, 0.2)
    end)
    closeBtn.MouseButton1Click:Connect(function()
        local cx = mainFrame.Position.X.Offset
        local cy = mainFrame.Position.Y.Offset
        CreateTween(mainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(mainFrame.Position.X.Scale, cx + 175, mainFrame.Position.Y.Scale, cy + 100)}, 0.3)
        task.wait(0.3)
        screenGui:Destroy()
        if NotificationContainer then NotificationContainer:Destroy() end
    end)

    -- ─── MINIMIZE BUTTON (Fixed) ───
    local minBtn = Instance.new("TextButton")
    minBtn.Name = "Minimize"
    minBtn.Size = UDim2.new(0, 30, 0, 30)
    minBtn.Position = UDim2.new(1, -75, 0, 10)
    minBtn.BackgroundColor3 = CONFIG.Colors.Accent
    minBtn.BackgroundTransparency = 0.9
    minBtn.Text = "−"
    minBtn.TextColor3 = CONFIG.Colors.TextDim
    minBtn.TextSize = 20
    minBtn.Font = Enum.Font.GothamBold
    minBtn.ZIndex = 12
    minBtn.Parent = header

    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 6)
    minCorner.Parent = minBtn

    minBtn.MouseEnter:Connect(function()
        CreateTween(minBtn, {BackgroundTransparency = 0, TextColor3 = CONFIG.Colors.Text}, 0.2)
    end)
    minBtn.MouseLeave:Connect(function()
        CreateTween(minBtn, {BackgroundTransparency = 0.9, TextColor3 = CONFIG.Colors.TextDim}, 0.2)
    end)

    -- Content Frame
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "Content"
    contentFrame.Size = UDim2.new(1, -40, 0, 140)
    contentFrame.Position = UDim2.new(0, 20, 0, 60)
    contentFrame.BackgroundTransparency = 1
    contentFrame.ZIndex = 11
    contentFrame.Parent = mainFrame

    local minimized = false
    local normalSize = UDim2.new(0, 350, 0, 200)
    local minimizedSize = UDim2.new(0, 350, 0, 50)

    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            -- Hide content by making it invisible (no transparency tweening on children = no glitch)
            contentFrame.Visible = false
            -- Shrink frame — ClipsDescendants handles the rest cleanly
            CreateTween(mainFrame, {Size = minimizedSize}, 0.3, Enum.EasingStyle.Quart)
            minBtn.Text = "+"
        else
            -- Expand first, then show content
            local t = CreateTween(mainFrame, {Size = normalSize}, 0.3, Enum.EasingStyle.Quart)
            t.Completed:Connect(function()
                contentFrame.Visible = true
            end)
            minBtn.Text = "−"
        end
    end)

    -- Tab Indicator
    local tabIndicator = Instance.new("Frame")
    tabIndicator.Name = "TabIndicator"
    tabIndicator.Size = UDim2.new(0, 100, 0, 3)
    tabIndicator.Position = UDim2.new(0, 0, 0, 0)
    tabIndicator.BackgroundColor3 = CONFIG.Colors.Accent
    tabIndicator.BorderSizePixel = 0
    tabIndicator.ZIndex = 12
    tabIndicator.Parent = contentFrame

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 2)
    tabCorner.Parent = tabIndicator

    -- Tab Title
    local tabTitle = Instance.new("TextLabel")
    tabTitle.Name = "TabTitle"
    tabTitle.Size = UDim2.new(0, 100, 0, 25)
    tabTitle.Position = UDim2.new(0, 22, 0, 5)
    tabTitle.BackgroundTransparency = 1
    tabTitle.Text = "Main Tab"
    tabTitle.TextColor3 = CONFIG.Colors.Text
    tabTitle.TextSize = 14
    tabTitle.Font = Enum.Font.GothamBold
    tabTitle.TextXAlignment = Enum.TextXAlignment.Left
    tabTitle.ZIndex = 12
    tabTitle.Parent = contentFrame

    local homeIcon = Instance.new("ImageLabel")
    homeIcon.Name = "HomeIcon"
    homeIcon.Size = UDim2.new(0, 16, 0, 16)
    homeIcon.Position = UDim2.new(0, 0, 0, 7)
    homeIcon.BackgroundTransparency = 1
    homeIcon.Image = "rbxassetid://7733963881"
    homeIcon.ImageColor3 = CONFIG.Colors.Accent
    homeIcon.ZIndex = 12
    homeIcon.Parent = contentFrame

    -- Separator
    local separator = Instance.new("Frame")
    separator.Name = "Separator"
    separator.Size = UDim2.new(1, 0, 0, 1)
    separator.Position = UDim2.new(0, 0, 0, 35)
    separator.BackgroundColor3 = CONFIG.Colors.Header
    separator.BorderSizePixel = 0
    separator.ZIndex = 11
    separator.Parent = contentFrame

    -- Button Container
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Name = "ButtonContainer"
    buttonContainer.Size = UDim2.new(1, 0, 1, -45)
    buttonContainer.Position = UDim2.new(0, 0, 0, 45)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.ZIndex = 11
    buttonContainer.Parent = contentFrame

    -- Duplicate Tool Button
    local dupeButton = Instance.new("TextButton")
    dupeButton.Name = "DupeButton"
    dupeButton.Size = UDim2.new(1, 0, 0, 50)
    dupeButton.Position = UDim2.new(0, 0, 0, 10)
    dupeButton.BackgroundColor3 = CONFIG.Colors.Accent
    dupeButton.BorderSizePixel = 0
    dupeButton.Text = ""
    dupeButton.AutoButtonColor = false
    dupeButton.ZIndex = 12
    dupeButton.Parent = buttonContainer

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = CONFIG.CornerRadius
    btnCorner.Parent = dupeButton

    local btnGradient = Instance.new("UIGradient")
    btnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, CONFIG.Colors.Accent),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 60, 180))
    })
    btnGradient.Rotation = 45
    btnGradient.Parent = dupeButton

    local btnTitle = Instance.new("TextLabel")
    btnTitle.Name = "Title"
    btnTitle.Size = UDim2.new(1, -20, 0, 20)
    btnTitle.Position = UDim2.new(0, 10, 0, 8)
    btnTitle.BackgroundTransparency = 1
    btnTitle.Text = "Duplicate Tool"
    btnTitle.TextColor3 = CONFIG.Colors.Text
    btnTitle.TextSize = 16
    btnTitle.Font = Enum.Font.GothamBold
    btnTitle.TextXAlignment = Enum.TextXAlignment.Left
    btnTitle.ZIndex = 13
    btnTitle.Parent = dupeButton

    local btnDesc = Instance.new("TextLabel")
    btnDesc.Name = "Desc"
    btnDesc.Size = UDim2.new(1, -20, 0, 15)
    btnDesc.Position = UDim2.new(0, 10, 0, 28)
    btnDesc.BackgroundTransparency = 1
    btnDesc.Text = "Duplicate the tool in your hand"
    btnDesc.TextColor3 = CONFIG.Colors.TextDim
    btnDesc.TextSize = 12
    btnDesc.Font = Enum.Font.Gotham
    btnDesc.TextXAlignment = Enum.TextXAlignment.Left
    btnDesc.ZIndex = 13
    btnDesc.Parent = dupeButton

    local btnIcon = Instance.new("ImageLabel")
    btnIcon.Name = "Icon"
    btnIcon.Size = UDim2.new(0, 24, 0, 24)
    btnIcon.Position = UDim2.new(1, -34, 0, 13)
    btnIcon.BackgroundTransparency = 1
    btnIcon.Image = "rbxassetid://7733970599"
    btnIcon.ImageColor3 = CONFIG.Colors.Text
    btnIcon.ZIndex = 13
    btnIcon.Parent = dupeButton

    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.Size = UDim2.new(1, 30, 1, 30)
    glow.Position = UDim2.new(0, -15, 0, -15)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://10822615846"
    glow.ImageColor3 = CONFIG.Colors.Accent
    glow.ImageTransparency = 0.9
    glow.ScaleType = Enum.ScaleType.Slice
    glow.SliceCenter = Rect.new(10, 10, 118, 118)
    glow.ZIndex = 11
    glow.Parent = dupeButton

    -- Button Interactions
    dupeButton.MouseEnter:Connect(function()
        CreateTween(dupeButton, {BackgroundColor3 = CONFIG.Colors.AccentHover}, 0.2)
        CreateTween(glow, {ImageTransparency = 0.7}, 0.2)
        CreateTween(btnIcon, {Rotation = 15}, 0.3, Enum.EasingStyle.Back)
    end)
    dupeButton.MouseLeave:Connect(function()
        CreateTween(dupeButton, {BackgroundColor3 = CONFIG.Colors.Accent}, 0.2)
        CreateTween(glow, {ImageTransparency = 0.9}, 0.2)
        CreateTween(btnIcon, {Rotation = 0}, 0.3, Enum.EasingStyle.Back)
    end)
    dupeButton.MouseButton1Down:Connect(function()
        CreateTween(dupeButton, {Size = UDim2.new(0.98, 0, 0, 48), Position = UDim2.new(0.01, 0, 0, 11)}, 0.1)
    end)
    dupeButton.MouseButton1Up:Connect(function()
        CreateTween(dupeButton, {Size = UDim2.new(1, 0, 0, 50), Position = UDim2.new(0, 0, 0, 10)}, 0.1)
    end)

    -- Main Functionality
    dupeButton.MouseButton1Click:Connect(function()
        local Character = LocalPlayer.Character
        if not Character then
            Notify({Title = "Error", Content = "Character not found!", Duration = 2})
            return
        end

        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if not Humanoid then
            Notify({Title = "Error", Content = "Humanoid not found!", Duration = 2})
            return
        end

        local Tool = Character:FindFirstChildOfClass("Tool")
        if not Tool then
            Notify({Title = "Error", Content = "No tool equipped!", Duration = 2})
            return
        end

        local success, err = pcall(function()
            local Clone = Tool:Clone()
            Clone.Parent = LocalPlayer.Backpack
            Humanoid:EquipTool(Clone)
        end)

        if success then
            Notify({
                Title = "Mzwn Scripts - Dupe",
                Content = Tool.Name .. " duplicated and equipped!",
                Duration = 2
            })
        else
            Notify({
                Title = "Error",
                Content = "Failed to duplicate: " .. tostring(err),
                Duration = 3
            })
        end
    end)

    -- Make Draggable
    MakeDraggable(mainFrame, header)

    -- Entrance Animation
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    CreateTween(mainFrame, {Size = UDim2.new(0, 350, 0, 200), Position = UDim2.new(0.5, -175, 0.5, -100)}, 0.5, Enum.EasingStyle.Back)

    return screenGui
end

-- Initialize
InitNotifications()
CreateMainGUI()
print("Mzwn Scripts - Dupe GUI Loaded! (V1 Fixed)")
