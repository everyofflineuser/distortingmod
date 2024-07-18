util.PrecacheModel("models/weapons/w_irifle_magazine.mdl")
util.PrecacheModel("models/weapons/w_pistol_magazine.mdl")
util.PrecacheModel("models/weapons/w_smg1_magazine.mdl")

--game.AddParticles( "particles/hl2mmod_weaponeffects.pcf" )

local magazineWeapons = {
	["weapon_pistol"] = true,
	["weapon_smg1"] = true,
	["weapon_ar2"] = true
}

local ironsightWeapons = {
	["weapon_pistol"] = true,
	["weapon_357"] = true,
	["weapon_smg1"] = true,
	["weapon_shotgun"] = true,
	["weapon_ar2"] = true
}

local ironsightPos = {
	["weapon_pistol"] = Vector(2, -4.62, 2.85),
	["weapon_357"] = Vector(2, -3.18, 1.08),
	["weapon_smg1"] = Vector(2, -4.765, 1.15),
	["weapon_shotgun"] = Vector(2, -3.1, 2.85),
	["weapon_ar2"] = Vector(0, -5.1, 2.1)
}

local ironsightAng = {
    ["weapon_pistol"] = 4.2, 
    ["weapon_357"] = 0,
    ["weapon_smg1"] = 1.3,
    ["weapon_shotgun"] = 2.5,
    ["weapon_ar2"] = 0
}

hook.Add("InitPostEntity", "MMOD_DeploySpeed", function() 
    RunConsoleCommand("sv_defaultdeployspeed", "1")
end)

---------------------
--Dynamic Magazines--
---------------------

if SERVER then

	local reloadedWeapons = {}
	
	CreateConVar("mmod_mags", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE}, "Toggle magazine dropping (0: Off, 1: On)")
	
	hook.Add("PlayerPostThink", "MMOD_Mags", function(ply)
	
		if GetConVar("mmod_mags"):GetInt() != 1 then return end
	
		local function CreateAmmoProp(wep, pos, magazineModel)

			local prop = ents.Create("prop_physics")
			prop:SetModel(magazineModel)
			prop:SetPos(pos)
			prop:SetAngles(prop:GetAngles())
			prop:Spawn()
			prop:Activate()
			prop:PhysicsInit(SOLID_VPHYSICS)
			prop:SetSolid(SOLID_VPHYSICS)

			local phys = prop:GetPhysicsObject()
			if IsValid(phys) and IsValid(prop) then
			phys:Wake()
			prop:SetMoveType(MOVETYPE_VPHYSICS)
			prop:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			prop:SetRenderMode(RENDERMODE_TRANSALPHA)
			prop:SetColor(Color(255,255,255,255))
			
			wep.MMOD_Reload = CurTime() + 4

				timer.Simple(60,function()
					if IsValid(prop) then 
						prop:Remove() 
					end
				end)
			end
		end
		
		for k, v in pairs(ents.GetAll()) do

			if v:IsPlayer() or v:IsNPC() then

				if IsValid(v) then
				local wep = v:GetActiveWeapon()

				if IsValid(wep) then
				local class = wep:GetClass()
				local activeclass = tostring(wep:GetClass())

				if !magazineWeapons[class] then return end

				local ent = v:GetShootPos()

				if v:IsPlayer() then
						
					local pos = ent
					pos = pos + v:GetForward() * 10
					pos = pos + v:GetRight() * 5
					pos = pos + v:GetUp() * -15

					local vm = v:GetViewModel()
					if !IsValid(vm) then return end

					local seq = vm:GetSequence()
					local seqinfo = vm:GetSequenceInfo(seq)
					local reloadanimation = string.find(seqinfo.activityname, "_RELOAD")

					if wep:Clip1() > 0 then
						local indexToRemove
				
						for index, weaponclass in pairs(reloadedWeapons) do
							if weaponclass == activeclass then
								indexToRemove = index
								break
							end
						end

						if indexToRemove then
							table.remove(reloadedWeapons, indexToRemove)
						end
					end

					timer.Simple(0.2,function()
					if reloadanimation then
						if (!wep.MMOD_Reload) or (wep.MMOD_Reload and CurTime() > wep.MMOD_Reload) then
							if IsValid(wep) and wep:Clip1() == 0 and !table.HasValue(reloadedWeapons, activeclass) then
								if wep:GetClass() == "weapon_ar2" then
									CreateAmmoProp(wep, pos, "models/weapons/w_irifle_magazine.mdl")
								elseif wep:GetClass() == "weapon_pistol" then
									CreateAmmoProp(wep, pos, "models/weapons/w_pistol_magazine.mdl")
								elseif wep:GetClass() == "weapon_smg1" then
									CreateAmmoProp(wep, pos, "models/weapons/w_smg1_magazine.mdl")
								end
							end
						end
					for k, v in pairs(magazineWeapons) do
						if k == activeclass then
							if !table.HasValue(reloadedWeapons, activeclass) then
								table.insert(reloadedWeapons, activeclass)
							end
						end
					end
				end
			end)

			elseif v:IsNPC() then

				local pos = ent
				pos = pos + v:GetForward() * 5
				pos = pos + v:GetRight() * -5
				pos = pos + v:GetUp() * -25

				local seq = v:GetSequence()
				local seqinfo = v:GetSequenceInfo(seq)
				local reloadanimation = string.find(seqinfo.activityname, "_RELOAD")

				timer.Simple(0.2,function()
				if reloadanimation then
					if (!wep.MMOD_Reload) or (wep.MMOD_Reload and CurTime() > wep.MMOD_Reload) then
						if wep:GetClass() == "weapon_ar2" then
							CreateAmmoProp(wep, pos, "models/weapons/w_irifle_magazine.mdl")
						elseif wep:GetClass() == "weapon_pistol" then
							CreateAmmoProp(wep, pos, "models/weapons/w_pistol_magazine.mdl")
						elseif wep:GetClass() == "weapon_smg1" then
							CreateAmmoProp(wep, pos, "models/weapons/w_smg1_magazine.mdl")

										end
									end
								end
							end)
						end
					end
				end			
			end
		end
	end)
