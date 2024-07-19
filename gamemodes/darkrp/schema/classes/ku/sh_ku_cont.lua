-- КЮ.C3.CONTACT:[ID] - Связной (Лимита - 1)
CLASS.name = "КЮ.Связ"
CLASS.faction = FACTION_MPF

-- Может ли становиться классом
function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), 'КЮ.Связ')
end

if (SERVER) then


	-- При входе в класс (Смена класса)
	function CLASS:OnSet(client)
		local character = client:GetCharacter()

		character:SetName("C"
						.. ix.config.Get("city")
						.. ".КЮ.Связ:"
						.. character:GetData("cid", "UNKWN"))
	end

	-- При спавне класса (Каждый раз)
	function CLASS:OnSpawn(client)
		

		client:SetBodygroup(2, 1)
		client:SetBodygroup(4, 1)
		client:SetBodygroup(9, 1)
		client:SetBodygroup(10, 1)
		client:SetBodygroup(13, 1)
		client:SetBodygroup(16, 1)
	end
end
CLASS_KUCON = CLASS.index