class ACE_Medical_Treatment_Actions {
    class BasicBandage;
    class Nasopharyngeal: BasicBandage {
        displayName = CSTRING(npa_display);
        displayNameProgress = CSTRING(action_placing);
        category = "airway";
        allowedSelections[] = {"head"};
        allowSelfTreatment = 0;
        requiredMedic = GVAR(npa_requiredLevel);
        treatmentTime = 8;
        items[] = {"KAM_nasopharyngeal"};
        condition = QFUNC(canAirway);
        callbackSuccess = QFUNC(treatmentAirway);
        litter[] = {};
    };
    class Oropharyngeal: Nasopharyngeal {
        displayName = CSTRING(opa_display);
        requiredMedic = GVAR(opa_requiredLevel);
        treatmentTime = 2;
        items[] = {"KAM_oropharyngeal"};
        callbackSuccess = QFUNC(treatmentAirway);
    };
    class Endotracheal: Nasopharyngeal {
        displayName = CSTRING(end_display);
        requiredMedic = 2;
        items[] = {"KAM_endotracheal"};
        callbackSuccess = QFUNC(treatmentAirway);
    };
    class RemoveAirway: Nasopharyngeal {
        displayName = CSTRING(removeAirway);
        displayNameProgress = CSTRING(action_remove);
        requiredMedic = 0;
        items[] = {};
        allowSelfTreatment = 1;
        treatmentTime = 3;
        condition = QFUNC(canRemoveAirway);
        callbackSuccess = QFUNC(removeAirway);
    };
    class Suction: Nasopharyngeal {
        displayName = CSTRING(suction_display);
        treatmentTime = 8;
        items[] = {"KAM_suction"};
        itemConsumed = 0;
        condition = QFUNC(canSuction);
        callbackSuccess = QFUNC(treatmentSuction);
        //sounds[] = {{QPATHTO_R(sounds\suction.wav), 1, 1, 50}};
    };
    class Accuvac: suction {
        displayName = CSTRING(accuvac_display);
        items[] = {"KAM_accuvac"};
        sounds[] = {{QPATHTOF_SOUND(sounds\suction.wav), 1, 1, 50}};
    };
    class HeadTilt: Nasopharyngeal {
        displayName = CSTRING(headtilt);
        displayNameProgress = CSTRING(headtilt);
        treatmentTime = 2;
        requiredMedic = 0;
        items[] = {};
        callbackSuccess = QFUNC(treatmentHeadtilt);
    };
    class TurnAround: suction {
        displayName = CSTRING(turnaround);
        displayNameProgress = CSTRING(turnaround_action);
        treatmentTime = 2.5;
        requiredMedic = 0;
        items[] = {};
    };
    class CheckPulse;
    class CheckAirway: CheckPulse {
        displayName = CSTRING(assessAirway);
        displayNameProgress = CSTRING(assessAirway_progress);
        allowedSelections[] = {"head"};
        allowSelfTreatment = 0;
        callbackSuccess = QFUNC(checkAirway);
        condition = QFUNC(canAirway);
    };
};
