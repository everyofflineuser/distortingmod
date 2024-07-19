-- КЮ.C3.SEC:[ID] - Командир сектора (Лимита - 1)
CLASS.name = "КЮ.КС"
CLASS.faction = FACTION_MPF

-- Может ли становиться классом
function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "КЮ.КС")
end

if (SERVER) then


	-- При входе в класс (Смена класса)
	function CLASS:OnSet(client)
		local character = client:GetCharacter()
		local character = client:GetCharacter()
		character:SetName("C"
						.. ix.config.Get("city")
						.. ".КЮ.КС:"
						.. character:GetData("cid", "UNKWN"))
	end

	-- При спавне класса (Каждый раз)
	function CLASS:OnSpawn(client)
		

		client:SetBodygroup(0, 5)
		client:SetBodygroup(2, 1)
		client:SetBodygroup(3, 7)
		client:SetBodygroup(4, 5)
		client:SetBodygroup(9, 1)
		client:SetBodygroup(10, 1)
	end
end

CLASS_KUCS = CLASS.index