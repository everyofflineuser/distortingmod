-- OTA.C3.JAGER:[ID] - Джаггернаут (Лимита - 2)
CLASS.name = "ОТА.JAGER"
CLASS.faction = FACTION_OTA

-- Может ли становиться классом
function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "ОТА.JAGER")
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
						.. ".OTA.JAGER:"
						.. character:GetData("cid", "UNKWN"))
	end

	-- При спавне класса (Каждый раз)
	function CLASS:OnSpawn(client)
		
	end
end

CLASS_OG = CLASS.index