end

--------------
--Ironsights--
--------------

CreateConVar("mmod_ironsights", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE}, "Toggle ironsight (0: Off, 1: On)")
CreateClientConVar("cl_ironsight_key", "MOUSE3", FCVAR_ARCHIVE, "The key to toggle ironsight")
CreateClientConVar("cl_ironsight_toggle", "1", FCVAR_ARCHIVE, "Determines if you should hold or press the ironsight key")
CreateClientConVar("cl_ironsight_blur", "1", FCVAR_ARCHIVE, "Toggle blur during ironsights")

local transitionSpeed = 3.8
local lastToggleTime = 0
local toggleCooldown = 0.6
local canToggleIronsight = true
inIronsights = false

local function ToggleIronsight()
	if canToggleIronsight then
		inIronsights = not inIronsights
		lastToggleTime = CurTime()
	end
end

local function GetMouseKeyCode(buttonName)
	--I can't get the keycodes for mouse buttons so I'm doing this the other way
	local mouseButtonMap = {
		MOUSE1 = 107,
		MOUSE2 = 108,
		MOUSE3 = 109,
		MOUSE4 = 110,
		MOUSE5 = 111
	}
	return mouseButtonMap[buttonName] or -1
end

hook.Add("HUDShouldDraw", "Ironsight_HideCrosshair", function(name)
	if inIronsights then
		if name == "CHudCrosshair" then
			return false
		end
	end
end)

hook.Add("RenderScreenspaceEffects", "Ironsight_ToyTown", function()
	if GetConVar("cl_ironsight_blur"):GetInt() != 1 then return end

	if inIronsights then
		DrawToyTown(2.1, ScrH() / 2.5)
	end
end)

