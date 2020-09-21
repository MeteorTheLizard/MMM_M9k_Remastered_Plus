if not MMM_M9k_IsBaseInstalled then return end -- Make sure the base is installed!

SWEP.Base = "bobs_shotty_base"
SWEP.Category = "M9K+ Shotguns"
SWEP.PrintName = "Serbu Super Shorty"

SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/supershorty/v_shot_m3super90.mdl"
SWEP.WorldModel = "models/weapons/w_benelli_m3.mdl"

SWEP.Primary.Sound = "KSG.Fire"
SWEP.Primary.RPM = 45
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 24

SWEP.Primary.KickUp = 9
SWEP.Primary.KickDown = 5
SWEP.Primary.KickHorizontal = 8
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.NumShots = 29
SWEP.Primary.Damage = 3.7
SWEP.Primary.Spread = .16
SWEP.ShellTime = .5

SWEP.IronSightsPos = Vector(4.3,0,2.35)
SWEP.IronSightsAng = Vector(1,0,0)

SWEP.ShouldDoMoveSpread = false