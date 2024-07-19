-- ЮОН.C3.ENGINEER:[ID] - Инженер (Лимита - 2)
CLASS.name = "ЮОН.ИеР"
CLASS.faction = FACTION_MPF

-- Может ли становиться классом
function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "ЮОН.ИеР")
end

if (SERVER) then

	-- При входе в класс (Смена класса)
	function CLASS:OnSet(client)
		local character = client:GetCharacter()

		character:SetName("C"
						.. ix.config.Get("city")
						.. ".ЮОН.ИеР:"
						.. character:GetData("cid", "UNKWN"))

	end

	-- При спавне класса (Каждый раз)
	function CLASS:OnSpawn(client)
		
	end
end

CLASS_UENG = CLASS.index