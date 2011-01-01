﻿------------------------------------------------------------------------
--	First Time Launch and On Login file
------------------------------------------------------------------------

local function install()
	SetCVar("buffDurations", 1)
	SetCVar("mapQuestDifficulty", 1)
	SetCVar("scriptErrors", 0)
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("screenshotQuality", 10)
	SetCVar("cameraDistanceMax", 50)
	SetCVar("cameraDistanceMaxFactor", 3.4)
	SetCVar("chatMouseScroll", 1)
	SetCVar("chatStyle", "classic")
	SetCVar("WholeChatWindowClickable", 0)
	SetCVar("ConversationMode", "inline")
	SetCVar("showTutorials", 0)
	SetCVar("showNewbieTips", 0)
	SetCVar("autoQuestWatch", 1)
	SetCVar("autoQuestProgress", 1)
	SetCVar("showLootSpam", 1)
	SetCVar("UberTooltips", 1)
	SetCVar("removeChatDelay", 1)
	SetCVar("gxTextureCacheSize", 512)
	
	-- Var ok, now setting chat frames if using Tukui chats.	
	if (TukuiCF.chat.enable == true) and (not IsAddOnLoaded("Prat") or not IsAddOnLoaded("Chatter")) then					
		FCF_ResetChatWindows()
		FCF_SetLocked(ChatFrame1, 1)
		FCF_DockFrame(ChatFrame2)
		FCF_SetLocked(ChatFrame2, 1)
		
		if TukuiCF["chat"].rightchat == true then
			FCF_OpenNewWindow(LOOT)
			FCF_UnDockFrame(ChatFrame3)
			FCF_SetLocked(ChatFrame3, 1)
			ChatFrame3:Show()			
		end
				
		for i = 1, NUM_CHAT_WINDOWS do
			local frame = _G[format("ChatFrame%s", i)]
			local chatFrameId = frame:GetID()
			local chatName = FCF_GetChatWindowInfo(chatFrameId)
			
			_G["ChatFrame"..i]:SetSize(TukuiDB.Scale(TukuiCF["chat"].chatwidth - 5), TukuiDB.Scale(TukuiCF["chat"].chatheight))
			
			-- this is the default width and height of tukui chats.
			SetChatWindowSavedDimensions(chatFrameId, TukuiDB.Scale(TukuiCF["chat"].chatwidth + -4), TukuiDB.Scale(TukuiCF["chat"].chatheight))
			
			-- move general bottom left
			if i == 1 then
				frame:ClearAllPoints()
				frame:SetPoint("BOTTOMLEFT", ChatLBackground, "BOTTOMLEFT", TukuiDB.Scale(2), 0)
			elseif i == 3 and TukuiCF["chat"].rightchat == true then
				frame:ClearAllPoints()
				frame:SetPoint("BOTTOMLEFT", ChatRBackground, "BOTTOMLEFT", TukuiDB.Scale(2), 0)			
			end
					
			-- save new default position and dimension
			FCF_SavePositionAndDimensions(frame)
			
			-- set default tukui font size
			FCF_SetChatWindowFontSize(nil, frame, 12)
			
			-- rename windows general because moved to chat #3
			if i == 1 then
				FCF_SetWindowName(frame, GENERAL)
			elseif i == 2 then
				FCF_SetWindowName(frame, GUILD_EVENT_LOG)
			elseif i == 3 and TukuiCF["chat"].rightchat == true then 
				FCF_SetWindowName(frame, LOOT.." / "..TRADE) 
			end
		end
		
		ChatFrame_RemoveAllMessageGroups(ChatFrame1)
		ChatFrame_AddMessageGroup(ChatFrame1, "SAY")
		ChatFrame_AddMessageGroup(ChatFrame1, "EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "YELL")
		ChatFrame_AddMessageGroup(ChatFrame1, "GUILD")
		ChatFrame_AddMessageGroup(ChatFrame1, "OFFICER")
		ChatFrame_AddMessageGroup(ChatFrame1, "GUILD_ACHIEVEMENT")
		ChatFrame_AddMessageGroup(ChatFrame1, "WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_SAY")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_YELL")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "PARTY")
		ChatFrame_AddMessageGroup(ChatFrame1, "PARTY_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID_WARNING")
		ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND")
		ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_HORDE")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_ALLIANCE")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_NEUTRAL")
		ChatFrame_AddMessageGroup(ChatFrame1, "SYSTEM")
		ChatFrame_AddMessageGroup(ChatFrame1, "ERRORS")
		ChatFrame_AddMessageGroup(ChatFrame1, "AFK")
		ChatFrame_AddMessageGroup(ChatFrame1, "DND")
		ChatFrame_AddMessageGroup(ChatFrame1, "IGNORED")
		ChatFrame_AddMessageGroup(ChatFrame1, "ACHIEVEMENT")
		ChatFrame_AddMessageGroup(ChatFrame1, "BN_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "BN_CONVERSATION")
		ChatFrame_AddMessageGroup(ChatFrame1, "BN_INLINE_TOAST_ALERT")
		
		if TukuiCF["chat"].rightchat == true then
			ChatFrame_RemoveAllMessageGroups(ChatFrame3)	
			ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_FACTION_CHANGE")
			ChatFrame_AddMessageGroup(ChatFrame3, "SKILL")
			ChatFrame_AddMessageGroup(ChatFrame3, "LOOT")
			ChatFrame_AddMessageGroup(ChatFrame3, "MONEY")
			ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_XP_GAIN")
			ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_HONOR_GAIN")
			ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_GUILD_XP_GAIN")
			ChatFrame_AddChannel(ChatFrame1, "General")
			ChatFrame_RemoveChannel(ChatFrame1, "Trade")
			ChatFrame_AddChannel(ChatFrame3, "Trade")
			ChatFrame_AddChannel(ChatFrame1, "LocalDefense")
			ChatFrame_AddChannel(ChatFrame1, "GuildRecruitment")
			ChatFrame_AddChannel(ChatFrame1, "LookingForGroup")
		else
			ChatFrame_AddMessageGroup(ChatFrame1, "LOOT")
			ChatFrame_AddMessageGroup(ChatFrame1, "MONEY")	
			ChatFrame_AddMessageGroup(ChatFrame1, "SKILL")
			ChatFrame_AddMessageGroup(ChatFrame1, "COMBAT_XP_GAIN")
			ChatFrame_AddMessageGroup(ChatFrame1, "COMBAT_GUILD_XP_GAIN")
			ChatFrame_AddMessageGroup(ChatFrame1, "COMBAT_HONOR_GAIN")
			ChatFrame_AddMessageGroup(ChatFrame1, "COMBAT_FACTION_CHANGE")
			ChatFrame_AddChannel(ChatFrame1, "General")
			ChatFrame_RemoveChannel(ChatFrame3, "Trade")
			ChatFrame_AddChannel(ChatFrame1, "Trade")
			ChatFrame_AddChannel(ChatFrame1, "LocalDefense")
			ChatFrame_AddChannel(ChatFrame1, "GuildRecruitment")
			ChatFrame_AddChannel(ChatFrame1, "LookingForGroup")
		end
		
		if TukuiDB.myname == "Elv" then
			--keep losing my god damn channels everytime i resetui
			ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, "tystank")
			ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, "tys")
			ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, "crusaderaura")
			ChangeChatColor("CHANNEL5", 147/255, 112/255, 219/255)
			ChangeChatColor("CHANNEL6", 139/255, 115/255, 85/255)
			ChangeChatColor("CHANNEL7", RAID_CLASS_COLORS["PALADIN"].r, RAID_CLASS_COLORS["PALADIN"].g, RAID_CLASS_COLORS["PALADIN"].b)
			SetCVar("scriptErrors", 1)
		end	
		
		-- enable classcolor automatically on login and on each character without doing /configure each time.
		ToggleChatColorNamesByClassGroup(true, "SAY")
		ToggleChatColorNamesByClassGroup(true, "EMOTE")
		ToggleChatColorNamesByClassGroup(true, "YELL")
		ToggleChatColorNamesByClassGroup(true, "GUILD")
		ToggleChatColorNamesByClassGroup(true, "OFFICER")
		ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "WHISPER")
		ToggleChatColorNamesByClassGroup(true, "PARTY")
		ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID")
		ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
		ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
		ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")	
		ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL6")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL7")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL8")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL9")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL10")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL11")
		
		--Adjust Chat Colors
			--General
			ChangeChatColor("CHANNEL1", 195/255, 230/255, 232/255)
			--Trade
			ChangeChatColor("CHANNEL2", 232/255, 158/255, 121/255)
			--Local Defense
			ChangeChatColor("CHANNEL3", 232/255, 228/255, 121/255)
	end
		   
	ElvUIInstalled = true

	-- reset unitframe position
	if TukuiCF["unitframes"].positionbychar == true then
		TukuiUFpos = {}
	else
		TukuiData.ufpos = {}
	end
	
	ReloadUI()
