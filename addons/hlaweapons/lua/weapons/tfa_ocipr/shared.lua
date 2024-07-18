SWEP.Category						= "Half-Life Alyx"
SWEP.Author							= "Mr.Spooky"
SWEP.Contact						= ""
SWEP.Purpose						= ""
SWEP.Instructions					= ""
SWEP.MuzzleAttachment				= "muzzle"
SWEP.ShellEjectAttachment			= "2"
SWEP.PrintName						= "OCIPR"
SWEP.Manufacturer 			= "Universal Union" --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Slot							= 2
SWEP.SlotPos						= 58
SWEP.DrawAmmo						= true
SWEP.DrawWeaponInfoBox				= false
SWEP.BounceWeaponIcon   			= false
SWEP.DrawCrosshair					= true
SWEP.Weight							= 30
SWEP.AutoSwitchTo					= true
SWEP.AutoSwitchFrom					= true
SWEP.HoldType 						= "ar2"

SWEP.ViewModelFOV					= 55
SWEP.ViewModelFlip					= false
SWEP.ViewModel						= "models/weapons/ocipr/c_ocipr.mdl"
SWEP.VMPos                          = Vector(0,0,1)
SWEP.WorldModel						= "models/weapons/ocipr/w_ocipr.mdl"
SWEP.Base							= "tfa_gun_base"
SWEP.Spawnable						= true
SWEP.UseHands 						= true
SWEP.AdminSpawnable					= true
SWEP.FiresUnderwater 				= false

SWEP.DisableChambering              = true

SWEP.Primary.Sound			= Sound("TFA_HL2R_AR1.1")	
SWEP.Primary.SoundEchoTable = {
	[0] = Sound("TFA_HL2R_AR1.TailOutside"), -- This is the sound of the weapon, when you shoot.
}
SWEP.Primary.RPM					= 410
SWEP.Primary.ClipSize				= 30
SWEP.Primary.DefaultClip			= 90
SWEP.Primary.KickUp					= 0.8
SWEP.Primary.KickDown				= 0.1
SWEP.Primary.KickHorizontal			= 0.2
SWEP.Primary.StaticRecoilFactor = 0.60 	--Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
SWEP.Primary.Automatic				= true
SWEP.Primary.Ammo					= "ar2"
SWEP.Primary.Force = 0 --Force value, leave nil to autocalc
SWEP.Primary.Knockback = 0 --Autodetected if nil; this is the velocity kickback

SWEP.Primary.SpreadMultiplierMax = 4.23                        -- How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement     = 0.9                         -- What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery      = 5.38                        -- How much the spread recovers, per second. Example val: 3

SWEP.TracerName 					= "AR2Tracer"
SWEP.TracerCount 					= 1

SWEP.ImpactEffect = "AR2Impact"--Impact Effect
SWEP.ImpactDecal = nil--Impact Decal

SWEP.Secondary.IronFOV				= 65	

SWEP.data 							= {}
SWEP.data.ironsights				= 1

SWEP.IronRecoilMultiplier       = 0.85                         -- Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier   = 0.80 
SWEP.CrouchRecoilMultiplier 	= 0.91  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.

SWEP.Primary.NumShots				= 1
SWEP.Primary.Damage					= 42
SWEP.Primary.Spread					= 0.0092
SWEP.Primary.IronAccuracy           = 0.001

SWEP.data 							= {}
SWEP.data.ironsights				= 1
SWEP.ScopeScale 					= 0.7
SWEP.MoveSpeed                  = 1                          -- Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed        = 1  

SWEP.SelectiveFire					= true


SWEP.IronSightsPos =                Vector(-4.83, -1.064, 1.149)
SWEP.IronSightsAng =                Vector(0, 0, -0.345)
SWEP.RunSightsPos 					= Vector(9.369, -17.244, -3.689)
SWEP.RunSightsAng 					= Vector(6.446, 62.852, 0)

SWEP.CrouchPos    = Vector(-0.5, -1, -0.5)
SWEP.CrouchAng    = Vector(0, 0, -5)

SWEP.MuzzleAttachment			= "muzzle" 		-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "shell" 		-- Should be "2" for CSS models or "shell" for hl2 models

SWEP.Tracer				= 0		--Bullet tracer.  TracerName overrides this.
SWEP.TracerName 		= "tfa_hla_ar2_tracer" 	--Change to a string of your tracer name.  Can be custom.
								--There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		= 1 	--0 disables, otherwise, 1 in X chance


SWEP.TracerLua 			= false --Use lua effect, TFA Muzzle syntax.  Currently obsolete.
SWEP.TracerDelay		= 0.01 --Delay for lua tracer effect

SWEP.DoMuzzleFlash = true --Do a muzzle flash?
SWEP.CustomMuzzleFlash = false --Disable muzzle anim events and use our custom flashes?
SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect = "tfa_hl2r_muzzleflash_ar2" --Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.
SWEP.ChargeMuzzleFlashEffect = "tfa_hl2r_muzzleflash_ar2_charge" --Used by the AR2, Charging Muzzle effect
SWEP.SecondaryMuzzleFlash = "tfa_hl2r_muzzleflash_ar2_alt" --Used by the AR2, Secondary Fire muzzle effect.

SWEP.VElements = {
	["irons"] = { type = "Model", model = "models/props_combine/combine_emitter01.mdl", bone = "pulserifle", rel = "", pos = Vector(-0.05, 0.805, 2.713), angle = Angle(0, 90, 0), size = Vector(0.028, 0.028, 0.028), color = Color(200, 200, 220, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

local soundData = {
    name        = "TFA_HL2R_AR1.1" ,
    channel     = CHAN_WEAPON,
    volume      = 1,
    soundlevel  = 80,
	pitch 		= {95, 110},
    sound       = "ar1/fire"..math.random( 1, 16 )..".wav"
}
sound.Add(soundData)