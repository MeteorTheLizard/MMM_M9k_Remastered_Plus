if not MMM_M9k_IsBaseInstalled then return end -- Make sure the base is installed!

SWEP.Base = "bobs_scoped_base"
SWEP.Category = "M9K+ Assault Rifles"
SWEP.PrintName = "G36 Assault"

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/asg36/v_rif_aug.mdl"
SWEP.WorldModel = "models/weapons/w_hk_g36c.mdl"

SWEP.Primary.Sound = "weapons/asg36/aug-1.wav"
SWEP.Primary.RPM = 400
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 90

SWEP.Primary.KickUp = 1.1
SWEP.Primary.KickDown = 1.1
SWEP.Primary.KickHorizontal = 1.1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.NumShots = 1
SWEP.Primary.Damage = 31
SWEP.Primary.Spread = .031
SWEP.Primary.SpreadBefore = SWEP.Primary.Spread

SWEP.ScopeScale = 0.5
SWEP.ReticleScale = 0.6
SWEP.HasZoomStages = false -- This weapon does not have variable zooms (No zoom stages)

if CLIENT then
	local CachedTextureID1 = surface.GetTextureID("scope/gdcw_closedsight")
	local CachedTextureID2 = surface.GetTextureID("scope/gdcw_acogchevron")
	local CachedTextureID3 = surface.GetTextureID("scope/gdcw_acogcross")

	function SWEP:DrawHUD()
		if self:GetNWInt("ScopeState") > 0 then
			if self.DrawCrosshair then -- Only set the vars once (this is faster)
				self.Owner:DrawViewModel(false)
				self.DrawCrosshair = false
			end

			surface.SetDrawColor(0,0,0,255)
			surface.SetTexture(CachedTextureID1)
			surface.DrawTexturedRect(self.LensTable.x,self.LensTable.y,self.LensTable.w,self.LensTable.h)

			surface.SetTexture(CachedTextureID2)
			surface.DrawTexturedRect(self.ReticleTable.x,self.ReticleTable.y,self.ReticleTable.w,self.ReticleTable.h)

			surface.SetTexture(CachedTextureID3)
			surface.DrawTexturedRect(self.ReticleTable.x, self.ReticleTable.y, self.ReticleTable.w, self.ReticleTable.h)
		elseif not self.DrawCrosshair then -- Only set the vars once (this is faster)
			self.Owner:DrawViewModel(true)
			self.DrawCrosshair = true
		end
	end
end