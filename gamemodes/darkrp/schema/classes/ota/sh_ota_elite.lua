-- OTA.C3.ELITE:[ID] - Элита (Лимита - 2)
CLASS.name = "ОТА.ELITE"
CLASS.faction = FACTION_OTA

-- Может ли становиться классом
function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "ОТА.ELITE")
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
						.. ".OTA.ELITE:"
						.. character:GetData("cid", "UNKWN"))
	end

	-- При спавне класса (Каждый раз)
	function CLASS:OnSpawn(client)
		
	end
end

CLASS_OE = CLASS.index