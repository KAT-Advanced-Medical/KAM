class ACE_Medical_Treatment_Actions {
    class Morphine;
    class Antidot : Morphine {
        displayName = CSTRING(AntidotItem_action);
        displayNameProgress = CSTRING(AntidotItem_action_progress);
        callbackSuccess = FUNC(medication);
        items[] = {"kat_Antidot"};
        litter[] = {{"ACE_MedicalLitter_antidot"}};
        
    };

    class PoisenBP {
        displayName = "";
        displayNameProgress = "";
        callbackSuccess = "";
        items[] = {};
        litter[] = {{"ACE_MedicalLitter_PoisenBP"}};
        animationMedic = "";
        sounds[] = {};
    };
 
    class Diagnose;
    class putonGasMask: Diagnose {
        displayName = CSTRING(giveGasMask_action);
        displayNameProgress = CSTRING(giveGasMask_progress);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 0;
        callbackSuccess = FUNC(giveUnitGasMask);
        condition = QUOTE([ARR_2(_player, _patient)] call FUNC(canPutGasMask));
    };
};