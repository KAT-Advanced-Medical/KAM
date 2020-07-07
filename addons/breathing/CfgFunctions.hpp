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
        tag = "ace_medical_status";
        class ace_medical_status {
            class hasStableVitals {
                file = QPATHTOF(functions\fnc_hasStableVitals.sqf);
            };
        };
    };
};
