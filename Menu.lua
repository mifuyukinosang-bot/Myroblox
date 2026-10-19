-- // สคริปต์สำหรับสร้าง UI เมนู Automation ใน Roblox (LocalScript) // --

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ลบเมนูเก่าถ้ามีการรันซ้ำ
local oldGui = playerGui:FindFirstChild("AutomationMenuUI")
if oldGui then oldGui:Destroy() end

-- โหลดฟอนต์
local FontBold = Enum.Font.GothamBold
local FontNormal = Enum.Font.Gotham

-- สีที่ใช้
local COLOR_BG = Color3.fromRGB(30, 27, 30)
local COLOR_PANEL = Color3.fromRGB(42, 37, 40)
local COLOR_PANEL_LIGHT = Color3.fromRGB(51, 45, 48)
local COLOR_TEXT = Color3.fromRGB(255, 255, 255)
local COLOR_TEXT_MUTED = Color3.fromRGB(140, 134, 137)
local COLOR_ACCENT = Color3.fromRGB(255, 123, 156) -- สีชมพู

-- // 1. สร้าง ScreenGui หลัก //
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutomationMenuUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- // 2. สร้างหน้าต่างเมนูหลัก //
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 750, 0, 500)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = COLOR_BG
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- // 3. สร้าง Sidebar ด้านซ้าย //
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 180, 1, 0)
Sidebar.BackgroundColor3 = COLOR_BG
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 12)
SidebarCorner.Parent = Sidebar

-- โลโก้ Ouroboros
local LogoLabel = Instance.new("TextLabel")
LogoLabel.Size = UDim2.new(1, -40, 0, 50)
LogoLabel.Position = UDim2.new(0, 20, 0, 10)
LogoLabel.BackgroundTransparency = 1
LogoLabel.Text = "⟲ Ouroboros"
LogoLabel.TextColor3 = COLOR_TEXT
LogoLabel.Font = FontBold
LogoLabel.TextXAlignment = Enum.TextXAlignment.Left
LogoLabel.TextSize = 16
LogoLabel.Parent = Sidebar

-- เมนู Automation (Active)
local ActiveMenu = Instance.new("Frame")
ActiveMenu.Size = UDim2.new(1, 0, 0, 40)
ActiveMenu.Position = UDim2.new(0, 0, 0, 70)
ActiveMenu.BackgroundColor3 = COLOR_PANEL_LIGHT
ActiveMenu.BorderSizePixel = 0
ActiveMenu.Parent = Sidebar

local ActiveLine = Instance.new("Frame")
ActiveLine.Size = UDim2.new(0, 3, 1, 0)
ActiveLine.BackgroundColor3 = COLOR_ACCENT
ActiveLine.BorderSizePixel = 0
ActiveLine.Parent = ActiveMenu

local ActiveText = Instance.new("TextLabel")
ActiveText.Size = UDim2.new(1, -40, 1, 0)
ActiveText.Position = UDim2.new(0, 40, 0, 0)
ActiveText.BackgroundTransparency = 1
ActiveText.Text = "⚡ Automation"
ActiveText.TextColor3 = COLOR_TEXT
ActiveText.Font = FontBold
ActiveText.TextXAlignment = Enum.TextXAlignment.Left
ActiveText.TextSize = 14
ActiveText.Parent = ActiveMenu

-- // 4. สร้างพื้นที่เนื้อหาด้านขวา //
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -180, 1, 0)
ContentArea.Position = UDim2.new(0, 180, 0, 0)
ContentArea.BackgroundColor3 = COLOR_PANEL
ContentArea.BorderSizePixel = 0
ContentArea.Parent = MainFrame

-- Header (หัวข้อ Automation)
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency = 1
Header.Parent = ContentArea

