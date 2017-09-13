class aj_client_general_eventhandlers { //Allgemein verwendbare Clientfunctions
	file="addons\aj\eventHandlers";
	class aj_c_evInventoryClosed {};
	class aj_c_evtookSomeThing {};
};

class ajzeus {
	file="addons\aj\zeus";
	class aj_s_initZeus {preInit=1;};	
};


class teargas_functions {
	file="addons\aj\teargas";
	class aj_c_createTearTrigger {};
	class aj_c_firedWeapon {};
	class aj_s_getPlayersAndSendTriggerCommand {};
	class aj_c_teargasEffect {};
};

class money {
	file="addons\aj\aj_serverfunctions";
	class aj_s_saveMoneyToDB {};
};

class limitedWeapons {
	file="addons\aj\limitedWeapons";
	class aj_c_limitAttachedScope {};
};

