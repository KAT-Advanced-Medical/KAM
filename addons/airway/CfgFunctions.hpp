class CfgFunctions {
    class ace_medical_gui {
        tag = "ace_medical_gui";
        class ace_medical_gui {
            class displayPatientInformation {
                file = QPATHTOF(functions\fnc_displayPatientInformation.sqf);
            };
            class updateInjuryList {
                file = QPATHTOF(functions\fnc_updateInjuryList.sqf);
            };
            class updateLogList {
                file = QPATHTOF(functions\fnc_updateLogList.sqf);
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
