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
        allowSelfTreatment = 0;
        callbackSuccess = QFUNC(manualConversion);
    };
    class ConvertPatientTickets: CheckPulse {
        displayName = CSTRING(TicketConversion);
        displayNameProgress = CSTRING(converting);
        category = "examine";
        condition = QFUNC(ticketConversionCondition);
        medicRequired = QGVAR(manualConversionLevel);
        treatmentLocations = 2;
        treatmentTime = QGVAR(manualConversionTime);
        allowedSelections[] = {"All"};
        allowSelfTreatment = 0;
        items[] = {};
        callbackSuccess = QFUNC(ticketConversion);
    };
    class ConvertPatientFacility: CheckPulse {
        displayName = CSTRING(TicketConversion);
        displayNameProgress = CSTRING(converting);
        category = "examine";
        condition = QFUNC(facilityConversionCondition);
        medicRequired = QGVAR(manualConversionLevel);
        treatmentLocations = 2;
        treatmentTime = QGVAR(manualConversionTime);
        allowedSelections[] = {"All"};
        allowSelfTreatment = 0;
        items[] = {};
        callbackSuccess = QFUNC(facilityConversion);
    };
};
