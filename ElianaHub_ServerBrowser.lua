--[[
    ███████╗██╗     ██╗ █████╗ ███╗   ██╗ █████╗     ██╗  ██╗██╗   ██╗██████╗
    ██╔════╝██║     ██║██╔══██╗████╗  ██║██╔══██╗    ██║  ██║██║   ██║██╔══██╗
    █████╗  ██║     ██║███████║██╔██╗ ██║███████║    ███████║██║   ██║██████╔╝
    ██╔══╝  ██║     ██║██╔══██║██║╚██╗██║██╔══██║    ██╔══██║██║   ██║██╔══██╗
    ███████╗███████╗██║██║  ██║██║ ╚████║██║  ██║    ██║  ██║╚██████╔╝██████╔╝
    ╚══════╝╚══════╝╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝
    
    Server Browser | Eliana Hub
    Advanced GUI — Full Remake
]]

-- ============================================================
-- GUARD: Prevent double-loading
-- ============================================================
if _G.ELIANA_HUB_LOADED and not _G.ELIANA_HUB_CAN_RELOAD then return end
_G.ELIANA_HUB_LOADED = true
_G.ELIANA_HUB_CAN_RELOAD = false

if not game:IsLoaded() then game.Loaded:Wait() end

-- ============================================================
-- SERVICES
-- ============================================================
local HttpService       = game:GetService("HttpService")
local TeleportService   = game:GetService("TeleportService")
local Players           = game:GetService("Players")
local UserInputService  = game:GetService("UserInputService")
local LocalizationService = game:GetService("LocalizationService")
local TweenService      = game:GetService("TweenService")
local RunService        = game:GetService("RunService")
local CoreGui           = game:GetService("CoreGui")
local Lighting          = game:GetService("Lighting")
local SoundService      = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera or workspace:FindFirstChildOfClass("Camera")
if not camera then repeat task.wait() camera = workspace.CurrentCamera until camera end

local SCREEN_SIZE = camera.ViewportSize
local platform = UserInputService:GetPlatform()
local IsOnMobile = (platform == Enum.Platform.IOS or platform == Enum.Platform.Android)
    or (platform == Enum.Platform.None and UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled)

-- ============================================================
-- RESPONSIVE LAYOUT SYSTEM
-- ============================================================
-- Breakpoints (based on viewport width):
--   LARGE  : >= 700px  → full desktop layout
--   MEDIUM : 480–699px → compact layout (tablet / small window)
--   SMALL  : < 480px   → mobile / tiny screen (stacked toolbar, small cards)

local SW = SCREEN_SIZE.X  -- screen width
local SH = SCREEN_SIZE.Y  -- screen height

local LAYOUT = {}
if SW >= 700 and not IsOnMobile then
    -- Desktop
    LAYOUT.frameW       = 680
    LAYOUT.frameH       = 520
    LAYOUT.topBarH      = 54
    LAYOUT.titleSize    = 20
    LAYOUT.subSize      = 13
    LAYOUT.toolbarH     = 40
    LAYOUT.toolbarRows  = 1        -- single row
    LAYOUT.statusH      = 30
    LAYOUT.cardH        = 110
    LAYOUT.cardFontSz   = 14
    LAYOUT.cardSubSz    = 12
    LAYOUT.cardIdSz     = 10
    LAYOUT.btnW         = 80
    LAYOUT.linkW        = 144
    LAYOUT.btnAreaW     = 230
    LAYOUT.scrollOff    = 148      -- scrollFrame top offset
    LAYOUT.barBgW       = 180
    LAYOUT.iconBtnSz    = 28
    LAYOUT.notifW       = 320
    LAYOUT.notifH       = 80
    LAYOUT.notifFont    = 14
    LAYOUT.notifMsgFont = 12
    LAYOUT.filterLblSz  = 12
    LAYOUT.filterBtnSz  = 24
    LAYOUT.sortLblSz    = 12
    LAYOUT.sortBtnW     = {100, 100, 80}
elseif SW >= 480 then
    -- Tablet / medium
    LAYOUT.frameW       = math.min(SW - 20, 520)
    LAYOUT.frameH       = math.min(SH - 30, 440)
    LAYOUT.topBarH      = 48
    LAYOUT.titleSize    = 17
    LAYOUT.subSize      = 11
    LAYOUT.toolbarH     = 76         -- two rows
    LAYOUT.toolbarRows  = 2
    LAYOUT.statusH      = 26
    LAYOUT.cardH        = 130        -- taller cards (buttons stack)
    LAYOUT.cardFontSz   = 13
    LAYOUT.cardSubSz    = 11
    LAYOUT.cardIdSz     = 9
    LAYOUT.btnW         = 70
    LAYOUT.linkW        = 120
    LAYOUT.btnAreaW     = 196
    LAYOUT.scrollOff    = 162
    LAYOUT.barBgW       = 150
    LAYOUT.iconBtnSz    = 24
    LAYOUT.notifW       = 260
    LAYOUT.notifH       = 74
    LAYOUT.notifFont    = 13
    LAYOUT.notifMsgFont = 11
    LAYOUT.filterLblSz  = 11
    LAYOUT.filterBtnSz  = 22
    LAYOUT.sortLblSz    = 11
    LAYOUT.sortBtnW     = {88, 88, 68}
else
    -- Mobile / small
    LAYOUT.frameW       = math.min(SW - 10, 380)
    LAYOUT.frameH       = math.min(SH - 20, 560)
    LAYOUT.topBarH      = 44
    LAYOUT.titleSize    = 14
    LAYOUT.subSize      = 10
    LAYOUT.toolbarH     = 80         -- two rows
    LAYOUT.toolbarRows  = 2
    LAYOUT.statusH      = 22
    LAYOUT.cardH        = 150        -- cards are taller, buttons stack vertically
    LAYOUT.cardFontSz   = 12
    LAYOUT.cardSubSz    = 10
    LAYOUT.cardIdSz     = 8
    LAYOUT.btnW         = math.min(LAYOUT.frameW - 40, 150)  -- full-ish width
    LAYOUT.linkW        = math.min(LAYOUT.frameW - 40, 150)
    LAYOUT.btnAreaW     = math.min(LAYOUT.frameW - 40, 155)
    LAYOUT.scrollOff    = 164
    LAYOUT.barBgW       = math.min(LAYOUT.frameW - 80, 140)
    LAYOUT.iconBtnSz    = 22
    LAYOUT.notifW       = math.min(SW - 20, 240)
    LAYOUT.notifH       = 68
    LAYOUT.notifFont    = 12
    LAYOUT.notifMsgFont = 10
    LAYOUT.filterLblSz  = 10
    LAYOUT.filterBtnSz  = 20
    LAYOUT.sortLblSz    = 10
    LAYOUT.sortBtnW     = {76, 76, 58}
