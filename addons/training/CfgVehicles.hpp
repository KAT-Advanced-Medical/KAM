#define PATIENT (_target getVariable [ARR_2(QQGVAR(patient),objNull)])

// Selecting the severity itself spawns one patient, its children offer every amount up to the number of free patient spots
#define SPAWN_ACTION(NAME,SEVERITY)     class NAME {         displayName = CSTRING(NAME);         statement = QUOTE([ARR_3(_target,_player,SEVERITY)] call FUNC(spawnPatient));         insertChildren = QUOTE([ARR_2(_target,SEVERITY)] call FUNC(getAmountActions));     }

#define SEVERITY_ACTION(NAME,SEVERITY) \
    class NAME { \
        displayName = CSTRING(NAME); \
        statement = QUOTE([ARR_4(_target,_player,'severity',SEVERITY)] call FUNC(requestInjury)); \
    }

#define INJURY_ACTION(NAME,TYPE,VALUE) \
    class NAME { \
        displayName = CSTRING(NAME); \
        statement = QUOTE([ARR_4(_target,_player,'TYPE',VALUE)] call FUNC(requestInjury)); \
    }

// Damage passed to ace_medical_fnc_addDamageToUnit for each wound strength
#define WOUND_DAMAGE_LIGHT 0.2
#define WOUND_DAMAGE_MEDIUM 0.5
#define WOUND_DAMAGE_HEAVY 0.9

#define WOUND_STRENGTH_ACTION(NAME,PART,DAMAGETYPE,DAMAGE) \
    class NAME { \
        displayName = CSTRING(NAME); \
        statement = QUOTE([ARR_6(_target,_player,'wound','PART','DAMAGETYPE',DAMAGE)] call FUNC(requestInjury)); \
    }

#define WOUND_TYPE_ACTION(NAME,PART,DAMAGETYPE) \
    class NAME { \
        displayName = CSTRING(NAME); \
        WOUND_STRENGTH_ACTION(Strength_Light,PART,DAMAGETYPE,WOUND_DAMAGE_LIGHT); \
        WOUND_STRENGTH_ACTION(Strength_Medium,PART,DAMAGETYPE,WOUND_DAMAGE_MEDIUM); \
        WOUND_STRENGTH_ACTION(Strength_Heavy,PART,DAMAGETYPE,WOUND_DAMAGE_HEAVY); \
    }

#define WOUND_BODYPART_ACTION(NAME,PART) \
    class NAME { \
        displayName = CSTRING(NAME); \
        WOUND_TYPE_ACTION(DamageType_Bullet,PART,bullet); \
        WOUND_TYPE_ACTION(DamageType_Shrapnel,PART,grenade); \
        WOUND_TYPE_ACTION(DamageType_Explosion,PART,explosive); \
        WOUND_TYPE_ACTION(DamageType_Stab,PART,stab); \
        WOUND_TYPE_ACTION(DamageType_Blunt,PART,falling); \
        WOUND_TYPE_ACTION(DamageType_Burn,PART,burn); \
    }

// Fracture grades match kat_surgery_fractures: 1 simple, 2 compound, 3 comminuted
#define FRACTURE_GRADE_ACTION(NAME,PART,GRADE) \
    class NAME { \
        displayName = CSTRING(NAME); \
        statement = QUOTE([ARR_5(_target,_player,'fracture','PART',GRADE)] call FUNC(requestInjury)); \
    }

#define FRACTURE_BODYPART_ACTION(NAME,PART) \
    class NAME { \
        displayName = CSTRING(NAME); \
        FRACTURE_GRADE_ACTION(Fracture_Simple,PART,1); \
        FRACTURE_GRADE_ACTION(Fracture_Compound,PART,2); \
        FRACTURE_GRADE_ACTION(Fracture_Comminuted,PART,3); \
    }

class CfgVehicles {
    class Land_Ground_sheet_F;
    class GVAR(patientSpot): Land_Ground_sheet_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(PatientSpot_DisplayName);
        author = "MiszczuZPolski";

