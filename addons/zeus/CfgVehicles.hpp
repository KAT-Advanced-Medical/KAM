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
        icon = "\z\ace\addons\medical_gui\data\categories\airway_management.paa";
    };

    class GVAR(bloodType_module): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(bloodType_Module_displayname);
        curatorInfoType = QGVAR(RscChangeBloodType);
        icon = "\z\ace\addons\medical_feedback\data\bloodVolume_1.paa";
    };

    class GVAR(asystole_module): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(shockablestate_Module_displayname);
        curatorInfoType = QGVAR(RscAsystoleModule);
        icon = "\z\ace\addons\medical_gui\data\categories\advanced_treatment.paa";
    };

    class GVAR(checkmedical_module): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(checkmedical_Module_displayname);
        function = QFUNC(openMedicalMenu);
        icon = "\z\ace\addons\medical_gui\data\categories\triage_card.paa";
    };

};