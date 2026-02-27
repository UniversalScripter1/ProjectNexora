-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera

-- =============================================
-- ANIMATION IDs
-- =============================================
local ANIM_IDLE     = "rbxassetid://73017334485905"
local ANIM_FORWARD  = "rbxassetid://71046537304573"
local ANIM_BACKWARD = "rbxassetid://133594786690861"
-- =============================================

-- Boost stages: {speed, fov}
local BOOST_STAGES = {
    {speed = 100,  fov = 70},
    {speed = 160,  fov = 80},
    {speed = 240,  fov = 90},
    {speed = 340,  fov = 100},
    {speed = 460,  fov = 110},
    {speed = 600,  fov = 120},
}
local BASE_FOV = 70
local currentStage = 1

local flying = false
local flyBV, flyBG, flyConnection
local hoverAmplitude = 2
local hoverSpeed = 2
local hoverTime = 0

local currentTrack = nil
local currentAnimState = nil

-- =============================================
-- Animation Logic
-- =============================================
local function resolveAnimId(id)
    local ok, result = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(id))
    end)
    if ok and result and #result > 0 then
        local obj = result[1]
        if obj:IsA("Animation") then
            return obj.AnimationId
        end
    end
    return "rbxassetid://" .. tostring(id)
end

local function loadAndPlay(animId, shouldLoop)
    if currentTrack then
        currentTrack:Stop(0)
        currentTrack = nil
    end
    local rawId = tostring(animId):match("%d+") or animId
    local resolvedId = resolveAnimId(rawId)
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then return end
    local anim = Instance.new("Animation")
    anim.AnimationId = resolvedId
    local ok, track = pcall(function()
        return animator:LoadAnimation(anim)
    end)
    if not ok or not track then return end
    track.Priority = Enum.AnimationPriority.Movement
    track.Looped = shouldLoop
    track:Play(0.1, 1, 1)
    currentTrack = track
end

local function stopAnim()
    if currentTrack then
        currentTrack:Stop(0)
        currentTrack = nil
    end
    currentAnimState = nil
end

local function updateFlyAnim(state)
    if currentAnimState == state then return end
    currentAnimState = state
    if state == "idle" then
        loadAndPlay(ANIM_IDLE, true)
    elseif state == "forward" then
        loadAndPlay(ANIM_FORWARD, true)
    elseif state == "backward" then
        loadAndPlay(ANIM_BACKWARD, true)
    end
end

-- =============================================
-- Suppress / Restore default anims
-- =============================================
local function suppressDefaultAnims()
    local animScript = char:FindFirstChild("Animate")
    if animScript then animScript.Disabled = true end
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if animator then
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            if track ~= currentTrack then track:Stop(0) end
        end
    end
end

local function restoreDefaultAnims()
    local animScript = char:FindFirstChild("Animate")
    if animScript then animScript.Disabled = false end
end

-- =============================================
-- FOV Tween
-- =============================================
local function tweenFOV(targetFov)
    TweenService:Create(camera, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
        FieldOfView = targetFov
    }):Play()
end

-- =============================================
-- GUI
-- =============================================
local screen = Instance.new("ScreenGui")
screen.Name = "FlyGUI"
screen.ResetOnSpawn = false
screen.Parent = player:WaitForChild("PlayerGui")

--[[
    Layout (all Y positions inside main frame, height = 255):
    Title bar       : Y=0,   H=36
    Stage label     : Y=36,  H=18
    Pip bar         : Y=58,  H=12
    Divider         : Y=76,  H=1
    Fly button      : Y=84,  H=42  → bottom at 126
    Boost button    : Y=133, H=42  → bottom at 175
    Reset button    : Y=182, H=42  → bottom at 224
    Bottom padding  : 255 - 224 = 31
    Frame height    : 255
]]

local FRAME_W = 185
local FRAME_H = 255

local main = Instance.new("Frame")
main.Parent = screen
main.Position = UDim2.new(0, 30, 0.5, -FRAME_H / 2)
main.Size = UDim2.new(0, FRAME_W, 0, FRAME_H)
main.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.ZIndex = 2
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