end

-- Convenience: are we in compact mode?
local IS_COMPACT = LAYOUT.toolbarRows == 2

-- ============================================================
-- HTTP REQUEST FUNCTION
-- ============================================================
local httprequest = (syn and syn.request) or (http and http.request) or http_request
    or (fluxus and fluxus.request) or request

local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport
    or (fluxus and fluxus.queue_on_teleport)

-- ============================================================
-- THEME
-- ============================================================
local THEME = {
    BG          = Color3.fromRGB(12, 12, 18),
    PANEL       = Color3.fromRGB(18, 18, 28),
    CARD        = Color3.fromRGB(22, 22, 35),
    CARD_HOVER  = Color3.fromRGB(30, 30, 48),
    ACCENT      = Color3.fromRGB(120, 80, 220),
    ACCENT2     = Color3.fromRGB(80, 160, 255),
    SUCCESS     = Color3.fromRGB(80, 210, 130),
    WARNING     = Color3.fromRGB(255, 190, 60),
    ERROR       = Color3.fromRGB(255, 80, 80),
    TEXT        = Color3.fromRGB(235, 235, 245),
    SUBTEXT     = Color3.fromRGB(160, 160, 185),
    BORDER      = Color3.fromRGB(45, 45, 65),
    TOPBAR      = Color3.fromRGB(15, 15, 25),
    BTN         = Color3.fromRGB(30, 30, 50),
    BTN_HOVER   = Color3.fromRGB(50, 50, 80),
    JOIN_BTN    = Color3.fromRGB(80, 210, 130),
    COPY_BTN    = Color3.fromRGB(80, 160, 255),
    LINK_BTN    = Color3.fromRGB(160, 100, 255),
}

-- ============================================================
-- HELPERS
-- ============================================================
local function corner(parent, radius)
    local c = Instance.new("UICorner", parent)
    c.CornerRadius = UDim.new(0, radius or 8)
    return c
end

local function stroke(parent, color, thickness)
    local s = Instance.new("UIStroke", parent)
    s.Color = color or THEME.BORDER
    s.Thickness = thickness or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return s
end

local function gradient(parent, c0, c1, rotation)
    local g = Instance.new("UIGradient", parent)
    g.Color = ColorSequence.new(c0, c1)
    g.Rotation = rotation or 90
    return g
end

local function tween(obj, props, t, style, dir)
    return TweenService:Create(obj,
        TweenInfo.new(t or 0.2, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out),
        props):Play()
end

local function makeLabel(parent, text, size, color, font, xAlign)
    local l = Instance.new("TextLabel", parent)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextSize = size or 14
    l.TextColor3 = color or THEME.TEXT
    l.Font = font or Enum.Font.GothamMedium
    l.TextXAlignment = xAlign or Enum.TextXAlignment.Left
    l.TextWrapped = true
    return l
end

local function makeButton(parent, text, size, color, font)
    local b = Instance.new("TextButton", parent)
    b.BackgroundColor3 = color or THEME.BTN
    b.Text = text
    b.TextSize = size or 13
    b.TextColor3 = THEME.TEXT
    b.Font = font or Enum.Font.GothamBold
    b.AutoButtonColor = false
    b.BorderSizePixel = 0
    -- Hover effect
    b.MouseEnter:Connect(function()
        tween(b, {BackgroundColor3 = THEME.BTN_HOVER}, 0.15)
    end)
    b.MouseLeave:Connect(function()
        tween(b, {BackgroundColor3 = color or THEME.BTN}, 0.15)
    end)
    return b
end

local function playClick(parent)
    local s = Instance.new("Sound", parent or SoundService)
    s.SoundId = "rbxassetid://9120093264"
    s.Volume = 0.7
    s:Play()
    game:GetService("Debris"):AddItem(s, 2)
end

-- ============================================================
-- LOADING SCREEN
-- ============================================================
do
    local loadGui = Instance.new("ScreenGui", CoreGui)
    loadGui.IgnoreGuiInset = true
    loadGui.ResetOnSpawn = false
    loadGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local bg = Instance.new("Frame", loadGui)
    bg.Size = UDim2.fromScale(1, 1)
    bg.BackgroundColor3 = THEME.BG
    bg.BorderSizePixel = 0

    gradient(bg,
        Color3.fromRGB(10, 10, 20),
        Color3.fromRGB(20, 10, 35), 135)

    local blur = Instance.new("BlurEffect", Lighting)
    blur.Size = 20

    local titleLbl = makeLabel(bg, "Server Browser", 36, THEME.TEXT, Enum.Font.GothamBlack, Enum.TextXAlignment.Center)
    titleLbl.Size = UDim2.new(1, 0, 0, 44)
    titleLbl.Position = UDim2.new(0, 0, 0.38, 0)

    local subLbl = makeLabel(bg, "Eliana Hub", 20, THEME.ACCENT, Enum.Font.GothamMedium, Enum.TextXAlignment.Center)
    subLbl.Size = UDim2.new(1, 0, 0, 28)
    subLbl.Position = UDim2.new(0, 0, 0.38, 48)

    -- animated accent line
    local lineBack = Instance.new("Frame", bg)
    lineBack.Size = UDim2.new(0, 300, 0, 4)
    lineBack.AnchorPoint = Vector2.new(0.5, 0.5)
    lineBack.Position = UDim2.new(0.5, 0, 0.62, 0)
    lineBack.BackgroundColor3 = THEME.BORDER
    lineBack.BorderSizePixel = 0
    corner(lineBack, 2)

    local line = Instance.new("Frame", lineBack)
    line.Size = UDim2.new(0, 0, 1, 0)
    line.BackgroundColor3 = THEME.ACCENT
    line.BorderSizePixel = 0
    corner(line, 2)
    gradient(line, THEME.ACCENT, THEME.ACCENT2, 0)

    local pctLbl = makeLabel(bg, "0%", 16, THEME.SUBTEXT, Enum.Font.GothamMedium, Enum.TextXAlignment.Center)
    pctLbl.Size = UDim2.new(1, 0, 0, 22)
    pctLbl.Position = UDim2.new(0, 0, 0.62, 12)

    local statusLbl = makeLabel(bg, "Initializing...", 13, THEME.SUBTEXT, Enum.Font.Gotham, Enum.TextXAlignment.Center)
    statusLbl.Size = UDim2.new(1, 0, 0, 20)
    statusLbl.Position = UDim2.new(0, 0, 0.62, 36)

    -- animate
    local tw = TweenService:Create(line, TweenInfo.new(2.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(1, 0, 1, 0)})
    tw:Play()

    local msgs = {"Initializing...", "Loading servers...", "Preparing UI...", "Almost ready..."}
    task.spawn(function()
        for i = 0, 100 do
            pctLbl.Text = i .. "%"
            if i < 25 then statusLbl.Text = msgs[1]
            elseif i < 55 then statusLbl.Text = msgs[2]
            elseif i < 85 then statusLbl.Text = msgs[3]
            else statusLbl.Text = msgs[4] end
            task.wait(2.2 / 100)
        end
    end)

    task.wait(2.3)
    blur:Destroy()
    loadGui:Destroy()
