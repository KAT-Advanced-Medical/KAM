class ACE_Medical_Treatment_Actions {
    class BasicBandage;
    class Nasopharyngeal: BasicBandage {
        displayName = CSTRING(npa_display);
        displayNameProgress = CSTRING(action_placing);
        category = "airway";
        allowedSelections[] = {"head"};
        allowSelfTreatment = 0;
        requiredMedic = 1;
        treatmentTime = 5;
        items[] = {"kam_nasopharyngeal"};
        condition = QFUNC(canAirway);
        callbackSuccess = QFUNC(treatmentAirway);
        litter[] = {};
    };
    class Oropharyngeal: Nasopharyngeal {
        displayName = CSTRING(opa_display);
        requiredMedic = 0;
        items[] = {"kam_oropharyngeal"};
        callbackSuccess = QFUNC(treatmentAirway);
    };
    class Endotracheal: Nasopharyngeal {
        displayName = CSTRING(end_display);
        requiredMedic = 2;
        items[] = {"kam_endotracheal"};
        callbackSuccess = QFUNC(treatmentAirway);
    };
    class Suction: Nasopharyngeal {
        displayName = CSTRING(suction_display);
        treatmentTime = 8;
        items[] = {"kam_suction"};
        itemConsumed = 0;
        condition = QFUNC(canSuction);
        callbackSuccess = QFUNC(treatmentSuction);
        //sounds[] = {{QPATHTO_R(sounds\suction.wav), 1, 1, 50}};
    };
    class Accuvac: suction {
        displayName = CSTRING(accuvac_display);
        items[] = {"kam_accuvac"};
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
        displayName = CSTRING(assessairway);
        displayNameProgress = CSTRING(action_checking);
        allowedSelections[] = {"head"};
        allowSelfTreatment = 0;
        callbackSuccess = QFUNC(checkAirway);
        condition = QFUNC(canAirway);
    };
};
