class ACE_Medical_Treatment_Actions {
    class CheckPulse;
    class BasicBandage;
    class ConvertPatient: CheckPulse {
        displayName = CSTRING(convertPatient);
        displayNameProgress = CSTRING(converting);
        condition = QFUNC(manualConversionCondition);
        category = "examine";
        medicRequired = QGVAR(manualConversionLevel);
        treatmentLocations = QGVAR(manualConversionLocation);
        treatmentTime = 10;
        allowedSelections[] = {"All"};
        items[] = {""};
        callbackSuccess = QFUNC(manualConversion);
    };
};
