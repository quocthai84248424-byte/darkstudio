local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Skibidi Hub | Blox Fruits",
   LoadingTitle = "Skibidi Edition",
   LoadingSubtitle = "by ilovedog",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SkibidiConfig", -- Đổi tên folder lưu config
      FileName = "SkibidiHub"
   },
   KeySystem = false 
})

-- [[ BIẾN LOGIC ]] --
_G.AutoFarm = false
_G.AttackRange = 30 

-- [[ HÀM LOGIC FARM (CHẠY NGẦM) ]] --
spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                -- 1. Tăng tầm đánh (Big Hitbox)
                local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if Tool and Tool:FindFirstChild("Handle") then
                    Tool.Handle.Size = Vector3.new(_G.AttackRange, _G.AttackRange, _G.AttackRange)
                    Tool.Handle.CanCollide = false
                end

                -- 2. GOM QUÁI DƯỚI CHÂN (Sửa ở đây)
                for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        -- CFrame.new(0, -5, 0) sẽ đưa quái xuống thấp hơn chân bạn 5 mét
                        v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -5, 0)
                        v.HumanoidRootPart.CanCollide = false
                    end
                end
            end)
        end
    end
end)

-- [[ GIAO DIỆN MENU ]] --
Rayfield:Notify({
   Title = "Skibidi Hub Loaded",
   Content = "Chào mừng bạn, chúc bạn có trải nghiệm vui vẻ! Script bởi ilovedog",
   Duration = 5,
   Image = 4483345998,
})

local MainTab = Window:CreateTab("Auto Farm", 4483362458) 
local Section = MainTab:CreateSection("Farm Level")

MainTab:CreateToggle({
   Name = "Auto Farm + Bring Mob",
   CurrentValue = false,
   Flag = "AutoFarmToggle", 
   Callback = function(Value)
      _G.AutoFarm = Value
      if Value then
          Rayfield:Notify({Title = "Skibidi Hub", Content = "Đã bật Auto Farm & Gom quái", Duration = 2})
      end
   end,
})

-- Thanh chỉnh độ xa của đòn đánh
MainTab:CreateSlider({
   Name = "Attack Range (Tầm đánh)",
   Info = "Chỉnh tầm đánh xa của vũ khí",
   Min = 10,
   Max = 100,
   Default = 30,
   Color = Color3.fromRGB(255, 255, 255),
   Increment = 1,
   ValueName = "Range",
   Callback = function(Value)
      _G.AttackRange = Value
   end,
})

local MiscTab = Window:CreateTab("Misc", 4483345998)
MiscTab:CreateButton({
   Name = "Nhập mã Code (Full Codes)",
   Callback = function()
       print("Skibidi Hub: Đã nhập code")
   end,
})

local SettingsTab = Window:CreateTab("Settings", 4483345998)
SettingsTab:CreateButton({
   Name = "Tắt Menu (Destroy UI)",
   Callback = function()
       Rayfield:Destroy()
   end,
})