end

-- ============================================================
-- NOTIFICATION SYSTEM (consolidated, single instance)
-- ============================================================
local NotifLib = {}
do
    local container = Instance.new("ScreenGui", CoreGui)
    container.Name = "ElianaHubNotifs"
    container.ResetOnSpawn = false
    container.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local queue = {}

    function NotifLib:Notify(opt)
        opt = opt or {}
        local title   = opt.Title or "Eliana Hub"
        local msg     = opt.Message or ""
        local dur     = opt.Duration or 4
        local accentC = opt.Accent or THEME.ACCENT

        local idx = #queue + 1
        local frame = Instance.new("Frame", container)
        frame.Size = UDim2.new(0, LAYOUT.notifW, 0, LAYOUT.notifH)
        frame.AnchorPoint = Vector2.new(1, 1)
        frame.Position = UDim2.new(1, -16, 1, -16 - (idx-1)*96)
        frame.BackgroundColor3 = THEME.PANEL
        frame.BorderSizePixel = 0
        frame.ClipsDescendants = true
        corner(frame, 10)
        stroke(frame, THEME.BORDER)

        local accentBar = Instance.new("Frame", frame)
        accentBar.Size = UDim2.new(0, 4, 1, 0)
        accentBar.BackgroundColor3 = accentC
        accentBar.BorderSizePixel = 0
        corner(accentBar, 2)

        local tLbl = makeLabel(frame, title, LAYOUT.notifFont, THEME.TEXT, Enum.Font.GothamBold)
        tLbl.Size = UDim2.new(1, -20, 0, 22)
        tLbl.Position = UDim2.new(0, 14, 0, 10)

        local mLbl = makeLabel(frame, msg, LAYOUT.notifMsgFont, THEME.SUBTEXT, Enum.Font.Gotham)
        mLbl.Size = UDim2.new(1, -20, 0, LAYOUT.notifH - 46)
        mLbl.Position = UDim2.new(0, 14, 0, 32)

        table.insert(queue, frame)

        local rowH = LAYOUT.notifH + 8
        -- slide in
        frame.Position = UDim2.new(1, LAYOUT.notifW + 20, 1, -16 - (idx-1)*rowH)
        tween(frame, {Position = UDim2.new(1, -16, 1, -16 - (idx-1)*rowH)}, 0.3, Enum.EasingStyle.Back)

        task.delay(dur, function()
            if frame and frame.Parent then
                tween(frame, {Position = frame.Position + UDim2.new(0, LAYOUT.notifW + 20, 0, 0), BackgroundTransparency = 1}, 0.25)
                task.wait(0.3)
                frame:Destroy()
                for i, v in ipairs(queue) do
                    if v == frame then table.remove(queue, i) break end
                end
            end
        end)
    end
end

-- ============================================================
-- HOLIDAY DETECTION + COLORS
-- ============================================================
local isXmas, isHalloween, isNewYear, isEaster, isValentine = false,false,false,false,false
pcall(function()
    local d = os.date("*t")
    isXmas      = d.month == 12 and d.day >= 15 and d.day <= 29
    isHalloween = (d.month == 10 and d.day >= 23) or (d.month == 11 and d.day <= 1)
    isNewYear   = (d.month == 12 and d.day >= 30) or (d.month == 1 and d.day <= 2)
    isEaster    = (d.month == 3 and d.day >= 31) or (d.month == 4 and d.day <= 15)
    isValentine = d.month == 2 and d.day == 14
end)

-- ============================================================
-- MAIN SCREEN GUI
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ElianaHubServerBrowser"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true

pcall(function()
    if gethui then
        screenGui.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(screenGui)
        screenGui.Parent = CoreGui
    else
        screenGui.Parent = CoreGui
    end
end)
if not screenGui.Parent then
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- ============================================================
-- MAIN FRAME
-- ============================================================
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Size = UDim2.new(0, LAYOUT.frameW, 0, LAYOUT.frameH)
mainFrame.BackgroundColor3 = THEME.BG
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
corner(mainFrame, 14)
stroke(mainFrame, THEME.BORDER, 1)

-- Background subtle gradient
gradient(mainFrame,
    Color3.fromRGB(12, 12, 20),
    Color3.fromRGB(16, 12, 28), 135)

-- Watermark BG logo (subtle)
local bgLogo = Instance.new("ImageLabel", mainFrame)
bgLogo.Size = UDim2.new(0.6, 0, 0.6, 0)
bgLogo.AnchorPoint = Vector2.new(0.5, 0.5)
bgLogo.Position = UDim2.new(0.5, 0, 0.5, 0)
bgLogo.BackgroundTransparency = 1
bgLogo.ImageTransparency = 0.94
bgLogo.ScaleType = Enum.ScaleType.Fit
bgLogo.ZIndex = 1
task.defer(function()
    pcall(function() bgLogo.Image = "http://www.roblox.com/asset/?id=75503909317175" end)
end)

-- Screenshot hide
pcall(function()
    local cs = game:GetService("CaptureService")
    cs.CaptureBegan:Connect(function() screenGui.Enabled = false end)
    cs.CaptureEnded:Connect(function() task.delay(0.5, function() screenGui.Enabled = true end) end)
end)

-- ============================================================
-- DRAG LOGIC
-- ============================================================
do
    local dragging, dragStart, startPos, dragInput
    mainFrame.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = inp.Position
            startPos = mainFrame.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    mainFrame.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            dragInput = inp
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and inp == dragInput then
            local delta = inp.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- ============================================================
-- TOP BAR
-- ============================================================
local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, LAYOUT.topBarH)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = THEME.TOPBAR
topBar.BorderSizePixel = 0
topBar.ZIndex = 5

-- Top bar bottom border accent line
local accentLine = Instance.new("Frame", topBar)
accentLine.Size = UDim2.new(1, 0, 0, 2)
accentLine.Position = UDim2.new(0, 0, 1, -2)
accentLine.BackgroundColor3 = THEME.ACCENT
accentLine.BorderSizePixel = 0
gradient(accentLine, THEME.ACCENT, THEME.ACCENT2, 0)

-- Title
local hubTitle = makeLabel(topBar, "Server Browser", LAYOUT.titleSize, THEME.TEXT, Enum.Font.GothamBlack, Enum.TextXAlignment.Left)
hubTitle.Size = UDim2.new(0, 220, 0, 28)
hubTitle.Position = UDim2.new(0, 16, 0, IS_COMPACT and 6 or 8)
hubTitle.ZIndex = 6

