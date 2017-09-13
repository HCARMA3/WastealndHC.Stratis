// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 	BadVolt 	*
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: password_change.sqf
//	@file Author: BadVolt
//	@file Description: Changes password for building and locks all doors.

_object = cursorTarget;

OutputText = nil;
InputText = "";
ClearText = "Enter Keycode";

createDialog "AF_Keypad";

waitUntil {!(isNil "OutputText")};

_object setVariable ["password", OutputText, true];

if (OutputText=="")then {
	["PIN lock disabled.", 5] call mf_notify_client;	
}else{
	["You successfully changed the PIN", 5] call mf_notify_client;	
	_object setVariable ["authUIDs", [], true]; //reset authUIDs on pin change.
	};	

pvar_manualObjectSave = netId _object;
publicVariableServer "pvar_manualObjectSave";

OutputText = nil;