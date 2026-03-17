-- ============================================================
-- Eliana Hub - MM2 Trade Value Checker
-- Version: V1
-- Source: supremevaluelist.com
-- ============================================================

-- SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Trade = ReplicatedStorage:WaitForChild("Trade")
local Camera = workspace.CurrentCamera

-- VALUE STORAGE
local itemValues = {}
local valuesLoaded = false
local pagesLoaded = 0

-- All pages to scrape from supremevaluelist.com
local valuePages = {
    "https://supremevaluelist.com/mm2/godlies.html",
    "https://supremevaluelist.com/mm2/ancients.html",
    "https://supremevaluelist.com/mm2/uniques.html",
    "https://supremevaluelist.com/mm2/vintages.html",
    "https://supremevaluelist.com/mm2/chromas.html",
    "https://supremevaluelist.com/mm2/pets.html",
    "https://supremevaluelist.com/mm2/sets.html",
    "https://supremevaluelist.com/mm2/legendaries.html",
    "https://supremevaluelist.com/mm2/rares.html",
    "https://supremevaluelist.com/mm2/uncommons.html",
    "https://supremevaluelist.com/mm2/commons.html",
    "https://supremevaluelist.com/mm2/evos.html",
}

local totalPages = #valuePages

-- Safe string trim
local function trim(s)
    return s:match("^%s*(.-)%s*$")
end

-- Safe lowercase normalize: remove spaces, punctuation for fuzzy match
local function normalize(s)
    return tostring(s):lower():gsub("[%s%p]", "")
end

-- Parse a value string: handles "1,095", "1,095-1,110" -> takes lower bound number
local function parseValue(raw)
    if not raw then return 0 end
    -- Remove commas, grab first number in case of range
    local cleaned = raw:gsub(",", "")
    local num = cleaned:match("^(%d+%.?%d*)")
    return tonumber(num) or 0
end

-- SCRAPER
local function LoadWebsiteValues()
    local requestHeaders = {
        ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"
    }

    for _, url in ipairs(valuePages) do
        task.spawn(function()
            local success, resp = pcall(function()
                return request({ Url = url, Method = "GET", Headers = requestHeaders })
            end)

            if success and resp and resp.Body then
                local body = resp.Body

                -- Pattern 1: <div class="itemhead">NAME</div> ... <b class="itemvalue">VALUE</b>
                -- Handles both single quotes and double quotes in class attributes
                for rawTitle, rawBody in body:gmatch('<div%s+class=["\']itemhead["\']>(.-)</div>%s*<div%s+class=["\']itembody["\']>(.-)</div>') do

                    -- Strip HTML tags from title to get plain name
                    local name = rawTitle:gsub("<[^>]+>", ""):gsub("&amp;", "&"):gsub("&#x27;", "'")
                    name = trim(name)

                    -- Remove " click" suffix if present (old format artifact)
                    name = name:gsub("%s*click%s*$", "")

                    if name and name ~= "" then
                        local normName = normalize(name)

                        -- Try to find value: <b class="itemvalue">NUMBER_OR_RANGE</b>
                        local valText = rawBody:match('<b%s+class=["\']itemvalue["\']>([%d%s,%.%-]+)</b>')

                        -- Fallback: any bold with digits
                        if not valText then
                            valText = rawBody:match('<b>([%d,%.%-]+)</b>')
                        end

                        -- Fallback: bracket range pattern [1,000-1,100] inside body text
                        if not valText then
                            valText = rawBody:match('%[([%d,%.%-]+)%]')
                        end

                        local value = parseValue(valText)

                        -- Store both original and normalized key
                        if value > 0 then
                            itemValues[normName] = value
                            itemValues[name:lower()] = value
                        end
                    end
                end

                -- Pattern 2: Updated site format - data-name / data-value attributes
                for dataName, dataVal in body:gmatch('data%-name=["\']([^"\']+)["\'][^>]*data%-value=["\']([%d,%.%-]+)["\']') do
                    local v = parseValue(dataVal)
                    if v > 0 then
                        itemValues[normalize(dataName)] = v
                        itemValues[dataName:lower()] = v
                    end
                end

                -- Pattern 3: JSON-like embedded value objects {"name":"...","value":...}
                for jName, jVal in body:gmatch('"name"%s*:%s*"([^"]+)"%s*,%s*"value"%s*:%s*"?([%d,%.%-]+)"?') do
                    local v = parseValue(jVal)
                    if v > 0 then
                        itemValues[normalize(jName)] = v
                        itemValues[jName:lower()] = v
                    end
                end
            end

            pagesLoaded = pagesLoaded + 1
            if pagesLoaded >= totalPages then
                valuesLoaded = true
            end
        end)
    end
