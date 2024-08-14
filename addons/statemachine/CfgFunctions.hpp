class CfgFunctions {
    class overwrite_ace_medical_statemachine {
        tag = "ace_medical_statemachine";
        class ace_medical_statemachine {
            class conditionExecutionDeath {
                file = QPATHTOF(functions\fnc_conditionExecutionDeath.sqf); //TODO move these over here
            };
            class conditionSecondChance {
                file = QPATHTOF(functions\fnc_conditionSecondChance.sqf);
            };
        };
    };
};
