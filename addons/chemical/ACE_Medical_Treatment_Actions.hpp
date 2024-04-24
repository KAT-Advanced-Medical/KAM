class ACE_Medical_Treatment_Actions {
    class Diagnose;
    class putonGasMask: Diagnose {
        displayName = CSTRING(giveGasMask_action);
        displayNameProgress = CSTRING(giveGasMask_progress);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 0;
        callbackSuccess = QFUNC(giveUnitGasMask);
        condition = QUOTE([ARR_2(_player,_patient)] call FUNC(canPutGasMask));
        icon = QPATHTOF(ui\Gasmask_icon.paa);
    };
};
