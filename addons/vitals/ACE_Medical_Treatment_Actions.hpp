class ACE_Medical_Treatment_Actions {
    class CheckPulse;
    class BasicDiagnostic: CheckPulse {
        displayName = CSTRING(basicDiagnostic_use);
        displayNameProgress = CSTRING(basicDiagnostic_progress);
        treatmentTime = QGVAR(basicDiagnosticTime);
        callbackSuccess = QFUNC(basicDiagnostic);
        condition = QUOTE(GVAR(enableBasicDiagnostic));
        items[] = {"kat_basicDiagnostic"};
    };
};
