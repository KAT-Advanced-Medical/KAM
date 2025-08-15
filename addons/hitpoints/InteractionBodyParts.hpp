class ACE_Head {
    displayName = CSTRING(Head);
    distance = MEDICAL_ACTION_DISTANCE;
    icon = QPATHTOF(ui\cross.paa);
    exceptions[] = {"isNotInside", "isNotSitting"};
    ACTION_CONDITION
    statement = QUOTE([ARR_2(_target,0)] call EFUNC(gui,displayPatientInformation));
    modifierFunction = QUOTE([ARR_3(_target,""head"",_this select 3)] call EFUNC(gui,modifyAction));
    runOnHover = 1;
};
class ACE_Neck {
    displayName = CSTRING(Neck);
    distance = MEDICAL_ACTION_DISTANCE;
    icon = QPATHTOF(ui\cross.paa);
    exceptions[] = {"isNotInside", "isNotSitting"};
    ACTION_CONDITION
    statement = QUOTE([ARR_2(_target,1)] call EFUNC(gui,displayPatientInformation));
    modifierFunction = QUOTE([ARR_3(_target,""neck"",_this select 3)] call EFUNC(gui,modifyAction));
    runOnHover = 1;
};
class ACE_Chest {
    displayName = CSTRING(Chest);
    distance = MEDICAL_ACTION_DISTANCE;
    icon = QPATHTOF(ui\cross.paa);
    exceptions[] = {"isNotInside", "isNotSitting"};
    ACTION_CONDITION
    statement = QUOTE([ARR_2(_target,2)] call EFUNC(gui,displayPatientInformation));
    modifierFunction = QUOTE([ARR_3(_target,""chest"",_this select 3)] call EFUNC(gui,modifyAction));
    runOnHover = 1;
    class TriageCard {
        displayName = CSTRING(Actions_TriageCard);
        exceptions[] = {"isNotInside", "isNotSitting"};
        condition = "true";
        statement = QUOTE(_target call ACEFUNC(medical_gui,displayTriageCard));
        icon = QPATHTOF(ui\triage_card.paa);
    };
};
class ACE_Torso {
    displayName = CSTRING(Torso);
    distance = MEDICAL_ACTION_DISTANCE;
    icon = QPATHTOF(ui\cross.paa);
    exceptions[] = {"isNotInside", "isNotSitting"};
    ACTION_CONDITION
    statement = QUOTE([ARR_2(_target,3)] call EFUNC(gui,displayPatientInformation));
    modifierFunction = QUOTE([ARR_3(_target,""body"",_this select 3)] call EFUNC(gui,modifyAction));
    runOnHover = 1;
    class TriageCard {
        displayName = CSTRING(Actions_TriageCard);
        exceptions[] = {"isNotInside", "isNotSitting"};
        condition = "true";
        statement = QUOTE(_target call ACEFUNC(medical_gui,displayTriageCard));
        icon = QPATHTOF(ui\triage_card.paa);
    };
};
class ACE_ArmUpperLeft {
    displayName = CSTRING(UpperLeftArm);
    distance = MEDICAL_ACTION_DISTANCE;
    icon = QPATHTOF(ui\cross.paa);
    exceptions[] = {"isNotInside", "isNotSitting"};
    ACTION_CONDITION
    statement = QUOTE([ARR_2(_target,5)] call EFUNC(gui,displayPatientInformation));
    modifierFunction = QUOTE([ARR_3(_target,""upperleftarm"",_this select 3)] call EFUNC(gui,modifyAction));
    runOnHover = 1;
};
class ACE_ArmLeft {
    displayName = CSTRING(LeftArm);
    distance = MEDICAL_ACTION_DISTANCE;
    icon = QPATHTOF(ui\cross.paa);
    exceptions[] = {"isNotInside", "isNotSitting"};
    ACTION_CONDITION
    statement = QUOTE([ARR_2(_target,4)] call EFUNC(gui,displayPatientInformation));
    modifierFunction = QUOTE([ARR_3(_target,""leftarm"",_this select 3)] call EFUNC(gui,modifyAction));
    runOnHover = 1;
};
class ACE_ArmUpperRight {
    displayName = CSTRING(UpperRightArm);
    distance = MEDICAL_ACTION_DISTANCE;
    icon = QPATHTOF(ui\cross.paa);
    exceptions[] = {"isNotInside", "isNotSitting"};
    ACTION_CONDITION
    statement = QUOTE([ARR_2(_target,7)] call EFUNC(gui,displayPatientInformation));
    modifierFunction = QUOTE([ARR_3(_target,""upperrightarm"",_this select 3)] call EFUNC(gui,modifyAction));
    runOnHover = 1;
};
class ACE_ArmRight {
    displayName = CSTRING(RightArm);
    distance = MEDICAL_ACTION_DISTANCE;
    icon = QPATHTOF(ui\cross.paa);
    exceptions[] = {"isNotInside", "isNotSitting"};
    ACTION_CONDITION
    statement = QUOTE([ARR_2(_target,6)] call EFUNC(gui,displayPatientInformation));
    modifierFunction = QUOTE([ARR_3(_target,""rightarm"",_this select 3)] call EFUNC(gui,modifyAction));
    runOnHover = 1;
};
class ACE_LegUpperLeft {
    displayName = CSTRING(UpperLeftLeg);
    distance = MEDICAL_ACTION_DISTANCE;
    icon = QPATHTOF(ui\cross.paa);
    exceptions[] = {"isNotInside", "isNotSitting"};
    ACTION_CONDITION
    statement = QUOTE([ARR_2(_target,9)] call EFUNC(gui,displayPatientInformation));
    modifierFunction = QUOTE([ARR_3(_target,""upperleftleg"",_this select 3)] call EFUNC(gui,modifyAction));
    runOnHover = 1;
};
class ACE_LegLeft {
    displayName = CSTRING(LeftLeg);
    distance = MEDICAL_ACTION_DISTANCE;
    icon = QPATHTOF(ui\cross.paa);
    exceptions[] = {"isNotInside", "isNotSitting"};
    ACTION_CONDITION
    statement = QUOTE([ARR_2(_target,8)] call EFUNC(gui,displayPatientInformation));
    modifierFunction = QUOTE([ARR_3(_target,""leftleg"",_this select 3)] call EFUNC(gui,modifyAction));
    runOnHover = 1;
};
class ACE_LegUpperRight {
    displayName = CSTRING(UpperRightLeg);
    distance = MEDICAL_ACTION_DISTANCE;
    icon = QPATHTOF(ui\cross.paa);
    exceptions[] = {"isNotInside", "isNotSitting"};
    ACTION_CONDITION
    statement = QUOTE([ARR_2(_target,11)] call EFUNC(gui,displayPatientInformation));
    modifierFunction = QUOTE([ARR_3(_target,""upperrightleg"",_this select 3)] call EFUNC(gui,modifyAction));
    runOnHover = 1;
};
class ACE_LegRight {
    displayName = CSTRING(RightLeg);
    distance = MEDICAL_ACTION_DISTANCE;
    icon = QPATHTOF(ui\cross.paa);
    exceptions[] = {"isNotInside", "isNotSitting"};
    ACTION_CONDITION
    statement = QUOTE([ARR_2(_target,10)] call EFUNC(gui,displayPatientInformation));
    modifierFunction = QUOTE([ARR_3(_target,""rightleg"",_this select 3)] call EFUNC(gui,modifyAction));
    runOnHover = 1;
};
