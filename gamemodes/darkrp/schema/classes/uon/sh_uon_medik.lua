-- ЮОН.С3.MEDIC:[ID] - Медик (Лимита - 2)
CLASS.name = "ЮОН.МдК"
CLASS.faction = FACTION_MPF

-- Может ли становиться классом
function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "ЮОН.МдК")
end

if (SERVER) then

	-- При входе в класс (Смена класса)
	function CLASS:OnSet(client)
		local character = client:GetCharacter()
		local character = client:GetCharacter()
		character:SetName("C"
						.. ix.config.Get("city")
						.. ".ЮОН.МдК:"
						.. character:GetData("cid", "UNKWN"))
	end

	-- При спавне класса (Каждый раз)
	function CLASS:OnSpawn(client)
	end
end

CLASS_UMED = CLASS.index