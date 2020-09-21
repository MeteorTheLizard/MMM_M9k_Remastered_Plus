if not MMM_M9k_IsBaseInstalled then return end -- Make sure the base is installed!

SWEP.Base = "bobs_gun_base"
SWEP.Category = "M9K+ Pistols"
SWEP.PrintName = "Glock 18 Drum Mag."

SWEP.Slot = 1
SWEP.Spawnable = true

SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/glock_18_ext/v_mach_m249para.mdl"
SWEP.WorldModel = "models/weapons/w_dmg_glock.mdl"

SWEP.Primary.Sound = "Dmgfok_glock.Single" -- This sounds better IMO
SWEP.Primary.RPM = 650
SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 200

SWEP.Primary.KickUp = 1.9
SWEP.Primary.KickDown = 1.3
SWEP.Primary.KickHorizontal = 1.1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.NumShots = 1
SWEP.Primary.Damage = 11
SWEP.Primary.Spread = .036

SWEP.IronSightsPos = Vector(-3.8525,0,2.695)
SWEP.IronSightsAng = Vector(0.1,0,-1)