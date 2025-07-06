class CfgVehicles {
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

    /*class GVAR(manageAirway_module): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(manageAirway_Module_displayname);
        curatorInfoType = QGVAR(RscManageAirway);
        icon = QACEPATHTOF(medical_gui,data\categories\airway_management.paa);
    };*/

    class GVAR(bloodType_module): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(bloodType_Module_displayname);
        curatorInfoType = QGVAR(RscChangeBloodType);
        icon = QACEPATHTOF(medical_feedback,data\bloodVolume_1.paa);
    };

    class GVAR(cardiacState_module): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(CardiacState_Module_displayname);
        curatorInfoType = QGVAR(RscCardiacStateModule);
        icon = QACEPATHTOF(medical_gui,data\categories\advanced_treatment.paa);
    };

    class GVAR(toggleAIDeath_module): GVAR(baseModule) {
        author = "Blue";
        curatorCanAttach = 1;
        displayName = CSTRING(toggleAIDeath_Module_displayname);
        function = QFUNC(toggleAIDeathModule);
        icon = QPATHTOF(ui\Icon_Module_Zeus_Prevent_AI_Death.paa);
    };
    class GVAR(takeUnitSnapshot_module): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(takeUnitSnapshot_Module_displayname);
        function = QFUNC(takeUnitSnapshot);
        icon = QACEPATHTOF(medical_gui,data\categories\examine_patient.paa);
    };
    class GVAR(serializeState_module): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(serializeState_Module_displayname);
        function = QFUNC(serializeState_module);
        icon = QACEPATHTOF(medical_gui,data\categories\examine_patient.paa);
    };
    class GVAR(deserializeState_module): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(deserializeState_Module_displayname);
        curatorInfoType = QGVAR(RscSerializeStateModule);
        icon = QACEPATHTOF(medical_gui,data\categories\examine_patient.paa);
    };
};