class CfgVehicles {
    class Land_IntravenStand_01_base_F;

    class Land_IntravenStand_01_empty_F: Land_IntravenStand_01_base_F {
        ace_cargo_size = 2;
        ace_cargo_canLoad = 1;

        // Dragging
        ace_dragging_canDrag = 1;
        ace_dragging_dragPosition[] = {0, 1.2, 1};
        ace_dragging_dragDirection = 0;

        // Carrying
        ace_dragging_canCarry = 1;
        ace_dragging_carryPosition[] = {0, 1.2, 1};
        ace_dragging_carryDirection = 0;
    };
    class Land_IntravenStand_01_1bag_F: Land_IntravenStand_01_base_F {
        ace_cargo_size = 2;
        ace_cargo_canLoad = 1;

        // Dragging
        ace_dragging_canDrag = 1;
        ace_dragging_dragPosition[] = {0, 1.2, 1};
        ace_dragging_dragDirection = 0;

        // Carrying
        ace_dragging_canCarry = 1;
        ace_dragging_carryPosition[] = {0, 1.2, 1};
        ace_dragging_carryDirection = 0;
    };
    class Land_IntravenStand_01_2bags_F: Land_IntravenStand_01_base_F {
        ace_cargo_size = 2;
        ace_cargo_canLoad = 1;

        // Dragging
        ace_dragging_canDrag = 1;
        ace_dragging_dragPosition[] = {0, 1.2, 1};
        ace_dragging_dragDirection = 0;

        // Carrying
        ace_dragging_canCarry = 1;
        ace_dragging_carryPosition[] = {0, 1.2, 1};
        ace_dragging_carryDirection = 0;
    };

    class Items_base_F;
    class kat_Armband_Red_Cross_Object: Items_base_F {
        scope = 2;
        scopeCurator = 2;
        scopeArsenal = 2;
        author = "Miss Heda, vccv9040 (Swedish Forces Pack)";
        editorPreview = QPATHTOF(ui\ArmbandWhiteCross.paa);
        model = QPATHTOF(models\armband\Armband.p3d);
        hiddenSelections[] = {"Armband"};
        hiddenSelectionsTextures[] = {QPATHTOF(models\armband\ArmbandWC.paa)};
    };
    class kat_Armband_Medic_Object: kat_Armband_Red_Cross_Object {
        editorPreview = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
        model = QPATHTOF(models\armband\Armband.p3d);
        hiddenSelectionsTextures[] = {QPATHTOF(models\armband\ArmbandWCM.paa)};
    };
    class kat_Armband_Doctor_Object: kat_Armband_Red_Cross_Object {
        editorPreview = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
        model = QPATHTOF(models\armband\Armband.p3d);
        hiddenSelectionsTextures[] = {QPATHTOF(models\armband\ArmbandWCD.paa)};
    };
    class kat_Armband_Kat_Object: kat_Armband_Red_Cross_Object {
        editorPreview = QPATHTOF(ui\ArmbandKat.paa);
        model = QPATHTOF(models\armband\Armband.p3d);
        hiddenSelectionsTextures[] = {QPATHTOF(models\armband\ArmbandKAT.paa)};
    };
    class Man;
    class CAManBase: Man {
        class ACE_Actions {
            class ACE_MainActions {
                class KAT_UnloadAndCarryPatient {
                    displayName = CSTRING(CarryPatient);
                    condition = QUOTE(_target getVariable [ARR_2('ACE_isUnconscious',false)] && {!(isNull (objectParent _target))} && {isNull (objectParent _player)});
                    statement = QUOTE([ARR_2(_player,_target)] call FUNC(unloadAndCarryPatient));
                    icon = QACEPATHTOF(dragging,UI\icons\person_carry.paa);
                };     
                class KAT_IFAK_Item {
                    displayName = CSTRING(IFAK_Unpack);
                    condition = QUOTE([ARR_4(_target,'kat_IFAK',0,0)] call FUNC(FAK_checkSlot) && !([_target] call ACEFUNC(common,isAwake)));
                    statement = QUOTE([ARR_4(_target,'kat_IFAK',0,0)] call FUNC(FAK_unpack));
                    exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                    showDisabled = 0;
                    icon = QPATHTOF(ui\IFAK.paa);