        ACEGVAR(dragging,canDrag) = 1;
        ACEGVAR(dragging,dragPosition)[] = {0,1.2,0};
        ACEGVAR(dragging,canCarry) = 1;
        ACEGVAR(dragging,carryPosition)[] = {0,1.2,1};
    };

    class Land_MultiScreenComputer_01_sand_F;
    class GVAR(computer): Land_MultiScreenComputer_01_sand_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(Computer_DisplayName);
        author = "MiszczuZPolski";

        class ACE_Actions {
            class ACE_MainActions {
                displayName = CSTRING(Computer_DisplayName);
                condition = "true";
                distance = 3;
                icon = QACEPATHTOF(medical_gui,ui\cross.paa);

                class GVAR(spawnPatient) {
                    displayName = CSTRING(SpawnPatient);
                    icon = QACEPATHTOF(medical_gui,ui\cross.paa);

                    SPAWN_ACTION(Severity_Healthy,0);
                    SPAWN_ACTION(Severity_Light,1);
                    SPAWN_ACTION(Severity_Moderate,2);
                    SPAWN_ACTION(Severity_Severe,3);
                    SPAWN_ACTION(Severity_Critical,4);
                };

                class GVAR(tutorial) {
                    displayName = CSTRING(Tutorial);

                    class Start {
                        displayName = CSTRING(Tutorial_Start);
                        condition = QUOTE(GVAR(tutorialHandle) == -1);
                        statement = QUOTE([ARR_2(_target,_player)] call FUNC(startTutorial));
                    };
                    class Stop {
                        displayName = CSTRING(Tutorial_Stop);
                        condition = QUOTE(GVAR(tutorialHandle) != -1);
                        statement = QUOTE([] call FUNC(stopTutorial));
                    };
                };

                class GVAR(randomWounds) {
                    displayName = CSTRING(RandomWounds);
                    condition = QUOTE(alive PATIENT);

                    SEVERITY_ACTION(Severity_Light,1);
                    SEVERITY_ACTION(Severity_Moderate,2);
                    SEVERITY_ACTION(Severity_Severe,3);
                    SEVERITY_ACTION(Severity_Critical,4);
                };

                class GVAR(addWound) {
                    displayName = CSTRING(AddWound);
                    condition = QUOTE(alive PATIENT);

                    WOUND_BODYPART_ACTION(BodyPart_Head,head);
                    WOUND_BODYPART_ACTION(BodyPart_Torso,body);
                    WOUND_BODYPART_ACTION(BodyPart_LeftArm,leftarm);
                    WOUND_BODYPART_ACTION(BodyPart_RightArm,rightarm);
                    WOUND_BODYPART_ACTION(BodyPart_LeftLeg,leftleg);
                    WOUND_BODYPART_ACTION(BodyPart_RightLeg,rightleg);
                };

                class GVAR(addFracture) {
                    displayName = CSTRING(AddFracture);
                    condition = QUOTE(alive PATIENT);

                    FRACTURE_BODYPART_ACTION(BodyPart_LeftArm,leftarm);
                    FRACTURE_BODYPART_ACTION(BodyPart_RightArm,rightarm);
                    FRACTURE_BODYPART_ACTION(BodyPart_LeftLeg,leftleg);
                    FRACTURE_BODYPART_ACTION(BodyPart_RightLeg,rightleg);
                };

                class GVAR(chestInjury) {
                    displayName = CSTRING(ChestInjury);
                    condition = QUOTE(alive PATIENT);

                    INJURY_ACTION(Pneumothorax,chest,'pneumothorax');
                    INJURY_ACTION(TensionPneumothorax,chest,'tension');
                    INJURY_ACTION(Hemopneumothorax,chest,'hemo');
                    INJURY_ACTION(Tamponade,chest,'tamponade');
                };

                // Rhythm values match kat_circulation_cardiacArrestType
                class GVAR(cardiacArrest) {
                    displayName = CSTRING(CardiacArrest);
                    condition = QUOTE(alive PATIENT);

                    INJURY_ACTION(Asystole,cardiacArrest,1);
                    INJURY_ACTION(PEA,cardiacArrest,2);
                    INJURY_ACTION(VFib,cardiacArrest,3);
                    INJURY_ACTION(VTach,cardiacArrest,4);
                };

                class GVAR(airway) {
                    displayName = CSTRING(Airway);
                    condition = QUOTE(alive PATIENT);

                    INJURY_ACTION(Obstruction,airway,'obstruction');
                    INJURY_ACTION(Occlusion,airway,'occlusion');
                };

                class GVAR(managePatient) {
                    displayName = CSTRING(ManagePatient);
                    condition = QUOTE(([_target] call FUNC(getPatients)) isNotEqualTo []);

                    class SelectPatient {
                        displayName = CSTRING(SelectPatient);
                        insertChildren = QUOTE([_target] call FUNC(getPatientActions));
                    };
                    class KnockOut {
                        displayName = CSTRING(KnockOut);
                        condition = QUOTE(alive PATIENT && {!(PATIENT getVariable [ARR_2('ACE_isUnconscious',false)])});
                        statement = QUOTE([ARR_3(_target,_player,'unconscious')] call FUNC(requestInjury));
                    };
                    class FullHeal {
                        displayName = CSTRING(FullHeal);
                        condition = QUOTE(alive PATIENT);
                        statement = QUOTE([ARR_2(_player,PATIENT)] call ACEFUNC(medical_treatment,fullHeal));
                    };
                    class DeletePatient {
                        displayName = CSTRING(DeletePatient);
                        condition = QUOTE(!isNull PATIENT);
                        statement = QUOTE([ARR_2(_target,_player)] call FUNC(deletePatient));
                    };
                    class DeleteAllPatients {
                        displayName = CSTRING(DeleteAllPatients);
                        statement = QUOTE([ARR_3(_target,_player,true)] call FUNC(deletePatient));
                    };
                };
            };
        };
    };
};
