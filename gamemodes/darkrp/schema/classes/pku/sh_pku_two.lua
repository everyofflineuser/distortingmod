CLASS.name = "ПКЮ.02"
CLASS.faction = FACTION_MPF

function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "ПКЮ.02")
end

function CLASS:OnSpawn(client)
	client:SetBodygroup(2, 1)
	client:SetBodygroup(4, 1)
	client:SetBodygroup(9, 1)
	client:SetBodygroup(10, 1)
	client:SetBodygroup(13, 1)
	client:SetBodygroup(16, 1)
end

CLASS_PTT = CLASS.index