                    class Slot1 {
                        displayName = CSTRING(FAK_Slot_1);
                        condition = QUOTE([ARR_4(_target,'kat_IFAK',0,1)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_IFAK',0,1)] call FUNC(FAK_unpack));
                        showDisabled = 0;
                        icon = QPATHTOF(ui\IFAK.paa);
                    };

                    class Slot2: Slot1 {
                        displayName = CSTRING(FAK_Slot_2);
                        condition = QUOTE([ARR_4(_target,'kat_IFAK',0,2)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_IFAK',0,2)] call FUNC(FAK_unpack));
                    };

                    class Slot3: Slot1 {
                        displayName = CSTRING(FAK_Slot_3);
                        condition = QUOTE([ARR_4(_target,'kat_IFAK',0,3)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_IFAK',0,3)] call FUNC(FAK_unpack));
                    };

                    class Slot4: Slot1 {
                        displayName = CSTRING(FAK_Slot_4);
                        condition = QUOTE([ARR_4(_target,'kat_IFAK',0,4)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_IFAK',0,4)] call FUNC(FAK_unpack));
                    };
                };

                class KAT_IFAK_Mag {
                    displayName = CSTRING(IFAK_Unpack);
                    condition = QUOTE([ARR_4(_target,'kat_IFAK_Magazine',0,0)] call FUNC(FAK_checkSlot) && !([_target] call ACEFUNC(common,isAwake)));
                    statement = QUOTE([ARR_4(_target,'kat_IFAK_Magazine',0,0)] call FUNC(FAK_unpack));
                    exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                    showDisabled = 0;
                    icon = QPATHTOF(ui\IFAK.paa);

                    class Slot1 {
                        displayName = CSTRING(FAK_Slot_1);
                        condition = QUOTE([ARR_4(_target,'kat_IFAK_Magazine',0,1)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_IFAK_Magazine',0,1)] call FUNC(FAK_unpack));
                        showDisabled = 0;
                        icon = QPATHTOF(ui\IFAK.paa);
                    };

                    class Slot2: Slot1 {
                        displayName = CSTRING(FAK_Slot_2);
                        condition = QUOTE([ARR_4(_target,'kat_IFAK_Magazine',0,2)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_IFAK_Magazine',0,2)] call FUNC(FAK_unpack));
                    };

                    class Slot3: Slot1 {
                        displayName = CSTRING(FAK_Slot_3);
                        condition = QUOTE([ARR_4(_target,'kat_IFAK_Magazine',0,3)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_IFAK_Magazine',0,3)] call FUNC(FAK_unpack));
                    };

                    class Slot4: Slot1 {
                        displayName = CSTRING(FAK_Slot_4);
                        condition = QUOTE([ARR_4(_target,'kat_IFAK_Magazine',0,4)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_IFAK_Magazine',0,4)] call FUNC(FAK_unpack));
                    };

                };

                class KAT_AFAK_Item {
                    displayName = CSTRING(AFAK_Unpack);
                    condition = QUOTE([ARR_4(_target,'kat_AFAK',1,0)] call FUNC(FAK_checkSlot) && !([_target] call ACEFUNC(common,isAwake)));
                    statement = QUOTE([ARR_4(_target,'kat_AFAK',1,0)] call FUNC(FAK_unpack));
                    exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                    showDisabled = 0;
                    icon = QPATHTOF(ui\AFAK.paa);

                    class Slot1 {
                        displayName = CSTRING(FAK_Slot_1);
                        condition = QUOTE([ARR_4(_target,'kat_AFAK',1,1)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_AFAK',1,1)] call FUNC(FAK_unpack));
                        showDisabled = 0;
                        icon = QPATHTOF(ui\AFAK.paa);
                    };

                    class Slot2: Slot1 {
                        displayName = CSTRING(FAK_Slot_2);
                        condition = QUOTE([ARR_4(_target,'kat_AFAK',1,2)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_AFAK',1,2)] call FUNC(FAK_unpack));
                    };

                    class Slot3: Slot1 {
                        displayName = CSTRING(FAK_Slot_3);
                        condition = QUOTE([ARR_4(_target,'kat_AFAK',1,3)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_AFAK',1,3)] call FUNC(FAK_unpack));
                    };

                    class Slot4: Slot1 {
                        displayName = CSTRING(FAK_Slot_4);
                        condition = QUOTE([ARR_4(_target,'kat_AFAK',1,4)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_AFAK',1,4)] call FUNC(FAK_unpack));
                    };

                    class Slot5: Slot1 {
                        displayName = CSTRING(FAK_Slot_5);
                        condition = QUOTE([ARR_4(_target,'kat_AFAK',1,5)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_AFAK',1,5)] call FUNC(FAK_unpack));
                    };

                    class Slot6: Slot1 {
                        displayName = CSTRING(FAK_Slot_6);
                        condition = QUOTE([ARR_4(_target,'kat_AFAK',1,6)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_AFAK',1,6)] call FUNC(FAK_unpack));
                    };
                };

                class KAT_AFAK_Mag {
                    displayName = CSTRING(AFAK_Unpack);
                    condition = QUOTE([ARR_4(_target,'kat_AFAK_Magazine',1,0)] call FUNC(FAK_checkSlot) && !([_target] call ACEFUNC(common,isAwake)));
                    statement = QUOTE([ARR_4(_target,'kat_AFAK_Magazine',1,0)] call FUNC(FAK_unpack));
                    exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                    showDisabled = 0;
                    icon = QPATHTOF(ui\AFAK.paa);

                    class Slot1 {
                        displayName = CSTRING(FAK_Slot_1);
                        condition = QUOTE([ARR_4(_target,'kat_AFAK_Magazine',1,1)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_AFAK_Magazine',1,1)] call FUNC(FAK_unpack));
                        showDisabled = 0;
                        icon = QPATHTOF(ui\AFAK.paa);
                    };

                    class Slot2: Slot1 {
                        displayName = CSTRING(FAK_Slot_2);
                        condition = QUOTE([ARR_4(_target,'kat_AFAK_Magazine',1,2)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_AFAK_Magazine',1,2)] call FUNC(FAK_unpack));
                    };

                    class Slot3: Slot1 {
                        displayName = CSTRING(FAK_Slot_3);
                        condition = QUOTE([ARR_4(_target,'kat_AFAK_Magazine',1,3)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_AFAK_Magazine',1,3)] call FUNC(FAK_unpack));
                    };

                    class Slot4: Slot1 {
                        displayName = CSTRING(FAK_Slot_4);
                        condition = QUOTE([ARR_4(_target,'kat_AFAK_Magazine',1,4)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_AFAK_Magazine',1,4)] call FUNC(FAK_unpack));
                    };

                    class Slot5: Slot1 {
                        displayName = CSTRING(FAK_Slot_5);
                        condition = QUOTE([ARR_4(_target,'kat_AFAK_Magazine',1,5)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_AFAK_Magazine',1,5)] call FUNC(FAK_unpack));
                    };

                    class Slot6: Slot1 {
                        displayName = CSTRING(FAK_Slot_6);
                        condition = QUOTE([ARR_4(_target,'kat_AFAK_Magazine',1,6)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_AFAK_Magazine',1,6)] call FUNC(FAK_unpack));
                    };
                };

                class KAT_MFAK_Item {
                    displayName = CSTRING(MFAK_Unpack);
                    condition = QUOTE([ARR_4(_target,'kat_MFAK',2,0)] call FUNC(FAK_checkSlot) && !([_target] call ACEFUNC(common,isAwake)));
                    statement = QUOTE([ARR_4(_target,'kat_MFAK',2,0)] call FUNC(FAK_unpack));
                    exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                    showDisabled = 0;
                    icon = QPATHTOF(ui\MFAK.paa);

                    class Slot1 {
                        displayName = CSTRING(FAK_Slot_1);
                        condition = QUOTE([ARR_4(_target,'kat_MFAK',2,1)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_MFAK',2,1)] call FUNC(FAK_unpack));
                        showDisabled = 0;
                        icon = QPATHTOF(ui\MFAK.paa);
                    };

                    class Slot2: Slot1 {
                        displayName = CSTRING(FAK_Slot_2);
                        condition = QUOTE([ARR_4(_target,'kat_MFAK',2,2)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_MFAK',2,2)] call FUNC(FAK_unpack));
                    };

                    class Slot3: Slot1 {
                        displayName = CSTRING(FAK_Slot_3);
                        condition = QUOTE([ARR_4(_target,'kat_MFAK',2,3)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_MFAK',2,3)] call FUNC(FAK_unpack));
                    };

                    class Slot4: Slot1 {
                        displayName = CSTRING(FAK_Slot_4);
                        condition = QUOTE([ARR_4(_target,'kat_MFAK',2,4)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_MFAK',2,4)] call FUNC(FAK_unpack));
                    };

                    class Slot5: Slot1 {
                        displayName = CSTRING(FAK_Slot_5);
                        condition = QUOTE([ARR_4(_target,'kat_MFAK',2,5)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_MFAK',2,5)] call FUNC(FAK_unpack));
                    };

                    class Slot6: Slot1 {
                        displayName = CSTRING(FAK_Slot_6);
                        condition = QUOTE([ARR_4(_target,'kat_MFAK',2,6)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_MFAK',2,6)] call FUNC(FAK_unpack));
                    };

                    class Slot7: Slot1 {
                        displayName = CSTRING(FAK_Slot_7);
                        condition = QUOTE([ARR_4(_target,'kat_MFAK',2,7)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_MFAK',2,7)] call FUNC(FAK_unpack));
                    };

                    class Slot8: Slot1 {
                        displayName = CSTRING(FAK_Slot_8);
                        condition = QUOTE([ARR_4(_target,'kat_MFAK',2,8)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_MFAK',2,8)] call FUNC(FAK_unpack));
                    };
                };

                class KAT_MFAK_Mag {
                    displayName = CSTRING(MFAK_Unpack);
                    condition = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,0)] call FUNC(FAK_checkSlot) && !([_target] call ACEFUNC(common,isAwake)));
                    statement = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,0)] call FUNC(FAK_unpack));
                    exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                    showDisabled = 0;
                    icon = QPATHTOF(ui\MFAK.paa);

                    class Slot1 {
                        displayName = CSTRING(FAK_Slot_1);
                        condition = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,1)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,1)] call FUNC(FAK_unpack));
                        showDisabled = 0;
                        icon = QPATHTOF(ui\MFAK.paa);
                    };

                    class Slot2: Slot1 {
                        displayName = CSTRING(FAK_Slot_2);
                        condition = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,2)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,2)] call FUNC(FAK_unpack));
                    };

                    class Slot3: Slot1 {
                        displayName = CSTRING(FAK_Slot_3);
                        condition = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,3)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,3)] call FUNC(FAK_unpack));
                    };

                    class Slot4: Slot1 {
                        displayName = CSTRING(FAK_Slot_4);
                        condition = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,4)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,4)] call FUNC(FAK_unpack));
                    };

                    class Slot5: Slot1 {
                        displayName = CSTRING(FAK_Slot_5);
                        condition = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,5)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,5)] call FUNC(FAK_unpack));
                    };

                    class Slot6: Slot1 {
                        displayName = CSTRING(FAK_Slot_6);
                        condition = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,6)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,6)] call FUNC(FAK_unpack));
                    };

                    class Slot7: Slot1 {
                        displayName = CSTRING(FAK_Slot_7);
                        condition = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,7)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,7)] call FUNC(FAK_unpack));
                    };

                    class Slot8: Slot1 {
                        displayName = CSTRING(FAK_Slot_8);
                        condition = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,8)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_target,'kat_MFAK_Magazine',2,8)] call FUNC(FAK_unpack));
                    };
                };
            };
            class ACE_ArmLeft {
                class SalineIV;
                class SalineIV_Stand: SalineIV {
                    displayName = CSTRING(Display_IVStand);
                    condition = "[_player, _target, 'hand_l', 'SalineIV_Stand'] call ace_medical_treatment_fnc_canTreatCached";
                    statement = "[_player, _target, 'hand_l', 'SalineIV_Stand'] call ace_medical_treatment_fnc_treatment";
                };
                class SalineIV_Stand_500: SalineIV {
                    displayName = CSTRING(Display_IVStand_500);
                    condition = "[_player, _target, 'hand_l', 'SalineIV_Stand_500'] call ace_medical_treatment_fnc_canTreatCached";
                    statement = "[_player, _target, 'hand_l', 'SalineIV_Stand_500'] call ace_medical_treatment_fnc_treatment";
                };
                class SalineIV_Stand_250: SalineIV {
                    displayName = CSTRING(Display_IVStand_250);
                    condition = "[_player, _target, 'hand_l', 'SalineIV_Stand_250'] call ace_medical_treatment_fnc_canTreatCached";
                    statement = "[_player, _target, 'hand_l', 'SalineIV_Stand_250'] call ace_medical_treatment_fnc_treatment";
                };
            };
            class ACE_ArmRight {
                class SalineIV;
                class SalineIV_Stand: SalineIV {
                    displayName = CSTRING(Display_IVStand);
                    condition = "[_player, _target, 'hand_r', 'SalineIV_Stand'] call ace_medical_treatment_fnc_canTreatCached";
                    statement = "[_player, _target, 'hand_r', 'SalineIV_Stand'] call ace_medical_treatment_fnc_treatment";
                };
                class SalineIV_Stand_500: SalineIV {
                    displayName = CSTRING(Display_IVStand_500);
                    condition = "[_player, _target, 'hand_r', 'SalineIV_Stand_500'] call ace_medical_treatment_fnc_canTreatCached";
                    statement = "[_player, _target, 'hand_r', 'SalineIV_Stand_500'] call ace_medical_treatment_fnc_treatment";
                };
                class SalineIV_Stand_250: SalineIV {
                    displayName = CSTRING(Display_IVStand_250);
                    condition = "[_player, _target, 'hand_r', 'SalineIV_Stand_250'] call ace_medical_treatment_fnc_canTreatCached";
                    statement = "[_player, _target, 'hand_r', 'SalineIV_Stand_250'] call ace_medical_treatment_fnc_treatment";
                };
            };
            class ACE_LegLeft {
                class SalineIV;
                class SalineIV_Stand: SalineIV {
                    displayName = CSTRING(Display_IVStand);
                    condition = "[_player, _target, 'leg_l', 'SalineIV_Stand'] call ace_medical_treatment_fnc_canTreatCached";
                    statement = "[_player, _target, 'leg_l', 'SalineIV_Stand'] call ace_medical_treatment_fnc_treatment";
                };
                class SalineIV_Stand_500: SalineIV {
                    displayName = CSTRING(Display_IVStand_500);
                    condition = "[_player, _target, 'leg_l', 'SalineIV_Stand_500'] call ace_medical_treatment_fnc_canTreatCached";
                    statement = "[_player, _target, 'leg_l', 'SalineIV_Stand_500'] call ace_medical_treatment_fnc_treatment";
                };
                class SalineIV_Stand_250: SalineIV {
                    displayName = CSTRING(Display_IVStand_250);
                    condition = "[_player, _target, 'leg_l', 'SalineIV_Stand_250'] call ace_medical_treatment_fnc_canTreatCached";
                    statement = "[_player, _target, 'leg_l', 'SalineIV_Stand_250'] call ace_medical_treatment_fnc_treatment";
                };
            };
            class ACE_LegRight {
                class SalineIV;
                class SalineIV_Stand: SalineIV {
                    displayName = CSTRING(Display_IVStand);
                    condition = "[_player, _target, 'leg_r', 'SalineIV_Stand'] call ace_medical_treatment_fnc_canTreatCached";
                    statement = "[_player, _target, 'leg_r', 'SalineIV_Stand'] call ace_medical_treatment_fnc_treatment";
                };
                class SalineIV_Stand_500: SalineIV {
                    displayName = CSTRING(Display_IVStand_500);
                    condition = "[_player, _target, 'leg_r', 'SalineIV_Stand_500'] call ace_medical_treatment_fnc_canTreatCached";
                    statement = "[_player, _target, 'leg_r', 'SalineIV_Stand_500'] call ace_medical_treatment_fnc_treatment";
                };
                class SalineIV_Stand_250: SalineIV {
                    displayName = CSTRING(Display_IVStand_250);
                    condition = "[_player, _target, 'leg_r', 'SalineIV_Stand_250'] call ace_medical_treatment_fnc_canTreatCached";
                    statement = "[_player, _target, 'leg_r', 'SalineIV_Stand_250'] call ace_medical_treatment_fnc_treatment";
                };
            };
        };
        class ACE_SelfActions
        {
            class KAT_Equipment {
                displayName = CSTRING(Kat_Equipment);
                icon = QPATHTOF(ui\KAM_Iteraction_Logo.paa);
                exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                
                class Armband {
                    displayName = CSTRING(Armband_Sling);
                    condition = QUOTE(_player call FUNC(checkArmbandCondition));
                    statement = "";
                    icon = QPATHTOF(ui\ArmbandWhiteCross.paa);
                    showDisabled = 1;

                    class LeftArm {
                        displayName = CSTRING(Armband_Sling_Left_Arm);
                        condition = QUOTE(_player getVariable [ARR_2(QQGVAR(isLeftArmFree),false)]);
                        statement = "";
                        showDisabled = 0;
                        icon = QPATHTOF(ui\ArmbandLeftArm.paa);

                        class RedCross {
                            displayName = CSTRING(Armband_Red_Cross_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Red_Cross_Goggles')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Red_Cross_Goggles',0)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCross.paa);
                        };

                        class Medic {
                            displayName = CSTRING(Armband_Medic_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Medic_Goggles')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Medic_Goggles',0)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
                        };

                        class Doctor {
                            displayName = CSTRING(Armband_Doctor_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Doctor_Goggles')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Doctor_Goggles',0)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
                        };

                        class Kat {
                            displayName = CSTRING(Armband_Kat_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Kat_Goggles')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Kat_Goggles',0)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandKat.paa);
                        };

                        class RedCross_NVG {
                            displayName = CSTRING(Armband_Red_Cross_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Red_Cross_NVG')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Red_Cross_NVG',0)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCross.paa);
                        };

                        class Medic_NVG {
                            displayName = CSTRING(Armband_Medic_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Medic_NVG')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Medic_NVG',0)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
                        };

                        class Doctor_NVG {
                            displayName = CSTRING(Armband_Doctor_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Doctor_NVG')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Doctor_NVG',0)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
                        };

                        class Kat_NVG {
                            displayName = CSTRING(Armband_Kat_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Kat_NVG')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Kat_NVG',0)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandKat.paa);
                        };
                    };

                    class RightArm {
                        displayName = CSTRING(Armband_Sling_Right_Arm);
                        condition = QUOTE(_player getVariable [ARR_2(QQGVAR(isRightArmFree),false)]);
                        statement = "";
                        showDisabled = 0;
                        icon = QPATHTOF(ui\ArmbandRightArm.paa);

                        class RedCross {
                            displayName = CSTRING(Armband_Red_Cross_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Red_Cross_Goggles')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Red_Cross_Goggles',1)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCross.paa);
                        };

                        class Medic {
                            displayName = CSTRING(Armband_Medic_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Medic_Goggles')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Medic_Goggles',1)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
                        };

                        class Doctor {
                            displayName = CSTRING(Armband_Doctor_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Doctor_Goggles')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Doctor_Goggles',1)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
                        };

                        class Kat {
                            displayName = CSTRING(Armband_Kat_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Kat_Goggles')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Kat_Goggles',1)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandKat.paa);
                        };
                    
                        class RedCross_NVG {
                            displayName = CSTRING(Armband_Red_Cross_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Red_Cross_NVG')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Red_Cross_NVG',1)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCross.paa);
                        };

                        class Medic_NVG {
                            displayName = CSTRING(Armband_Medic_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Medic_NVG')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Medic_NVG',1)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
                        };

                        class Doctor_NVG {
                            displayName = CSTRING(Armband_Doctor_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Doctor_NVG')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Doctor_NVG',1)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
                        };

                        class Kat_NVG {
                            displayName = CSTRING(Armband_Kat_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Kat_NVG')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Kat_NVG',1)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandKat.paa);
                        };
                    };

                    class LeftLeg {
                        displayName = CSTRING(Armband_Sling_Left_Leg);
                        condition = QUOTE(_player getVariable [ARR_2(QQGVAR(isLeftLegFree),false)]);
                        statement = "";
                        showDisabled = 0;
                        icon = QPATHTOF(ui\ArmbandLeftLeg.paa);

                        class RedCross {
                            displayName = CSTRING(Armband_Red_Cross_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Red_Cross_Goggles')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Red_Cross_Goggles',2)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCross.paa);
                        };

                        class Medic {
                            displayName = CSTRING(Armband_Medic_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Medic_Goggles')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Medic_Goggles',2)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
                        };

                        class Doctor {
                            displayName = CSTRING(Armband_Doctor_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Doctor_Goggles')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Doctor_Goggles',2)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
                        };

                        class Kat {
                            displayName = CSTRING(Armband_Kat_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Kat_Goggles')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Kat_Goggles',2)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandKat.paa);
                        };

                        class RedCross_NVG {
                            displayName = CSTRING(Armband_Red_Cross_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Red_Cross_NVG')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Red_Cross_NVG',2)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCross.paa);
                        };

                        class Medic_NVG {
                            displayName = CSTRING(Armband_Medic_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Medic_NVG')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Medic_NVG',2)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
                        };

                        class Doctor_NVG {
                            displayName = CSTRING(Armband_Doctor_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Doctor_NVG')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Doctor_NVG',2)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
                        };

                        class Kat_NVG {
                            displayName = CSTRING(Armband_Kat_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Kat_NVG')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Kat_NVG',2)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandKat.paa);
                        };
                    };

                    class RightLeg {
                        displayName = CSTRING(Armband_Sling_Right_Leg);
                        condition = QUOTE(_player getVariable [ARR_2(QQGVAR(isRightLegFree),false)]);
                        statement = "";
                        showDisabled = 0;
                        icon = QPATHTOF(ui\ArmbandRightLeg.paa);

                        class RedCross {
                            displayName = CSTRING(Armband_Red_Cross_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Red_Cross_Goggles')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Red_Cross_Goggles',3)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCross.paa);
                        };

                        class Medic {
                            displayName = CSTRING(Armband_Medic_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Medic_Goggles')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Medic_Goggles',3)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
                        };

                        class Doctor {
                            displayName = CSTRING(Armband_Doctor_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Doctor_Goggles')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Doctor_Goggles',3)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
                        };

                        class Kat {
                            displayName = CSTRING(Armband_Kat_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Kat_Goggles')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Kat_Goggles',3)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandKat.paa);
                        };

                        class RedCross_NVG {
                            displayName = CSTRING(Armband_Red_Cross_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Red_Cross_NVG')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Red_Cross_NVG',3)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCross.paa);
                        };

                        class Medic_NVG {
                            displayName = CSTRING(Armband_Medic_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Medic_NVG')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Medic_NVG',3)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
                        };

                        class Doctor_NVG {
                            displayName = CSTRING(Armband_Doctor_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Doctor_NVG')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Doctor_NVG',3)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
                        };

                        class Kat_NVG {
                            displayName = CSTRING(Armband_Kat_ItemName);
                            condition = QUOTE([ARR_2(_player,'kat_Armband_Kat_NVG')] call ACEFUNC(common,hasItem));
                            statement = QUOTE([ARR_3(_player,'kat_Armband_Kat_NVG',3)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandKat.paa);
                        };
                    };

                    class UnSlingLeftArm {
                        displayName = CSTRING(Armband_UnSling_Left_Arm);
                        condition = QUOTE(!(_player getVariable [ARR_2(QQGVAR(isLeftArmFree),false)]));
                        statement = QUOTE([ARR_2(_player,0)] call FUNC(unSlingArmband));
                        showDisabled = 0;
                        icon = QPATHTOF(ui\ArmbandLeftArm.paa);
                    };

                    class UnSlingRightArm {
                        displayName = CSTRING(Armband_UnSling_Right_Arm);
                        condition = QUOTE(!(_player getVariable [ARR_2(QQGVAR(isRightArmFree),false)]));
                        statement = QUOTE([ARR_2(_player,1)] call FUNC(unSlingArmband));
                        showDisabled = 0;
                        icon = QPATHTOF(ui\ArmbandRightArm.paa);
                    };

                    class UnSlingLeftLeg {
                        displayName = CSTRING(Armband_UnSling_Left_Leg);
                        condition = QUOTE(!(_player getVariable [ARR_2(QQGVAR(isLeftLegFree),false)]));
                        statement = QUOTE([ARR_2(_player,2)] call FUNC(unSlingArmband));
                        showDisabled = 0;
                        icon = QPATHTOF(ui\ArmbandLeftLeg.paa);
                    };

                    class UnSlingRightLeg {
                        displayName = CSTRING(Armband_UnSling_Right_Leg);
                        condition = QUOTE(!(_player getVariable [ARR_2(QQGVAR(isRightLegFree),false)]));
                        statement = QUOTE([ARR_2(_player,3)] call FUNC(unSlingArmband));
                        showDisabled = 0;
                        icon = QPATHTOF(ui\ArmbandRightLeg.paa);
                    };
                };

                class BubbleWrapPopping {
                    displayName = CSTRING(Bubble_Wrap_Ace_Action);
                    condition = QUOTE([ARR_2(_player,'kat_Bubble_Wrap')] call ACEFUNC(common,hasMagazine));
                    exceptions[] = {"isNotInside", "isNotSitting"};
                    statement = QUOTE(_player call FUNC(BubbleWrap));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\Bubble_Wrap_Item.paa);
                };

                class KAT_IFAK_Item {
                    displayName = CSTRING(IFAK_Unpack);
                    condition = QUOTE([ARR_4(_player,'kat_IFAK',0,0)] call FUNC(FAK_checkSlot));
                    statement = QUOTE([ARR_4(_player,'kat_IFAK',0,0)] call FUNC(FAK_unpack));
                    exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                    showDisabled = 0;
                    icon = QPATHTOF(ui\IFAK.paa);

                    class IFAKInfo {
                        displayName = CSTRING(FAK_DisplayItems);
                        condition = QUOTE([ARR_2(_player,'kat_IFAK')] call ACEFUNC(common,hasItem));
                        statement = QUOTE([ARR_2(_player,0)] call FUNC(FAK_displayContent));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\IFAK_DisplayItems.paa);
                    };

                    class Slot1 {
                        displayName = CSTRING(FAK_Slot_1);
                        condition = QUOTE([ARR_4(_player,'kat_IFAK',0,1)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_IFAK',0,1)] call FUNC(FAK_unpack));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\IFAK.paa);
                    };

                    class Slot2: Slot1 {
                        displayName = CSTRING(FAK_Slot_2);
                        condition = QUOTE([ARR_4(_player,'kat_IFAK',0,2)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_IFAK',0,2)] call FUNC(FAK_unpack));
                    };

                    class Slot3: Slot1 {
                        displayName = CSTRING(FAK_Slot_3);
                        condition = QUOTE([ARR_4(_player,'kat_IFAK',0,3)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_IFAK',0,3)] call FUNC(FAK_unpack));
                    };

                    class Slot4: Slot1 {
                        displayName = CSTRING(FAK_Slot_4);
                        condition = QUOTE([ARR_4(_player,'kat_IFAK',0,4)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_IFAK',0,4)] call FUNC(FAK_unpack));
                    };
                };

                class KAT_IFAK_Mag {
                    displayName = CSTRING(IFAK_Unpack);
                    condition = QUOTE([ARR_4(_player,'kat_IFAK_Magazine',0,0)] call FUNC(FAK_checkSlot));
                    statement = QUOTE([ARR_4(_player,'kat_IFAK_Magazine',0,0)] call FUNC(FAK_unpack));
                    exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                    showDisabled = 0;
                    icon = QPATHTOF(ui\IFAK.paa);

                    class IFAKInfo {
                        displayName = CSTRING(FAK_DisplayItems);
                        condition = QUOTE([ARR_2(_player,'kat_IFAK_Magazine')] call ACEFUNC(common,hasMagazine));
                        statement = QUOTE([ARR_2(_player,0)] call FUNC(FAK_displayContent));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\IFAK_DisplayItems.paa);
                    };
                    
                    class Slot1 {
                        displayName = CSTRING(FAK_Slot_1);
                        condition = QUOTE([ARR_4(_player,'kat_IFAK_Magazine',0,1)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_IFAK_Magazine',0,1)] call FUNC(FAK_unpack));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\IFAK.paa);
                    };

                    class Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_1_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_IFAK_Magazine',0,1)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_IFAK_Magazine',0,1)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_IFAK_Magazine',0,1)] call FUNC(FAK_repack));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\IFAK_Repack.paa);
                    };

                    class Slot2: Slot1 {
                        displayName = CSTRING(FAK_Slot_2);
                        condition = QUOTE([ARR_4(_player,'kat_IFAK_Magazine',0,2)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_IFAK_Magazine',0,2)] call FUNC(FAK_unpack));
                    };

                    class Slot2_Repack: Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_2_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_IFAK_Magazine',0,2)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_IFAK_Magazine',0,2)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_IFAK_Magazine',0,2)] call FUNC(FAK_repack));
                    };

                    class Slot3: Slot1 {
                        displayName = CSTRING(FAK_Slot_3);
                        condition = QUOTE([ARR_4(_player,'kat_IFAK_Magazine',0,3)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_IFAK_Magazine',0,3)] call FUNC(FAK_unpack));
                    };

                    class Slot3_Repack: Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_3_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_IFAK_Magazine',0,3)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_IFAK_Magazine',0,3)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_IFAK_Magazine',0,3)] call FUNC(FAK_repack));
                    };

                    class Slot4: Slot1 {
                        displayName = CSTRING(FAK_Slot_4);
                        condition = QUOTE([ARR_4(_player,'kat_IFAK_Magazine',0,4)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_IFAK_Magazine',0,4)] call FUNC(FAK_unpack));
                    };

                    class Slot4_Repack: Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_4_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_IFAK_Magazine',0,4)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_IFAK_Magazine',0,4)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_IFAK_Magazine',0,4)] call FUNC(FAK_repack));
                    };
                };

                class KAT_AFAK_Item {
                    displayName = CSTRING(AFAK_Unpack);
                    condition = QUOTE([ARR_4(_player,'kat_AFAK',1,0)] call FUNC(FAK_checkSlot));
                    statement = QUOTE([ARR_4(_player,'kat_AFAK',1,0)] call FUNC(FAK_unpack));
                    exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                    showDisabled = 0;
                    icon = QPATHTOF(ui\AFAK.paa);

                    class AFAKInfo {
                        displayName = CSTRING(FAK_DisplayItems);
                        condition = QUOTE([ARR_2(_player,'kat_AFAK')] call ACEFUNC(common,hasItem));
                        statement = QUOTE([ARR_2(_player,1)] call FUNC(FAK_displayContent));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\AFAK_DisplayItems.paa);
                    };

                    class Slot1 {
                        displayName = CSTRING(FAK_Slot_1);
                        condition = QUOTE([ARR_4(_player,'kat_AFAK',1,1)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK',1,1)] call FUNC(FAK_unpack));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\AFAK.paa);
                    };

                    class Slot2: Slot1 {
                        displayName = CSTRING(FAK_Slot_2);
                        condition = QUOTE([ARR_4(_player,'kat_AFAK',1,2)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK',1,2)] call FUNC(FAK_unpack));
                    };

                    class Slot3: Slot1 {
                        displayName = CSTRING(FAK_Slot_3);
                        condition = QUOTE([ARR_4(_player,'kat_AFAK',1,3)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK',1,3)] call FUNC(FAK_unpack));
                    };

                    class Slot4: Slot1 {
                        displayName = CSTRING(FAK_Slot_4);
                        condition = QUOTE([ARR_4(_player,'kat_AFAK',1,4)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK',1,4)] call FUNC(FAK_unpack));
                    };

                    class Slot5: Slot1 {
                        displayName = CSTRING(FAK_Slot_5);
                        condition = QUOTE([ARR_4(_player,'kat_AFAK',1,5)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK',1,5)] call FUNC(FAK_unpack));
                    };

                    class Slot6: Slot1 {
                        displayName = CSTRING(FAK_Slot_6);
                        condition = QUOTE([ARR_4(_player,'kat_AFAK',1,6)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK',1,6)] call FUNC(FAK_unpack));
                    };
                };

                class KAT_AFAK_Mag {
                    displayName = CSTRING(AFAK_Unpack);
                    condition = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,0)] call FUNC(FAK_checkSlot));
                    statement = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,0)] call FUNC(FAK_unpack));
                    exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                    showDisabled = 0;
                    icon = QPATHTOF(ui\AFAK.paa);

                    class AFAKInfo {
                        displayName = CSTRING(FAK_DisplayItems);
                        condition = QUOTE([ARR_2(_player,'kat_AFAK_Magazine')] call ACEFUNC(common,hasMagazine));
                        statement = QUOTE([ARR_2(_player,1)] call FUNC(FAK_displayContent));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\AFAK_DisplayItems.paa);
                    };

                    class Slot1 {
                        displayName = CSTRING(FAK_Slot_1);
                        condition = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,1)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,1)] call FUNC(FAK_unpack));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\AFAK.paa);
                    };

                    class Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_1_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_AFAK_Magazine',1,1)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_AFAK_Magazine',1,1)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,1)] call FUNC(FAK_repack));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\AFAK_Repack.paa);
                    };

                    class Slot2: Slot1 {
                        displayName = CSTRING(FAK_Slot_2);
                        condition = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,2)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,2)] call FUNC(FAK_unpack));
                    };

