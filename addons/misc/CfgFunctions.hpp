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
            class hasItem {
                file = QPATHTOF(functions\fnc_hasItem.sqf);
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
};
