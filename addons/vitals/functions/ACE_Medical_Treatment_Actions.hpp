class ACE_Medical_Treatment_Actions {
    class CheckPulse;
    class BasicDiagnostic: CheckPulse {
        displayName = CSTRING(basicDiagnostic_display);
        displayNameProgress = CSTRING(basicDiagnostic_progress);
        treatmentTime = QGVAR(basicDiagnosticTime);
        category = "examine";
        medicRequired = 0;
        consumeItem = 0;
        callbackSuccess = callbackSuccess = QFUNC(basicDiagnostic);
        condition = QUOTE(missionNamespace getVariable [ARR_2(QQGVAR(enableBasicDiagnostic),false)]);
        items[] = {"kat_basicDiagnostic"};
    };
};
