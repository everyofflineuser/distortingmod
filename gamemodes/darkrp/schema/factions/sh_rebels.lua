
FACTION.name = "Сопротивление"
FACTION.description = "НЕ ВЕРЬ АЛЬЯНСУ! БУДЬ ПРОТИВ НИХ"
FACTION.color = Color(50, 150, 50)
FACTION.models = {"models/player/Group03/male_04.mdl"}
FACTION.weapons = {"rust_python"}
FACTION.isDefault = true

function FACTION:OnTransferred(character)
	character:SetModel(self.models[1])
end

function FACTION:OnNameChanged(client, oldValue, value)

end

FACTION_RBL = FACTION.index