end

LoadWebsiteValues()

-- CLEANUP old GUI
local oldGui = game:GetService("CoreGui"):FindFirstChild("TradeCoreGui")
if oldGui then oldGui:Destroy() end

-- MAIN GUI SETUP
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TradeCoreGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Enabled = false
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromScale(0.5, 0.7)
MainFrame.Position = UDim2.fromScale(0.25, 0.15)
MainFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(220, 220, 220)
UIStroke.Parent = MainFrame

-- AUTO-SCALER
local UIScale = Instance.new("UIScale")
UIScale.Parent = MainFrame
local function UpdateScale()
    local viewportSize = Camera.ViewportSize
    local scale = viewportSize.X / 1280
    UIScale.Scale = math.clamp(scale, 0.45, 1.1)
end
Camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)
UpdateScale()

-- TITLE BAR
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "Eliana Hub (Value Checker)"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(30, 30, 30)
Title.Active = true
Title.Parent = MainFrame

-- LOADING INDICATOR (shown while values are still scraping)
local LoadingLabel = Instance.new("TextLabel")
LoadingLabel.Size = UDim2.new(1, 0, 0, 20)
LoadingLabel.Position = UDim2.new(0, 0, 0, 50)
LoadingLabel.BackgroundTransparency = 1
LoadingLabel.Text = "Loading values... (0/" .. totalPages .. ")"
LoadingLabel.Font = Enum.Font.Gotham
LoadingLabel.TextSize = 12
LoadingLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
LoadingLabel.Parent = MainFrame

-- Update loading label progress
task.spawn(function()
    while not valuesLoaded do
        LoadingLabel.Text = "Loading values... (" .. pagesLoaded .. "/" .. totalPages .. ")"
        task.wait(0.5)
    end
    LoadingLabel.Text = "✓ Values loaded (" .. totalPages .. "/" .. totalPages .. ")"
    task.wait(2)
    LoadingLabel.Text = ""
end)

-- WIN/LOSS STATUS FRAME
local StatusFrame = Instance.new("Frame")
StatusFrame.Size = UDim2.new(0.96, 0, 0, 45)
StatusFrame.Position = UDim2.new(0.02, 0, 0.83, 0)
StatusFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
StatusFrame.Parent = MainFrame
Instance.new("UICorner", StatusFrame).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", StatusFrame).Color = Color3.fromRGB(230, 230, 230)

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, 0, 1, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "WAITING FOR TRADE..."
StatusText.Font = Enum.Font.GothamBold
StatusText.TextSize = 20
StatusText.TextColor3 = Color3.fromRGB(50, 50, 50)
StatusText.Parent = StatusFrame

-- COLUMN CREATOR
local function createColumn(titleText, posX)
    local Column = Instance.new("Frame")
    Column.Size = UDim2.new(0.46, 0, 0.65, 0)
    Column.Position = UDim2.new(posX, 0, 0.17, 0) -- shifted slightly down to accommodate loading label
    Column.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Column.Parent = MainFrame
    Instance.new("UICorner", Column).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", Column).Color = Color3.fromRGB(235, 235, 235)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 40)
    Label.BackgroundTransparency = 1
    Label.Text = titleText
    Label.Font = Enum.Font.GothamBold
    Label.TextColor3 = Color3.fromRGB(40, 40, 40)
    Label.TextSize = 16
    Label.Parent = Column

    local List = Instance.new("ScrollingFrame")
    List.Size = UDim2.new(1, -10, 1, -50)
    List.Position = UDim2.new(0, 5, 0, 45)
    List.BackgroundTransparency = 1
    List.CanvasSize = UDim2.new(0, 0, 0, 0)
    List.AutomaticCanvasSize = Enum.AutomaticSize.Y
    List.ScrollBarThickness = 4
    List.Parent = Column

    local Layout = Instance.new("UIListLayout", List)
    Layout.Padding = UDim.new(0, 6)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    return List, Label
end

local OurList, OurLabel = createColumn("YOUR OFFER", 0.02)
local TheirList, TheirLabel = createColumn("THEIR OFFER", 0.52)

