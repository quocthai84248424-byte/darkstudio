local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "skibidi Clone | Blox Fruits",
   LoadingTitle = "Skibidi Edition",
   LoadingSubtitle = "by ilovedog",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "HuTaoConfig",
      FileName = "SkibidiHub"
   },
   KeySystem = false -- Bạn có thể bật true nếu muốn làm hệ thống Key
})

-- Thông báo chào mừng phong cách Hu Tao
Rayfield:Notify({
   Title = "Skibidi Hub Loaded",
   Content = "Chào mừng bạn, chúc bạn cày cuốc vui vẻ!",
   Duration = 5,
   Image = 4483345998,
   Actions = {
      Ignore = {
         Name = "Đồng ý!",
         Callback = function()
         print("Người dùng đã nhấn xác nhận")
      end
   },
},
})

-- Biến logic
_G.AutoFarm = false

-- Tab chính
local MainTab = Window:CreateTab("Auto Farm", 4483362458) -- Icon mặc định

local Section = MainTab:CreateSection("Farm Level")

MainTab:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
      _G.AutoFarm = Value
      if Value then
          print("Đã kích hoạt Auto Farm Level")
          -- Thêm logic farm của bạn vào đây
      end
   end,
})

-- Tab hỗ trợ (Misc)
local MiscTab = Window:CreateTab("Misc", 4483345998)

MiscTab:CreateButton({
   Name = "Nhập mã Code (Full Codes)",
   Callback = function()
       -- Logic tự động nhập code cho người dùng
       print("Đã nhập toàn bộ code x2 EXP")
   end,
})

-- Tab Cài đặt (Settings)
local SettingsTab = Window:CreateTab("Settings", 4483345998)

SettingsTab:CreateButton({
   Name = "Tắt Menu (Destroy UI)",
   Callback = function()
       Rayfield:Destroy()
   end,
})
