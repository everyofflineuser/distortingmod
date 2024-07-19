-- ЮОН.C3.ASSAULT:[ID] - Штурмовик (Лимита - 3)
CLASS.name = "ЮОН.ШрК"
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
						.. ".ЮОН.ШрК:"
						.. character:GetData("cid", "UNKWN"))
	end

	-- При спавне класса (Каждый раз)
	function CLASS:OnSpawn(client)

	end
end

CLASS_UASS = CLASS.index