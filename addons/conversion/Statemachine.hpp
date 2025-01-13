// Overwrite for ACE_Medical_StateMachine
class ACE_Medical_StateMachine {
    class Unconscious {
        class DeathAI {
            condition = QFUNC(conversionCheck);
        };
    };
    class FatalInjury {
        class SecondChance {
            condition = QFUNC(KATConditionSecondChance);
        };
    };
    class CardiacArrest {
        class DeathAI {
            condition = QFUNC(conversionCheck);
        };
        class Execution {
            condition = QFUNC(KATConditionExecutionDeath);
        };
    };
};