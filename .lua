local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4 - This is a test script for AES, source code for testing script")
local T1 = wndw:Tab("Main")
local T2 = wndw:Tab("Upgrade")
local T3 = wndw:Tab("Chest & Item")
local T4 = wndw:Tab("Animal Changer")
local T7 = wndw:Tab("Server Manipulator")
local T8 = wndw:Tab("Custom Change Stats")
local T6 = wndw:Tab("Animal ESP")
local T5 = wndw:Tab("Leaderstats - FIXED")
local amount ={
	lv = 9e10,
	gem = 8000000000
}

local workspace = game:GetService("Workspace")
local client = game.Players.LocalPlayer
local skinHandler = {}
local animals = {}
local itms = {}
local tgl = false

local stats = T5:Label("Error label")
lib:AddTable(game:GetService("ReplicatedStorage")["AnimalsSkin"],skinHandler)
lib:AddTable(client["Consumables"],itms)

local function animalESP(tag)
       for i,v in pairs(workspace:GetDescendants()) do
          if v:FindFirstChild("TAG ESP") or v.Name == "TAG ESP" then
             v:Destroy()
          end
      end
   
        local BillboardGui = Instance.new('BillboardGui')
        local TextLabel = Instance.new('TextLabel')
        
        BillboardGui.Parent = tag
        BillboardGui.AlwaysOnTop = true
        BillboardGui.Size = UDim2.new(0, 50, 0, 50)
        BillboardGui.StudsOffset = Vector3.new(0,2,0)
        BillboardGui.Enabled = false
	     BillboardGui.Name = "TAG ESP"
	
        TextLabel.Parent = BillboardGui
        TextLabel.BackgroundColor3 = Color3.new(1,1,1)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.new(1, 0, 1, 0)
        TextLabel.Text = "<font color='rgb(255,255,0)'>" .. tag .. "</font>"
        TextLabel.TextColor3 = Color3.new(1,1,0)
        TextLabel.TextScaled = false
	     TextLabel.RichText = true
        TextLabel.Name = "UI 1"
end

local function cESP(str)
   for i,v in pairs(workspace:GetDescendants()) do
      if v:FindFirstChild("ANIMAL XRAY") or v.Name == "ANIMAL XRAY" then
         v:Destroy()
      end
   end

   if tgl == true then
      local esp = Instance.new("Highlight")
      esp.Name = "ANIMAL XRAY"
      esp.FillColor = Color3.new(0,1,0)
      esp.OutlineColor = Color3.new(1,1,1)
      esp.FillTransparency = 0
      esp.OutlineTransparency = 0
      esp.Adornee = str
      esp.Parent = str
      esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
   end
end

for i,v in pairs(workspace:GetChildren()) do
   if v:IsA("Model") and v.Name ~= "Model" and v.Name:find(" ") then
      table.insert(animals,v.Name)
  end
end

local function getGoldRebirth()
   return client["leaderstats"]["G Rebirth"]["Value"]
end

local function UserWarning(str,params)
	lib:WarnUser(str,{
		AutoClose = params[1],
		CanClick = params[2],
		Duration = params[3]
	})
end

local function ChangeStats(str,array)
	game:GetService("ReplicatedStorage")["Events"]["UpdateStatEvent"]:FireServer(str,tonumber(array))
end

--UserWarning("",{false,true,10})

local function getRebirth()
   return client["leaderstats"]["Rebirth"]["Value"]
end

local function getXP()
   return client["leaderstats"]["Xp"]["Value"]
end

local function getLevel()
   return client["leaderstats"]["Lv"]["Value"]
end

T6:Dropdown("Select animal",animals,function(value)
      _G.AnimalsESP = value or "Two Headed Dragon"
      for i,v in pairs(workspace:GetChildren()) do
          if v:IsA("Model") and v.Name ~= "Model" and v.Name:find(" ") then
            if v.Name == value then
               cESP(v)
               animalESP(v)
            end
          end
      end
end)

T6:Toggle("Enable XRAY",false,function(value)
      tgl = value
      for i,v in pairs(workspace:GetChildren()) do
          if v:IsA("Model") and v.Name ~= "Model" and v.Name:find(" ") then
            if v.Name == tostring(_G.AnimalsESP) then
               cESP(v)
            end
          end
      end
end)

T6:Toggle("Enable animal tag [ DISABLED ]",false,function(value)
      for i,v in pairs(workspace:GetDescendants()) do
          if v:FindFirstChild("TAG ESP") or v.Name == "TAG ESP" then
            v.Enabled = value
         end
      end
end)

T1:Toggle("Auto attack",false,function(value)
   _G.Attack = value
    while wait(1.5) do
      if _G.Attack == false then break end
      game:GetService("ReplicatedStorage")["Events"]["AttackEvent"]:FireServer()
    end
end)

