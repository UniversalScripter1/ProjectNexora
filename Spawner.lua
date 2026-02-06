local a = Instance.new("ScreenGui")
a.Name = "HydroStreamzHub_Mac_V10"
a.ResetOnSpawn = false
a.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local b = Instance.new("Frame")
b.Size = UDim2.new(0, 220, 0, 180)
b.Position = UDim2.new(0.5, -110, 0.5, -90)
b.BackgroundTransparency = 1
b.Active = true
b.Draggable = true
b.Parent = a

local c = Instance.new("Frame")
c.Name = "GestureHandle"
c.Size = UDim2.new(0, 60, 0, 5)
c.Position = UDim2.new(0.5, -30, 0, 0)
c.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
c.BackgroundTransparency = 0.5
c.BorderSizePixel = 0
c.Parent = b

local d = Instance.new("UICorner")
d.CornerRadius = UDim.new(1, 0)
d.Parent = c

c.InputBegan:Connect(function(e)
    if e.UserInputType == Enum.UserInputType.MouseButton1 or e.UserInputType == Enum.UserInputType.Touch then
        c.BackgroundColor3 = Color3.fromRGB(40, 201, 64)
        c.BackgroundTransparency = 0.2
    end
end)

c.InputEnded:Connect(function(e)
    if e.UserInputType == Enum.UserInputType.MouseButton1 or e.UserInputType == Enum.UserInputType.Touch then
        c.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        c.BackgroundTransparency = 0.5
    end
end)

local f = Instance.new("Frame")
f.Name = "MainWindow"
f.Size = UDim2.new(1, 0, 0, 160)
f.Position = UDim2.new(0, 0, 0, 15)
f.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
f.BackgroundTransparency = 0.05
f.BorderSizePixel = 0
f.ClipsDescendants = true
f.Parent = b

local g = Instance.new("UICorner")
g.CornerRadius = UDim.new(0, 10)
g.Parent = f

local h = Instance.new("UIStroke")
h.Thickness = 1
h.Color = Color3.fromRGB(0, 0, 0)
h.Transparency = 0.85
h.Parent = f

local i = Instance.new("Frame")
i.Size = UDim2.new(1, 0, 0, 32)
i.BackgroundTransparency = 1
i.Parent = f

local j = Instance.new("TextLabel")
j.Size = UDim2.new(1, 0, 1, 0)
j.Text = "HydroStreamz Hub"
j.TextColor3 = Color3.fromRGB(60, 60, 60)
j.Font = Enum.Font.GothamMedium
j.TextSize = 13
j.BackgroundTransparency = 1
j.Parent = i

local function k(l, m)
    local n = Instance.new("Frame")
    n.Size = UDim2.new(0, 10, 0, 10)
    n.Position = UDim2.new(0, m, 0.5, -5)
    n.BackgroundColor3 = l
    n.BorderSizePixel = 0
    n.Parent = i
    Instance.new("UICorner", n).CornerRadius = UDim.new(1, 0)
end

k(Color3.fromRGB(255, 95, 87), 12)
k(Color3.fromRGB(255, 189, 46), 28)
k(Color3.fromRGB(40, 201, 64), 44)

local o = Instance.new("Frame")
o.Name = "Content"
o.Size = UDim2.new(1, 0, 1, -32)
o.Position = UDim2.new(0, 0, 0, 32)
o.BackgroundTransparency = 1
o.Parent = f

local p = Instance.new("TextBox")
p.Size = UDim2.new(0.85, 0, 0, 30)
p.Position = UDim2.new(0.075, 0, 0.1, 0)
p.PlaceholderText = "Search Weapon..."
p.Text = ""
p.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
p.TextColor3 = Color3.fromRGB(40, 40, 40)
p.PlaceholderColor3 = Color3.fromRGB(130, 130, 130)
p.Font = Enum.Font.Gotham
p.TextSize = 14
p.ClearTextOnFocus = false
p.Parent = o

Instance.new("UICorner", p).CornerRadius = UDim.new(0, 6)

local q = Instance.new("ScrollingFrame")
q.Size = UDim2.new(0.85, 0, 0, 80)
q.Position = UDim2.new(0.075, 0, 0.1, 32)
q.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
q.BorderSizePixel = 1
q.BorderColor3 = Color3.fromRGB(200, 200, 200)
q.Visible = false
q.ZIndex = 15
q.ScrollBarThickness = 2
q.AutomaticCanvasSize = Enum.AutomaticSize.Y
q.Parent = o

Instance.new("UICorner", q).CornerRadius = UDim.new(0, 4)

local r = Instance.new("UIListLayout")
r.Parent = q
r.SortOrder = Enum.SortOrder.LayoutOrder

local s = Instance.new("TextButton")
s.Size = UDim2.new(0.85, 0, 0, 35)
s.Position = UDim2.new(0.075, 0, 0.7, 0)
s.Text = "Spawn Item"
s.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
s.TextColor3 = Color3.fromRGB(255, 255, 255)
s.Font = Enum.Font.GothamBold
s.TextSize = 14
s.Parent = o

