scriptName "teargasEffect";
/*--------------------------------------------------------------------
	-------------------- Armajunkies Wasteland -----------------------
	------------------------------------------------------------------

	- This Wasteland Version is a completely new code build. -
	- Please do not just copy and paste this code, there could be server dependencies -


	file: teargasEffect.sqf
	path: /E/Arma3Dev/Missions/particle_test.altis/teargasEffect.sqf
	=======================
	Author: Hatchet Harry <orga@armajunkies.de>
	Modified by:
	Description: Creates a Teargas Effect
	Parameter(s):
	Returns:
--------------------------------------------------------------------*/
#define __filename "teargasEffect.sqf"

if(headgear player find "PilotHelmetFighter" > -1 || headgear player find "CrewHelmetHeli" > -1 || headgear player find "H_HelmetO_ViperSP_ghex_F" > -1 || headgear player find "H_HelmetO_ViperSP_hex_F" > -1) exitWith {false};
player setFatigue 1;
0 = ["WetDistortion", 500, [
	1,
	0, 1,
	4.10, 3.70, 2.50, 1.85,
	0.0054, 0.0041, 0.05, 0.0070,
	0.1, 0.1, 0.1, 0.1
]] spawn {
	params ["_name", "_priority", "_effect", "_handle"];
	7+ {
		_handle = ppEffectCreate [_name, _priority];
		_handle < 0
	} do {
		_priority = _priority + 1;
	};
	_handle ppEffectEnable true;
	_handle ppEffectAdjust _effect;
	_handle ppEffectCommit 5;
	waitUntil {ppEffectCommitted _handle};
	_handle ppEffectAdjust [
	0,
	0, 0,
	4.10, 3.70, 2.50, 1.85,
	0, 0, 0, 0,
	0, 0, 0, 0
	];
	_handle ppEffectCommit 5;
	waitUntil {ppEffectCommitted _handle};
	//uiSleep 3;
	comment "admire effect for a sec";
	_handle ppEffectEnable false;
	ppEffectDestroy _handle;
};
0 = ["ChromAberration", 499, [0.15, 0.15, true]] spawn {
	params ["_name", "_priority", "_effect", "_handle1"];
	while {
		_handle1 = ppEffectCreate [_name, _priority];
		_handle1 < 0
	} do {
		_priority = _priority + 1;
	};
	_handle1 ppEffectEnable true;
	_handle1 ppEffectAdjust _effect;
	_handle1 ppEffectCommit 7;
	waitUntil {ppEffectCommitted _handle1};
	_handle1 ppEffectAdjust [0, 0, false];
	_handle1 ppEffectCommit 11;
	waitUntil {ppEffectCommitted _handle1};
	//uiSleep 3;
	comment "admire effect for a sec";
	_handle1 ppEffectEnable false;
	ppEffectDestroy _handle1;
};

0 = ["DynamicBlur", 200, [3]] spawn {
	params ["_name", "_priority", "_effect", "_handle"];
	while {
		_handle = ppEffectCreate [_name, _priority];
		_handle < 0
	} do {
		_priority = _priority + 1;
	};
	_handle ppEffectEnable true;
	_handle ppEffectAdjust _effect;
	_handle ppEffectCommit 3;
	waitUntil {ppEffectCommitted _handle};
	_handle ppEffectAdjust [0];
	_handle ppEffectCommit 3;
	waitUntil {ppEffectCommitted _handle};
	//uiSleep 3;
	comment "admire effect for a sec";
	_handle ppEffectEnable false;
	ppEffectDestroy _handle;
};
(vehicle player) setVehicleLock "Unlocked";
player action ["Eject",vehicle player];



