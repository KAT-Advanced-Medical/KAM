class CfgFunctions {
    class overwrite_medical_gui {
        tag = "ace_medical_gui";
        class ace_medical_gui {
            class displayPatientInformation {
                file = QPATHTOF(functions\fnc_displayPatientInformation.sqf);
            };
            class onMenuOpen {
                file = QPATHTOF(functions\fnc_onMenuOpen.sqf);
            };
            class updateActions {
                file = QPATHTOF(functions\fnc_updateActions.sqf);
            };
            class updateCategories {
                file = QPATHTOF(functions\fnc_updateCategories.sqf);
            };
            class updateInjuryList {
                file = QPATHTOF(functions\fnc_updateInjuryList.sqf);
            };
            class updateLogList {
                file = QPATHTOF(functions\fnc_updateLogList.sqf);
            };
        };
    };
};
