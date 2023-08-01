class CfgFunctions {
    class overwrite_medical_treatment {
        tag = "ace_medical_treatment";
        class ace_medical_treatment {
            class cprLocal {
                file = QPATHTOF(functions\fnc_cprLocal.sqf);
            };
            class cprSuccess {
                file = QPATHTOF(functions\fnc_cprSuccess.sqf);
            };
        };
    };
};