local outerGlow = Instance.new("UIStroke", main)
outerGlow.Color = Color3.fromRGB(0, 180, 255)
outerGlow.Thickness = 1.5
outerGlow.Transparency = 0.2

local grad = Instance.new("UIGradient", main)
grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(12, 12, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 15)),
})
grad.Rotation = 135

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 36)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "FLY SYSTEM"
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.ZIndex = 3

-- Stage label
local stageLabel = Instance.new("TextLabel", main)
stageLabel.Size = UDim2.new(1, -20, 0, 18)
stageLabel.Position = UDim2.new(0, 10, 0, 36)
stageLabel.BackgroundTransparency = 1
stageLabel.Text = "STAGE  0 / 5  |  100 u/s"
stageLabel.Font = Enum.Font.Gotham
stageLabel.TextSize = 11
stageLabel.TextColor3 = Color3.fromRGB(120, 200, 255)
stageLabel.ZIndex = 3

-- Pip bar
local pipBar = Instance.new("Frame", main)
pipBar.Size = UDim2.new(1, -20, 0, 12)
pipBar.Position = UDim2.new(0, 10, 0, 58)
pipBar.BackgroundTransparency = 1
pipBar.ZIndex = 3

local pips = {}
local PIP_W = 24
local PIP_GAP = 30
for i = 1, 5 do
    local pip = Instance.new("Frame", pipBar)
    pip.Size = UDim2.new(0, PIP_W, 1, 0)
    pip.Position = UDim2.new(0, (i - 1) * PIP_GAP, 0, 0)
    pip.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    pip.BorderSizePixel = 0
    pip.ZIndex = 3
    Instance.new("UICorner", pip).CornerRadius = UDim.new(1, 0)
    pips[i] = pip
end

local function updatePips()
    local activePips = currentStage - 1
    for i = 1, 5 do
        TweenService:Create(pips[i], TweenInfo.new(0.2), {
            BackgroundColor3 = i <= activePips
                and Color3.fromRGB(0, 200, 255)
                or  Color3.fromRGB(30, 30, 60)
        }):Play()
    end
    local s = BOOST_STAGES[currentStage]
    stageLabel.Text = "STAGE  " .. (currentStage - 1) .. " / 5  |  " .. s.speed .. " u/s"
end

updatePips()

-- Divider
local div = Instance.new("Frame", main)
div.Size = UDim2.new(1, -20, 0, 1)
div.Position = UDim2.new(0, 10, 0, 76)
div.BackgroundColor3 = Color3.fromRGB(0, 100, 160)
div.BorderSizePixel = 0
div.ZIndex = 3

-- Button factory
local function makeButton(posY, text, color)
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(1, -20, 0, 42)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 0
    btn.ZIndex = 3
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.85
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = color:Lerp(Color3.fromRGB(255, 255, 255), 0.18)
        }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = color
        }):Play()
    end)
    return btn
end

local FLY_COLOR   = Color3.fromRGB(0, 120, 220)
local STOP_COLOR  = Color3.fromRGB(180, 0, 50)
local BOOST_COLOR = Color3.fromRGB(180, 80, 0)
local RESET_COLOR = Color3.fromRGB(35, 35, 70)

local flyBtn   = makeButton(84,  "FLY",          FLY_COLOR)
local boostBtn = makeButton(133, "BOOST  [0/5]", BOOST_COLOR)
local resetBtn = makeButton(182, "RESET BOOST",  RESET_COLOR)
resetBtn.TextSize = 12

