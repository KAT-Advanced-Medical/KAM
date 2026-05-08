class ACE_Medical_Treatment_Actions {
    class Diagnose;
    class PutOnGasMask: Diagnose {
        displayName = CSTRING(giveGasMask_action);
        displayNameProgress = CSTRING(giveGasMask_progress);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 0;
        callbackSuccess = QFUNC(giveUnitGasMask);
        condition = QUOTE([ARR_2(_player,_patient)] call FUNC(canPutGasMask));
        icon = QPATHTOF(ui\Gasmask_icon.paa);
    };
    class Decontaminate: Diagnose {
        displayName = CSTRING(UseDecon);
        displayNameProgress = CSTRING(UseDecon_Progress);
        allowedSelections[] = {"Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        allowSelfTreatment = 1;
        items[] = {"kat_decon_kit"};
        treatmentTime = 8;
        callbackSuccess = QFUNC(clearContamination);
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(chemicalContamination),'')]) != '');
        icon = QPATHTOF(ui\icon_deconkit.paa);
    };
};