local hubSub = makeLabel(topBar, "Eliana Hub", LAYOUT.subSize, THEME.ACCENT, Enum.Font.GothamMedium, Enum.TextXAlignment.Left)
hubSub.Size = UDim2.new(0, 200, 0, 16)
hubSub.Position = UDim2.new(0, 16, 0, IS_COMPACT and 26 or 32)
hubSub.ZIndex = 6

-- Version badge
local verBadge = Instance.new("Frame", topBar)
verBadge.Size = UDim2.new(0, 36, 0, 20)
verBadge.Position = UDim2.new(0, 200, 0, 10)
verBadge.BackgroundColor3 = THEME.ACCENT
verBadge.BorderSizePixel = 0
corner(verBadge, 4)
local verLbl = makeLabel(verBadge, "v1.0", 11, Color3.new(1,1,1), Enum.Font.GothamBold, Enum.TextXAlignment.Center)
verLbl.Size = UDim2.fromScale(1,1)

-- Holiday decoration cycle
local function startColorCycle(colors, labels)
    task.spawn(function()
        local i = 1
        while screenGui.Parent do
            local c = colors[i]
            for _, lbl in ipairs(labels) do lbl.TextColor3 = c end
            i = i % #colors + 1
            task.wait(0.5)
        end
    end)
end

if isXmas then
    hubTitle.Text = "🎄 Server Browser 🎄"
    startColorCycle({Color3.fromRGB(0,220,0), Color3.fromRGB(220,0,0), Color3.fromRGB(255,255,255)}, {hubTitle, hubSub})
elseif isHalloween then
    hubTitle.Text = "🎃 Server Browser 🎃"
    startColorCycle({Color3.fromRGB(0,0,0), Color3.fromRGB(255,140,0)}, {hubTitle, hubSub})
elseif isNewYear then
    hubTitle.Text = "🎉 Server Browser 🎉"
    startColorCycle({Color3.fromRGB(255,215,0), Color3.fromRGB(255,255,255)}, {hubTitle, hubSub})
elseif isEaster then
    hubTitle.Text = "🐰 Server Browser 🐰"
    startColorCycle({Color3.fromRGB(216,191,216), Color3.fromRGB(255,182,193), Color3.fromRGB(173,216,230)}, {hubTitle, hubSub})
elseif isValentine then
    hubTitle.Text = "💖 Server Browser 💖"
    startColorCycle({Color3.fromRGB(255,85,127), Color3.fromRGB(200,0,80)}, {hubTitle, hubSub})
end

-- ============================================================
-- TOP BAR BUTTONS (right side)
-- ============================================================
local function makeIconBtn(parent, icon, size, posX, posY, zidx, tooltip)
    local btn = Instance.new("ImageButton", parent)
    btn.Size = UDim2.new(0, size, 0, size)
    btn.AnchorPoint = Vector2.new(1, 0.5)
    btn.Position = UDim2.new(1, posX, 0.5, posY)
    btn.Image = icon
    btn.BackgroundColor3 = THEME.BTN
    btn.BorderSizePixel = 0
    btn.ZIndex = zidx or 6
    corner(btn, 6)
    stroke(btn, THEME.BORDER)

    local snd = Instance.new("Sound", btn)
    snd.SoundId = "rbxassetid://9120093264"
    snd.Volume = 0.6

    btn.MouseEnter:Connect(function() tween(btn, {BackgroundColor3 = THEME.BTN_HOVER}, 0.15) end)
    btn.MouseLeave:Connect(function() tween(btn, {BackgroundColor3 = THEME.BTN}, 0.15) end)
    btn.MouseButton1Click:Connect(function() pcall(function() snd:Play() end) end)

    return btn
end

local IBS = LAYOUT.iconBtnSz
local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0, IBS, 0, IBS)
closeBtn.AnchorPoint = Vector2.new(1, 0.5)
closeBtn.Position = UDim2.new(1, -8, 0.5, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextSize = IS_COMPACT and 11 or 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.ZIndex = 8
corner(closeBtn, 6)

local gap = IBS + 6
local refreshBtn = makeIconBtn(topBar, "http://www.roblox.com/asset/?id=126446661859683", IBS, -(8 + IBS + gap*0), 0, 7)
local rejoinBtn  = makeIconBtn(topBar, "rbxassetid://103864549538113",                    IBS, -(8 + IBS + gap*1), 0, 7)
local resizeBtn  = makeIconBtn(topBar, "http://www.roblox.com/asset/?id=92176830367195",  IBS, -(8 + IBS + gap*2), 0, 7)

-- ============================================================
-- TOOLBAR (filters + player count selector) — RESPONSIVE
-- Uses two explicit sub-row frames so nothing relies on manual Y math.
-- ============================================================
local TOOLBAR_PAD   = 6   -- inner padding top/bottom per row
local ROW_H         = 30  -- each row's height
local toolbarH      = IS_COMPACT and (TOOLBAR_PAD*3 + ROW_H*2) or (TOOLBAR_PAD*2 + ROW_H)
local toolbarTopOff = LAYOUT.topBarH + 6

local toolbar = Instance.new("Frame", mainFrame)
toolbar.Size = UDim2.new(1, -24, 0, toolbarH)
toolbar.Position = UDim2.new(0, 12, 0, toolbarTopOff)
toolbar.BackgroundColor3 = THEME.PANEL
toolbar.BorderSizePixel = 0
toolbar.ZIndex = 5
toolbar.ClipsDescendants = true
corner(toolbar, 8)
stroke(toolbar, THEME.BORDER)

-- Row containers — using Scale+Offset so they sit flush inside the toolbar
local row1 = Instance.new("Frame", toolbar)
row1.BackgroundTransparency = 1
row1.Size = UDim2.new(1, -16, 0, ROW_H)
row1.Position = UDim2.new(0, 8, 0, TOOLBAR_PAD)

local row2Parent = IS_COMPACT and toolbar or row1  -- desktop: filter lives in row1; compact: own row
local row2 = Instance.new("Frame", toolbar)
row2.BackgroundTransparency = 1
row2.Size = UDim2.new(1, -16, 0, ROW_H)
row2.Position = UDim2.new(0, 8, 0, TOOLBAR_PAD*2 + ROW_H)
row2.Visible = IS_COMPACT  -- hidden on desktop (filter goes into row1 space instead)

-- Helper: small inline button inside a row frame, positioned by absolute X
local function makeRowBtn(parent, text, color, x, w, h)
    h = h or ROW_H
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, w, 0, h)
    btn.Position = UDim2.new(0, x, 0.5, 0)
    btn.AnchorPoint = Vector2.new(0, 0.5)
    btn.BackgroundColor3 = color or THEME.BTN
    btn.Text = text
    btn.TextColor3 = THEME.TEXT
    btn.TextSize = LAYOUT.sortLblSz
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    corner(btn, 6)
    btn.MouseEnter:Connect(function() tween(btn, {BackgroundColor3 = THEME.BTN_HOVER}, 0.12) end)
    btn.MouseLeave:Connect(function() tween(btn, {BackgroundColor3 = color or THEME.BTN}, 0.12) end)
    return btn
