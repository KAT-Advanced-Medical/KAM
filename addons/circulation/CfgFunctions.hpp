class CfgFunctions {
    class overwrite_medical_treatment {
        tag = "ace_medical_treatment";
        class ace_medical_treatment {
            class canTreat {
                file = QPATHTOF(functions\fnc_canTreat.sqf);
            };
            class cprLocal {
                file = QPATHTOF(functions\fnc_cprLocal.sqf);
            };
            class cprSuccess {
                file = QPATHTOF(functions\fnc_cprSuccess.sqf);
            };
        };
    };
    class overwrite_medical_vitals {
        tag = "ace_medical_vitals";
        class ace_medical_treatment {
            class updateHeartRate {
                file = QPATHTOF(functions\fnc_updateHeartRate.sqf);
            };
        };
    };
};
