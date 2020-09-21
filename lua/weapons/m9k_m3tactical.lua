if not MMM_M9k_IsBaseInstalled then return end -- Make sure the base is installed!

SWEP.Base = "bobs_shotty_base"
SWEP.Category = "M9K+ Shotguns"
SWEP.PrintName = "M3 Tactical"

SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/tacticalm3/v_shot_m3super90.mdl"
SWEP.WorldModel = "models/weapons/w_benelli_m3.mdl"

SWEP.Primary.Sound = "weapons/m3/m3-1.wav"
SWEP.Primary.RPM = 60
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 24

SWEP.Primary.KickUp = 6
SWEP.Primary.KickDown = 3
SWEP.Primary.KickHorizontal = 7
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.NumShots = 35
SWEP.Primary.Damage = 4
SWEP.Primary.Spread = .16
SWEP.ShellTime = .4

SWEP.IronSightsPos = Vector(2.935,0,2)
SWEP.IronSightsAng = Vector(1,0,0)

SWEP.ShouldDoMoveSpread = false