                    class Slot2_Repack: Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_2_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_AFAK_Magazine',1,2)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_AFAK_Magazine',1,2)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,2)] call FUNC(FAK_repack));
                    };

                    class Slot3: Slot1 {
                        displayName = CSTRING(FAK_Slot_3);
                        condition = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,3)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,3)] call FUNC(FAK_unpack));
                    };
                    
                    class Slot3_Repack: Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_3_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_AFAK_Magazine',1,3)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_AFAK_Magazine',1,3)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,3)] call FUNC(FAK_repack));
                    };

                    class Slot4: Slot1 {
                        displayName = CSTRING(FAK_Slot_4);
                        condition = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,4)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,4)] call FUNC(FAK_unpack));
                    };

                    class Slot4_Repack: Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_4_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_AFAK_Magazine',1,4)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_AFAK_Magazine',1,4)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,4)] call FUNC(FAK_repack));
                    };

                    class Slot5: Slot1 {
                        displayName = CSTRING(FAK_Slot_5);
                        condition = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,5)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,5)] call FUNC(FAK_unpack));
                    };

                    class Slot5_Repack: Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_5_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_AFAK_Magazine',1,5)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_AFAK_Magazine',1,5)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,5)] call FUNC(FAK_repack));
                    };

                    class Slot6: Slot1 {
                        displayName = CSTRING(FAK_Slot_6);
                        condition = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,6)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,6)] call FUNC(FAK_unpack));
                    };

                    class Slot6_Repack: Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_6_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_AFAK_Magazine',1,6)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_AFAK_Magazine',1,6)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_AFAK_Magazine',1,6)] call FUNC(FAK_repack));
                    };
                };

                class KAT_MFAK_Item {
                    displayName = CSTRING(MFAK_Unpack);
                    condition = QUOTE([ARR_4(_player,'kat_MFAK',2,0)] call FUNC(FAK_checkSlot));
                    statement = QUOTE([ARR_4(_player,'kat_MFAK',2,0)] call FUNC(FAK_unpack));
                    exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                    showDisabled = 0;
                    icon = QPATHTOF(ui\MFAK.paa);

                    class MFAKInfo {
                        displayName = CSTRING(FAK_DisplayItems);
                        condition = QUOTE([ARR_2(_player,'kat_MFAK')] call ACEFUNC(common,hasItem));
                        statement = QUOTE([ARR_2(_player,2)] call FUNC(FAK_displayContent));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\MFAK_DisplayItems.paa);
                    };

                    class Slot1 {
                        displayName = CSTRING(FAK_Slot_1);
                        condition = QUOTE([ARR_4(_player,'kat_MFAK',2,1)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK',2,1)] call FUNC(FAK_unpack));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\MFAK.paa);
                    };

                    class Slot2: Slot1 {
                        displayName = CSTRING(FAK_Slot_2);
                        condition = QUOTE([ARR_4(_player,'kat_MFAK',2,2)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK',2,2)] call FUNC(FAK_unpack));
                    };

                    class Slot3: Slot1 {
                        displayName = CSTRING(FAK_Slot_3);
                        condition = QUOTE([ARR_4(_player,'kat_MFAK',2,3)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK',2,3)] call FUNC(FAK_unpack));
                    };

                    class Slot4: Slot1 {
                        displayName = CSTRING(FAK_Slot_4);
                        condition = QUOTE([ARR_4(_player,'kat_MFAK',2,4)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK',2,4)] call FUNC(FAK_unpack));
                    };

                    class Slot5: Slot1 {
                        displayName = CSTRING(FAK_Slot_5);
                        condition = QUOTE([ARR_4(_player,'kat_MFAK',2,5)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK',2,5)] call FUNC(FAK_unpack));
                    };

                    class Slot6: Slot1 {
                        displayName = CSTRING(FAK_Slot_6);
                        condition = QUOTE([ARR_4(_player,'kat_MFAK',2,6)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK',2,6)] call FUNC(FAK_unpack));
                    };

                    class Slot7: Slot1 {
                        displayName = CSTRING(FAK_Slot_7);
                        condition = QUOTE([ARR_4(_player,'kat_MFAK',2,7)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK',2,7)] call FUNC(FAK_unpack));
                    };

                    class Slot8: Slot1 {
                        displayName = CSTRING(FAK_Slot_8);
                        condition = QUOTE([ARR_4(_player,'kat_MFAK',2,8)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK',2,8)] call FUNC(FAK_unpack));
                    };
                };

                 class KAT_MFAK_Mag {
                    displayName = CSTRING(MFAK_Unpack);
                    condition = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,0)] call FUNC(FAK_checkSlot));
                    statement = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,0)] call FUNC(FAK_unpack));
                    exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                    showDisabled = 0;
                    icon = QPATHTOF(ui\MFAK.paa);

                    class MFAKInfo {
                        displayName = CSTRING(FAK_DisplayItems);
                        condition = QUOTE([ARR_2(_player,'kat_MFAK_Magazine')] call ACEFUNC(common,hasMagazine));
                        statement = QUOTE([ARR_2(_player,2)] call FUNC(FAK_displayContent));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\MFAK_DisplayItems.paa);
                    };

                    class Slot1 {
                        displayName = CSTRING(FAK_Slot_1);
                        condition = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,1)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,1)] call FUNC(FAK_unpack));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\MFAK.paa);
                    };

                    class Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_1_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_MFAK_Magazine',3,1)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_MFAK_Magazine',3,1)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,1)] call FUNC(FAK_repack));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\MFAK_Repack.paa);
                    };

                    class Slot2: Slot1 {
                        displayName = CSTRING(FAK_Slot_2);
                        condition = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,2)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,2)] call FUNC(FAK_unpack));
                    };

                    class Slot2_Repack: Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_2_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_MFAK_Magazine',3,2)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_MFAK_Magazine',3,2)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,2)] call FUNC(FAK_repack));
                    };

                    class Slot3: Slot1 {
                        displayName = CSTRING(FAK_Slot_3);
                        condition = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,3)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,3)] call FUNC(FAK_unpack));
                    };

                    class Slot3_Repack: Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_3_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_MFAK_Magazine',3,3)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_MFAK_Magazine',3,3)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,3)] call FUNC(FAK_repack));
                    };

                    class Slot4: Slot1 {
                        displayName = CSTRING(FAK_Slot_4);
                        condition = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,4)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,4)] call FUNC(FAK_unpack));
                    };

                    class Slot4_Repack: Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_4_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_MFAK_Magazine',3,4)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_MFAK_Magazine',3,4)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,4)] call FUNC(FAK_repack));
                    };

                    class Slot5: Slot1 {
                        displayName = CSTRING(FAK_Slot_5);
                        condition = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,5)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,5)] call FUNC(FAK_unpack));
                    };

                    class Slot5_Repack: Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_5_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_MFAK_Magazine',3,5)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_MFAK_Magazine',3,5)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,5)] call FUNC(FAK_repack));
                    };

                    class Slot6: Slot1 {
                        displayName = CSTRING(FAK_Slot_6);
                        condition = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,6)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,6)] call FUNC(FAK_unpack));
                    };

                    class Slot6_Repack: Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_6_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_MFAK_Magazine',3,6)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_MFAK_Magazine',3,6)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,6)] call FUNC(FAK_repack));
                    };

                    class Slot7: Slot1 {
                        displayName = CSTRING(FAK_Slot_7);
                        condition = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,7)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,7)] call FUNC(FAK_unpack));
                    };

                    class Slot7_Repack: Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_7_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_MFAK_Magazine',3,7)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_MFAK_Magazine',3,7)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,7)] call FUNC(FAK_repack));
                    };

                    class Slot8: Slot1 {
                        displayName = CSTRING(FAK_Slot_8);
                        condition = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,8)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,8)] call FUNC(FAK_unpack));
                    };

                    class Slot8_Repack: Slot1_Repack {
                        displayName = CSTRING(FAK_Slot_8_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_MFAK_Magazine',3,8)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_MFAK_Magazine',3,8)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_MFAK_Magazine',3,8)] call FUNC(FAK_repack));
                    };
                };
                class KAT_MEDPACK_Item {
                    displayName = CSTRING(MEDPACK_Unpack);
                    condition = QUOTE([ARR_4(_player,'kat_MEDPACK',2,0)] call FUNC(FAK_checkSlot));
                    statement = QUOTE([ARR_4(_player,'kat_MEDPACK',2,0)] call FUNC(FAK_unpack));
                    exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                    showDisabled = 0;
                    icon = QPATHTOF(ui\MFAK.paa);

                    class MEDPACKInfo {
                        displayName = CSTRING(FAK_DisplayItems);
                        condition = QUOTE([ARR_2(_player,'kat_MEDPACK')] call ACEFUNC(common,hasItem));
                        statement = QUOTE([ARR_2(_player,2)] call FUNC(FAK_displayContent));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\MFAK_DisplayItems.paa);
                    };

                    class Slot1 {
                        displayName = CSTRING(MEDPACK_Slot_1);
                        condition = QUOTE([ARR_4(_player,'kat_MEDPACK',2,1)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK',2,1)] call FUNC(FAK_unpack));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\MFAK.paa);
                    };

                    class Slot2: Slot1 {
                        displayName = CSTRING(MEDPACK_Slot_2);
                        condition = QUOTE([ARR_4(_player,'kat_MEDPACK',2,2)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK',2,2)] call FUNC(FAK_unpack));
                    };

                    class Slot3: Slot1 {
                        displayName = CSTRING(MEDPACK_Slot_3);
                        condition = QUOTE([ARR_4(_player,'kat_MEDPACK',2,3)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK',2,3)] call FUNC(FAK_unpack));
                    };

                    class Slot4: Slot1 {
                        displayName = CSTRING(MEDPACK_Slot_4);
                        condition = QUOTE([ARR_4(_player,'kat_MEDPACK',2,4)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK',2,4)] call FUNC(FAK_unpack));
                    };

                    class Slot5: Slot1 {
                        displayName = CSTRING(MEDPACK_Slot_5);
                        condition = QUOTE([ARR_4(_player,'kat_MEDPACK',2,5)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK',2,5)] call FUNC(FAK_unpack));
                    };

                    class Slot6: Slot1 {
                        displayName = CSTRING(MEDPACK_Slot_6);
                        condition = QUOTE([ARR_4(_player,'kat_MEDPACK',2,6)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK',2,6)] call FUNC(FAK_unpack));
                    };

                    class Slot7: Slot1 {
                        displayName = CSTRING(MEDPACK_Slot_7);
                        condition = QUOTE([ARR_4(_player,'kat_MEDPACK',2,7)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK',2,7)] call FUNC(FAK_unpack));
                    };

                    class Slot8: Slot1 {
                        displayName = CSTRING(MEDPACK_Slot_8);
                        condition = QUOTE([ARR_4(_player,'kat_MEDPACK',2,8)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK',2,8)] call FUNC(FAK_unpack));
                    };
                };

                class KAT_MEDPACK_Mag {
                    displayName = CSTRING(MEDPACK_Unpack);
                    condition = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,0)] call FUNC(FAK_checkSlot));
                    statement = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,0)] call FUNC(FAK_unpack));
                    exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                    showDisabled = 0;
                    icon = QPATHTOF(ui\MFAK.paa);

                    class MEDPACKInfo {
                        displayName = CSTRING(FAK_DisplayItems);
                        condition = QUOTE([ARR_2(_player,'kat_MEDPACK_Magazine')] call ACEFUNC(common,hasMagazine));
                        statement = QUOTE([ARR_2(_player,2)] call FUNC(FAK_displayContent));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\MFAK_DisplayItems.paa);
                    };

                    class Slot1 {
                        displayName = CSTRING(MEDPACK_Slot_1);
                        condition = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,1)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,1)] call FUNC(FAK_unpack));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\MFAK.paa);
                    };

                    class Slot1_Repack {
                        displayName = CSTRING(MEDPACK_Slot_1_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_MEDPACK_Magazine',2,1)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_MEDPACK_Magazine',2,1)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,1)] call FUNC(FAK_repack));
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\MFAK_Repack.paa);
                    };

                    class Slot2: Slot1 {
                        displayName = CSTRING(MEDPACK_Slot_2);
                        condition = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,2)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,2)] call FUNC(FAK_unpack));
                    };

                    class Slot2_Repack: Slot1_Repack {
                        displayName = CSTRING(MEDPACK_Slot_2_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_MEDPACK_Magazine',2,2)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_MEDPACK_Magazine',2,2)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,2)] call FUNC(FAK_repack));
                    };

                    class Slot3: Slot1 {
                        displayName = CSTRING(MEDPACK_Slot_3);
                        condition = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,3)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,3)] call FUNC(FAK_unpack));
                    };

                    class Slot3_Repack: Slot1_Repack {
                        displayName = CSTRING(MEDPACK_Slot_3_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_MEDPACK_Magazine',2,3)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_MEDPACK_Magazine',2,3)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,3)] call FUNC(FAK_repack));
                    };

                    class Slot4: Slot1 {
                        displayName = CSTRING(MEDPACK_Slot_4);
                        condition = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,4)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,4)] call FUNC(FAK_unpack));
                    };

                    class Slot4_Repack: Slot1_Repack {
                        displayName = CSTRING(MEDPACK_Slot_4_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_MEDPACK_Magazine',2,4)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_MEDPACK_Magazine',2,4)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,4)] call FUNC(FAK_repack));
                    };

                    class Slot5: Slot1 {
                        displayName = CSTRING(MEDPACK_Slot_5);
                        condition = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,5)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,5)] call FUNC(FAK_unpack));
                    };

                    class Slot5_Repack: Slot1_Repack {
                        displayName = CSTRING(MEDPACK_Slot_5_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_MEDPACK_Magazine',2,5)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_MEDPACK_Magazine',2,5)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,5)] call FUNC(FAK_repack));
                    };

                    class Slot6: Slot1 {
                        displayName = CSTRING(MEDPACK_Slot_6);
                        condition = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,6)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,6)] call FUNC(FAK_unpack));
                    };

                    class Slot6_Repack: Slot1_Repack {
                        displayName = CSTRING(MEDPACK_Slot_6_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_MEDPACK_Magazine',2,6)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_MEDPACK_Magazine',2,6)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,6)] call FUNC(FAK_repack));
                    };

                    class Slot7: Slot1 {
                        displayName = CSTRING(MEDPACK_Slot_7);
                        condition = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,7)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,7)] call FUNC(FAK_unpack));
                    };

                    class Slot7_Repack: Slot1_Repack {
                        displayName = CSTRING(MEDPACK_Slot_7_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_MEDPACK_Magazine',2,7)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_MEDPACK_Magazine',2,7)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,7)] call FUNC(FAK_repack));
                    };

                    class Slot8: Slot1 {
                        displayName = CSTRING(MEDPACK_Slot_8);
                        condition = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,8)] call FUNC(FAK_checkSlot));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,8)] call FUNC(FAK_unpack));
                    };

                    class Slot8_Repack: Slot1_Repack {
                        displayName = CSTRING(MEDPACK_Slot_8_Repack);
                        condition = QUOTE(!([ARR_4(_player,'kat_MEDPACK_Magazine',2,8)] call FUNC(FAK_checkSlot)) && [ARR_4(_player,'kat_MEDPACK_Magazine',2,8)] call FUNC(FAK_checkRepack));
                        statement = QUOTE([ARR_4(_player,'kat_MEDPACK_Magazine',2,8)] call FUNC(FAK_repack));
                    };
                };
            };
        };
    };

    class LandVehicle;
    class Car: LandVehicle {
        class ACE_Actions {
            class ACE_MainActions {
                class KAT_UnloadAndCarryPatient {
                    displayName = CSTRING(CarryPatient);
                    condition = QUOTE(alive _target);
                    statement = "";
                    insertChildren = QUOTE(call FUNC(addVehicleUnloadCarryPatientActions));
                    icon = QACEPATHTOF(medical_gui,ui\cross.paa);
                };
            };
        };
    };

    class Car_F: Car {};
    class Quadbike_01_base_F: Car_F {
        class ACE_Actions: ACE_Actions {
            class ACE_MainActions: ACE_MainActions {
                class KAT_UnloadAndCarryPatient {
                    displayName = CSTRING(CarryPatient);
                    condition = QUOTE(alive _target);
                    statement = "";
                    insertChildren = QUOTE(call FUNC(addVehicleUnloadCarryPatientActions));
                    icon = QACEPATHTOF(medical_gui,ui\cross.paa);
                };
            };
        };
    };

    class Kart_01_Base_F: Car_F {
        class ACE_Actions: ACE_Actions {
            class ACE_MainActions: ACE_MainActions {
                class KAT_UnloadAndCarryPatient {
                    displayName = CSTRING(CarryPatient);
                    condition = QUOTE(alive _target);
                    statement = "";
                    insertChildren = QUOTE(call FUNC(addVehicleUnloadCarryPatientActions));
                    icon = QACEPATHTOF(medical_gui,ui\cross.paa);
                };
            };
        };
    };

    class Tank: LandVehicle {
        class ACE_Actions {
            class ACE_MainActions {
                class KAT_UnloadAndCarryPatient {
                    displayName = CSTRING(CarryPatient);
                    condition = QUOTE(alive _target);
                    statement = "";
                    insertChildren = QUOTE(call FUNC(addVehicleUnloadCarryPatientActions));
                    icon = QACEPATHTOF(medical_gui,ui\cross.paa);
                };
            };
        };
    };

    class Motorcycle: LandVehicle {
        class ACE_Actions {
            class ACE_MainActions {
                class KAT_UnloadAndCarryPatient {
                    displayName = CSTRING(CarryPatient);
                    condition = QUOTE(alive _target);
                    statement = "";
                    insertChildren = QUOTE(call FUNC(addVehicleUnloadCarryPatientActions));
                    icon = QACEPATHTOF(medical_gui,ui\cross.paa);
                };
            };
        };
    };

    class Air;
    class Helicopter: Air {
        class ACE_Actions {
            class ACE_MainActions {
                class KAT_UnloadAndCarryPatient {
                    displayName = CSTRING(CarryPatient);
                    condition = QUOTE(alive _target);
                    statement = "";
                    insertChildren = QUOTE(call FUNC(addVehicleUnloadCarryPatientActions));
                    icon = QACEPATHTOF(medical_gui,ui\cross.paa);
                };
            };
        };
    };

    class Plane: Air {
        class ACE_Actions {
            class ACE_MainActions {
                class KAT_UnloadAndCarryPatient {
                    displayName = CSTRING(CarryPatient);
                    condition = QUOTE(alive _target);
                    statement = "";
                    insertChildren = QUOTE(call FUNC(addVehicleUnloadCarryPatientActions));
                    icon = QACEPATHTOF(medical_gui,ui\cross.paa);
                };
            };
        };
    };

    class Ship;
    class Ship_F: Ship {
        class ACE_Actions {
            class ACE_MainActions {
                class KAT_UnloadAndCarryPatient {
                    displayName = CSTRING(CarryPatient);
                    condition = QUOTE(alive _target);
                    statement = "";
                    insertChildren = QUOTE(call FUNC(addVehicleUnloadCarryPatientActions));
                    icon = QACEPATHTOF(dragging,UI\icons\person_carry.paa);
                };
            };
        };
    };
};