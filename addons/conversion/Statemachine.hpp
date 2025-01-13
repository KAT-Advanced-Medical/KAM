// Overwrite for ACE_Medical_StateMachine
class ACE_Medical_StateMachine {
    class Unconscious {
        class DeathAI {
            condition = QUOTE(call FUNC(conversionCheck));
        };
    };
    class FatalInjury {
        class SecondChance {
            condition = QUOTE(call FUNC(KATConditionSecondChance));
        };
    };
    class CardiacArrest {
        class DeathAI {
            condition = QUOTE(call FUNC(conversionCheck));
        };
        class Execution {
            condition = QUOTE(call FUNC(KATConditionExecutionDeath));
        };
    };
};