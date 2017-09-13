// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Door_lockDoor.sqf
//	@file Author: LouD / Cael817, modified by wiking.at[AJ]
//	@file Description: Door script


private ["_doors"];
_doors = (nearestObjects [player, ["Land_Canal_Wall_10m_F", "Land_Mil_WallBig_4m_F"], 10]);

if (!isNil "_doors") then
{
	{
		if (cursortarget getVariable ["owneruid", "undef"] == _x getVariable ["owneruid", "undef2"]) then  //check if door and key are owned by the same player
		{
			[[_x, false], "A3W_fnc_hideObjectGlobal"] call A3W_fnc_MP;			
		}
		else
		{
		["The door and the opener have to be locked by the same player", 5] call mf_notify_client;
		};	
	} forEach _doors;
//cursortarget setObjectTextureGlobal [0, "#(argb,8,8,3)color(0,0,0,0.0,co)"];
//cursortarget setObjectTextureGlobal [1, "#(argb,8,8,3)color(0,0,0,0.0,co)"];
} 
else 
{
	["No locked door found", 5] call mf_notify_client;
};