-- GET ITEM VALUE (improved fuzzy matching)
local function getItemValue(id)
    if not id then return 0 end
    local raw = tostring(id)
    local normID = normalize(raw)
    local lowerID = raw:lower()

    -- Exact normalized match first
    if itemValues[normID] then
        return itemValues[normID]
    end

    -- Exact lowercase match
    if itemValues[lowerID] then
        return itemValues[lowerID]
    end

    -- Fuzzy: check if stored name contains the item id or vice versa
    -- Only match if lengths are close (within 4 chars) to avoid false positives
    for storedName, value in pairs(itemValues) do
        local lenDiff = math.abs(#storedName - #normID)
        if lenDiff <= 4 then
            if storedName:find(normID, 1, true) or normID:find(storedName, 1, true) then
                return value
            end
        end
    end

    return 0
end

-- ITEM CREATOR
local function createItem(id, amount, isOurs, itemType)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -8, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(248, 248, 248)
    btn.Text = ""
    btn.Parent = nil
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    Instance.new("UIStroke", btn).Color = Color3.fromRGB(240, 240, 240)

    local val = getItemValue(id)
    local displayValue = val > 0 and " [" .. val .. "]" or " [0]"

    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1, -20, 1, 0)
    txt.Position = UDim2.new(0, 10, 0, 0)
    txt.BackgroundTransparency = 1
    txt.Text = id .. (amount > 1 and " x" .. amount or "") .. displayValue
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 15

    if val > 0 then
        txt.TextColor3 = Color3.fromRGB(255, 220, 0)
        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 1.2
        stroke.Color = Color3.fromRGB(40, 40, 40)
        stroke.Parent = txt
    else
        txt.TextColor3 = Color3.fromRGB(160, 160, 160) -- greyed out for no value
    end

    txt.Parent = btn

    if isOurs then
        btn.MouseButton1Click:Connect(function()
            Trade.RemoveOffer:FireServer(id, itemType)
        end)
    end
    return btn
end

local function ClearAll()
    for _, v in pairs(OurList:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for _, v in pairs(TheirList:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
end

local function UpdateGUI(data)
    ClearAll()
    local p1, p2 = data.Player1, data.Player2
    local ours = (p1.Player == LocalPlayer and p1.Offer or p2.Offer)
    local theirs = (p1.Player == LocalPlayer and p2.Offer or p1.Offer)

    local ourTotal = 0
    local theirTotal = 0

    for _, item in pairs(ours) do
        local id = item[1] or item.ItemID
        local amt = item[2] or item.Amount or 1
        ourTotal = ourTotal + (getItemValue(id) * amt)
        createItem(id, amt, true, item[3] or item.ItemType).Parent = OurList
    end
    for _, item in pairs(theirs) do
        local id = item[1] or item.ItemID
        local amt = item[2] or item.Amount or 1
        theirTotal = theirTotal + (getItemValue(id) * amt)
        createItem(id, amt, false, item[3] or item.ItemType).Parent = TheirList
    end

    OurLabel.Text = "YOUR OFFER: " .. ourTotal
    TheirLabel.Text = "THEIR OFFER: " .. theirTotal

    if not valuesLoaded then
        StatusText.Text = "⚠ VALUES STILL LOADING..."
        StatusText.TextColor3 = Color3.fromRGB(200, 140, 0)
    elseif theirTotal > ourTotal then
        StatusText.Text = "RESULT: W  (+" .. (theirTotal - ourTotal) .. ")"
        StatusText.TextColor3 = Color3.fromRGB(0, 150, 70)
    elseif theirTotal == ourTotal and ourTotal > 0 then
        StatusText.Text = "RESULT: M  (Even)"
        StatusText.TextColor3 = Color3.fromRGB(210, 105, 30)
    elseif ourTotal > theirTotal then
        StatusText.Text = "RESULT: L  (-" .. (ourTotal - theirTotal) .. ")"
        StatusText.TextColor3 = Color3.fromRGB(200, 0, 0)
    else
        StatusText.Text = "ADD ITEMS TO CALCULATE"
        StatusText.TextColor3 = Color3.fromRGB(100, 100, 100)
    end

    ScreenGui.Enabled = true
end

-- EVENTS
Trade.UpdateTrade.OnClientEvent:Connect(UpdateGUI)
Trade.StartTrade.OnClientEvent:Connect(function(data)
    ScreenGui.Enabled = true
    UpdateGUI(data)
end)
local function HideUI()
    ScreenGui.Enabled = false
    ClearAll()
end
Trade.DeclineTrade.OnClientEvent:Connect(HideUI)
Trade.AcceptTrade.OnClientEvent:Connect(function(s) if s then HideUI() end end)

-- DRAGGING
local dragging, dragStart, startPos
local function updateInput(input)
    local delta = input.Position - dragStart
    local s = UIScale.Scale
    MainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + (delta.X / s),
        startPos.Y.Scale,
        startPos.Y.Offset + (delta.Y / s)
    )
end
Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateInput(input)
    end
end)
