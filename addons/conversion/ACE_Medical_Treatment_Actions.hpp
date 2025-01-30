class ACE_Medical_Treatment_Actions {
    class CheckPulse;
    class ConvertPatient: CheckPulse {
        displayName = CSTRING(convertPatient);
        displayNameProgress = CSTRING(converting);
        condition = QFUNC(manualConversionCondition);
        medicRequired = QGVAR(manualConversionLevel);
        treatmentLocations = QGVAR(manualConversionLocation);
        treatmentTime = QGVAR(manualConversionTime);
        allowedSelections[] = {"All"};
        items[] = {""};
        callbackSuccess = QFUNC(manualConversion);
    };
};
