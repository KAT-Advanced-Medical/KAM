// Overwrite for ACE_Medical_StateMachine
class ACE_Medical_StateMachine {
    class Unconscious {
        class DeathAI {
            condition = QFUNC(conversionCheck);
        };
    };
    class FatalInjury {
        class SecondChance {
            condition = QFUNC(conditionSecondChance);
        };
    };
    class CardiacArrest {
        class DeathAI {
            condition = QFUNC(conversionCheck);
        };
        class Execution {
            condition = QFUNC(conditionExecutionDeath);
        };
    };
};