end

local function DisableTukui()
	DisableAddOn("Tukui"); 
	ReloadUI()
end

------------------------------------------------------------------------
--	Popups
------------------------------------------------------------------------

StaticPopupDialogs["DISABLE_UI"] = {
	text = tukuilocal.popup_disableui,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = DisableTukui,
	timeout = 0,
	whileDead = 1,
}

StaticPopupDialogs["INSTALL_UI"] = {
	text = tukuilocal.popup_install,
	button1 = ACCEPT,
	button2 = CANCEL,
    OnAccept = install,
	OnCancel = function() TukuiMinimal = true end,
    timeout = 0,
    whileDead = 1,
}

StaticPopupDialogs["DISABLE_RAID"] = {
	text = tukuilocal.popup_2raidactive,
	button1 = "DPS - TANK",
	button2 = "HEAL",
	OnAccept = function() DisableAddOn("Tukui_Heal_Layout") EnableAddOn("Tukui_Dps_Layout") ReloadUI() end,
	OnCancel = function() EnableAddOn("Tukui_Heal_Layout") DisableAddOn("Tukui_Dps_Layout") ReloadUI() end,
	timeout = 0,
	whileDead = 1,
}

StaticPopupDialogs["CHAT_WARN"] = {
	text = tukuilocal.popup_rightchatwarn,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = install,
	timeout = 0,
	whileDead = 1,
}