Instance.new("UICorner", s).CornerRadius = UDim.new(0, 6)

local function t(u)
    task.spawn(function()
        local v = Instance.new("TextLabel")
        v.Size = UDim2.new(0, 160, 0, 30)
        v.Position = UDim2.new(0.5, -80, 1, 10)
        v.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        v.TextColor3 = Color3.fromRGB(40, 40, 40)
        v.Text = u
        v.Font = Enum.Font.GothamMedium
        v.TextSize = 12
        v.Parent = a
        v.ZIndex = 100
        Instance.new("UICorner", v).CornerRadius = UDim.new(0, 6)
        Instance.new("UIStroke", v).Transparency = 0.9
        v:TweenPosition(UDim2.new(0.5, -80, 0.85, 0), "Out", "Back", 0.3)
        task.wait(1.5)
        v:TweenPosition(UDim2.new(0.5, -80, 1, 10), "In", "Sine", 0.3)
        task.wait(0.4)
        v:Destroy()
    end)
end

local w = workspace:FindFirstChild("SpawnedWeapons") or Instance.new("Folder", workspace)
local x = require(game:GetService("ReplicatedStorage").Database.Sync.Item)
local y = require(game:GetService("ReplicatedStorage").Modules.ProfileData)

p:GetPropertyChangedSignal("Text"):Connect(function()
    local z = p.Text:lower()
    for _, A in pairs(q:GetChildren()) do
        if A:IsA("TextButton") then
            A:Destroy()
        end
    end
    if z == "" then
        q.Visible = false
        return
    end
    local B = false
    for C, _ in pairs(x) do
        local D = tostring(C)
        if string.find(D:lower(), z) then
            B = true
            local E = Instance.new("TextButton")
            E.Size = UDim2.new(1, -10, 0, 25)
            E.BackgroundTransparency = 1
            E.Text = "  " .. D
            E.TextColor3 = Color3.fromRGB(60, 60, 60)
            E.TextXAlignment = Enum.TextXAlignment.Left
            E.Font = Enum.Font.Gotham
            E.TextSize = 14
            E.ZIndex = 20
            E.Parent = q
            E.MouseButton1Click:Connect(function()
                p.Text = D
                q.Visible = false
            end)
        end
    end
    q.Visible = B
end)

s.MouseButton1Click:Connect(function()
    local F = p.Text:match("^%s*(.-)%s*$"):lower()
    q.Visible = false
    local G
    for H, _ in pairs(x) do
        if tostring(H):lower() == F then
            G = H
            break
        end
    end
    if not G then
        t("❌ Not Found")
        return
    end
    y.Weapons.Owned[G] = 1
    local I = x[G] and x[G].Tool
    if I and I:IsA("Tool") then
        local J = I:Clone()
        J.Name = tostring(G)
        J.Parent = w
        t("✅ " .. tostring(G))
    else
        t("Successfully spawned")
    end
    task.delay(0.1, function()
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character:BreakJoints()
        end
    end)
end)

local K = true
local L = Instance.new("TextButton")
L.Size = UDim2.new(1, 0, 1, 0)
L.BackgroundTransparency = 1
L.Text = ""
L.Parent = i
L.MouseButton1Click:Connect(function()
    K = not K
    q.Visible = false
    if not K then
        o.Visible = false
        f:TweenSize(UDim2.new(1, 0, 0, 32), "Out", "Quart", 0.3, true)
        b:TweenSize(UDim2.new(0, 220, 0, 47), "Out", "Quart", 0.3, true)
    else
        b:TweenSize(UDim2.new(0, 220, 0, 180), "Out", "Quart", 0.3, true)
        f:TweenSize(UDim2.new(1, 0, 0, 160), "Out", "Quart", 0.3, true)
        task.delay(0.2, function()
            o.Visible = true
        end)
    end
end)

-- New button to spawn all items from the database
local spawnAllButton = Instance.new("TextButton")
spawnAllButton.Size = UDim2.new(0.85, 0, 0, 35)
spawnAllButton.Position = UDim2.new(0.075, 0, 0.5, 0)  -- Adjusted position to fit in the GUI
spawnAllButton.Text = "Spawn All Items"
spawnAllButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
spawnAllButton.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnAllButton.Font = Enum.Font.GothamBold
spawnAllButton.TextSize = 14
spawnAllButton.Parent = o

Instance.new("UICorner", spawnAllButton).CornerRadius = UDim.new(0, 6)

spawnAllButton.MouseButton1Click:Connect(function()
    local count = 0
    for G, _ in pairs(x) do
        y.Weapons.Owned[G] = 1
        local I = x[G] and x[G].Tool
        if I and I:IsA("Tool") then
            local J = I:Clone()
            J.Name = tostring(G)
            J.Parent = w
            count = count + 1
        end
    end
    t("✅ Spawned " .. count .. " items")
    task.delay(0.1, function()
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character:BreakJoints()
        end
    end)
end)
