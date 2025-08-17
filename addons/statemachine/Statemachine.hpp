// Overwrite for ACE_Medical_StateMachine
class KAT_StateMachine {
    list = QUOTE(call ACEFUNC(common,getLocalUnits));
    skipNull = 1;
    class Default {
        onState = QACEFUNC(medical_statemachine,handleStateDefault);
        class Injury {
            targetState = "Injured";
            events[] = {QACEGVAR(medical,injured), QACEGVAR(medical,LoweredVitals)};
        };
        class CriticalInjuryOrVitals {
            targetState = "Unconscious";
            events[] = {QACEGVAR(medical,CriticalInjury), QACEGVAR(medical,CriticalVitals), QACEGVAR(medical,knockOut)};
        };
        class FatalVitals {
            targetState = "CardiacArrest";
            events[] = {QACEGVAR(medical,FatalVitals), QACEGVAR(medical,Bleedout)};
        };
        class FatalInjury {
            targetState = "FatalInjury";
            events[] = {QACEGVAR(medical,FatalInjury)};
        };
    };
    class Injured {
        onState = QACEFUNC(medical_statemachine,handleStateInjured);
        class FullHeal {
            targetState = "Default";
            events[] = {QACEGVAR(medical,FullHeal)};
        };
        class CriticalInjuryOrVitals {
            targetState = "Unconscious";
            events[] = {QACEGVAR(medical,CriticalInjury), QACEGVAR(medical,CriticalVitals), QACEGVAR(medical,knockOut)};
        };
        class FatalVitals {
            targetState = "CardiacArrest";
            events[] = {QACEGVAR(medical,FatalVitals), QACEGVAR(medical,Bleedout)};
        };
        class FatalInjury {
            targetState = "FatalInjury";
            events[] = {QACEGVAR(medical,FatalInjury)};
        };
    };
    class Unconscious {
        onState = QACEFUNC(medical_statemachine,handleStateUnconscious);
        onStateEntered = QACEFUNC(medical_statemachine,enteredStateUnconscious);
        class DeathAI {
            targetState = "Dead";
            condition = QUOTE(!(_this getVariable [ARR_2(QQACEGVAR(medical_statemachine,AIUnconsciousness),ACEGVAR(medical_statemachine,AIUnconsciousness))]) && {!isPlayer _this});
        };
        class WakeUp {
            targetState = "Injured";
            condition = QACEFUNC(medical_status,hasStableVitals);
            events[] = {QACEGVAR(medical,WakeUp)};
            onTransition = QUOTE([ARR_2(_this,false)] call ACEFUNC(medical_status,setUnconsciousState));
        };
        class FatalTransitions {
            targetState = "CardiacArrest";
            events[] = {QACEGVAR(medical,FatalVitals), QACEGVAR(medical,Bleedout)};
        };
        class FatalInjury {
            targetState = "FatalInjury";
            events[] = {QACEGVAR(medical,FatalInjury)};
        };
        class EnterSeizure {
            targetState = "Seizure";
            condition = QUOTE((GVAR(enableSeizure))); // wrapped to allow cba to read code  //TODO also check brain sim is on
            events[] = {QEGVAR(brain,enterSeizure)};
        };
    };
    class FatalInjury {
        // Transition state for handling instant death from fatal injuries
        // This state raises the next transition in the same frame
        onStateEntered = QACEFUNC(medical_statemachine,enteredStateFatalInjury);
        class SecondChance {
            events[] = {QACEGVAR(medical,FatalInjuryInstantTransition)};
            targetState = "CardiacArrest";
            condition = QACEFUNC(medical_statemachine,conditionSecondChance);
            onTransition = QACEFUNC(medical_statemachine,transitionSecondChance);
        };
        class Death {
            events[] = {QACEGVAR(medical,FatalInjuryInstantTransition)};
            targetState = "Dead";
        };
    };
    class CardiacArrest {
        onState = QACEFUNC(medical_statemachine,handleStateCardiacArrest);
        onStateEntered = QACEFUNC(medical_statemachine,enteredStateCardiacArrest);
        onStateLeaving = QACEFUNC(medical_statemachine,leftStateCardiacArrest);
        class DeathAI {
            // If an AI unit reanimates, they will immediately die upon entering unconsciousness if AI Unconsciousness is disabled
            // As a result, we immediately kill the AI unit since cardiac arrest is effectively useless for it
            targetState = "Dead";
            condition = QUOTE(!ACEGVAR(medical_statemachine,AIUnconsciousness) && {!isPlayer _this});
        };
        class Timeout {
            targetState = "Dead";
            condition = QACEFUNC(medical_statemachine,conditionCardiacArrestTimer);
        };
        class Reanimation {
            targetState = "Unconscious";
            events[] = {QACEGVAR(medical,CPRSucceeded)};
        };
        class Execution {
            targetState = "Dead";
            condition = QACEFUNC(medical_statemachine,conditionExecutionDeath);
            events[] = {QACEGVAR(medical,FatalInjury)};
        };
        class Bleedout {
            targetState = "Dead";
            condition = QUOTE((ACEGVAR(medical_statemachine,cardiacArrestBleedoutEnabled))); // wrap to ensure cba uses this as code and not a direct variable
            events[] = {QACEGVAR(medical,Bleedout)};
        };
    };
    class Seizure {
        onStateEntered = QFUNC(enteredStateSeizure);
        onState = QFUNC(handleStateSeizure);
        class ExitSeizure {
            targetState = "Unconscious";
            events[] = {QEGVAR(brain,exitSeizure)};
        };
        class FatalTransitions {
            targetState = "CardiacArrest";
            events[] = {QACEGVAR(medical,FatalVitals), QACEGVAR(medical,Bleedout)};
        };
        class FatalInjury {
            targetState = "FatalInjury";
            events[] = {QACEGVAR(medical,FatalInjury)};
        };
    };
    class Dead {
        // When the unit is killed it's no longer handled by the statemachine
        onStateEntered = QACEFUNC(medical_statemachine,enteredStateDeath);
    };
};
