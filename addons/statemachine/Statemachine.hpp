// Overwrite for ACE_Medical_StateMachine
class ACE_Medical_StateMachine {
    class Unconscious {
        class DeathAI {
            condition = QUOTE(call EFUNC(conversion,conversionCheck));
        };
    };
    class FatalInjury {
        class SecondChance {
            condition = QUOTE(call EFUNC(conversion,conversionKATConditionSecondChance));
        };
    };
    class CardiacArrest {
        class DeathAI {
            condition = QUOTE(call EFUNC(conversion,conversionCheck));
        };
        class Execution {
            condition = QUOTE(call EFUNC(conversion,KATConditionExecutionDeath));
        };
    };
};