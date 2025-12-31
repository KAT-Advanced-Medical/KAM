class CfgFunctions {
    class overwrite_ace_advanced_fatigue {
        tag = "ace_advanced_fatigue";
        class ace_advanced_fatigue {
            class getMetabolicCosts {
                file = QPATHTOF(functions\fnc_getMetabolicCosts.sqf);
            };
            class mainLoop {
                file = QPATHTOF(functions\fnc_mainLoop.sqf);
            };
        };
    };
};
