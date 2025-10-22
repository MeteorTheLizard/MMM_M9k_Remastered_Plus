if not MMM_M9k_IsBaseInstalled then return end -- Make sure the base is installed!

SWEP.Base = "bobs_scoped_base"
SWEP.Category = "M9kR+ Assault Rifles"
SWEP.PrintName = "FW900K"

SWEP.DynamicLightScale = 1 -- Set to Default

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.Spawnable = true

SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/fw900k/v_rif_galil.mdl"
SWEP.WorldModel = "models/weapons/w_hk_sl8.mdl"

SWEP.tReloadDynamic = {
	{
		sSound = "weapons/fw/famas_clipout.wav",
		iDelay = 0.45
	},
	{
		sSound = "weapons/fw/famas_clipin.wav",
		iDelay = 0.45 + 0.85
	},
	{
		sSound = "weapons/fw/famas_forearm.wav",
		iDelay = 0.45 + 0.85 + 0.85
	}
}

SWEP.tDrawSoundSequence = {
	{
		sSound = "weapons/fw/fireselect.wav",
		iDelay = 0.45
	}
}

SWEP.Primary.Sound = "weapons/fw/galil-1.wav"

SWEP.Primary.RPM = 250
SWEP.Primary.ClipSize = 15
SWEP.Primary.KickUp = 2.7
SWEP.Primary.KickDown = 1.5
SWEP.Primary.KickHorizontal = 2
SWEP.Primary.Automatic = true
SWEP.Primary.NumShots = 1
SWEP.Primary.Damage = 34
SWEP.Primary.Spread = .027
SWEP.Primary.Ammo = "ar2"

SWEP.Primary.SpreadBefore = SWEP.Primary.Spread

SWEP.ScopeType = "gdcw_scopesight"
SWEP.ScopeStages = 1
SWEP.ScopeScale = 0.5
SWEP.ReticleScale = 0.6

SWEP.LegacyBalance = {
	Primary = {
		RPM = 500,
		ClipSize = 10,
		KickUp = .3,
		KickDown = .2,
		KickHorizontal = .8,
		Automatic = true,
		NumShots = 1,
		Damage = 35,
		Spread = 0.2
	}
}

function SWEP:DoDrawCrosshair()
end