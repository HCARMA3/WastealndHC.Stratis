scriptName "fn_aj_c_evtookSomeThing";
/*--------------------------------------------------------------------
	-------------------- Armajunkies Wasteland -----------------------
	------------------------------------------------------------------

	- This Wasteland Version is a completely new code build. -
	- Please do not just copy and paste this code, there could be server dependencies -


	file: fn_aj_c_evInventoryClosed.sqf
	path: /E/Arma3Dev/BitBucket/ArmajunkiesWasteland/ArmajunkiesWasteland.altis/AJ/aj_clientFunctions/eventHandlers/fn_aj_c_evInventoryClosed.sqf
	===================================
	Author: Hatchet Harry <info@armajunkies.de>
	Modified by:
	Description: this file just spawns functions on event handlers and delivers the needed data to the function.
	EV Description: https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#Take
	Parameter(s): ev parameters
	Returns:
--------------------------------------------------------------------*/
#define __filename "fn_aj_c_evtookSomeThing.sqf"
/*
_unit = param [0, objNull, [objNull];
_FromContainer = param [1, objNull, [objNull];
_tookItemType = param [2, "", [""];
Removed, not in use
//TODO: Switch to params - full engine blown
*/
0 spawn armajunkies_fnc_aj_c_limitAttachedScope;