T1:Toggle("Instant mission",false,function(value)
   _G.cm = value
    while wait() do
      if _G.cm == false then break end
      game:GetService("ReplicatedStorage")["Events"]["CompletedDailyQuestsEvent"]:FireServer()
      game:GetService("ReplicatedStorage")["Events"]["DailyQuestsEvent"]:FireServer(true)
    end
end)

T1:Toggle("Auto upgrade rarity",false,function(value)
   _G.upgrarerity = value
    while wait() do
      if _G.upgrarerity == false then break end
      game:GetService("ReplicatedStorage")["Events"]["UpgradeRarityEvent"]:FireServer()
    end
end)

T1:Toggle("Auto gold rebirth",false,function(value)
   _G.agr = value
    while wait() do
      if _G.agr == false then break end
      game:GetService("ReplicatedStorage")["Events"]["getGoldenRebEvent"]:FireServer()
    end
end)

T1:Toggle("Auto diamond rebirth",false,function(value)
   _G.adr = value
    while wait() do
      if _G.adr == false then break end
      game:GetService("ReplicatedStorage")["Events"]["getDiamondRebEvent"]:FireServer()
    end
end)

T1:Toggle("Auto rebirth",false,function(value)
   _G.rbrts = value
    while wait() do
      if _G.rbrts == false then break end
         game:GetService("ReplicatedStorage")["Events"]["RebirthEvent"]:FireServer()
    end
end)

T7:Button("EvoCoins config",function()
   ChangeStats("EvoCoins",9e9)
end)

T7:Button("EvoGems config",function()
   ChangeStats("evoGems",amount.gem)
end)

T1:Button("Ranged kill",function()
   UserWarning("dont be lazy, lil nigga",{true,false,10})
end)

T7:Button("Damage config",function()
   ChangeStats("DmgLevel",180000000000)
end)

T7:Toggle("Auto increase level",false,function(value)
   _G.lvconf = value
	while wait() do
		if _G.lvconf == false then break end
			amount.lv = amount.lv + 9e10
			ChangeStats("Lv",amount.lv)
	end
end)

T8:Dropdown("Select stats ( Testing only )",{"Damage","Evo Coins","Evo Gems","Level","Gold rebirths","Rebirths","XP","Health"},function(value)
	_G.custype = value
end)

T8:Textbox("Enter number value ( EXPERIMENT )",false,function(value)
	_G.cuschange = tonumber(value)
end)

T8:Button("Custom config",function()
	if _G.custype == "Damage" then
		ChangeStats("DmgLevel",_G.cuschange)
	elseif _G.custype == "Evo Coins" then
		ChangeStats("EvoCoins",_G.cuschange)
	elseif _G.custype == "Evo Gems" then
		ChangeStats("evoGems",_G.cuschange)
	elseif _G.custype == "Level" then
		ChangeStats("Lv",_G.cuschange)
	elseif _G.custype == "Gold rebirths" then
		ChangeStats("gRebirth",_G.cuschange)
		ChangeStats("Grebirth",_G.cuschange)
		ChangeStats("GRebirth",_G.cuschange)
	elseif _G.custype == "Rebirths" then
		ChangeStats("rebirthLevel",_G.cuschange)
		ChangeStats("RebirthLv",_G.cuschange)
	elseif _G.custype == "XP" then
		ChangeStats("xp",_G.cuschange)
	elseif _G.custype == "Health" then
		ChangeStats("Health",_G.cuschange)
	end
end)

T2:Dropdown("Select upgraded",{"DmgLevel","HpLevel","CritDmgLevel","CritRateLevel"},function(value)
      _G.upgtype = value
end)

T2:Toggle("Auto upgrade",false,function(value)
   _G.aupg = value
    while wait() do
      if _G.aupg == false then break end
      game:GetService("ReplicatedStorage")["Events"]["UpgradeStatEvent"]:FireServer(_G.upgtype,0)
    end
end)

T3:Dropdown("Select chest",itms,function(value)
      _G.ctype = value
end)

T3:Toggle("Auto open chest",false,function(value)
   _G.aoc = value
    while wait() do
      if _G.aoc == false then break end
      game:GetService("ReplicatedStorage")["Events"]["UseItemEvent"]:FireServer(_G.ctype)
    end
end)

T4:Dropdown("Select animals",skinHandler,function(value)
      _G.animaltype = value
end)

T4:Button("Change animal",function()
   game:GetService("ReplicatedStorage")["Events"]["ChangeRaceEvent"]:FireServer(_G.animaltype)
end)

task.spawn(function()
while wait() do
   stats:EditLabel("[ Your leaderstats ]\nLevel: " .. getLevel() .. "\nGolden Rebirth: " .. getGoldRebirth() .. "\nRebirth: " .. getRebirth() .. "\nXP: " .. getXP())
end
end)
