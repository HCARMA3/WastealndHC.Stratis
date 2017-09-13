// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: basePartSetup.sqf
//	@file Author: AgentRev

if (!isServer) exitWith {};

private "_obj";
_obj = _this select 0;

_obj setVariable [call vChecksum, true];

_obj addEventHandler ["Killed",
{
	_obj = _this select 0;

	if (!isNil "fn_manualObjectDelete") then
	{
		[objNull, _obj getVariable "A3W_objectID"] call fn_manualObjectDelete;
		_obj setVariable ["A3W_objectSaved", false, true];
	};
}];
//aj set flag texture
if (_obj isKindOf "FlagPole_F") then
{
	_obj setFlagTexture "image/out.jpg";
};

_obj enableDynamicSimulation true;

//diag_log "TURNOFF START";
//AJ-EDIT: TURN OFF THE LIGHTS INSIDE A BASE
//Need this complex argument, as we want all lights in range of the generator. If we just check if there is generator and turn off the lights in range, maybe some lights will spawn after the generator and are then not effected
//Wenn Lampe UND in Reichweite eines Generators, dann Licht aus
if ((_obj isKindOf "Lamps_base_F" || _obj isKindOf "PowerLines_base_F" || _obj isKindOf "PowerLines_Small_base_F") && (count (nearestObjects [_obj, ["Land_Device_assembled_F"], (["A3W_AJBaseRadius", 60] call getPublicVar)]) > 0)) then
{
    //Turn Off Lights of this one lamp/generator
    _obj setHit ["light_1_hitpoint", 0.97];
    _obj setHit ["light_2_hitpoint", 0.97];
    _obj setHit ["light_3_hitpoint", 0.97];
    _obj setHit ["light_4_hitpoint", 0.97];
    _obj setHit ["light_1_hit", 0.97];
    _obj setHit ["light_2_hit", 0.97];
    _obj setHit ["light_3_hit", 0.97];
    _obj setHit ["light_4_hit", 0.97];
    _obj setVariable ["lights", "off", true];
    //diag_log "TURNOFF Lamp single";
};

//If _obj is a generator, turn off other Lamp Lights in range, as the generator maybe spawned after the lights #MakeSureThatAllLightsAreTurnedOff
if (typeOf _obj == "Land_Device_assembled_F") then
{
    //Turn off lights for every lamp around the generator
    //diag_log "TURNOFF generator single";
    {
        _x setHit ["light_1_hitpoint", 0.97];
        _x setHit ["light_2_hitpoint", 0.97];
        _x setHit ["light_3_hitpoint", 0.97];
        _x setHit ["light_4_hitpoint", 0.97];
        _x setHit ["light_1_hit", 0.97];
        _x setHit ["light_2_hit", 0.97];
        _x setHit ["light_3_hit", 0.97];
        _x setHit ["light_4_hit", 0.97];
        _x setVariable ["lights", "off", true];
        //diag_log "TURNOFF generator foreach";
    } forEach nearestObjects [_obj, [
    "Lamps_base_F",
    "PowerLines_base_F",
    "PowerLines_Small_base_F",
    "Land_Device_assembled_F"
    ], (["A3W_AJBaseRadius", 60] call getPublicVar)];
    
    //Turn off lights for the generator itself
    _obj setHit ["light_1_hitpoint", 0.97];
    _obj setHit ["light_2_hitpoint", 0.97];
    _obj setHit ["light_3_hitpoint", 0.97];
    _obj setHit ["light_4_hitpoint", 0.97];
    _obj setHit ["light_1_hit", 0.97];
    _obj setHit ["light_2_hit", 0.97];
    _obj setHit ["light_3_hit", 0.97];
    _obj setHit ["light_4_hit", 0.97];
    _obj setVariable ["lights", "off", true];
};
//diag_log "TURNOFF STOP";