-- =============================================
-- Fly Logic
-- =============================================
local function startFly()
    if flying then return end
    flying = true
    humanoid.PlatformStand = true
    suppressDefaultAnims()
    tweenFOV(BOOST_STAGES[currentStage].fov)

    flyBV = Instance.new("BodyVelocity")
    flyBV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    flyBV.Velocity = Vector3.new(0, 0, 0)
    flyBV.Parent = root

    flyBG = Instance.new("BodyGyro")
    flyBG.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    flyBG.P = 3000
    flyBG.CFrame = root.CFrame
    flyBG.Parent = root

    hoverTime = 0

    flyConnection = RunService.RenderStepped:Connect(function(dt)
        if not root or not root.Parent then return end
        local flySpeed = BOOST_STAGES[currentStage].speed
        local moveDir = humanoid.MoveDirection
        local camForward = workspace.CurrentCamera.CFrame.LookVector
        local camBackward = -camForward
        local forwardMag = camForward:Dot(moveDir)
        local backwardMag = camBackward:Dot(moveDir)

        if forwardMag > 0.1 then
            flyBV.Velocity = camForward.Unit * flySpeed * forwardMag
            flyBG.CFrame = CFrame.new(root.Position, root.Position + camForward)
            updateFlyAnim("forward")
        elseif backwardMag > 0.1 then
            flyBV.Velocity = camBackward.Unit * flySpeed * backwardMag
            flyBG.CFrame = CFrame.new(root.Position, root.Position + camForward)
            updateFlyAnim("backward")
        else
            hoverTime = hoverTime + dt * hoverSpeed
            flyBV.Velocity = Vector3.new(0, math.sin(hoverTime) * hoverAmplitude, 0)
            flyBG.CFrame = CFrame.new(root.Position, root.Position + camForward)
            updateFlyAnim("idle")
        end
    end)
end

local function stopFly()
    flying = false
    humanoid.PlatformStand = false
    if flyConnection then flyConnection:Disconnect() flyConnection = nil end
    if flyBV then flyBV:Destroy() flyBV = nil end
    if flyBG then flyBG:Destroy() flyBG = nil end
    stopAnim()
    restoreDefaultAnims()
    tweenFOV(BASE_FOV)
    -- Reset stage
    currentStage = 1
    updatePips()
    boostBtn.Text = "BOOST  [0/5]"
    flyBtn.Text = "FLY"
    TweenService:Create(flyBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = FLY_COLOR
    }):Play()
end

-- =============================================
-- Death handler
-- =============================================
local function onDied()
    if flying then
        stopFly()
    else
        stopAnim()
    end
end

local function connectDeath()
    humanoid.Died:Connect(onDied)
end
connectDeath()

player.CharacterAdded:Connect(function(newChar)
    char = newChar
    humanoid = char:WaitForChild("Humanoid")
    root = char:WaitForChild("HumanoidRootPart")
    currentTrack = nil
    currentAnimState = nil
    connectDeath()
    -- Reset GUI state on respawn
    currentStage = 1
    updatePips()
    boostBtn.Text = "BOOST  [0/5]"
    flyBtn.Text = "FLY"
    TweenService:Create(flyBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = FLY_COLOR
    }):Play()
end)

-- =============================================
-- Button Logic
-- =============================================
flyBtn.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
    else
        startFly()
        flyBtn.Text = "STOP FLYING"
        TweenService:Create(flyBtn, TweenInfo.new(0.15), {
            BackgroundColor3 = STOP_COLOR
        }):Play()
    end
end)

boostBtn.MouseButton1Click:Connect(function()
    if currentStage < #BOOST_STAGES then
        currentStage = currentStage + 1
        updatePips()
        boostBtn.Text = "BOOST  [" .. (currentStage - 1) .. "/5]"
        if flying then tweenFOV(BOOST_STAGES[currentStage].fov) end
        TweenService:Create(outerGlow, TweenInfo.new(0.1), {
            Color = Color3.fromRGB(255, 140, 0)
        }):Play()
        task.delay(0.3, function()
            TweenService:Create(outerGlow, TweenInfo.new(0.3), {
                Color = Color3.fromRGB(0, 180, 255)
            }):Play()
        end)
    end
end)

resetBtn.MouseButton1Click:Connect(function()
    currentStage = 1
    updatePips()
    boostBtn.Text = "BOOST  [0/5]"
    if flying then tweenFOV(BOOST_STAGES[1].fov) end
end)