end

-- ── ROW 1: Sort: [↓Low] [↑Max] [⚡Fast]  (+ filter on desktop) ──────────
local SW1, SW2, SW3 = LAYOUT.sortBtnW[1], LAYOUT.sortBtnW[2], LAYOUT.sortBtnW[3]
local GAP = 6

local sortLabel = makeLabel(row1, "Sort:", LAYOUT.sortLblSz, THEME.SUBTEXT, Enum.Font.GothamMedium)
sortLabel.Size = UDim2.new(0, 34, 1, 0)
sortLabel.Position = UDim2.new(0, 0, 0, 0)

local SX = 36
local btnLowPlayers = makeRowBtn(row1, "↓ Low",  THEME.BTN, SX,                     SW1)
local btnMaxPlayers = makeRowBtn(row1, "↑ Max",  THEME.BTN, SX + SW1 + GAP,          SW2)
local btnFastest    = makeRowBtn(row1, "⚡ Fast", THEME.BTN, SX + SW1 + SW2 + GAP*2, SW3)

-- ── ROW 2 (compact) / inline after sort (desktop): Players= < OFF > Apply ──
local FBS = LAYOUT.filterBtnSz   -- < > button size
local filterRow = IS_COMPACT and row2 or row1
local FX_start  = IS_COMPACT and 0 or (SX + SW1 + SW2 + SW3 + GAP*3 + 10)

local filterLabel = makeLabel(filterRow, "Players=", LAYOUT.filterLblSz, THEME.SUBTEXT, Enum.Font.GothamMedium)
filterLabel.Size = UDim2.new(0, 60, 1, 0)
filterLabel.Position = UDim2.new(0, FX_start, 0, 0)

local FBX = FX_start + 62

local btnFilterDown = makeRowBtn(filterRow, "<", THEME.BTN, FBX, FBS, FBS)
local filterNumLbl = makeLabel(filterRow, "OFF", LAYOUT.filterLblSz + 1, THEME.TEXT, Enum.Font.GothamBold, Enum.TextXAlignment.Center)
filterNumLbl.Size = UDim2.new(0, 40, 0, FBS)
filterNumLbl.Position = UDim2.new(0, FBX + FBS + 4, 0.5, 0)
filterNumLbl.AnchorPoint = Vector2.new(0, 0.5)
filterNumLbl.BackgroundColor3 = THEME.CARD
filterNumLbl.BackgroundTransparency = 0
corner(filterNumLbl, 5)
stroke(filterNumLbl, THEME.BORDER)

local btnFilterUp    = makeRowBtn(filterRow, ">",     THEME.BTN,    FBX + FBS + 48,       FBS, FBS)
local btnFilterApply = makeRowBtn(filterRow, "Apply", THEME.ACCENT, FBX + FBS*2 + 56,     52)

-- ============================================================
-- STATUS BAR
-- ============================================================
local statusBarTop = toolbarTopOff + toolbarH + 4
local statusBar = Instance.new("Frame", mainFrame)
statusBar.Size = UDim2.new(1, -24, 0, LAYOUT.statusH)
statusBar.Position = UDim2.new(0, 12, 0, statusBarTop)
statusBar.BackgroundTransparency = 1
statusBar.ZIndex = 5

local statusDot = Instance.new("Frame", statusBar)
statusDot.Size = UDim2.new(0, 8, 0, 8)
statusDot.Position = UDim2.new(0, 0, 0.5, 0)
statusDot.AnchorPoint = Vector2.new(0, 0.5)
statusDot.BackgroundColor3 = THEME.SUBTEXT
statusDot.BorderSizePixel = 0
corner(statusDot, 4)

local statusLbl = makeLabel(statusBar, "Ready", 12, THEME.SUBTEXT, Enum.Font.Gotham, Enum.TextXAlignment.Left)
statusLbl.Size = UDim2.new(0.5, 0, 1, 0)
statusLbl.Position = UDim2.new(0, 14, 0, 0)

local serverCountLbl = makeLabel(statusBar, "", 12, THEME.SUBTEXT, Enum.Font.GothamMedium, Enum.TextXAlignment.Right)
serverCountLbl.Size = UDim2.new(0.5, 0, 1, 0)
serverCountLbl.Position = UDim2.new(0.5, 0, 0, 0)

local function setStatus(text, color)
    statusLbl.Text = text
    statusDot.BackgroundColor3 = color or THEME.SUBTEXT
end

-- ============================================================
-- SCROLL FRAME (server cards)
-- ============================================================
local scrollTop = statusBarTop + LAYOUT.statusH + 4
local scrollFrame = Instance.new("ScrollingFrame", mainFrame)
scrollFrame.Size = UDim2.new(1, -24, 1, -(scrollTop + 8))
scrollFrame.Position = UDim2.new(0, 12, 0, scrollTop)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.ScrollBarThickness = 5
scrollFrame.ScrollBarImageColor3 = THEME.ACCENT
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ZIndex = 3

local layout = Instance.new("UIListLayout", scrollFrame)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local scrollPadding = Instance.new("UIPadding", scrollFrame)
scrollPadding.PaddingBottom = UDim.new(0, 8)
scrollPadding.PaddingTop = UDim.new(0, 4)

-- prevent scroll stealing drag
local isScrolling = false
scrollFrame.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseWheel then
        isScrolling = true; mainFrame.Active = false
    end
end)
scrollFrame.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseWheel then
        task.delay(0.1, function() isScrolling = false; mainFrame.Active = true end)
    end
end)

-- ============================================================
-- SERVER SCANNING
-- ============================================================
getgenv().ElianaNextServer = nil
getgenv().ElianaScannedAll = false

local function GetAllServers(placeId)
    getgenv().ElianaNextServer = nil
    getgenv().ElianaScannedAll = false
    local results = {}

    xpcall(function()
        local url = "https://games.roblox.com/v1/games/" .. tostring(placeId) .. "/servers/Public?sortOrder=Desc&limit=100"
        local raw = game:HttpGet(url)
        local data = HttpService:JSONDecode(raw)

        if data and data.data then
            for _, sv in ipairs(data.data) do
                table.insert(results, sv)
            end
        end

        local cursor = data and data.nextPageCursor
        local pages = 0
        while cursor and cursor ~= "null" and cursor ~= "" and pages < 10 do
            local nextRaw = game:HttpGet(url .. "&cursor=" .. cursor)
            local nextData = HttpService:JSONDecode(nextRaw)
            cursor = nextData and nextData.nextPageCursor or nil
            if nextData and nextData.data then
                for _, sv in ipairs(nextData.data) do
                    table.insert(results, sv)
                end
            end
            pages += 1
            task.wait(0.05)
        end
        if not cursor or cursor == "null" or cursor == "" then
            getgenv().ElianaScannedAll = true
        else
            getgenv().ElianaNextServer = cursor
        end
    end, function(err)
        warn("[ElianaHub] Scan error:", err)
    end)

    return results
