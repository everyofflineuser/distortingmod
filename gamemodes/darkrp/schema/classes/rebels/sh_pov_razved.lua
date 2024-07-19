-- Разведчик Повстанец (Лимита - 3)
CLASS.name = "Разведчик"
CLASS.faction = FACTION_RBL

if (SERVER) then
	-- При выходе с класса (Смена класса)
	function CLASS:OnLeave(client)
	end

	-- При входе в класс (Смена класса)
	function CLASS:OnSet(client)
		local character = client:GetCharacter()
	end

	-- При спавне класса (Каждый раз)
	function CLASS:OnSpawn(client)
		
	end
end

CLASS_PRAZ = CLASS.index