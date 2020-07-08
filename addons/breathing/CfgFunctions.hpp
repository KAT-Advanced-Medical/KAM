class CfgFunctions {
    class overwrite_medicalTreatment {
        tag = "ace_medical_treatment";
        class ace_medical_treatment {
            class fullHealLocal {
                file = QPATHTOF(functions\fnc_fullHealLocal.sqf);
            };
        };
    };
    class overwrite_medicalStatus {
        tag = "ace_medical_Status";
        class ace_medical_Status {
            class hasStableVitals {
                file = QPATHTOF(functions\fnc_hasStableVitals.sqf);
            };
        };
    };
};