end

-- ============================================================
-- FPS / SMOOTH MODE
-- ============================================================
local smoothMode = false
local fpsFrames = 0
local fpsLast = tick()
RunService.RenderStepped:Connect(function()
    fpsFrames += 1
    if tick() - fpsLast >= 1 then
        smoothMode = (fpsFrames / (tick() - fpsLast)) < 22
        fpsFrames = 0
        fpsLast = tick()
    end
end)

-- ============================================================
-- SERVER CARD CREATION
-- ============================================================
local serverFrames = {}
local allServers   = {}

local function CreateServerCard(server, index)
    local card = Instance.new("Frame", scrollFrame)
    card.Size = UDim2.new(1, -4, 0, LAYOUT.cardH)
    card.BackgroundColor3 = THEME.CARD
    card.BorderSizePixel = 0
    card.LayoutOrder = index
    card.ZIndex = 4
    corner(card, 10)
    stroke(card, THEME.BORDER)

    -- hover glow
    card.MouseEnter:Connect(function() tween(card, {BackgroundColor3 = THEME.CARD_HOVER}, 0.15) end)
    card.MouseLeave:Connect(function() tween(card, {BackgroundColor3 = THEME.CARD}, 0.15) end)

    -- Left accent stripe
    local stripe = Instance.new("Frame", card)
    stripe.Size = UDim2.new(0, 4, 1, -16)
    stripe.Position = UDim2.new(0, 0, 0.5, 0)
    stripe.AnchorPoint = Vector2.new(0, 0.5)
    stripe.BackgroundColor3 = THEME.ACCENT
    stripe.BorderSizePixel = 0
    corner(stripe, 2)

    local playing    = server.playing or 0
    local maxPlayers = server.maxPlayers or 1
    local fillRatio  = math.clamp(playing / maxPlayers, 0, 1)
    local fillColor  = fillRatio > 0.8 and THEME.ERROR or (fillRatio > 0.5 and THEME.WARNING or THEME.SUCCESS)

    -- Layout decides button area width — on mobile, full card width
    local MOBILE_CARD = IS_COMPACT and LAYOUT.frameW < 480
    local INFO_W = MOBILE_CARD and 1.0 or 0.62   -- scale fraction of card width for info

    -- Server # label
    local numLbl = makeLabel(card, "#" .. index, LAYOUT.cardSubSz - 1, THEME.ACCENT, Enum.Font.GothamBold)
    numLbl.Size = UDim2.new(0, 40, 0, 16)
    numLbl.Position = UDim2.new(0, 14, 0, 6)

    -- Players
    local playersLbl = makeLabel(card, "👥 " .. playing .. " / " .. maxPlayers, LAYOUT.cardFontSz, THEME.TEXT, Enum.Font.GothamBold)
    playersLbl.Size = UDim2.new(0, 170, 0, 20)
    playersLbl.Position = UDim2.new(0, 14, 0, 22)

    -- Ping
    local ping = server.ping or 0
    local pingColor = ping > 250 and THEME.ERROR or (ping > 100 and THEME.WARNING or THEME.SUCCESS)
    local pingLbl = makeLabel(card, "📡 " .. ping .. "ms", LAYOUT.cardSubSz, pingColor, Enum.Font.Gotham)
    pingLbl.Size = UDim2.new(0, 110, 0, 16)
    pingLbl.Position = UDim2.new(0, 14, 0, 44)

    -- FPS estimate
    local fps = (ping > 0) and math.min(math.floor(1000 / ping), 60) or 0
    local fpsLbl = makeLabel(card, "🖥 ~" .. fps .. " fps", LAYOUT.cardSubSz, THEME.SUBTEXT, Enum.Font.Gotham)
    fpsLbl.Size = UDim2.new(0, 110, 0, 16)
    fpsLbl.Position = UDim2.new(0, 120, 0, 44)

    -- Player fill bar
    local barBg = Instance.new("Frame", card)
    barBg.Size = UDim2.new(0, LAYOUT.barBgW, 0, 5)
    barBg.Position = UDim2.new(0, 14, 0, 64)
    barBg.BackgroundColor3 = THEME.BORDER
    barBg.BorderSizePixel = 0
    corner(barBg, 3)

    local barFill = Instance.new("Frame", barBg)
    barFill.Size = UDim2.new(fillRatio, 0, 1, 0)
    barFill.BackgroundColor3 = fillColor
    barFill.BorderSizePixel = 0
    corner(barFill, 3)

    -- Server ID
    local sid = tostring(server.id or "")
    local maxIdChars = IS_COMPACT and 18 or 24
    local shortId = sid:len() > maxIdChars and sid:sub(1, maxIdChars) .. "…" or sid
    local idLbl = makeLabel(card, "🆔 " .. shortId, LAYOUT.cardIdSz, THEME.SUBTEXT, Enum.Font.Gotham)
    idLbl.Size = UDim2.new(0.85, 0, 0, 14)
    idLbl.Position = UDim2.new(0, 14, 0, 72)

    -- ── BUTTONS ─────────────────────────────────────────────
    -- On compact/mobile: stack buttons vertically in bottom portion of card
    -- On desktop: buttons on right side

    if IS_COMPACT then
        -- Stacked row at bottom of card
        local BY = 90  -- buttons start Y
        local BH = 28
        local BW = (LAYOUT.frameW - 40) / 2 - 4  -- two side by side

        local joinBtn = Instance.new("TextButton", card)
        joinBtn.Size = UDim2.new(0, BW, 0, BH)
        joinBtn.Position = UDim2.new(0, 14, 0, BY)
        joinBtn.BackgroundColor3 = THEME.JOIN_BTN
        joinBtn.Text = "▶ Join"
        joinBtn.TextColor3 = Color3.fromRGB(10, 30, 18)
        joinBtn.TextSize = LAYOUT.cardSubSz
        joinBtn.Font = Enum.Font.GothamBold
        joinBtn.BorderSizePixel = 0
        corner(joinBtn, 7)
        joinBtn.MouseButton1Click:Connect(function()
            playClick(joinBtn)
            pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer) end)
        end)

        local copyLinkBtn = Instance.new("TextButton", card)
        copyLinkBtn.Size = UDim2.new(0, BW, 0, BH)
        copyLinkBtn.Position = UDim2.new(0, 18 + BW, 0, BY)
        copyLinkBtn.BackgroundColor3 = THEME.LINK_BTN
        copyLinkBtn.Text = "🔗 Copy Link"
        copyLinkBtn.TextColor3 = Color3.new(1,1,1)
        copyLinkBtn.TextSize = LAYOUT.cardSubSz
        copyLinkBtn.Font = Enum.Font.GothamBold
        copyLinkBtn.BorderSizePixel = 0
        corner(copyLinkBtn, 7)
        copyLinkBtn.MouseButton1Click:Connect(function()
            playClick(copyLinkBtn)
            local ok = pcall(function()
                local link = "https://reverse.software/joiner?placeId=" .. tostring(game.PlaceId) .. "&gameInstanceId=" .. tostring(server.id)
                setclipboard(link)
            end)
            if ok then
                copyLinkBtn.Text = "✓ Copied!"
                tween(copyLinkBtn, {BackgroundColor3 = THEME.SUCCESS}, 0.1)
                task.delay(1.8, function()
                    if copyLinkBtn and copyLinkBtn.Parent then
                        copyLinkBtn.Text = "🔗 Copy Link"
                        tween(copyLinkBtn, {BackgroundColor3 = THEME.LINK_BTN}, 0.2)
                    end
                end)
                NotifLib:Notify({Title="Link Copied!", Message="Join link copied.", Accent=THEME.LINK_BTN, Duration=3})
            end
        end)
    else
        -- Desktop: right-side button area
        local btnArea = Instance.new("Frame", card)
        btnArea.Size = UDim2.new(0, LAYOUT.btnAreaW, 1, -16)
        btnArea.Position = UDim2.new(1, -(LAYOUT.btnAreaW + 8), 0.5, 0)
        btnArea.AnchorPoint = Vector2.new(0, 0.5)
        btnArea.BackgroundTransparency = 1

        local joinBtn = Instance.new("TextButton", btnArea)
        joinBtn.Size = UDim2.new(0, LAYOUT.btnW, 0, 34)
        joinBtn.Position = UDim2.new(0, 0, 0.5, 0)
        joinBtn.AnchorPoint = Vector2.new(0, 0.5)
        joinBtn.BackgroundColor3 = THEME.JOIN_BTN
        joinBtn.Text = "▶  Join"
        joinBtn.TextColor3 = Color3.fromRGB(10, 30, 18)
        joinBtn.TextSize = 13
        joinBtn.Font = Enum.Font.GothamBold
        joinBtn.BorderSizePixel = 0
        corner(joinBtn, 7)
        joinBtn.MouseEnter:Connect(function() tween(joinBtn, {BackgroundColor3 = Color3.fromRGB(100,230,150)}, 0.12) end)
        joinBtn.MouseLeave:Connect(function() tween(joinBtn, {BackgroundColor3 = THEME.JOIN_BTN}, 0.12) end)
        joinBtn.MouseButton1Click:Connect(function()
            playClick(joinBtn)
            pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer) end)
        end)

        local copyLinkBtn = Instance.new("TextButton", btnArea)
        copyLinkBtn.Size = UDim2.new(0, LAYOUT.linkW, 0, 34)
        copyLinkBtn.Position = UDim2.new(0, LAYOUT.btnW + 4, 0.5, 0)
        copyLinkBtn.AnchorPoint = Vector2.new(0, 0.5)
        copyLinkBtn.BackgroundColor3 = THEME.LINK_BTN
        copyLinkBtn.Text = "🔗 Copy Join Link"
        copyLinkBtn.TextColor3 = Color3.new(1,1,1)
        copyLinkBtn.TextSize = 12
        copyLinkBtn.Font = Enum.Font.GothamBold
        copyLinkBtn.BorderSizePixel = 0
        corner(copyLinkBtn, 7)
        copyLinkBtn.MouseEnter:Connect(function() tween(copyLinkBtn, {BackgroundColor3 = Color3.fromRGB(180,120,255)}, 0.12) end)
        copyLinkBtn.MouseLeave:Connect(function() tween(copyLinkBtn, {BackgroundColor3 = THEME.LINK_BTN}, 0.12) end)
        copyLinkBtn.MouseButton1Click:Connect(function()
            playClick(copyLinkBtn)
            local ok, err = pcall(function()
                local link = "https://reverse.software/joiner?placeId=" .. tostring(game.PlaceId) .. "&gameInstanceId=" .. tostring(server.id)
                setclipboard(link)
            end)
            if ok then
                copyLinkBtn.Text = "✓ Copied!"
                tween(copyLinkBtn, {BackgroundColor3 = THEME.SUCCESS}, 0.1)
                task.delay(1.8, function()
                    if copyLinkBtn and copyLinkBtn.Parent then
                        copyLinkBtn.Text = "🔗 Copy Join Link"
                        tween(copyLinkBtn, {BackgroundColor3 = THEME.LINK_BTN}, 0.2)
                    end
                end)
                NotifLib:Notify({Title="Link Copied!", Message="Join link copied to clipboard.", Accent=THEME.LINK_BTN, Duration=3})
            else
                warn("[ElianaHub] Copy link failed:", err)
            end
        end)
    end

    table.insert(serverFrames, card)
