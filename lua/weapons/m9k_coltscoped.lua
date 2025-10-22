if not MMM_M9k_IsBaseInstalled then return end -- Make sure the base is installed!

SWEP.Base = "bobs_scoped_base"
SWEP.Category = "M9kR+ Pistols"
SWEP.PrintName = "Colt 1911 Scoped"

SWEP.DynamicLightScale = 1 -- Set to Default

SWEP.Slot = 1
SWEP.Spawnable = true

SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/colts/v_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/s_dmgf_co1911.mdl"

SWEP.tReloadDynamic = {
	{
		sSound = "weapons/1911/back.wav",
		iDelay = 0.00
	},
	{
		sSound = "weapons/1911/out.wav",
		iDelay = 0.00 + 0.25
	},
	{
		sSound = "weapons/1911/in.wav",
		iDelay = 0.00 + 0.25 + 1.15
	},
	{
		sSound = "weapons/1911/for.wav",
		iDelay = 0.00 + 0.25 + 1.15 + 0.45
	}
}

SWEP.DrawSound = "weapons/1911/cloth1.wav"

SWEP.Primary.Sound = "weapons/1911/fire.wav"

SWEP.Primary.RPM = 350
SWEP.Primary.ClipSize = 7
SWEP.Primary.KickUp = 1.8
SWEP.Primary.KickDown = 0.9
SWEP.Primary.KickHorizontal = 1.6
SWEP.Primary.Automatic = false
SWEP.Primary.NumShots = 1
SWEP.Primary.Damage = 22
SWEP.Primary.Spread = .015
SWEP.Primary.Ammo = "pistol"

SWEP.Primary.SpreadBefore = SWEP.Primary.Spread

SWEP.ScopeType = "gdcw_acog"
SWEP.ScopeStages = 1
SWEP.ScopeScale = 0.5
SWEP.ReticleScale = 0.6

SWEP.LegacyBalance = {
	Primary = {
		RPM = 600,
		ClipSize = 7,
		KickUp = 0.8,
		KickDown = 0.1,
		KickHorizontal = 0.2,
		Automatic = false,
		NumShots = 1,
		Damage = 9,
		Spread = .025
	}
}

function SWEP:DoDrawCrosshair()
end