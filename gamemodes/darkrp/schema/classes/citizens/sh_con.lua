-- Консул (Лимит - 1)
CLASS.name = "Консул"
CLASS.faction = FACTION_CITIZEN

function CLASS:CanSwitchTo(client)
end

if (SERVER) then
    function CLASS:OnLeave(client)
    end

    function CLASS:OnSet(client)
    end

    function CLASS:OnSpawn(client)
    end
end

CLASS_CON = CLASS.index