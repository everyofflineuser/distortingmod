-- ПКЮ.С3.03:[ID] (ID Виден только альянсу) - Юнит 03 (Лимита - 5)
CLASS.name = "ПКЮ.03"
CLASS.faction = FACTION_MPF
CLASS.isDefault = true

-- Может ли становиться классом
function CLASS:CanSwitchTo(client)
	if client:GetPlayTime() >= 1800 then
		return true
	end
	return false
end

if (SERVER) then

	-- При входе в класс (Смена класса)
	function CLASS:OnSet(client)
		local character = client:GetCharacter()
		character:SetName("C"
						.. ix.config.Get("city")
						.. ".ПКЮ.03:"
						.. character:GetData("cid", "UNKWN"))
	end

	-- При спавне класса (Каждый раз)
	function CLASS:OnSpawn(client)
	end
end

CLASS_PTH = CLASS.index