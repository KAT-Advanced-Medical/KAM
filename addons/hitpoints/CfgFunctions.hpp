class CfgFunctions {
    class overwrite_ace_medical_status {
        tag = "ace_medical_status";
        class ace_medical_status {
            class hasStableVitals {
                file = QPATHTOF(functions\fnc_hasStableVitals.sqf);
            };
            class addMedicationAdjustment {
                file = QPATHTOF(functions\fnc_addMedicationAdjustment.sqf);
            };
        };
    };
    class overwrite_ace_medical_vitals {
        tag = "ace_medical_vitals";
        class ace_medical_vitals {
            class handleUnitVitals {
                file = QPATHTOF(functions\fnc_handleUnitVitals.sqf);
            };
        };
    };
};
