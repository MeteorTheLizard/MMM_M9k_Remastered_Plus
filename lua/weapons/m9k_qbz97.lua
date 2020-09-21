if not MMM_M9k_IsBaseInstalled then return end -- Make sure the base is installed!

SWEP.Base = "bobs_gun_base"
SWEP.Category = "M9K+ Assault Rifles"
SWEP.PrintName = "QBZ-97"

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.Spawnable = true

SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/qbz/v_rif_famas.mdl"
SWEP.WorldModel = "models/weapons/w_tct_famas.mdl"

SWEP.Primary.Sound = "weapons/qbz/1.wav"
SWEP.Primary.RPM = 350
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 90

SWEP.Primary.KickUp = 3.5
SWEP.Primary.KickDown = 2.1
SWEP.Primary.KickHorizontal = 2.1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.NumShots = 1
SWEP.Primary.Damage = 36
SWEP.Primary.Spread = .035

SWEP.IronSightsPos = Vector(-2.165,0,0)
SWEP.IronSightsAng = Vector(1.1,-1,0)

function SWEP:Deploy()
	if SERVER and game.SinglePlayer() then self:CallOnClient("Deploy") end -- Make sure that it runs on the CLIENT!
	self:SetHoldType(self.HoldType)

	local vm = self.Owner:GetViewModel()
	if IsValid(vm) then -- This is required since the code should only run on the server or on the player holding the gun (Causes errors otherwise)
		self.CanReload = false
		self:SetNWBool("CanIronSights",false)
		self:SendWeaponAnim(ACT_VM_DRAW)

		local Index = 0
		for k,v in ipairs(vm:GetMaterials()) do
			if v == "___error" then
				Index = k
				break
			end
		end

		vm:SetSubMaterial(Index - 1,"models/weapons/v_models/fnp45/sleeve_diffuse") -- Fix missing texture sleeves

		local Dur = vm:SequenceDuration() + 0.1
		self:SetNextPrimaryFire(CurTime() + Dur)
		self:SetNextSecondaryFire(CurTime() + Dur)

		timer.Remove("MMM_M9k_Deploy_" .. self.OurIndex)
		timer.Create("MMM_M9k_Deploy_" .. self.OurIndex,Dur,1,function()
			if not IsValid(self) or not IsValid(self.Owner) or not IsValid(self.Owner:GetActiveWeapon()) or self.Owner:GetActiveWeapon():GetClass() ~= self:GetClass() then return end
			self:SetNWBool("CanIronSights",true)
			self.CanReload = true
		end)
	end

	return true
end

function SWEP:Holster()
	if SERVER and game.SinglePlayer() then self:CallOnClient("Holster") end -- Make sure that it runs on the CLIENT!
	if not SERVER and self.Owner ~= LocalPlayer() and self.LastOwner ~= LocalPlayer() then return end

	if self.IronSightState then
		self.Owner:SetFOV(0,0.3)
		self.IronSightState = false
		self.DrawCrosshair = true
	end

	local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or IsValid(self.LastOwner) and self.LastOwner:GetViewModel()
	if IsValid(vm) then
		for k = 0,50 do -- Needs to be a somewhat high number since there can be A LOT of submaterials and #v:GetMaterials() returns the future viewmodel material count!
			vm:SetSubMaterial(k,"") -- We need to unset the material as it would otherwise carry over to other weapons!
		end
	end

	return true
end

function SWEP:Equip()
	self.LastOwner = self.Owner

	if SERVER and not self.Owner:IsPlayer() then
		self:Remove()
		return
	end
end

--[[ This doesn't work. Why? Check the SWEP:OnDrop() function.
if CLIENT then -- This is done to fix the viewmodel after dropping
	function SWEP:OwnerChanged()
		self:Holster()
	end
end
]]

if SERVER then
	function SWEP:OnDrop()
		self:Holster()

		-- HACK!! At the time of coding this, WEAPON:OwnerChanged does not work for the first spawn and drop! (Which causes issues!!)
		-- https://github.com/Facepunch/garrysmod-issues/issues/4639
		if IsValid(self) and IsValid(self.LastOwner) and isnumber(self.OurIndex) then -- This is done to fix the viewmodel after dropping
			self.LastOwner:SendLua("local Ent = Entity(" .. self.OurIndex .. "); if IsValid(Ent) then Ent:Holster() end")
		end
	end
end