hook.Add("CreateMove", "Ironsights_CreateMove", function(cmd)

	if GetConVar("mmod_ironsights"):GetInt() != 1 then return end

	local randomsounds = {
		"/weapons/movement/weapon_movement_sprint1.wav",
		"/weapons/movement/weapon_movement_sprint2.wav",
		"/weapons/movement/weapon_movement_sprint3.wav",
		"/weapons/movement/weapon_movement_sprint4.wav",
		"/weapons/movement/weapon_movement_sprint5.wav",
		"/weapons/movement/weapon_movement_sprint6.wav",
		"/weapons/movement/weapon_movement_sprint7.wav",
		"/weapons/movement/weapon_movement_sprint8.wav",
		"/weapons/movement/weapon_movement_sprint9.wav"
	}
	
	local randomSound = table.Random(randomsounds)

	local ply = LocalPlayer()
	if !ply:Alive() then return end
	
	local wep = ply:GetActiveWeapon()
	if !IsValid(wep) then return end

	local class = wep:GetClass()
	if !ironsightWeapons[class] then return end

	local vm = ply:GetViewModel()
	if !IsValid(vm) then return end

	local ironsightKey = string.upper(GetConVar("cl_ironsight_key"):GetString())
	local ironsightKeyCode = input.GetKeyCode(ironsightKey)
	local mouseKey = GetMouseKeyCode(ironsightKey)

	if canToggleIronsight then
		local shouldToggle = false
		shouldToggle = input.IsMouseDown(mouseKey) or input.IsKeyDown(ironsightKeyCode)
		
		if GetConVar("cl_ironsight_toggle"):GetInt() == 0 then 
			if shouldToggle and (CurTime() - lastToggleTime > toggleCooldown) then
				if !ply.IronsightKeyDown then
					if (CurTime() - lastToggleTime > toggleCooldown) then
						ToggleIronsight(ply)
						ply:EmitSound(randomSound, 75, 100, 0.75)
					end
				end
			elseif inIronsights and (CurTime() - lastToggleTime > toggleCooldown) then
				ToggleIronsight(ply)
				ply:EmitSound(randomSound, 75, 100, 0.75)
			end	
			ply.IronsightKeyDown = shouldToggle
		elseif GetConVar("cl_ironsight_toggle"):GetInt() == 1 then 
			if canToggleIronsight then
				if shouldToggle then
					if (CurTime() - lastToggleTime > toggleCooldown) then
						ToggleIronsight(ply)
						ply:EmitSound(randomSound, 75, 100, 0.75)	
					end
				end
			end
		end
	end
	
	local seq = vm:GetSequence()
	local seqinfo = vm:GetSequenceInfo(seq)
	local blacklistanimations = string.find(seqinfo.activityname, "_RELOAD") or string.find(seqinfo.activityname, "_INSPECT") or string.find(seqinfo.activityname, "_SPRINT") or string.find(seqinfo.activityname, "_DRAW")

	if blacklistanimations or wep:Clip1() == 0 or GetConVar("mmod_ironsights"):GetInt() == 0 then
		if inIronsights then
			ToggleIronsight()
		end
		canToggleIronsight = false
	else
		canToggleIronsight = true
	end

end)


hook.Add("CalcView", "MMOD_IronsightView_FOV", function(ply, pos, angles, fov)

	if GetConVar("mmod_ironsights"):GetInt() != 1 then return end

	if !ply:Alive() then return end
	
	local wep = ply:GetActiveWeapon()
	if !IsValid(wep) then return end

	local class = wep:GetClass()
	if !ironsightWeapons[class] then return end
	
	local drawplayer = ply:ShouldDrawLocalPlayer() 

	local vm = ply:GetViewModel()
	if !IsValid(vm) then return end
	
	local playerfov = ply:GetFOV()

    if IsValid(vm) then

		local view = {}
	
		if !drawplayer then
	
			if inIronsights then
				
				view.fov = Lerp(math.min(1, (CurTime() - lastToggleTime) * transitionSpeed), playerfov, fov / 1.5)
			
				return view

			elseif (CurTime() - lastToggleTime < toggleCooldown) then

				view.fov = Lerp(math.min(1, (CurTime() - lastToggleTime) * transitionSpeed), fov / 1.5 , playerfov)
					
				return view
				
			end
		end
	end
end)
	

