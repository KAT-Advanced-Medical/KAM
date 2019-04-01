class ACE_Medical_Treatment_Actions {
    class BasicBandage;
    class PulseOximeter: BasicBandage {
        displayName = CSTRING(pulseoximeter_display);
        displayNameProgress = CSTRING(placing);
        category = "examine";
        allowedSelections[] = {"leftarm", "rightarm"};
        allowSelfTreatment = 0;
        requiredMedic = 1;
        treatmentTime = 2;
        items[] = {"kat_pulseoximeter"};
        callbackSuccess = FUNC(treatmentPulseOximeter);
        condition = QUOTE(!([ARR_2(_target,_bodyPart)] call FUNC(hasPulseOxiAppliedTo)));
        itemConsumed = 1;
        litter[] = {};
    };
    class RemovePulseOximeter: PulseOximeter {
        displayName = CSTRING(pulseoximeter_remove_display);
        displayNameProgress = CSTRING(remove);
        items[] = {};
        condition = QUOTE(([ARR_2(_target,_bodyPart)] call FUNC(hasPulseOxiAppliedTo)));
        callbackSuccess = FUNC(treatmentPulseOximeterRemove);
        itemConsumed = 0;
        litter[] = {};
    };
};
