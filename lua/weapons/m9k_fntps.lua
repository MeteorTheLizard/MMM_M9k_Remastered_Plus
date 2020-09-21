if not MMM_M9k_IsBaseInstalled then return end -- Make sure the base is installed!

SWEP.Base = "bobs_shotty_base"
SWEP.Category = "M9K+ Shotguns"
SWEP.PrintName = "FN TPS"

SWEP.Spawnable = true

SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/tps/v_shot_m3super90.mdl"
SWEP.WorldModel = "models/weapons/w_ithaca_m37.mdl"

SWEP.Primary.Sound = "weapons/tps/m3-1.wav"
SWEP.Primary.RPM = 55
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 24

SWEP.Primary.KickUp = 22
SWEP.Primary.KickDown = 3
SWEP.Primary.KickHorizontal = 7
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.NumShots = 35
SWEP.Primary.Damage = 4
SWEP.Primary.Spread = .16
SWEP.ShellTime = .4

SWEP.IronSightsPos = Vector(-7.225,-7.37,2.12)
SWEP.IronSightsAng = Vector(-0.579,0,0)

SWEP.ShouldDoMoveSpread = false