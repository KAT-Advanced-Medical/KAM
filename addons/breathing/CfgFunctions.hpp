class CfgFunctions {
    class overwrite_medicalTreatment {
        tag = "ace_medical_treatment";
        class ace_medical_treatment {
            class fullHealLocal {
                file = QPATHTOF(functions\fnc_fullHealLocal.sqf);
            };
        };
    };
    class overwrite_medicalTreatment {
        tag = "ace_medical_feedback";
        class ace_medical_feedback {
            class handleEffects {
                file = QPATHTOF(functions\fnc_handleEffects.sqf);
            };
        };
    };
};
