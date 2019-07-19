class ACE_Medical_Treatment_Actions {
        class Morphine;
        class CheckPulse;

        class Painkillers: Morphine {
            displayName = CSTRING(painkillers_inject);
            displayNameProgress = CSTRING(painkillers_using);
            allowedSelections[] = {"head"};
            items[] = {};
            callbackSuccess = QUOTE([ARR_5('KAM_Painkiller', _player, _target, _selectionName, 'Painkillers')] call FUNC(removeItemfromMag));
            condition = QUOTE(('KAM_painkiller' in (magazines _player)) && _player == _target);
            litter[] = {};
            sounds[] = {{QPATHTOF_SOUND(sounds\take_painkillers.wav), 1, 1, 50}};
        };
        class CheckDogtags: checkPulse {
            displayName = CSTRING(DogTag);
            displayNameProgress = CSTRING(DogTag_Action);
            treatmentTime = 2;
            allowedSelections[] = {"head"};
            allowSelfTreatment = 1;
            callbackSuccess = "[_player, _target] call ace_dogtags_fnc_checkDogtag";
            condition = "true";
        };

        #include "KAT_Medical_Blood_Type.hpp"
        /*
        class Defibrillator: CPR {
            items[] = {{"adv_aceCPR_AED", "KAM_X_AED"}};
            treatmentTime = 10;
            callbackProgress = QUOTE(call FUNC(AED_sound));
        };
        class X_Defibrillator: CPR {
            displayName = CSTRING(X_Action_Use);
            displayNameProgress = CSTRING(X_Action_Progress);
            items[] = {"kat_X_AED"};
            condition = QUOTE(!(_player getVariable [ARR_2(QQGVAR(use),false)]));
            treatmentTime = 2;
            requiredMedic = 1;
            callbackProgress = "";
            callbackSuccess = QUOTE([ARR_2(_player, _target)] call FUNC(treatmentAdvanced_X));
            animationCaller = "AinvPknlMstpSnonWnonDnon_medic3";
        };
        class Remove_X_Defibrillator: X_Defibrillator {
            displayName = CSTRING(X_Action_Remove);
            items[] = {};
            condition = QUOTE(_target getVariable [ARR_2(QQGVAR(X), true)]);
            treatmentTime = 2;
            callbackProgress = "";
            callbackSuccess = QUOTE(_target setVariable [ARR_3(QQGVAR(X), false, true)]; _player setVariable [ARR_3(QQGVAR(use), false, true)]);
        };
        */
};
