if not MMM_M9k_IsBaseInstalled then return end -- Make sure the base is installed!

SWEP.Base = "bobs_gun_base"
SWEP.Category = "M9K+ Assault Rifles"
SWEP.PrintName = "M4A4"

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.Spawnable = true

SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/m4a4a/v_rif_famas.mdl"
SWEP.WorldModel = "models/weapons/w_m4a1_iron.mdl"

SWEP.Primary.Sound = "weapons/m4a4a/shoot.wav"
SWEP.Primary.RPM = 450
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 90

SWEP.Primary.KickUp = 2.8
SWEP.Primary.KickDown = 1.5
SWEP.Primary.KickHorizontal = 1.6
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.NumShots = 1
SWEP.Primary.Damage = 34
SWEP.Primary.Spread = .036

SWEP.IronSightsPos = Vector(-1.65,0,0.349)
SWEP.IronSightsAng = Vector(-0.4,0.14,1.75)