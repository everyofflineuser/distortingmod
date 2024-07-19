
FACTION.name = "Гражданская Оборона"
FACTION.description = "Подразделение городской полиции, работающее в режиме гражданской обороны."
FACTION.color = Color(50, 100, 150)
FACTION.pay = 10
FACTION.models = {"models/conceptbine_policeforce/conceptpolice_nemez_pm1.mdl"}
FACTION.weapons = {"ix_stunstick"}
FACTION.isDefault = true
FACTION.isGloballyRecognized = true
FACTION.runSounds = {[0] = "NPC_MetroPolice.RunFootstepLeft", [1] = "NPC_MetroPolice.RunFootstepRight"}

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
	..".ПКЮ.03", true
end

function FACTION:OnTransferred(character)
	character:SetName(self:GetDefaultName())
	character:SetModel(self.models[1])
end

function FACTION:OnNameChanged(client, oldValue, value)
	-- Получаем список bodygroups модели
	local bodygroups = client:GetBodyGroups()

	-- Проходимся по всем bodygroups и устанавливаем их в 0
	for k, v in pairs(bodygroups) do
		client:SetBodygroup(v.id, 0)
	end
	client:SetSkin(0)

	if Schema:IsCombineRank(value, "ЮОН.ИеР") then
		client:SetSkin(2)
		client:SetBodygroup(1, 1)
		client:SetBodygroup(2, 1)
		client:SetBodygroup(4, 4)
		client:SetBodygroup(9, 1)
		client:SetBodygroup(10, 1)
	elseif Schema:IsCombineRank(value, "ЮОН.МдК") then
		client:SetSkin(1)
		client:SetBodygroup(2, 1)
		client:SetBodygroup(4, 2)
		client:SetBodygroup(10, 1)
		client:SetBodygroup(11, 1)
		client:SetBodygroup(15, 1)
		client:SetBodygroup(16, 1)
	elseif Schema:IsCombineRank(value, "ЮОН.ШрК") then
		client:SetSkin(6)
		client:SetBodygroup(2, 1)
		client:SetBodygroup(3, 3)
		client:SetBodygroup(4, 3)
		client:SetBodygroup(10, 1)
		client:SetBodygroup(11, 1)
		client:SetBodygroup(12, 1)
		client:SetBodygroup(15, 1)
		client:SetBodygroup(16, 1)
	elseif Schema:IsCombineRank(value, "ПКЮ") then
		client:SetBodygroup(2, 1)
		client:SetBodygroup(4, 1)
		client:SetBodygroup(9, 1)
		client:SetBodygroup(10, 1)
		client:SetBodygroup(13, 1)
		client:SetBodygroup(15, 1)
		client:SetBodygroup(16, 1)
	elseif Schema:IsCombineRank(value, "КЮ.ОфЦ") then
		client:SetSkin(3)
		client:SetBodygroup(2, 2)
		client:SetBodygroup(3, 6)
		client:SetBodygroup(4, 5)
		client:SetBodygroup(10, 1)
		client:SetBodygroup(13, 1)
		client:SetBodygroup(15, 1)
		client:SetBodygroup(16, 1)
	elseif Schema:IsCombineRank(value, "КЮ.Дисп") then
		client:SetSkin(5)
		client:SetBodygroup(2, 2)
		client:SetBodygroup(3, 7)
		client:SetBodygroup(4, 5)
		client:SetBodygroup(10, 1)
		client:SetBodygroup(11, 1)
		client:SetBodygroup(15, 1)
		client:SetBodygroup(16, 1)
	elseif Schema:IsCombineRank(value, "КЮ.КС") then
		client:SetSkin(10)
		client:SetBodygroup(2, 1)
		client:SetBodygroup(3, 2)
		client:SetBodygroup(4, 5)
		client:SetBodygroup(10, 1)
		client:SetBodygroup(11, 1)
		client:SetBodygroup(15, 1)
		client:SetBodygroup(16, 1)
	end
end

FACTION_MPF = FACTION.index
