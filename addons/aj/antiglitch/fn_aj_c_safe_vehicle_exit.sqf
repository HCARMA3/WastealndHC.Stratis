// @file Name: fn_aj_c_safe_vehicle_exit.sqf
// @file Author:  wiking.at
// @file Author: www.armajunkies.de
// check if player tries to bug through wall by exiting vehicle near it


private["_player", "_position", "_vehicle", "_player_Pos","_vehicle_Pos", "_blocked"];
 
uisleep 1;
_player = _this select 0;
_position = _this select 1;
_vehicle = _this select 2;
 
_player_Pos = aimPos _player;
_vehicle_Pos = aimPos _vehicle;
 
_veh_position = getPos _vehicle;
 
_blocked = lineIntersects [_player_Pos, _vehicle_Pos, _player, _vehicle];

//systemchat Format["unit:%1,position:%2,vehicle%3,blocked:%4",_player,_position,_vehicle,_blocked ];

//only check this near bases
_baseradius = ["A3W_AJBaseRadius", 60] call getPublicVar;
_in_rad_1_5 = [_baseradius * 1.5] call fn_checkBaseLock;
 
if (_blocked && _in_rad_1_5 && (_vehicle iskindof "AllVehicles") && !(_vehicle iskindof "Steerable_Parachute_F") && !(_vehicle iskindof "NonSteerable_Parachute_F")) then {
           
    publicVariableServer format["!GLITCH Wall/Car - VehiclePos: %1 @%2 - veh %3", _vehicle_Pos, mapgridposition _player, typeof _vehicle];

    _msg = "Move away from objects to get out of car.";
    hint _msg;
    1 cutText [format ['%1',_msg],'WHITE IN'];
    systemChat _msg;

    _kill_player = false;

    if (locked _vehicle < 2) then {
            switch (true) do {
                    case ((_vehicle emptyPositions "driver") > 0):
                    {
                        player action ["getInDriver", _vehicle];
                    };
                    case ((_vehicle emptyPositions "cargo") > 0):
                    {
                        player action ["GetInCargo", _vehicle];
                    }; 
                    case ((_vehicle emptyPositions "gunner") > 0):
                    {
                        player action ["GetInGunner", _vehicle];
                    };
                    case ((_vehicle emptyPositions "commander") > 0):
                    {
                        player action ["GetInCommander", _vehicle];
                    };
                    default
                    {
                        _kill_player = true;
                    };
            };
    } else {
        _kill_player = true;
    };

    if (_kill_player) then {
        _player setdamage 1;
    };
	
};