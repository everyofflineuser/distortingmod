-- OTA.C3.STORM:[ID] - Штурмовик (Лимита - 2)
CLASS.name = "ОТА.Штурман"
CLASS.faction = FACTION_OTA
CLASS.isDefault = true

-- Может ли становиться классом
function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "ОТА.Штурман")
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
						.. ".OTA.Штурман:"
						.. character:GetData("cid", "UNKWN"))
	end

	-- При спавне класса (Каждый раз)
	function CLASS:OnSpawn(client)
		
	end
end

CLASS_OS = CLASS.index