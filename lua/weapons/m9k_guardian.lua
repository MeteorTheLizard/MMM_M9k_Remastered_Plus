if not MMM_M9k_IsBaseInstalled then return end -- Make sure the base is installed!

SWEP.Base = "bobs_gun_base"
SWEP.Category = "M9K+ Pistols"
SWEP.PrintName = "Guardian Mini"

SWEP.Slot = 1
SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/guardian/v_pist_p228.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fokkususp.mdl"

SWEP.Primary.Sound = "weapons/guardianmini/p228-1.wav"
SWEP.Primary.RPM = 500
SWEP.Primary.ClipSize = 7
SWEP.Primary.DefaultClip = 21

SWEP.Primary.KickUp = 1.3
SWEP.Primary.KickDown = 1
SWEP.Primary.KickHorizontal = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.NumShots = 1
SWEP.Primary.Damage = 17
SWEP.Primary.Spread = .015

SWEP.IronSightsPos = Vector(1.9,0,1.57)