hook.Add("CalcViewModelView", "MMOD_IronsightView_VM", function(wep, vm, oldPos, oldAng, pos, ang)

	if GetConVar("mmod_ironsights"):GetInt() != 1 then return end
	
	-- Modern Warfare Base
	if vm:GetClass() == "mg_viewmodel" then return end

	local ply = vm:GetOwner()
	if !ply:Alive() then return end

	local wep = ply:GetActiveWeapon()
	if !IsValid(wep) then return end

	local class = wep:GetClass()
	if !ironsightWeapons[class] then return end
	
	local drawplayer = ply:ShouldDrawLocalPlayer() 

	local vm = ply:GetViewModel()
	if !IsValid(vm) then return end
	local activeclass = tostring(wep:GetClass())
	
    if IsValid(vm) then

		local ironsightOffset = ironsightPos[activeclass]
		local ironsightAngle = ironsightAng[activeclass] or 0
	
		local targetPosCopy = Vector(oldPos.x, oldPos.y, oldPos.z)
		local targetAngCopy = Angle(oldAng.p, oldAng.y, oldAng.r)

		targetAngCopy:RotateAroundAxis(oldAng:Forward(), ironsightAngle)

		local targetPos = targetPosCopy - oldAng:Forward() * ironsightOffset.x + oldAng:Right() * ironsightOffset.y + oldAng:Up() * ironsightOffset.z
		local targetAng = targetAngCopy
	
		if !drawplayer then

			if inIronsights then

				pos = LerpVector(math.min(1, (CurTime() - lastToggleTime) * transitionSpeed), pos, targetPos)
				ang = LerpAngle(math.min(1, (CurTime() - lastToggleTime) * transitionSpeed), ang, targetAng)

				return pos, ang
					
			elseif (CurTime() - lastToggleTime < toggleCooldown) then

				pos = LerpVector(math.min(1, (CurTime() - lastToggleTime) * transitionSpeed), targetPos, pos)
				ang = LerpAngle(math.min(1, (CurTime() - lastToggleTime) * transitionSpeed), targetAng, ang)
			
				return  pos, ang

			end
		end
	end
end)

-------------------
--Ironsight Anims--
-------------------

