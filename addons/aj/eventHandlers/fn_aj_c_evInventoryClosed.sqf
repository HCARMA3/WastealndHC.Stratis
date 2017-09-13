scriptName "fn_aj_c_evInventoryClosed";
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
	EV Description: https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#InventoryClosed
	Parameter(s): ev parameters
	Returns:
--------------------------------------------------------------------*/
#define __filename "fn_aj_c_evInventoryClosed.sqf"
/*//Params from EV A3v1.50 [BIS_fnc_objectVar_obj1,<NULL-object>,"optic_Aco"]
_unit = param [0, objNull, [objNull];
_connectedContainer = param [1, objNull, [objNull];
//TODO: Switch to params - full engine blown
*/
0 spawn armajunkies_fnc_aj_c_limitAttachedScope;
