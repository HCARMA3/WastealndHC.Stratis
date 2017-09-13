scriptName "fn_aj_s_hideObjectGlobal";
// @file Name: fn_aj_s_hideObjectGlobal.sqf
// @file Author:  wiking.at
// @file Author: www.armajunkies.de

if (isServer) then 
	{
	
	private["_left", "_right"];
    _left = _this select 0;  //if you send the first parmaeter to this function do a "netid _x" on the object 
    _right = _this select 1;
    
//	diag_log format ["Serverfunc triggered: _left %1, _right %2",_left,_right];
	
	if (isNil "_left" || {typeName _left != typeName objNull || {isNull _left}}) exitWith {};   //exit if _left is not object
    if (isNil "_right" || {typeName _right != typeName false}) exitWith {};  					//exit if _right is not bool

    _left hideObjectGlobal _right;
//	diag_log "hideobjectglobal was run";
	};