if game.SinglePlayer() and CLIENT then
	hook.Add("Think", "MMOD_Weapon_IronsightIdle_SP", function()

		local ply = LocalPlayer()
		if !ply:Alive() then return end

		local wep = ply:GetActiveWeapon()
		if !IsValid(wep) then return end

		local class = wep:GetClass()
		if !ironsightWeapons[class] then return end

		local vm = ply:GetViewModel()
		if !IsValid(vm) then return end
			
		local seq = vm:GetSequence()
		local seqinfo = vm:GetSequenceInfo(seq)
		local cyc = vm:GetCycle()
		
		local vel = ply:GetVelocity():Length()
		local crouchspeed = ply:GetWalkSpeed() * ply:GetCrouchedWalkSpeed() // minimum speed to play anim
	
		if seqinfo.activityname == "ACT_VM_IDLE" then
			if inIronsights then
				local seqToPlay = vm:LookupSequence("ACT_VM_IDLE_SILENCED")
				if seqToPlay then

				local dur = vm:SequenceDuration(seqToPlay)
				vm:SendViewModelMatchingSequence(seqToPlay)
				wep.MMOD_NextSightTime = CurTime() + dur
						
				else return false

				end
			end
		elseif seqinfo.activityname == "ACT_VM_IDLE_SILENCED" then
			if !inIronsights or wep.MMOD_NextWalkTime then 
				local seqToPlay = vm:LookupSequence("ACT_VM_IDLE")
				if seqToPlay then

				local dur = vm:SequenceDuration(seqToPlay)
				vm:SendViewModelMatchingSequence(seqToPlay)
			
				else return false

				end
			end
		end
		
		local ironsightFireRandom = {"ACT_VM_PRIMARYATTACK_IRONSIGHTED1", "ACT_VM_PRIMARYATTACK_IRONSIGHTED2"}
		local shootanim = seqinfo.activityname == "ACT_VM_PRIMARYATTACK" or seqinfo.activityname == "ACT_VM_RECOIL1" or seqinfo.activityname == "ACT_VM_RECOIL2" or seqinfo.activityname == "ACT_VM_RECOIL3"

		if (shootanim and cyc < 0.05) then
			if inIronsights then
		
				local function getAvailableIronsightAnims()
					local availableAnims = {}
					for _, anim in ipairs(ironsightFireRandom) do
						local seqToPlay = vm:LookupSequence(anim)
						if seqToPlay ~= -1 then
							table.insert(availableAnims, anim)
						end
					end
					return availableAnims
				end

				local availableIronsightAnims = getAvailableIronsightAnims()
				local ironsightAnim

				if #availableIronsightAnims > 0 then
					-- Randomly select from available ironsight animations
					ironsightAnim = availableIronsightAnims[math.random(1, #availableIronsightAnims)]
				end			
	
				local seqToPlay = vm:LookupSequence(ironsightAnim)
				
				local dur = vm:SequenceDuration(seqToPlay)
				-- Had to use timer for primaryattack
				timer.Simple(0, function()
					vm:SendViewModelMatchingSequence(seqToPlay)
				end)
			end
		end
	end)
end

hook.Add("PlayerPostThink", "MMOD_Weapon_AR2_Logic", function(ply)

	if !ply:Alive() then return end

	local wep = ply:GetActiveWeapon()
	if !IsValid(wep) then return end

	local class = wep:GetClass()
	if class != "weapon_ar2" then return end

	local vm = ply:GetViewModel()
	if !IsValid(vm) then return end
			
	local seq = vm:GetSequence()
	local seqinfo = vm:GetSequenceInfo(seq)
	local cyc = vm:GetCycle()

	if wep:Clip1() == 1 then
		if vm:GetBodyGroups() != 0011 then
			vm:SetBodyGroups( "0011" )
		end
	elseif wep:Clip1() == 0 then
		if vm:GetBodyGroups() != 0111 then
			vm:SetBodyGroups( "0111" )
		end
	end

	if seqinfo.activityname == "ACT_VM_RELOADEMPTY" and cyc < 0.4 then
		if vm:GetBodyGroups() != 0111 then
			vm:SetBodyGroups( "0111" )
		end
	elseif seqinfo.activityname == "ACT_VM_RELOADEMPTY" and cyc > 0.4 then
		if vm:GetBodyGroups() != 0000 then
			vm:SetBodyGroups( "0000" )
		end
	end

	if seqinfo.activityname == "ACT_VM_RELOAD" and wep:Clip1() == 0 then
		local seqToPlay = vm:LookupSequence("ACT_VM_RELOADEMPTY")
		if seqToPlay then
		local dur = vm:SequenceDuration(seqToPlay)

		vm:SendViewModelMatchingSequence(seqToPlay)
		else return false

		end
	end
end)

-----------------------------
--Thrown Grenade Worldmodel--
-----------------------------

hook.Add("OnEntityCreated", "MMOD_ReplaceGrenade" ,function(ent)
	
		timer.Simple(0.01, function() 
			if IsValid(ent) and ent:GetClass() == "npc_grenade_frag" then
				
			local grenade = "models/weapons/w_grenade_thrown.mdl"
			local id = ent:LookupAttachment("fuse")

			ent:SetModel(grenade)
			ent:Activate()
			
			--PrecacheParticleSystem("hl2mmod_weapon_smg_grenadetrail")
			--ParticleEffectAttach("hl2mmod_weapon_smg_grenadetrail", PATTACH_ABSORIGIN_FOLLOW, ent, id)

		end
	end)
end)

-------------------------------
--Stunstick Underwater Damage--
-------------------------------
	
if SERVER then
	hook.Add("PlayerPostThink", "MMOD_StunstickWater", function(ply, pos, sound, volume)

	local randomsounds = {
		"/ambient/energy/zap1.wav",
		"/ambient/energy/zap2.wav",
		"/ambient/energy/zap3.wav"
	}

	local randomNum = math.floor(math.random(3))
	local randomSound = randomsounds[randomNum]

	if !ply:Alive() then return end

	local wep = ply:GetActiveWeapon()
	if !IsValid(wep) then return end
	
	local class = wep:GetClass()
	if class != "weapon_stunstick" then return end

	local vm = ply:GetViewModel()
	if !IsValid(vm) then return end

	local seq = vm:GetSequence()
	local seqinfo = vm:GetSequenceInfo(seq)

	if seqinfo.activityname == "ACT_VM_MISSCENTER" or seqinfo.activityname == "ACT_VM_HITCENTER" then
		if (!wep.MMOD_Stunstick) or (wep.MMOD_Stunstick and CurTime() > wep.MMOD_Stunstick) then
			if ply:WaterLevel() > 2 then
			
				local dur = vm:SequenceDuration(seqinfo)
				ply:TakeDamage(40, ply, ply)
				ply:EmitSound(randomSound)

				wep.MMOD_Stunstick = CurTime() + dur

				return true

				end
			end
		end
	end)
end