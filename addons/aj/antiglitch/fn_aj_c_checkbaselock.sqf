// @file Name: fn_aj_c_checkbaselock.sqf
// @file Author:  wiking.at
// @file Author: www.armajunkies.de
// check base lock status function
// Param  can be distance check

_dist = _this select 0;
_distcheck = ["A3W_AJBaseRadius", 60] call getPublicVar;

if !(isNil "_dist") then {
_distcheck = _dist;
};

_return = false;

_reLockers = nearestObjects [player, ["Land_Device_assembled_F"], _distcheck];
				if (count _reLockers > 0) then { 
					{
						//check if any baselocker in distance is under lockdown (not only nearest as old script)
						if (_x getVariable ["lockDown", false] && alive _x) then { 
						_return = true;
						}
					} forEach _reLockers;
				};
_return