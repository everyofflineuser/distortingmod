-- КЮ.С3.OFC:[ID] - Офицер (Лимита - 1)
CLASS.name = "КЮ.ОфЦ"
CLASS.faction = FACTION_MPF

-- Может ли становиться классом
function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "КЮ.ОфЦ")
end

if (SERVER) then


	-- При входе в класс (Смена класса)
	function CLASS:OnSet(client)
		local character = client:GetCharacter()
		local character = client:GetCharacter()
		character:SetName("C"
						.. ix.config.Get("city")
						.. ".КЮ.ОфЦ:"
						.. character:GetData("cid", "UNKWN"))
	end
	-- При спавне класса (Каждый раз)
	function CLASS:OnSpawn(client)
		
	end
end

CLASS_KYOFC = CLASS.index