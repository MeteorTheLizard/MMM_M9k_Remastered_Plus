if not MMM_M9k_IsBaseInstalled then return end -- Make sure the base is installed!

SWEP.Base = "bobs_shotty_base"
SWEP.Category = "M9K+ Shotguns"
SWEP.PrintName = "SPAS 12 Silenced"

SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/spas12silenced/v_shot_m3super90.mdl"
SWEP.WorldModel = "models/weapons/w_spas_12.mdl"
SWEP.ViewModelFOV = 60

SWEP.Primary.Sound = "weapons/silencedspas/m3-2.wav"
SWEP.Primary.RPM = 70
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 24

SWEP.Primary.KickUp = 5
SWEP.Primary.KickDown = 2
SWEP.Primary.KickHorizontal = 3
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.NumShots = 27
SWEP.Primary.Damage = 4
SWEP.Primary.Spread = .19
SWEP.ShellTime = .4

SWEP.IronSightsPos = Vector(2.63,-3.79,2.4)
SWEP.IronSightsAng = Vector(0.35,0.3,-6)

SWEP.ShouldDoMoveSpread = false