------------------------------------------------------------------------
--	On login function, look for some infos!
------------------------------------------------------------------------

local TukuiOnLogon = CreateFrame("Frame")
TukuiOnLogon:RegisterEvent("PLAYER_ENTERING_WORLD")
TukuiOnLogon:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	if TukuiDB.getscreenresolution == "800x600"
		or TukuiDB.getscreenresolution == "1024x768"
		or TukuiDB.getscreenresolution == "720x576"
		or TukuiDB.getscreenresolution == "1024x600" -- eeepc reso
		or TukuiDB.getscreenresolution == "1152x864" then
			SetCVar("useUiScale", 0)
			StaticPopup_Show("DISABLE_UI")
	else
		SetCVar("useUiScale", 1)
		if TukuiCF["general"].multisampleprotect == true then
			SetMultisampleFormat(1)
		end
		SetCVar("uiScale", TukuiCF["general"].uiscale)
		if (TukuiData == nil) then TukuiData = {} end

		if ElvUIInstalled ~= true then
			StaticPopup_Show("INSTALL_UI")
		end
	end
	
	if (IsAddOnLoaded("Tukui_Dps_Layout") and IsAddOnLoaded("Tukui_Heal_Layout")) then
		StaticPopup_Show("DISABLE_RAID")
	end
		
	if TukuiCF["arena"].unitframes == true then
		SetCVar("showArenaEnemyFrames", 0)
	end
	
	TukuiChatLIn = true
	TukuiChatRIn = true
	

	local chatrightfound = false
	for i = 1, NUM_CHAT_WINDOWS do
		local chat = _G[format("ChatFrame%s", i)]
		local tab = _G[format("ChatFrame%sTab", i)]
		local id = chat:GetID()
		local name = FCF_GetChatWindowInfo(id)
		local point = GetChatWindowSavedPosition(id)
		local _, fontSize = FCF_GetChatWindowInfo(id)
		local button = _G[format("ButtonCF%d", i)]
		local _, _, _, _, _, _, _, _, docked, _ = GetChatWindowInfo(id)
		
		if point == "BOTTOMRIGHT" and TukuiCF["chat"].rightchat == true and chat:IsShown() and docked == nil then
			chatrightfound = true
			tab:SetParent(ChatRBackground)
		end
		
		if TukuiCF["chat"].rightchat ~= true then chatrightfound = true end
		
		if i == NUM_CHAT_WINDOWS and chatrightfound == false and not StaticPopup1:IsShown() then
			StaticPopup_Show("CHAT_WARN")
		end

	end
	GeneralDockManager:SetParent(ChatLBackground)
	
	--Fixing fucked up border on right chat button, really do not understand why this is happening
	if TukuiCF["chat"].rightchat == true and TukuiCF["chat"].showbackdrop == true then
		if not ButtonCF3 then return end
		local x = CreateFrame("Frame", nil, ChatFrame3Tab)
		x:SetAllPoints(ButtonCF3)
		TukuiDB.SetTemplate(x)
		x:SetBackdropColor(0,0,0,0)
	end
	
	print(tukuilocal.core_welcome2)
end)

local eventcount = 0
local TukuiInGame = CreateFrame("Frame")
TukuiInGame:RegisterAllEvents()
TukuiInGame:SetScript("OnEvent", function(self, event)
	eventcount = eventcount + 1
	if eventcount == 250 then
		self:UnregisterAllEvents()
		eventcount = nil
		collectgarbage("collect")
		return
	end
end)

------------------------------------------------------------------------
--	UI HELP
------------------------------------------------------------------------

-- Print Help Messages
local function UIHelp()
	print(" ")
	print(tukuilocal.core_uihelp1)
	print(tukuilocal.core_uihelp2)
	print(tukuilocal.core_uihelp3)
	print(tukuilocal.core_uihelp4)
	print(tukuilocal.core_uihelp5)
	print(tukuilocal.core_uihelp6)
	print(tukuilocal.core_uihelp7)
	print(tukuilocal.core_uihelp8)
	print(tukuilocal.core_uihelp9)
	print(tukuilocal.core_uihelp10)
	print(tukuilocal.core_uihelp11)
	print(tukuilocal.core_uihelp12)
	print(tukuilocal.core_uihelp13)
	print(tukuilocal.core_uihelp15)
	print(tukuilocal.core_uihelp16)
	print(tukuilocal.core_uihelp17)
	print(tukuilocal.core_uihelp18)
	print(tukuilocal.core_uihelp19)
	print(tukuilocal.core_uihelp20)
	print(" ")
	print(tukuilocal.core_uihelp14)
end

SLASH_UIHELP1 = "/UIHelp"
SlashCmdList["UIHELP"] = UIHelp

SLASH_CONFIGURE1 = "/resetui"
SlashCmdList.CONFIGURE = function() StaticPopup_Show("INSTALL_UI") end


