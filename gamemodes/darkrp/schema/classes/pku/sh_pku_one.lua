-- ПКЮ.С3.01:[ID] - Юнит 01 (Лимита - 3)
CLASS.name = "ПКЮ.01"
CLASS.faction = FACTION_MPF

-- Может ли становиться классом
function CLASS:CanSwitchTo(client)
	if client:GetPlayTime() >= 36000 then
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
						.. ".ПКЮ.01:"
						.. character:GetData("cid", "UNKWN"))
	end

	-- При спавне класса (Каждый раз)
	function CLASS:OnSpawn(client)
	end
end

CLASS_PO = CLASS.index