class CfgFunctions {
    class overwrite_ace_medical_status {
        tag = "ace_medical_status";
        class ace_medical_status {
            class setDead {
                file = QPATHTOF(functions\fnc_setDead.sqf);
            };
        };
    };
};