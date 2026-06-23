class ACE_Medical_Treatment_Actions {
    class Diagnose;
    class KAT_PutOnGasMask: Diagnose {
        displayName = CSTRING(giveGasMask_action);
        displayNameProgress = CSTRING(giveGasMask_progress);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 0;
        callbackSuccess = QFUNC(giveUnitGasMask);
        condition = QUOTE([ARR_2(_player,_patient)] call FUNC(canPutGasMask));
        icon = QPATHTOF(ui\Gasmask_icon.paa);
    };
    class KAT_Decontaminate: Diagnose {
        displayName = CSTRING(UseDecon);
        displayNameProgress = CSTRING(UseDecon_Progress);
        allowedSelections[] = {"Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        allowSelfTreatment = 1;
        items[] = {"kat_decon_kit"};
        treatmentTime = 8;
        callbackSuccess = QFUNC(clearContamination);
        condition = QUOTE(((_patient getVariable [ARR_2(QQGVAR(chemicalContamination),'')]) != '') || {(_patient getVariable [ARR_2(QQGVAR(radExternalContam),0)]) > 0});
        icon = QPATHTOF(ui\icon_deconkit.paa);
    };
    class KAT_TakeKI: Diagnose {
        displayName = CSTRING(TakeKI);
        displayNameProgress = CSTRING(TakeKI_Progress);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 1;
        items[] = {"kat_potassiumIodide"};
        treatmentTime = 4;
        callbackSuccess = QUOTE([ARR_2(_patient,'ki')] call FUNC(treatmentAdvanced_AntiRadLocal));
        condition = "true";
        icon = QPATHTOF(ui\icon_deconkit.paa);
    };
    class KAT_TakePrussianBlue: Diagnose {
        displayName = CSTRING(TakePrussianBlue);
        displayNameProgress = CSTRING(TakePrussianBlue_Progress);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 1;
        items[] = {"kat_prussianBlue"};
        treatmentTime = 4;
        callbackSuccess = QUOTE([ARR_2(_patient,'prussian')] call FUNC(treatmentAdvanced_AntiRadLocal));
        condition = "true";
        icon = QPATHTOF(ui\icon_deconkit.paa);
    };
};
