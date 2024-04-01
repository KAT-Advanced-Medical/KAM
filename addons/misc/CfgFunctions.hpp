class CfgFunctions {
    class overwrite_ace_dragging {
        tag = "ace_dragging";
        class ace_dragging {
            class carryObject {
                file = QPATHTOF(functions\fnc_carryObject.sqf);
            };
            class handleUnconscious {
                file = QPATHTOF(functions\fnc_handleUnconscious.sqf);
            };
        };
    };
    class overwrite_ace_medical_engine {
        tag = "ace_medical_engine";
        class ace_medical_engine {
            class updateDamageEffects {
                file = QPATHTOF(functions\fnc_updateDamageEffects.sqf);
            };
        };
    };
    class overwrite_medical_treatment {
        tag = "ace_medical_treatment";
        class ace_medical_treatment {
            class treatment {
                file = QPATHTOF(functions\fnc_treatment.sqf);
            };
            class treatmentSuccess {
                file = QPATHTOF(functions\fnc_treatmentSuccess.sqf);
            };
            class useItem {
                file = QPATHTOF(functions\fnc_useItem.sqf);
            };
        };
    };
    class ace_medical {
        tag = "ace_medical";
        class ace_medical {
            class setUnconscious {
                file = QPATHTOF(functions\fnc_setUnconscious.sqf);
            };
        };
    };
    class overwrite_ace_medical_status {
        tag = "ace_medical_status";
        class ace_medical_status {
            class hasStableVitals {
                file = QPATHTOF(functions\fnc_hasStableVitals.sqf);
            };
        };
    };
    class overwrite_dogtags {
        tag = "ace_dogtags";
        class ace_dogtags {
            class getDogtagData {
                file = QPATHTOF(functions\fnc_getDogtagData.sqf);
            };
            class canCheckDogtag {
                file = QPATHTOF(functions\fnc_canCheckDogtag.sqf);
            };
        };
    };
    class overwrite_ace_medical_statemachine {
        tag = "ace_medical_statemachine";
        class ace_medical_statemachine {
            class conditionExecutionDeath {
                file = QPATHTOF(functions\fnc_conditionExecutionDeath.sqf);
            };
            class conditionSecondChance {
                file = QPATHTOF(functions\fnc_conditionSecondChance.sqf);
            };
        };
    };
};
