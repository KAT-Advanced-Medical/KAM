class CfgFunctions {
    class overwrite_medical_gui {
        tag = "ace_medical_gui";
        class ace_medical_gui {
            class onMenuOpen {
                file = QPATHTOF(functions\fnc_onMenuOpen.sqf);
            };
            class updateCategories {
                file = QPATHTOF(functions\fnc_updateCategories.sqf);
            };
            class updateActions {
                file = QPATHTOF(functions\fnc_updateActions.sqf);
            };
        };
    };
};
