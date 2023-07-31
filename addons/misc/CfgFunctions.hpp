class CfgFunctions {
    class ADDON {
        tag = "ace_interaction";
        class ace_interaction {
            class addPassengersActions {
                file = QPATHTOF(functions\fnc_addPassengersActions.sqf);
            };
        };
    };
    class overwrite_medical_treatment {
        tag = "ace_medical_treatment";
        class ace_medical_treatment {
            class canTreat {
                file = QPATHTOF(functions\fnc_canTreat.sqf);
            };
            class fullHealLocal {
                file = QPATHTOF(functions\fnc_fullHealLocal.sqf);
            };
            class hasItem {
                file = QPATHTOF(functions\fnc_hasItem.sqf);
            };
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
};
