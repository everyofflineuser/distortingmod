-- OTA.C3.NOWA:[ID] - Нова (Лимита - 2 )
CLASS.name = "ОТА.NOVA"
CLASS.faction = FACTION_OTA

-- Может ли становиться классом
function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "ОТА.NOVA")
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
						.. ".OTA.NOVA:"
						.. character:GetData("cid", "UNKWN"))
	end

	-- При спавне класса (Каждый раз)
	function CLASS:OnSpawn(client)
		local inventory = client:GetCharacter():GetInventory()

		if (!inventory:HasItem("smg1ammo")) then
			inventory:Add("smg1ammo", 2)
		end

		if (!inventory:HasItem("pistolammo")) then
			inventory:Add("pistolammo", 2)
		end
	end
end

CLASS_ON = CLASS.index