if not MMM_M9k_IsBaseInstalled then return end -- Make sure the base is installed!

SWEP.Base = "bobs_gun_base"
SWEP.Category = "M9K+ Assault Rifles"
SWEP.PrintName = "M16A4"

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.Spawnable = true

SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/m16a4/v_rif_sg552.mdl"
SWEP.WorldModel = "models/weapons/w_dmg_m16ag.mdl"

SWEP.Primary.Sound = "Dmgfok_M16A4.Single"
SWEP.Primary.RPM = 360
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 90

SWEP.Primary.KickUp = 2.3
SWEP.Primary.KickDown = 1.3
SWEP.Primary.KickHorizontal = 1.8
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.NumShots = 1
SWEP.Primary.Damage = 31
SWEP.Primary.Spread = .02

SWEP.IronSightsPos = Vector(-2.665,0,0.647)