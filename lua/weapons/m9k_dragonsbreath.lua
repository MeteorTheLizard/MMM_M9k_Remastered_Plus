if not MMM_M9k_IsBaseInstalled then return end -- Make sure the base is installed!

SWEP.Base = "bobs_shotty_base"
SWEP.Category = "M9K+ Shotguns"
SWEP.PrintName = "M97 Trench Gun"

SWEP.Spawnable = true

SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/dragonsbreath/v_shot_m3super90.mdl"
SWEP.WorldModel = "models/weapons/w_double_barrel_shotgun.mdl"

SWEP.Primary.Sound = "DragonFire"
SWEP.Primary.RPM = 60
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 18

SWEP.Primary.KickUp = 7
SWEP.Primary.KickDown = 5
SWEP.Primary.KickHorizontal = 9
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.NumShots = 27
SWEP.Primary.Damage = 4
SWEP.Primary.Spread = .18
SWEP.ShellTime = .6

SWEP.IronSightsPos = Vector(-1.621,-1.096,0.015)
SWEP.IronSightsAng = Vector(2.035,-0.003,0)

SWEP.ShouldDoMoveSpread = false

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