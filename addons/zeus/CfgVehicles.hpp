class cfgVehicles {
    class Module_F;

	class GVAR(baseModule): Module_F {
		author   = "DiGi";
		category = QGVAR(KAM);
		function = QFUNC(emptyFunction);
		functionPriority = 1;
		isGlobal = 1;
		isTriggerActivated = 0;
		scope = 1;
		scopeCurator = 2;
		side=7; 
	};

	class GVAR(manageAirway_module) : GVAR(baseModule) {
		curatorCanAttach = 1;
		displayName = CSTRING(manageAirway_Module_displayname);
		curatorInfoType = QGVAR(RscManageAirway);
	};

	class GVAR(bloodType_module): GVAR(baseModule) {
		curatorCanAttach = 1;
		displayName = CSTRING(bloodType_Module_displayname);
		curatorInfoType = QGVAR(RscChangeBloodType);
	};

};