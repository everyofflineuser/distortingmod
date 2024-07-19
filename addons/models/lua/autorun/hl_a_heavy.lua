player_manager.AddValidModel("HL_a_combine_heavy", "models/cultist/hl_a/combine_heavy/combine_heavy_trooper.mdl")
player_manager.AddValidHands("HL_a_combine_heavy", "models/weapons/c_arms_combine.mdl", 0, 00000000)


local Category = "HL:Alyx"
 
local NPC = {   Name = "Combine Heavy", 
                Class = "npc_combine_s",
                Model = "models/cultist/hl_a/combine_heavy/npc/combine_heavy_trooper.mdl",
                Health = "200", 
                Weapons = { "weapon_ar2" }, 
                Category = Category }
                               
list.Set( "NPC", "npc_hla_combine_heavy", NPC )

