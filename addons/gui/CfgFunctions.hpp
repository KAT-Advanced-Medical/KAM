class CfgFunctions {
    class overwrite_medical_gui {
        tag = "ace_medical_gui";
        class ace_medical_gui {
            class menuPFH {
                file = QPATHTOF(functions\fnc_menuPFH.sqf);
            };
            class onMenuClose {
                file = QPATHTOF(functions\fnc_onMenuClose.sqf);
            };
            class onMenuOpen {
                file = QPATHTOF(functions\fnc_onMenuOpen.sqf);
            };
            class updateCategories {
                file = QPATHTOF(functions\fnc_updateCategories.sqf);
            };
        };
    };
};
