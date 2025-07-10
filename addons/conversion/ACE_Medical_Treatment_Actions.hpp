class ACE_Medical_Treatment_Actions {
    class CheckPulse;
    class ConvertPatient: CheckPulse {
        displayName = CSTRING(convertPatient);
        displayNameProgress = CSTRING(converting);
        category = "examine";
        condition = QFUNC(manualConversionCondition);
        medicRequired = QGVAR(manualConversionLevel);
        treatmentLocations = QGVAR(manualConversionLocation);
        treatmentTime = QGVAR(manualConversionTime);
        allowedSelections[] = {"All"};
        allowSelfTreatment = 1;
        items[] = {};
        callbackSuccess = QFUNC(manualConversion);
    };
};
