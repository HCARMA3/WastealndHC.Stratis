// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: terrorGroup1.sqf
//  @modified by wiking.at [AJ]

if (!isServer) exitWith {};

private ["_group", "_pos", "_nbUnits", "_unitTypes", "_uPos", "_unit"];

_group = _this select 0;
_pos = _this select 1;
_nbUnits = param [2, 7, [0]];
_radius = param [3, 10, [0]];

_unitTypes =
[
	"C_Man_casual_1_F_tanoan", 
	"C_Man_casual_2_F_tanoan", 
	"C_Man_casual_3_F_tanoan", 
	"C_Man_casual_4_F_tanoan", 
	"C_Man_casual_5_F_tanoan", 
	"C_Man_casual_6_F_tanoan" 
];

for "_i" from 1 to _nbUnits do
{
	_uPos = _pos vectorAdd ([[random _radius, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_unit = _group createUnit [_unitTypes call BIS_fnc_selectRandom, _uPos, [], 0, "Form"];
	_unit setPosATL _uPos;

	removeAllWeapons _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;

	switch (true) do
	{
		// Grenadier every 3 units
		case (_i % 3 == 0):
		{
			_unit addVest "V_TacVest_brn";
			_unit forceAddUniform "U_BG_Guerilla1_1";
			_unit addMagazines ["SmokeShell", 2];
			for "_i" from 1 to 3 do {_unit addItemToUniform "30Rnd_556x45_Stanag";};
			for "_i" from 1 to 3 do {_unit addItemToVest "30Rnd_556x45_Stanag";};
			_unit addItemToVest "HandGrenade";
			_unit addHeadgear "H_Shemag_olive";
			_unit addGoggles "G_Lady_Blue";
			_unit addMagazine "1Rnd_HE_Grenade_shell";
			_unit addWeapon "arifle_SPAR_01_GL_snd_F";
			_unit addMagazine "1Rnd_HE_Grenade_shell";
			_unit addMagazine "1Rnd_HE_Grenade_shell";
		};
		// RPG-7 every 7 units, starting from second one
		case ((_i + 5) % 7 == 0):
		{
			_unit addVest "V_HarnessO_brn";
			_unit forceAddUniform "U_I_C_Soldier_Bandit_2_F";
			_unit addBackpack "B_AssaultPack_ocamo";
			for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_762x39_Mag_Green_F";};
			for "_i" from 1 to 3 do {_unit addItemToVest "30Rnd_762x39_Mag_Green_F";};
			for "_i" from 1 to 4 do {_unit addItemToBackpack "RPG7_F";};
			_unit addMagazines ["SmokeShell", 2];
			_unit addHeadgear "H_ShemagOpen_tan";
			_unit addGoggles "G_Bandanna_tan";
			_unit addWeapon "arifle_AKM_F";
			_unit addWeapon "launch_RPG7_F";
		};
		// AA every 6 units
		case (_i % 7 == 0):
		{
			_unit addVest "V_Chestrig_oli";
			_unit forceAddUniform "U_I_C_Soldier_Para_1_F";
			_unit addBackpack "B_TacticalPack_oli";
			for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_762x39_Mag_Green_F";};
			for "_i" from 1 to 3 do {_unit addItemToVest "30Rnd_762x39_Mag_Green_F";};
			for "_i" from 1 to 2 do {_unit addItemToBackpack "Titan_AA";};
			_unit addMagazines ["SmokeShell", 2];
			_unit addHeadgear "H_Bandanna_camo";
			_unit addGoggles "G_Squares_Tinted";
			_unit addWeapon "arifle_AKM_F";
			_unit addWeapon "launch_O_Titan_ghex_F";
		};
		// Rifleman
		default
		{

			if (_unit == leader _group) then
			{			
			_unit addVest "V_Chestrig_oli";
			_unit forceAddUniform "U_I_C_Soldier_Camo_F";
			_unit addBackpack "B_AssaultPack_khk";
			for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_762x39_Mag_Green_F";};
			for "_i" from 1 to 3 do {_unit addItemToVest "30Rnd_762x39_Mag_Green_F";};
			_unit addMagazines ["SmokeShellYellow", 1];
			_unit addHeadgear "H_Booniehat_khk";
			_unit addGoggles "G_Aviator";
			_unit addWeapon "arifle_AKM_F";

			}
			else
			{
			_unit addVest "V_HarnessO_brn";
			_unit forceAddUniform "U_C_HunterBody_grn";
			for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_545x39_Mag_F";};
			for "_i" from 1 to 3 do {_unit addItemToVest "30Rnd_545x39_Mag_F";};
			_unit addMagazines ["SmokeShell", 1];
			_unit addHeadgear "H_Bandanna_cbr";
			_unit addGoggles "G_Bandanna_khk";
			_unit addWeapon "arifle_AKS_F";
			};
		};
	};
	
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit  linkItem "ItemRadio";

	_unit addRating 1e11;
	_unit spawn refillPrimaryAmmo;
	_unit call setMissionSkill;
	_unit addEventHandler ["Killed", server_playerDied];
	_unit setVariable ["AI_MoneyDrop", true, true];
    
    // Give AI a new magazine (same type as old one) on reload if only 2 clips left
    _unit addeventhandler ["Reloaded", {
         if (count (magazines  (_this select 0) ) < 3 ) then {
         (_this select 0) addMagazine ((_this select 4) select 0)
         }
    }];
};


//[_group, _pos] call defendArea;