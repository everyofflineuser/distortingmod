-- ПКЮ.С3.02:[ID] - Юнит 02 (Лимита - 4)
CLASS.name = "ПКЮ.02"
CLASS.faction = FACTION_MPF

-- Может ли становиться классом
function CLASS:CanSwitchTo(client)
	if client:GetPlayTime() >= 18000 then
		return true
	end
	return false
end

if (SERVER) then
	-- При выходе с класса (Смена класса)
	function CLASS:OnLeave(client)
	end

	-- При входе в класс (Смена класса)
	function CLASS:OnSet(client)
		local character = client:GetCharacter()

		character:SetName("C"
						.. ix.config.Get("city")
						.. ".ПКЮ.02:"
						.. character:GetData("cid", "UNKWN"))
	end

	-- При спавне класса (Каждый раз)
	function CLASS:OnSpawn(client)
	end
end

CLASS_PTT = CLASS.index