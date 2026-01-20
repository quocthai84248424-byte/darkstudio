local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

local Running = true
local Flying = true
local Speed = 150
local Target = nil

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ProHub_Ultimate"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.1, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 110)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0.05, 0)
Title.Size = UDim2.new(0.5, 0, 0.25, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "PRO HUB"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(0.82, 0, 0.05, 0)
CloseBtn.Size = UDim2.new(0.15, 0, 0.2, 0)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.TextSize = 14

local MiniBtn = Instance.new("TextButton")
MiniBtn.Parent = MainFrame
MiniBtn.BackgroundTransparency = 1
MiniBtn.Position = UDim2.new(0.65, 0, 0.05, 0)
MiniBtn.Size = UDim2.new(0.15, 0, 0.2, 0)
MiniBtn.Text = "-"
MiniBtn.Font = Enum.Font.GothamBold
MiniBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MiniBtn.TextSize = 18

local SpeedInput = Instance.new("TextBox")
SpeedInput.Parent = MainFrame
SpeedInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SpeedInput.Position = UDim2.new(0.1, 0, 0.35, 0)
SpeedInput.Size = UDim2.new(0.8, 0, 0.25, 0)
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.Text = tostring(Speed)
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.TextSize = 12

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 5)
SpeedCorner.Parent = SpeedInput

local Status = Instance.new("TextLabel")
Status.Parent = MainFrame
Status.BackgroundTransparency = 1
Status.Position = UDim2.new(0, 0, 0.7, 0)
Status.Size = UDim2.new(1, 0, 0.25, 0)
Status.Font = Enum.Font.GothamItalic
Status.Text = "Scanning Targets..."
Status.TextColor3 = Color3.fromRGB(180, 180, 180)
Status.TextSize = 10

local OpenButton = Instance.new("ImageButton")
OpenButton.Name = "OpenButton"
OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenButton.Position = UDim2.new(0.02, 0, 0.85, 0)
OpenButton.Size = UDim2.new(0, 55, 0, 55)
OpenButton.Visible = false
OpenButton.Image = "rbxassetid://11252061280"
OpenButton.ScaleType = Enum.ScaleType.Fit

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 12)
ButtonCorner.Parent = OpenButton

local function ToggleUI()
    local Visible = MainFrame.Visible
    MainFrame.Visible = not Visible
    OpenButton.Visible = Visible
end

MiniBtn.MouseButton1Click:Connect(ToggleUI)
OpenButton.MouseButton1Click:Connect(ToggleUI)

CloseBtn.MouseButton1Click:Connect(function()
    Running = false
    ScreenGui:Destroy()
end)

SpeedInput.FocusLost:Connect(function()
    local Val = tonumber(SpeedInput.Text)
    if Val then Speed = Val else SpeedInput.Text = tostring(Speed) end
end)

local BV = Instance.new("BodyVelocity")
BV.MaxForce = Vector3.new(1e6, 1e6, 1e6)
local BG = Instance.new("BodyGyro")
BG.MaxTorque = Vector3.new(1e6, 1e6, 1e6)

local function GetClosest()
    local Closest = nil
    local Dist = math.huge
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local Mag = (v.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if Mag < Dist then
                Dist = Mag
                Closest = v
            end
        end
    end
    return Closest
end

RunService.RenderStepped:Connect(function()
    if not Running then return end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        BV.Parent = LocalPlayer.Character.HumanoidRootPart
        BG.Parent = LocalPlayer.Character.HumanoidRootPart
        Target = GetClosest()
        if Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
            Status.Text = "Target: " .. Target.Name
            local TPos = Target.Character.HumanoidRootPart.Position
            local Dir = (TPos - LocalPlayer.Character.HumanoidRootPart.Position).Unit
            BV.Velocity = Dir * Speed
            BG.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, TPos)
        else
            Status.Text = "No Target Found"
            BV.Velocity = Vector3.new(0, 0, 0)
        end
        if LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid:ChangeState(11)
        end
    end
end)
