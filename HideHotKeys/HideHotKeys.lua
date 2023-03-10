
HideHotKeys_Frame = nil

-- default enabled
if (HideHotKeys_HK_Hidden == nil) then
	HideHotKeys_HK_Hidden = true
end

-- default disabled
if (HideHotKeys_MN_Hidden == nil) then
	HideHotKeys_MN_Hidden = false
end



function HideHotKeys_OnLoad(self)
	HideHotKeys_Frame = self
	
	self:SetScript("OnEvent", HideHotKeys_EventHandler)
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	-- register a hook for action button update functions
	hooksecurefunc("ActionButton_UpdateHotkeys", HideHotKeys_ActionButton_UpdateHotkeys)
	hooksecurefunc("ActionButton_Update", HideHotKeys_ActionButton_Update)

	SLASH_HIDEHOTKEYSHK1 = "/hhk"
	SlashCmdList["HIDEHOTKEYSHK"] = HideHotKeys_HK_Slash

	SLASH_HIDEHOTKEYSMN1 = "/hmn"
	SlashCmdList["HIDEHOTKEYSMN"] = HideHotKeys_MN_Slash
	
	DEFAULT_CHAT_FRAME:AddMessage("HideHotKeys loaded! Type /hhk to toggle hotkey text, /hmn to toggle macro name text", 1, 1, 1, 2386, 5)
end


function HideHotKeys_EventHandler(self, event)
	if (event == "PLAYER_ENTERING_WORLD") then
		HideHotKeys_Update()
	end
end


-- the default ActionButton_UpdateHotkeys function will reget the first hotkey associated with a button
-- and show/hide if there is a bind or not, so we will rehide it if neccesary after the default function runs
function HideHotKeys_ActionButton_UpdateHotkeys(self)
	local hkf = getglobal(self:GetName().."HotKey")
	
	if (hkf) then
		if (HideHotKeys_HK_Hidden == true and hkf:IsShown() == 1) then
			hkf:Hide()
		elseif (HideHotKeys_HK_Hidden == false and hkf:IsShown() == nil) then
			hkf:Show()
		end
	end
end


-- same with macro names, except i don't see any example of it actually being hidden/shown in the default UI
-- the macro name frame only has its text property changed to a space to "hide" it, but we will do this anyway
function HideHotKeys_ActionButton_Update(self)
	local mnf = getglobal(self:GetName().."Name")
	if (mnf) then
		if (HideHotKeys_MN_Hidden == true and mnf:IsShown() == 1) then
			mnf:Hide()
		elseif (HideHotKeys_MN_Hidden == false and mnf:IsShown() == nil) then
			mnf:Show()
		end
	end
end


--rehides if they should be hidden, called whenever the UI reshows them
function HideHotKeys_Update()
		if (HideHotKeys_HK_Hidden == false) then
			HideHotKeys_HK_ShowAll()
		else
			HideHotKeys_HK_HideAll()
		end
		if (HideHotKeys_MN_Hidden == false) then
			HideHotKeys_MN_ShowAll()
		else
			HideHotKeys_MN_HideAll()
		end
end


function HideHotKeys_HK_HideAll()
	HideHotKeys_HideBar("Action", "HotKey")
	HideHotKeys_HideBar("BonusAction", "HotKey")
	HideHotKeys_HideBar("MultiBarBottomLeft", "HotKey")
	HideHotKeys_HideBar("MultiBarBottomRight", "HotKey")
	HideHotKeys_HideBar("MultiBarRight", "HotKey")
	HideHotKeys_HideBar("MultiBarLeft", "HotKey")
	HideHotKeys_HK_Hidden = true
end


function HideHotKeys_HK_ShowAll()
	HideHotKeys_ShowBar("Action", "HotKey")
	HideHotKeys_ShowBar("BonusAction", "HotKey")
	HideHotKeys_ShowBar("MultiBarBottomLeft", "HotKey")
	HideHotKeys_ShowBar("MultiBarBottomRight", "HotKey")
	HideHotKeys_ShowBar("MultiBarRight", "HotKey")
	HideHotKeys_ShowBar("MultiBarLeft", "HotKey")
	HideHotKeys_HK_Hidden = false
end


function HideHotKeys_HK_Slash()
	if (HideHotKeys_HK_Hidden == true) then
		HideHotKeys_HK_ShowAll()
	else
		HideHotKeys_HK_HideAll()
	end
end


function HideHotKeys_MN_HideAll()
	HideHotKeys_HideBar("Action", "Name")
	HideHotKeys_HideBar("BonusAction", "Name")
	HideHotKeys_HideBar("MultiBarBottomLeft", "Name")
	HideHotKeys_HideBar("MultiBarBottomRight", "Name")
	HideHotKeys_HideBar("MultiBarRight", "Name")
	HideHotKeys_HideBar("MultiBarLeft", "Name")
	HideHotKeys_MN_Hidden = true
end


function HideHotKeys_MN_ShowAll()
	HideHotKeys_ShowBar("Action", "Name")
	HideHotKeys_ShowBar("BonusAction", "Name")
	HideHotKeys_ShowBar("MultiBarBottomLeft", "Name")
	HideHotKeys_ShowBar("MultiBarBottomRight", "Name")
	HideHotKeys_ShowBar("MultiBarRight", "Name")
	HideHotKeys_ShowBar("MultiBarLeft", "Name")
	HideHotKeys_MN_Hidden = false
end


function HideHotKeys_MN_Slash()
	if (HideHotKeys_MN_Hidden == true) then
		HideHotKeys_MN_ShowAll()
	else
		HideHotKeys_MN_HideAll()
	end
end


function HideHotKeys_HideBar(b, f)
	for i = 1, 12 do
		local o = getglobal(b.."Button"..i..f)
		if (o) then
			o:Hide()
		end
	end
end


function HideHotKeys_ShowBar(b, f)
	for i = 1, 12 do
		local o = getglobal(b.."Button"..i..f)
		if (o) then
			o:Show()
		end
	end
end
