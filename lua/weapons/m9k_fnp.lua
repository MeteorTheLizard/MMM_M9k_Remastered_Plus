if not MMM_M9k_IsBaseInstalled then return end -- Make sure the base is installed!

SWEP.Base = "bobs_gun_base"
SWEP.Category = "M9K+ Pistols"
SWEP.PrintName = "FNP 45.Cal Advanced"

SWEP.Slot = 1
SWEP.Spawnable = true

SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/fnp/v_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fokkususp.mdl"

SWEP.Primary.Sound = "weapons/FNP45/FNP45-1.wav"
SWEP.Primary.RPM = 400
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 24

SWEP.Primary.KickUp = 2.2
SWEP.Primary.KickDown = 1.3
SWEP.Primary.KickHorizontal = 1.8
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.NumShots = 1
SWEP.Primary.Damage = 26
SWEP.Primary.Spread = .017

SWEP.IronSightsPos = Vector(-1.55,0,0.075)
SWEP.IronSightsAng = Vector(0,0.2,0)