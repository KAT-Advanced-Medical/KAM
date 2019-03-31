class ACE_Medical_Actions {
    class Advanced {
        class SalineIV;
        class SalineIV_Stand: SalineIV {
            displayName = CSTRING(Display_IVStand);
            requiredMedic = 0;
            condition = QUOTE(params ['_player']; [ARR_2(_player, 1000)] call FUNC(conditionIV));
            items[] = {};
            callbackSuccess = QUOTE([ARR_5(_player, _target, _selectionName, 'SalineIV', ['ACE_salineIV'])] call FUNC(treatmentIV));
            itemConsumed = 0;
        };
        class SalineIV_Stand_500: SalineIV_Stand {
            displayName = CSTRING(Display_IVStand_500);
            condition = QUOTE(params ['_player']; [ARR_2(_player, 500)] call FUNC(conditionIV));
            callbackSuccess = QUOTE([ARR_5(_player, _target, _selectionName, 'SalineIV_500', ['ACE_salineIV_500'])] call FUNC(treatmentIV));
        };
        class SalineIV_Stand_250: SalineIV_Stand {
            displayName = CSTRING(Display_IVStand_250);
            condition = QUOTE(params ['_player']; [ARR_2(_player, 250)] call FUNC(conditionIV));
            callbackSuccess = QUOTE([ARR_5(_player, _target, _selectionName, 'SalineIV_250', ['ACE_salineIV_250'])] call FUNC(treatmentIV));
        };
        class PersonalAidKit;
        class LimitWounds: PersonalAidKit {
            displayName = CSTRING(LIMITWOUNDS_Display);
            displayNameProgress = CSTRING(LIMITWOUNDS_Display);
            patientStateCondition = QGVAR(limitWounds_condition);
            condition = QUOTE(([_target] call FUNC(getNumOpenWounds) > 5) && GVAR(limitWounds_enable));
            treatmentTime = 8;
            callbackSuccess = QUOTE([_target] call FUNC(limitWounds));
        };
    };
};