end

-- ============================================================
-- SERVER LIST MANAGEMENT
-- ============================================================
local function clearServerList()
    for _, v in ipairs(serverFrames) do
        if v and v.Parent then v:Destroy() end
    end
    table.clear(serverFrames)
end

local function sortServers(servers, mode)
    if typeof(servers) ~= "table" then return {} end
    local copy = table.clone(servers)
    if mode == "lowPlayers" then
        table.sort(copy, function(a,b) return (a.playing or 0) < (b.playing or 0) end)
    elseif mode == "maxPlayers" then
        table.sort(copy, function(a,b) return (a.playing or 0) > (b.playing or 0) end)
    elseif mode == "fastest" then
        table.sort(copy, function(a,b) return (a.ping or 9999) < (b.ping or 9999) end)
    end
    return copy
end

local function filterByPlayers(servers, count)
    if count <= 0 then return servers end
    local out = {}
    for _, sv in ipairs(servers) do
        if (sv.playing or 0) == count then
            table.insert(out, sv)
        end
    end
    return out
end

local function populateList(servers)
    clearServerList()
    if typeof(servers) ~= "table" then return end
    local count = 0

    local function doCreate()
        for i, sv in ipairs(servers) do
            CreateServerCard(sv, i)
            count += 1
            if smoothMode then task.wait(0.04) end
        end
        serverCountLbl.Text = count .. " server" .. (count ~= 1 and "s" or "") .. " shown"
    end

    if smoothMode then
        task.spawn(doCreate)
    else
        doCreate()
    end
end

local displayedServers = {}

