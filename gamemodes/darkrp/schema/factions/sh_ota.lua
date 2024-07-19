
FACTION.name = "OTA"
FACTION.description = "A transhuman Overwatch soldier produced by the Combine."
FACTION.color = Color(50, 100, 150)
FACTION.pay = 40
FACTION.models = {"models/player/combine_soldier.mdl"}
FACTION.isDefault = true
FACTION.isGloballyRecognized = true
FACTION.runSounds = {[0] = "NPC_CombineS.RunFootstepLeft", [1] = "NPC_CombineS.RunFootstepRight"}

function FACTION:OnCharacterCreated(client, character)
	local id = Schema:ZeroNumber(math.random(00001, 99999), 5)
	local inventory = character:GetInventory()

	character:SetData("cid", id)

	inventory:Add("cid", 1, {
		name = character:GetName(),
		id = id
	})

	character:SetName(character:GetName() .. ":" .. id)
end

function FACTION:GetDefaultName(client)
	return "C"
	.. ix.config.Get("city") 
	.. ".OTA.STORM:"
	.. Schema:ZeroNumber(math.random(1, 99999), 5), true
end

function FACTION:OnTransferred(character)
	character:SetName(self:GetDefaultName())
	character:SetModel(self.models[1])
end

function FACTION:OnNameChanged(client, oldValue, value)

end

FACTION_OTA = FACTION.index