local HeaderLine = Instance.new("Frame")
HeaderLine.Size = UDim2.new(1, -40, 0, 1)
HeaderLine.Position = UDim2.new(0, 20, 1, -1)
HeaderLine.BackgroundColor3 = Color3.fromRGB(61, 52, 56)
HeaderLine.BorderSizePixel = 0
HeaderLine.Parent = Header

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1, -40, 1, 0)
HeaderTitle.Position = UDim2.new(0, 20, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "⚡ Automation"
HeaderTitle.TextColor3 = COLOR_TEXT
HeaderTitle.Font = FontBold
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.TextSize = 16
HeaderTitle.Parent = Header

-- // 5. ฟังก์ชันช่วยสร้าง Panel (กล่องย่อย) //
local function createPanel(parent, posY, height)
    local panel = Instance.new("Frame")
    panel.Size = UDim2.new(1, -40, 0, height)
    panel.Position = UDim2.new(0, 20, 0, posY)
    panel.BackgroundColor3 = COLOR_PANEL_LIGHT
    panel.BorderSizePixel = 0
    panel.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = panel
    
    return panel
end

-- // 6. ฟังก์ชันช่วยสร้างแถวข้อความ //
local function createRow(parent, text, yPos, isValue, valueText)
    local row = Instance.new("TextLabel")
    row.Size = UDim2.new(1, -30, 0, 24)
    row.Position = UDim2.new(0, 15, 0, yPos)
    row.BackgroundTransparency = 1
    row.Font = FontNormal
    row.TextSize = 12
    row.Text = text
    row.TextColor3 = isValue and COLOR_TEXT or COLOR_TEXT_MUTED
    row.TextXAlignment = Enum.TextXAlignment.Left
    row.Parent = parent
    
    if isValue and valueText then
        local value = Instance.new("TextLabel")
        value.Size = UDim2.new(0, 100, 1, 0)
        value.Position = UDim2.new(1, -100, 0, 0)
        value.BackgroundTransparency = 1
        value.Font = FontNormal
        value.TextSize = 12
        value.Text = valueText
        value.TextColor3 = COLOR_TEXT
        value.TextXAlignment = Enum.TextXAlignment.Right
        value.Parent = row
    end
end

-- // 7. ฟังก์ชันสร้างสวิตช์ Toggle //
local function createToggle(parent, yPos, isOn)
    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.new(0, 34, 0, 18)
    toggleBg.Position = UDim2.new(1, -49, 0, yPos + 3)
    toggleBg.BackgroundColor3 = isOn and COLOR_ACCENT or Color3.fromRGB(68, 68, 68)
    toggleBg.BorderSizePixel = 0
    toggleBg.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = toggleBg
    
    local thumb = Instance.new("Frame")
    thumb.Size = UDim2.new(0, 14, 0, 14)
    thumb.Position = isOn and UDim2.new(1, -16, 0, 2) or UDim2.new(0, 2, 0, 2)
    thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    thumb.BorderSizePixel = 0
    thumb.Parent = toggleBg
    
    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(1, 0)
    thumbCorner.Parent = thumb
end

-- // 8. ประกอบร่าง Panel ฝั่งซ้าย //
local LeftPanel1 = createPanel(ContentArea, 60, 170)
createRow(LeftPanel1, "Torment Tier", 10, true, "1")
createRow(LeftPanel1, "Auto Start", 40, false)
createToggle(LeftPanel1, 40, true)
createRow(LeftPanel1, "Status: In run", 65, false) -- สมมติว่าข้อความซ้อน
createRow(LeftPanel1, "Auto Replay", 90, false)
createToggle(LeftPanel1, 90, false)
createRow(LeftPanel1, "Auto Continue", 130, false)
createToggle(LeftPanel1, 130, true)

local LeftPanel2 = createPanel(ContentArea, 240, 150)
local title2 = Instance.new("TextLabel")
title2.Size = UDim2.new(1, -30, 0, 30)
title2.Position = UDim2.new(0, 15, 0, 5)
title2.BackgroundTransparency = 1
title2.Text = "📁 Path"
title2.TextColor3 = COLOR_TEXT
title2.Font = FontBold
title2.TextSize = 12
title2.TextXAlignment = Enum.TextXAlignment.Left
title2.Parent = LeftPanel2
createRow(LeftPanel2, "Auto Choose Path", 40, false)
createToggle(LeftPanel2, 40, true)
createRow(LeftPanel2, "Path Priority", 80, false)
createRow(LeftPanel2, "1  📦 Treasure", 110, true)

-- // 9. ประกอบร่าง Panel ฝั่งขวา (ใช้ Position X ขยับไปทางขวา) //
local RightPanel1 = createPanel(ContentArea, 60, 170)
RightPanel1.Position = UDim2.new(0, 390, 0, 60) -- ขยับไปขวา
RightPanel1.Size = UDim2.new(0, 340, 0, 170)

createRow(RightPanel1, "Target", 10, false)
createRow(RightPanel1, "Use Potion Below HP%", 40, false)
createRow(RightPanel1, "Prioritize Skills When...", 70, false)
createRow(RightPanel1, "Meditate When Out Of Energy", 130, false)
createToggle(RightPanel1, 130, true)

local RightPanel2 = createPanel(ContentArea, 240, 150)
RightPanel2.Position = UDim2.new(0, 390, 0, 240)
RightPanel2.Size = UDim2.new(0, 340, 0, 150)

local title4 = Instance.new("TextLabel")
title4.Size = UDim2.new(1, -30, 0, 30)
title4.Position = UDim2.new(0, 15, 0, 5)
title4.BackgroundTransparency = 1
title4.Text = "📋 Skill Rotation"
title4.TextColor3 = COLOR_TEXT
title4.Font = FontBold
title4.TextSize = 12
title4.TextXAlignment = Enum.TextXAlignment.Left
title4.Parent = RightPanel2
createRow(RightPanel2, "Use Rotation", 40, false)
createToggle(RightPanel2, 40, false)
createRow(RightPanel2, "Skill", 80, false)
createRow(RightPanel2, "Rotation", 110, false)

-- // เพิ่มปุ่มสำหรับเปิด/ปิดเมนู (เพื่อให้ทดสอบได้ง่าย) //
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 100, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.BackgroundColor3 = COLOR_ACCENT
ToggleButton.TextColor3 = COLOR_TEXT
ToggleButton.Font = FontBold
ToggleButton.Text = "เปิด/ปิด เมนู"
ToggleButton.Parent = ScreenGui

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
