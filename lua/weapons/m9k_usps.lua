if not MMM_M9k_IsBaseInstalled then return end -- Make sure the base is installed!

SWEP.Base = "bobs_gun_base"
SWEP.Category = "M9K+ Pistols"
SWEP.PrintName = "HK USP Silenced"

SWEP.Slot = 1
SWEP.Spawnable = true

SWEP.ViewModelFOV = 65
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/usps/v_pist_usp.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fokkususp.mdl"

SWEP.Primary.Sound = "weapons/Navaro's USP/usp1.wav"
SWEP.Primary.RPM = 335
SWEP.Primary.ClipSize = 15
SWEP.Primary.DefaultClip = 45

SWEP.Primary.KickUp = 1.6
SWEP.Primary.KickDown = 1.1
SWEP.Primary.KickHorizontal = 1.1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.NumShots = 1
SWEP.Primary.Damage = 19
SWEP.Primary.Spread = .019

SWEP.IronSightsPos = Vector(-1.95,0,0.77)

-- Since this weapon requires different sequences, we need to copy some parts from the base (slightly modified)

local effectData = EffectData()

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self.OurIndex = self:EntIndex()

	if SERVER and game.SinglePlayer() then -- In singleplayer we need to force the weapon to be equipped after spawning
		timer.Simple(0,function()
			if not IsValid(self) or not IsValid(self.Owner) then return end -- We need to abort when the owner already had the weapon!
			self.Owner:SelectWeapon(self:GetClass())
		end)
	end

	if CLIENT then
		self.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_usps")

		if self.Owner == LocalPlayer() then
			self:SendWeaponAnim(ACT_VM_IDLE_SILENCED)

			if self.Owner:GetActiveWeapon() == self then -- Compat/Bugfix
				self:Equip()
				self:Deploy()
			end
		end
	end
end

function SWEP:Deploy()
	if SERVER and game.SinglePlayer() then self:CallOnClient("Deploy") end -- Make sure that it runs on the CLIENT!
	self:SetHoldType(self.HoldType)

	local vm = self.Owner:GetViewModel()
	if IsValid(vm) then -- This is required since the code should only run on the server or on the player holding the gun (Causes errors otherwise)
		self.CanReload = false
		self:SetNWBool("CanIronSights",false)
		self:SendWeaponAnim(ACT_VM_DRAW_SILENCED)

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

function SWEP:AttackAnimation()
	if not IsValid(self.Owner) then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
end

function SWEP:PrimaryAttack()
	if SERVER and game.SinglePlayer() then self:CallOnClient("PrimaryAttack") end -- Make sure that it runs on the CLIENT!

	if self.Owner:WaterLevel() == 3 then -- No weapons may fire underwater
		if SERVER then
			self:EmitSound("Weapon_Pistol.Empty")
		end

		self:SetNextPrimaryFire(CurTime() + 0.2)
		return
	end

	if self:CanPrimaryAttack() and (self:GetNextPrimaryFire() < CurTime() or game.SinglePlayer()) then
		local Spread = self.Primary.Spread

		if self.ShouldDoMoveSpread then
			if self.Owner:GetVelocity():Length() > 100 then
				Spread = self.Primary.Spread * 6
			elseif self.Owner:KeyDown(IN_DUCK) then
				Spread = self.Primary.Spread / 2
			end
		end

		self:SetNextPrimaryFire(CurTime() + 1 / (self.Primary.RPM / 60))

		if self.IronSightState then -- Let us not play messy fire animations while aiming down the sights.. WE WANT TO SEE DAMMIT!
			self:SendWeaponAnim(ACT_VM_IDLE_SILENCED) -- Unfortunately this gets rid of the muzzleflash and brass ejection (So we need to simulate it.)

			if (CLIENT or (SERVER and game.SinglePlayer())) and IsFirstTimePredicted() then
				local vm = self.Owner:GetViewModel()
				local vmAttachment = vm:GetAttachment("1")

				if istable(vmAttachment) then
					effectData:SetScale(1)
					effectData:SetEntity(vm)
					effectData:SetMagnitude(1)
					effectData:SetAttachment(1)
					effectData:SetOrigin(vmAttachment.Pos)
					effectData:SetAngles(vmAttachment.Ang)
					util.Effect("CS_MuzzleFlash",effectData)

					vmAttachment = vm:GetAttachment("2")

					if istable(vmAttachment) then
						effectData:SetAttachment(2)
						effectData:SetOrigin(vmAttachment.Pos)
						effectData:SetAngles(vmAttachment.Ang)
						util.Effect("ShellEject",effectData)
					end
				end
			end

			self.PrimaryAnimationInt = 3 -- Recoil.
		else
			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK_SILENCED)
		end

		self:MuzzleFlash() -- IDK if this is really needed tbh

		if CLIENT and game.SinglePlayer() then return end

		self:TakePrimaryAmmo(1)
		self:ShootBullet((1 * self.Primary.Damage) * math.Rand(.85,1.3),self.Primary.Recoil,self.Primary.NumShots,Spread)
		self:AttackAnimation()
		self:EmitSound(self.Primary.Sound,65)
	end
end

function SWEP:Reload()
	if SERVER and game.SinglePlayer() then self:CallOnClient("Reload") end -- Make sure that it runs on the CLIENT!

	if self.CanReload and self.Owner:GetAmmoCount(self.Primary.Ammo) >= 1 and self:Clip1() < self.Primary.ClipSize then
		if self.IronSightState then
			self.Owner:SetFOV(0,0.3)
			self.IronSightState = false
			self.DrawCrosshair = true
		end

		self.Owner:SetAnimation(PLAYER_RELOAD)
		self:DefaultReload(ACT_VM_RELOAD_SILENCED)

		if SERVER then
			local vm = self.Owner:GetViewModel()

			if IsValid(vm) then
				self:SetNWBool("CanIronSights",false)

				timer.Simple(vm:SequenceDuration() + 0.1,function()
					if not IsValid(self) or not IsValid(self.Owner) or not IsValid(self.Owner:GetActiveWeapon()) or self.Owner:GetActiveWeapon():GetClass() ~= self:GetClass() then return end
					self:SetNWBool("CanIronSights",true)
				end)
			end
		end
	end
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