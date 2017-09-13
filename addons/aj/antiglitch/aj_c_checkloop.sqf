// @file Name: aj_c_checkloop.sqf
// @file Author:  wiking.at
// @file Author: www.armajunkies.de
// various anti glitch checks

//eventhandler for vehicle through wall glitch
player addEventHandler ["GetOutMan", {_this spawn fnc_safe_vehicle_exit;}];


//eventhandler for duping glitch 
  player addEventHandler ["InventoryOpened", {
  		// _unit = _this select 0; 
		 _container = _this select 1; 
		 _secondarycontainer = _this select 2;		
		
		//bypass this eventhandler if item is locked anyways - a3w default eh triggers then
		if !(locked _container > 1 || (_container getVariable ["A3W_inventoryLockR3F", false] && _container getVariable ["R3F_LOG_disabled", false])) then {
			if (
				 ((_container isKindOf 'GroundWeaponHolder')||(_container isKindOf 'WeaponHolderSimulated')||(_container isKindOf 'LootWeaponHolder')||(_container isKindOf 'Man')) &&
				 (_secondarycontainer isKindof 'ReammoBox_F') 
				  
			) exitWith {
				["Move the crate away to loot the body.", 5] call mf_notify_client;
				  true   //close inventory   
			};
			false // ok - do nothing
		};
  }];

_baseradius = ["A3W_AJBaseRadius", 60] call getPublicVar;
_lastglitch = time;
_wallgames = 0;

While {true} do {
	sleep 0.5;
	
	// run and dive glich
	if(animationState player == 'amovpercmsprsnonwnondf_amovppnemstpsnonwnondnon')then {	
		_ct = cursorTarget;
		if (!isNull _ct) then {
			if((_ct isKindOf 'Building') && (_ct distance player < 4)) then {
				_in_rad_1_5 = [_baseradius * 1.5] call fn_checkBaseLock;
				if (_in_rad_1_5) then { 
						if(time - _lastglitch > 45)then{_wallgames = 0;};
						_lastglitch = time;
						player switchMove '';
						player setVelocity [0,0,0];
						if(_wallgames >= 1)then
						{
							player setHitPointDamage ['HitLegs',1];
							_log = format['!GLITCH Dive %1, %2x, @%3 (LEGS BROKEN)',typeOf _ct,_wallgames,mapGridPosition player];
							publicVariableServer _log;
						};
						if(_wallgames >= 2)then
						{
							player setPos [0,0,100];
							{player setHitPointDamage [_x,1];} forEach ['HitBody','HitHead'];
							_log = format['!GLITCH Dive %1, %2x, @%3 (KILLED THE GLITCHER)',typeOf _ct,_wallgames,mapGridPosition player];
							publicVariableServer _log;
							_wallgames = 0;	
						};
						_wallgames = _wallgames + 1;
						_msg = 'NO GLITCHING';
						hint _msg;
						1 cutText [format ['%1',_msg],'WHITE IN'];
						systemChat _msg;
					
				}; 
			};
		};
	};
	
};