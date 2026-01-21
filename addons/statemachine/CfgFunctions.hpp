class CfgFunctions {
    class overwrite_ace_medical_statemachine {
        tag = "ace_medical_statemachine";
        class ace_medical_statemachine {
            class enteredStateCardiacArrest {
                file = QPATHTOF(functions\fnc_enteredStateCardiacArrest.sqf);
            };
            class handleStateCardiacArrest {
                file = QPATHTOF(functions\fnc_handleStateCardiacArrest.sqf);
            };
        };
    };
};
