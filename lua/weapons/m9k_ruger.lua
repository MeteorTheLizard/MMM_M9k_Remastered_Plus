if not MMM_M9k_IsBaseInstalled then return end -- Make sure the base is installed!

SWEP.Base = "bobs_gun_base"
SWEP.Category = "M9K+ Pistols"
SWEP.PrintName = "Ruger MK3"

SWEP.Slot = 1
SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/ruger/v_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_luger_p08.mdl"

SWEP.Primary.Sound = "weapons/usp/usp1.wav"
SWEP.Primary.RPM = 250
SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 30

SWEP.Primary.KickUp = 1.85
SWEP.Primary.KickDown = 0.95
SWEP.Primary.KickHorizontal = 1.65
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.NumShots = 1
SWEP.Primary.Damage = 25
SWEP.Primary.Spread = .017

SWEP.IronSightsPos = Vector(2.82,-0.301,1.78)
SWEP.IronSightsAng = Vector(0,0,0)