Config = {1}

-- 0, just attack the player. 1, total chaos
Config.HostilePeds = 1

Config.RandomWeapons = {
	"WEAPON_PISTOL", 
	"WEAPON_PISTOL_MK2", 
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_STUNGUN",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_FLAREGUN",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_REVOLVER",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_DOUBLEACTION",
	"WEAPON_RAYPISTOL",
	"WEAPON_CERAMICPISTOL",
	"WEAPON_NAVYREVOLVER",
	"WEAPON_MICROSMG", 
	"WEAPON_SMG", 
	"WEAPON_SMG_MK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_COMBATPDW",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_MINISMG",
	"WEAPON_RAYCARBINE",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_MUSKET",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DBSHOTGUN",
	"WEAPON_AUTOSHOTGUN",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2", 
	"WEAPON_CARBINERIFLE", 
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_GUSENBERG",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_RPG", 
	"WEAPON_GRENADELAUNCHER", 
	"WEAPON_MINIGUN",
	"WEAPON_FIREWORK",
	"WEAPON_RAILGUN",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_RAYMINIGUN",
	"WEAPON_DAGGER", 
	"WEAPON_BAT",
	"WEAPON_BOTTLE", 
	"WEAPON_CROWBAR",
	"WEAPON_FLASHLIGHT",
	"WEAPON_GOLFCLUB",
	"WEAPON_HAMMER",
	"WEAPON_HATCHET",
	"WEAPON_KNUCKLE", 
	"WEAPON_KNIFE", 
	"WEAPON_MACHETE",
	"WEAPON_SWITCHBLADE",
	"WEAPON_NIGHTSTICK", 
	"WEAPON_WRENCH",
	"WEAPON_BATTLEAXE",
	"WEAPON_POOLCUE", 
	"WEAPON_STONE_HATCHET",
	"WEAPON_BFG9000", 
	"WEAPON_FLAMETHROWER",
	"WEAPON_bow", 
}

-- Experiement with Ped density. No impact.
--[[
Config.PedDensity = 1

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		SetPedDensityMultiplierThisFrame(Config.PedDensity)
		SetScenarioPedDensityMultiplierThisFrame(Config.PedDensity,Config.PedDensity)
	end
end)
]]--

local relationshipTypes = {
	"CIVMALE",
	"CIVFEMALE",
	"SECURITY_GUARD",
	"PRIVATE_SECURITY",
	"FIREMAN",
	"MEDIC",
	"GANG_1",
	"GANG_2",
	"GANG_9",
	"GANG_10",
	"AMBIENT_GANG_LOST",
	"AMBIENT_GANG_MEXICAN",
	"AMBIENT_GANG_FAMILY",
	"AMBIENT_GANG_BALLAS",
	"AMBIENT_GANG_MARABUNTE",
	"AMBIENT_GANG_CULT",
	"AMBIENT_GANG_SALVA",
	"AMBIENT_GANG_WEICHENG",
	"AMBIENT_GANG_HILLBILLY",
	"DEALER",
	"HATES_PLAYER",
	"HEN",
	"WILD_ANIMAL",
	"SHARK",
	"COUGAR",
	"NO_RELATIONSHIP",
	"SPECIAL",
	"MISSION2",
	"MISSION3",
	"MISSION4",
	"MISSION5",
	"MISSION6",
	"MISSION7",
	"MISSION8",
	"ARMY",
	"GUARD_DOG",
	"AGGRESSIVE_INVESTIGATE",
	"CAT",
}

local RELATIONSHIP_HATE = 5
local RELATIONSHIP_COMPANION = 0

Citizen.CreateThread(function()
	print('Starting Ped Loop')
	while true do
		Citizen.Wait(10)
		for _, group in ipairs(relationshipTypes) do
			SetRelationshipBetweenGroups(RELATIONSHIP_HATE, GetHashKey(group), GetHashKey('PLAYER'))
			if Config.HostilePeds > 0 then
				for _, group2 in ipairs(relationshipTypes) do
					SetRelationshipBetweenGroups(RELATIONSHIP_HATE, GetHashKey(group), GetHashKey(group2))
					SetRelationshipBetweenGroups(RELATIONSHIP_HATE, GetHashKey(group2), GetHashKey(group))
				end
			end
		end
		for Ped in EnumeratePeds() do
			equipPed(Ped)
		end
    end
end)
 
function equipPed(Ped)
	-- Not a human, or the player? Ignore it.
	if (not IsPedHuman(Ped)) or (GetPedRelationshipGroupDefaultHash(Ped)==GetHashKey('PLAYER') or GetPedRelationshipGroupHash(Ped)==GetHashKey('PLAYER')) or (GetBestPedWeapon(Ped,0)~=GetHashKey("WEAPON_UNARMED")) then 
		return
	end
	local randomPedWeapon = Config.RandomWeapons[ math.random( #Config.RandomWeapons ) ]
	SetPedCombatAttributes(Ped, 5, true)	
	SetPedCombatAttributes(Ped, 16, true)
	SetPedCombatAttributes(Ped, 46, true)
	SetPedCombatAttributes(Ped, 26, true)
	SetPedCombatAttributes(Ped, 2, true)
	SetPedCombatAttributes(Ped, 1, true)
	SetPedCombatAttributes(Ped, 3, false)
	SetPedCombatAttributes(Ped, 52, true)
	SetPedCombatAttributes(Ped, 0, true)
	SetPedCombatAttributes(Ped, 20, true)
	SetPedDiesWhenInjured(Ped, true)
	SetPedAccuracy(Ped, 80)
	GiveWeaponToPed(Ped, GetHashKey(randomPedWeapon), 2800, false, true)
	SetPedInfiniteAmmo(Ped, true, randomPedWeapon)
	SetPedFleeAttributes(Ped, 0, 0)
	SetPedPathAvoidFire(Ped,1)
	SetPedPathCanUseLadders(Ped,1)
	SetPedPathCanDropFromHeight(Ped,1)
	SetPedPathCanUseClimbovers(Ped,1)
	SetPedAlertness(Ped,3)
	SetPedCombatRange(Ped,2)
	SetPedAllowedToDuck(Ped,1)
	EnableDispatchService(3, false)
	EnableDispatchService(5, false)
	if(randomPedWeapon == 0x42BF8A85) then
		SetPedFiringPattern(Ped, 0x914E786F) --FIRING_PATTERN_BURST_FIRE_HELI
	end
	ResetAiWeaponDamageModifier()
	SetAiWeaponDamageModifier(0.3) -- 1.0 == Normal Damage. 
	AddArmourToPed(Ped, 50) --<**is 100 max for npc???**
	SetPedArmour(Ped, 50)
end

local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end
    
    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)
    
    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next
    
    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

function EnumeratePeds()
  return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end