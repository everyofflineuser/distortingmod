HLAParticleFiles = {}
table.insert(HLAParticleFiles, #HLAParticleFiles, "tfa_hla_fx")

HLAParticleEffects = {}
table.insert(HLAParticleEffects, #HLAParticleEffects, "hl2r_muzzleflash_ar2")
table.insert(HLAParticleEffects, #HLAParticleEffects, "hl2r_muzzleflash_ar2_alt")
table.insert(HLAParticleEffects, #HLAParticleEffects, "hl2r_muzzleflash_ar2_alt2")

table.insert(HLAParticleEffects, #HLAParticleEffects, "hla_muzzleflash_smg1")
table.insert(HLAParticleEffects, #HLAParticleEffects, "hla_muzzleflash_smg1_alt")

table.insert(HLAParticleEffects, #HLAParticleEffects, "tracer_hla_ar2")
table.insert(HLAParticleEffects, #HLAParticleEffects, "tracer_hla_mg")
table.insert(HLAParticleEffects, #HLAParticleEffects, "tracer_hla_psmg")



local function enum(prefix, min, max, suffix)
	local t = {}

	for i = min, max do
		t[#t + 1] = prefix .. tostring(i) .. (suffix or "")
	end

	return t
end

for k, v in pairs(HLAParticleFiles) do
	game.AddParticles("particles/" .. v .. ".pcf")
end

for k, v in pairs(HLAParticleEffects) do
	PrecacheParticleSystem(v)
end


TFA.AddFireSound("TFA_HL2R_AR1.TailOutside", enum("ar1/wpn_combine_ar_fire_body_0", 1, 4, ".wav"), true, ")")

TFA.AddWeaponSound("TFA_HL2R_AR1.Draw", "weapons/tfa_hl2r/ar2/ar2_deploy.wav", "")
TFA.AddWeaponSound("TFA_HL2R_AR1.Holster", "weapons/tfa_hl2r/ar2/weapon_movement1.wav", "")
TFA.AddWeaponSound("Weapon_AR1.Reload_Rotate", "ar1/ar2_reload_rotate.wav", "")
TFA.AddWeaponSound("Weapon_AR1.Reload_Push", "ar1/ar2_reload_push.wav", "")

TFA.AddFireSound("TFA_HL2R_PSMG.TailOutside", enum("psmg/wpn_combine_smg_body_0", 2, 5, ".wav"), true, ")")

TFA.AddFireSound("TFA_HL2R_PSHOTGUN.TailOutside", enum("pshotgun/wpn_combine_shotgun_fire_body_0", 1, 4, ".wav"), true, ")")

TFA.AddFireSound("TFA_HL2R_PMG.TailOutside", enum("suppressor/suppressor_fire_dys", 1, 4, ".wav"), true, ")")




function VectorNormalize( v )
	local l = v:Length();
	if (l != 0.0) then
		v = v / l;
	else
		// FIXME:
		// Just copying the existing implemenation; shouldnt res.z == 0?
		v.x = 0.0;
		v.y = 0.0; v.z = 1.0;
	end
	return v;
end

function CrossProduct(a, b)
	return Vector( a.y*b.z - a.z*b.y, a.z*b.x - a.x*b.z, a.x*b.y - a.y*b.x );
end