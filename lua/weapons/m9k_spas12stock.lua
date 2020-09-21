if not MMM_M9k_IsBaseInstalled then return end -- Make sure the base is installed!

SWEP.Base = "bobs_shotty_base"
SWEP.Category = "M9K+ Shotguns"
SWEP.PrintName = "SPAS 12 Closed Stock"

SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/spas12stock/v_shot_xm1014.mdl"
SWEP.WorldModel = "models/weapons/w_spas_12.mdl"
SWEP.ViewModelFOV = 60

SWEP.Primary.Sound = "SPAS.Stock.Fire"
SWEP.Primary.RPM = 165
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
SWEP.ShellTime = .45

-- SWEP.IronSightsPos = Vector(0.295,0,1.335)
-- SWEP.IronSightsAng = Vector(0,0,0)

SWEP.ShouldDoMoveSpread = false

function SWEP:IronSight() -- This weapon should not have ironsights!
end

function SWEP:Deploy()
	if SERVER and game.SinglePlayer() then self:CallOnClient("Deploy") end -- Make sure that it runs on the CLIENT!
	self:SetHoldType(self.HoldType)

	timer.Remove("ShotgunReload_" .. self.OurIndex)

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

	self.InsertingShell = false
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

	if self.InsertingShell then
		timer.Remove("ShotgunReload_" .. self.OurIndex)
		self.InsertingShell = false
		self:SetNextPrimaryFire(CurTime() + 1.25)
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