class ACE_Medical_Treatment_Actions {
    class Diagnose;
    class BasicBandage;
    class PutOnGasMask: Diagnose {
        displayName = CSTRING(giveGasMask_action);
        displayNameProgress = CSTRING(giveGasMask_progress);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 0;
        callbackSuccess = QFUNC(giveUnitGasMask);
        condition = QUOTE([ARR_2(_player,_patient)] call FUNC(canPutGasMask));
        icon = QPATHTOF(ui\Gasmask_icon.paa);
    };
    class EnableSCBA: Diagnose {
        displayName = CSTRING(EnableSCBA);
        displayNameProgress = CSTRING(EnableSCBA_progress);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 0;
        callbackSuccess = QFUNC(giveUnitSCBA);
        condition = QUOTE(([_patient] call FUNC(hasSCBA)) && !(_patient getVariable [ARR_2(QQGVAR(SCBAEnabled),false)]));
        icon = QPATHTOF(ui\Scba_icon.paa);
    };
    class Decontaminate: BasicBandage {
        displayName = CSTRING(Decontaimeate);
        displayNameProgress = CSTRING(Decontaimeate_progress);
        allowedSelections[] = {"All"};
        allowSelfTreatment = 1;
        category = "advanced";
        callbackSuccess = QFUNC(healdecon);
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(Contaminated),false)]));
        icon = QPATHTOF(ui\deconkit_icon.paa);
        items[] = {"kat_deconkit"};
        consumeItem = 1;
        treatmentTime = 20;
    };
};