local function refreshServers()
    setStatus("Scanning...", THEME.WARNING)
    serverCountLbl.Text = ""
    local ok, result = pcall(function()
        return GetAllServers(game.PlaceId)
    end)
    if ok and typeof(result) == "table" and #result > 0 then
        allServers = result
        displayedServers = result
        populateList(result)
        setStatus("✓ " .. #result .. " servers found", THEME.SUCCESS)
        NotifLib:Notify({
            Title = "Eliana Hub",
            Message = "Found " .. #result .. " servers.",
            Accent = THEME.SUCCESS,
            Duration = 3
        })
    else
        setStatus("No servers found or API error.", THEME.ERROR)
        NotifLib:Notify({
            Title = "Error",
            Message = "Could not load servers. Try again.",
            Accent = THEME.ERROR,
            Duration = 4
        })
    end
end

-- ============================================================
-- BUTTON LOGIC
-- ============================================================

-- Sort buttons
btnLowPlayers.MouseButton1Click:Connect(function()
    playClick(btnLowPlayers)
    local sorted = sortServers(allServers, "lowPlayers")
    displayedServers = sorted
    populateList(sorted)
end)

btnMaxPlayers.MouseButton1Click:Connect(function()
    playClick(btnMaxPlayers)
    local sorted = sortServers(allServers, "maxPlayers")
    displayedServers = sorted
    populateList(sorted)
end)

btnFastest.MouseButton1Click:Connect(function()
    playClick(btnFastest)
    local sorted = sortServers(allServers, "fastest")
    displayedServers = sorted
    populateList(sorted)
end)

-- Player count filter: < N >
local PLAYER_STEPS = {0, 1, 2, 3, 4, 5, 6, 8, 10, 12, 15, 20, 25, 30, 40, 50}
local filterIdx = 1  -- index into PLAYER_STEPS; 1 = 0 = OFF

local function updateFilterDisplay()
    local n = PLAYER_STEPS[filterIdx]
    filterNumLbl.Text = n == 0 and "OFF" or tostring(n)
    filterNumLbl.TextColor3 = n == 0 and THEME.SUBTEXT or THEME.TEXT
end

btnFilterDown.MouseButton1Click:Connect(function()
    playClick(btnFilterDown)
    filterIdx = math.max(1, filterIdx - 1)
    updateFilterDisplay()
end)

btnFilterUp.MouseButton1Click:Connect(function()
    playClick(btnFilterUp)
    filterIdx = math.min(#PLAYER_STEPS, filterIdx + 1)
    updateFilterDisplay()
end)

btnFilterApply.MouseButton1Click:Connect(function()
    playClick(btnFilterApply)
    local n = PLAYER_STEPS[filterIdx]
    if n == 0 then
        populateList(allServers)
        setStatus("Filter cleared — all servers shown", THEME.SUCCESS)
    else
        local filtered = filterByPlayers(allServers, n)
        populateList(filtered)
        setStatus("Showing servers with exactly " .. n .. " player(s)", THEME.ACCENT2)
        NotifLib:Notify({
            Title = "Filter Applied",
            Message = "Showing servers with " .. n .. " player(s). Found: " .. #filtered,
            Accent = THEME.ACCENT2,
            Duration = 3
        })
    end
end)

-- Refresh
refreshBtn.MouseButton1Click:Connect(function()
    task.spawn(refreshServers)
end)

-- Close
closeBtn.MouseButton1Click:Connect(function()
    playClick(closeBtn)
    task.delay(0.12, function()
        pcall(function()
            _G.ELIANA_HUB_LOADED = false
            _G.ELIANA_HUB_CAN_RELOAD = true

            -- restore render quality
            local rs = settings():GetService("RenderSettings")
            pcall(function() rs.QualityLevel = Enum.QualityLevel.Automatic end)
            for _, ef in ipairs(Lighting:GetChildren()) do
                if ef:IsA("PostEffect") then ef.Enabled = true end
            end
            Lighting.GlobalShadows = true
            screenGui:Destroy()
        end)
    end)
end)

-- Rejoin
local RELOAD_SOURCE = [=[
loadstring(game:HttpGet("https://raw.githubusercontent.com/MaxproGlitcher/Server-Finder-Deluxe/refs/heads/main/Finder_Servers_Code.luau"))()
]=]

local startTime = os.clock()

rejoinBtn.MouseButton1Click:Connect(function()
    playClick(rejoinBtn)
    NotifLib:Notify({
        Title = "Rejoining...",
        Message = string.format("Session time: %.1f s", os.clock() - startTime),
        Accent = THEME.WARNING,
        Duration = 4
    })
    task.delay(0.5, function()
        pcall(function()
            if queueteleport then
                queueteleport(RELOAD_SOURCE)
            end
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)
    end)
end)

-- Resize toggle
local isSmall = false
resizeBtn.MouseButton1Click:Connect(function()
    playClick(resizeBtn)
    isSmall = not isSmall
    if isSmall then
        -- Shrink to a minimal size appropriate for the device
        local minW = math.max(300, math.floor(LAYOUT.frameW * 0.65))
        local minH = math.max(260, math.floor(LAYOUT.frameH * 0.65))
        tween(mainFrame, {Size = UDim2.new(0, minW, 0, minH)}, 0.25, Enum.EasingStyle.Back)
    else
        tween(mainFrame, {Size = UDim2.new(0, LAYOUT.frameW, 0, LAYOUT.frameH)}, 0.25, Enum.EasingStyle.Back)
    end
end)

-- Keyboard close shortcut
UserInputService.InputBegan:Connect(function(inp, gp)
    if gp then return end
    if inp.KeyCode == Enum.KeyCode.RightControl then
        pcall(function()
            _G.ELIANA_HUB_LOADED = false
            _G.ELIANA_HUB_CAN_RELOAD = true
            screenGui:Destroy()
        end)
    end
end)

-- ============================================================
-- PERFORMANCE MODE
-- ============================================================
local function EnablePerformanceMode()
    pcall(function()
        local rs = settings():GetService("RenderSettings")
        rs.QualityLevel = Enum.QualityLevel.Level01
        rs.EditQualityLevel = Enum.QualityLevel.Level01
        Lighting.GlobalShadows = false
        for _, ef in ipairs(Lighting:GetChildren()) do
            if ef:IsA("PostEffect") then ef.Enabled = false end
        end
    end)
end
EnablePerformanceMode()

-- ============================================================
-- WELCOME NOTIFICATION
-- ============================================================
task.wait(0.5)
NotifLib:Notify({
    Title = "👋 Welcome — Eliana Hub",
    Message = "Server Browser loaded! Scanning servers...",
    Accent = THEME.ACCENT,
    Duration = 5
})

-- ============================================================
-- INITIAL SCAN
-- ============================================================
task.spawn(refreshServers)
