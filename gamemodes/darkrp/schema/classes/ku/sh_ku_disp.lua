-- КЮ.С3.DISPATCH:[ID] - Диспечер (Лимита - 1)
CLASS.name = "КЮ.Дисп"
CLASS.faction = FACTION_MPF

-- Может ли становиться классом
function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "КЮ.Дисп")
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
						.. ".КЮ.Дисп:"
						.. character:GetData("cid", "UNKWN"))
	end

	-- При спавне класса (Каждый раз)
	function CLASS:OnSpawn(client)

	end
end

CLASS_KUDISP = CLASS.index