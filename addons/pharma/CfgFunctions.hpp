class CfgFunctions {
    class overwrite_ace_medical_status {
        tag = "ace_medical_status";
        class ace_medical_status {
            class getBloodVolumeChange {
                file = QPATHTOF(functions\fnc_getBloodVolumeChange.sqf);
            };
            class getBloodLoss {
                file = QPATHTOF(functions\fnc_getBloodLoss.sqf);
            };
            class hasStableVitals {
                file = QPATHTOF(functions\fnc_hasStableVitals.sqf);
            };
        };
    };

    class overwrite_medicalTreatment {
        tag = "ace_medical_treatment";
        class ace_medical_treatment {
            class medicationLocal {
                file = QPATHTOF(functions\fnc_treatmentAdvanced_medicationLocal.sqf);
            };
            class tourniquetRemove {
                file = QPATHTOF(functions\fnc_tourniquetRemove.sqf);
            };
        };
    };
};
