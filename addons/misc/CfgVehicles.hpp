class CfgVehicles {
    #include "vehicle_stretcher.hpp"
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

    class weapon_bag_base;
    class kat_stretcherBag: weapon_bag_base {
        class assembleInfo {
            displayName = CSTRING(Stretcher_Display);
            assembleTo = "kat_stretcher";
            base = "";
            primary = 1;
            dissasembleTo[] = {};
        };
        author = "Katalam";
        scope = 2;
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_DismantledWeapons";
        displayName = CSTRING(StretcherPacked_Display);
        mass = 60;
    };

    class Tank_F;
    class kat_stretcher: Tank_F {
        explosionEffect = "";
        fuelExplosionPower = 0;
        editorForceEmpty = 1;
        editorSubcategory = "edSubcat_Storage";
        crew = "C_man_1";
        icon = "iconObject_1x1";
        hasDriver = 0;
        scope = 2;
        side = 3;
        faction = "CIV_F";
        accuracy = 0.001;
        camouflage = 10;
        armor = 20;
        displayName = CSTRING(Stretcher_Display);
        model = QPATHTOF(models\stretcher\vurtual_stretcher.p3d);
        simulation = "tankX";
        crewVulnerable = 1;
        explosionShielding = 0;
        irTarget = 0;
        allowTabLock = 0;
        memoryPointsGetInCargo = "pos cargo";
        memoryPointsGetInCargoDir = "pos cargo dir";
        cargoAction[] = {"kat_stretcher"};
        tf_isolatedAmount = 0;
        numberPhysicalWheels = 0;
        hideProxyInCombat = 0;
        hideWeaponsCargo = "true";
        ejectDeadCargo = 0;
        class Damage {
            tex[] = {};
            mat[] = {
                QPATHTOF(models\stretcher\seat.rvmat),
                QPATHTOF(models\stretcher\seat_destruct.rvmat)
            };
        };
        class animationSources {
            class seat_hide {
                source = "user";
                initPhase = 0;
                animPeriod = 0.1;
                displayName = "Hide Stretcher";
                forceAnimatePhase = 1;
                forceAnimate[] = {"legs_hide", 1};
            };
        };
        maximumLoad = 0;
        transportMaxBackpacks = 0;
        transportMaxMagazines = 64;
        class TransportItems;
        class Turrets {};
        transportSoldier = 1;
        ace_cargo_canLoad = 0;
        ace_Cargo_hasCargo = 0;
        ace_dragging_canDrag = 1;
        ace_dragging_canCarry = 1;
        ace_dragging_dragPosition[] = {0,1.7,0};
        ace_dragging_carryPosition[] = {0, 1.7, 0};
        ace_dragging_dragDirection = 0;
        ace_Carry_carryDirection = 0;
        ace_cookoff_probability = 0;
        slingLoadCargoMemoryPoints[] = {"SlingLoadCargo1", "SlingLoadCargo2", "SlingLoadCargo3", "SlingLoadCargo4"};
        destrType = "destructDefault";
        fuelCapacity = 0;

        //pretend static weapon since some mods don't like unconscious people in static weapons
        nameSound = "veh_static_s";
        vehicleClass = "static";
        unitInfoType = "RscUnitInfoStatic";
        crewExplosionProtection = 0;
        class DestructionEffects {};
        class VehicleTransport {
            class Cargo {
                parachuteClass              = "B_Parachute_02_F";
                parachuteHeightLimit        = 5;
                canBeTransported            = 1;
                dimensions[]                = {"VTV_Cargo_Base", "VTV_Cargo_Corner"};
            };
        };
        class EventHandlers {
            init = QUOTE(_this call FUNC(stretcher));
        };
    };
    class Land_Stretcher_01_base_F;
    class Land_Stretcher_01_olive_F: Land_Stretcher_01_base_F {
        ace_cargo_canLoad = 1;
        ace_Cargo_hasCargo = 0;
        ace_dragging_canDrag = 1;
        ace_dragging_canCarry = 1;
        ace_dragging_dragPosition[] = {0,1.7,0};
        ace_dragging_carryPosition[] = {0, 1.7, 0};
        ace_dragging_dragDirection = 0;
        ace_Carry_carryDirection = 0;
        ace_cookoff_probability = 0;
        class VehicleTransport {
            class Cargo {
                parachuteClass              = "B_Parachute_02_F";
                parachuteHeightLimit        = 5;
                canBeTransported            = 1;
                dimensions[]                = {"VTV_Cargo_Base", "VTV_Cargo_Corner"};
            };
        };
    };
    class Items_base_F;
    class Kat_armbandRC: Items_base_F {
        scope = 2;
        scopeCurator = 2;
        scopeArsenal = 2;
        author = "Miss Heda, vccv9040 (Swedish Forces Pack)";
        editorPreview = QPATHTOF(ui\ArmbandWhiteCross.paa);
        model = QPATHTOF(models\armband\Armband.p3d);
        hiddenSelections[] = {"Armband"};
        hiddenSelectionsTextures[] = {QPATHTOF(models\armband\ArmbandWC.paa)};
    };
    class Kat_armbandRCM: Kat_armbandRC {
        author = "Miss Heda, vccv9040 (Swedish Forces Pack)";
        editorPreview = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
        model = QPATHTOF(models\armband\Armband.p3d);
        hiddenSelectionsTextures[] = {QPATHTOF(models\armband\ArmbandWCM.paa)};
    };
    class Kat_armbandRCD: Kat_armbandRC {
        author = "Miss Heda, vccv9040 (Swedish Forces Pack)";
        editorPreview = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
        model = QPATHTOF(models\armband\Armband.p3d);
        hiddenSelectionsTextures[] = {QPATHTOF(models\armband\ArmbandWCD.paa)};
    };
    class Kat_armbandKAT: Kat_armbandRC {
        author = "Miss Heda, vccv9040 (Swedish Forces Pack)";
        editorPreview = QPATHTOF(ui\ArmbandKat.paa);
        model = QPATHTOF(models\armband\Armband.p3d);
        hiddenSelectionsTextures[] = {QPATHTOF(models\armband\ArmbandKAT.paa)};
    };
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions
        {
            class ACE_Equipment
            {
                class Armband {
                    displayName = CSTRING(Armband_Sling);
                    condition = QUOTE(_player call FUNC(checkArmbandCondition));
                    statement = "";
                    icon = QPATHTOF(ui\ArmbandWhiteCross.paa);
                    showDisabled = 1;

                    class LeftArm {
                        displayName = CSTRING(Armband_Sling_Left_Arm);
                        condition = QUOTE(_player getVariable [ARR_2(QQGVAR(isLeftArmFree), false)]);
                        exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                        statement = "";
                        showDisabled = 0;
                        icon = QPATHTOF(ui\ArmbandLeftArm.paa);

                        class RedCross {
                            displayName = CSTRING(Armband_Red_Cross_ItemName);
                            condition = QUOTE([ARR_2(_player, ""kat_armband_red_cross"")] call ACEFUNC(common,hasItem));
                            exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                            statement = QUOTE([ARR_3(_player, ""kat_armband_red_cross"", 0)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCross.paa);
                        };

                        class Medic {
                            displayName = CSTRING(Armband_Medic_ItemName);
                            condition = QUOTE([ARR_2(_player, ""kat_armband_medic"")] call ACEFUNC(common,hasItem));
                            exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                            statement = QUOTE([ARR_3(_player, ""kat_armband_medic"", 0)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
                        };

                        class Doctor {
                            displayName = CSTRING(Armband_Doctor_ItemName);
                            condition = QUOTE([ARR_2(_player, ""kat_armband_doctor"")] call ACEFUNC(common,hasItem));
                            exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                            statement = QUOTE([ARR_3(_player, ""kat_armband_doctor"", 0)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
                        };

                        class Kat {
                            displayName = CSTRING(Armband_Kat_ItemName);
                            condition = QUOTE([ARR_2(_player, ""kat_armband_kat"")] call ACEFUNC(common,hasItem));
                            exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                            statement = QUOTE([ARR_3(_player, ""kat_armband_kat"", 0)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandKat.paa);
                        };
                    }; 

                    class RightArm {
                        displayName = CSTRING(Armband_Sling_Right_Arm);
                        condition = QUOTE(_player getVariable [ARR_2(QQGVAR(isRightArmFree), false)]);
                        exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                        statement = "";
                        showDisabled = 0;
                        icon = QPATHTOF(ui\ArmbandRightArm.paa);

                        class RedCross {
                            displayName = CSTRING(Armband_Red_Cross_ItemName);
                            condition = QUOTE([ARR_2(_player, ""kat_armband_red_cross"")] call ACEFUNC(common,hasItem));
                            exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                            statement = QUOTE([ARR_3(_player, ""kat_armband_red_cross"", 1)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCross.paa);
                        };

                        class Medic {
                            displayName = CSTRING(Armband_Medic_ItemName);
                            condition = QUOTE([ARR_2(_player, ""kat_armband_medic"")] call ACEFUNC(common,hasItem));
                            exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                            statement = QUOTE([ARR_3(_player, ""kat_armband_medic"", 1)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
                        };

                        class Doctor {
                            displayName = CSTRING(Armband_Doctor_ItemName);
                            condition = QUOTE([ARR_2(_player, ""kat_armband_doctor"")] call ACEFUNC(common,hasItem));
                            exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                            statement = QUOTE([ARR_3(_player, ""kat_armband_doctor"", 1)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
                        };

                        class Kat {
                            displayName = CSTRING(Armband_Kat_ItemName);
                            condition = QUOTE([ARR_2(_player, ""kat_armband_kat"")] call ACEFUNC(common,hasItem));
                            exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                            statement = QUOTE([ARR_3(_player, ""kat_armband_kat"", 1)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandKat.paa);
                        };
                    }; 

                    class LeftLeg {
                        displayName = CSTRING(Armband_Sling_Left_Leg);
                        condition = QUOTE(_player getVariable [ARR_2(QQGVAR(isLeftLegFree), false)]);
                        exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                        statement = "";
                        showDisabled = 0;
                        icon = QPATHTOF(ui\ArmbandLeftLeg.paa);

                        class RedCross {
                            displayName = CSTRING(Armband_Red_Cross_ItemName);
                            condition = QUOTE([ARR_2(_player, ""kat_armband_red_cross"")] call ACEFUNC(common,hasItem));
                            exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                            statement = QUOTE([ARR_3(_player, ""kat_armband_red_cross"", 2)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCross.paa);
                        };

                        class Medic {
                            displayName = CSTRING(Armband_Medic_ItemName);
                            condition = QUOTE([ARR_2(_player, ""kat_armband_medic"")] call ACEFUNC(common,hasItem));
                            exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                            statement = QUOTE([ARR_3(_player, ""kat_armband_medic"", 2)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
                        };

                        class Doctor {
                            displayName = CSTRING(Armband_Doctor_ItemName);
                            condition = QUOTE([ARR_2(_player, ""kat_armband_doctor"")] call ACEFUNC(common,hasItem));
                            exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                            statement = QUOTE([ARR_3(_player, ""kat_armband_doctor"", 2)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
                        };

                        class Kat {
                            displayName = CSTRING(Armband_Kat_ItemName);
                            condition = QUOTE([ARR_2(_player, ""kat_armband_kat"")] call ACEFUNC(common,hasItem));
                            exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                            statement = QUOTE([ARR_3(_player, ""kat_armband_kat"", 2)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandKat.paa);
                        };
                    }; 

                    class RightLeg {
                        displayName = CSTRING(Armband_Sling_Right_Leg);
                        condition = QUOTE(_player getVariable [ARR_2(QQGVAR(isRightLegFree), false)]);
                        exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                        statement = "";
                        showDisabled = 0;
                        icon = QPATHTOF(ui\ArmbandRightLeg.paa);

                        class RedCross {
                            displayName = CSTRING(Armband_Red_Cross_ItemName);
                            condition = QUOTE([ARR_2(_player, ""kat_armband_red_cross"")] call ACEFUNC(common,hasItem));
                            exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                            statement = QUOTE([ARR_3(_player, ""kat_armband_red_cross"", 3)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCross.paa);
                        };

                        class Medic {
                            displayName = CSTRING(Armband_Medic_ItemName);
                            condition = QUOTE([ARR_2(_player, ""kat_armband_medic"")] call ACEFUNC(common,hasItem));
                            exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                            statement = QUOTE([ARR_3(_player, ""kat_armband_medic"", 3)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
                        };

                        class Doctor {
                            displayName = CSTRING(Armband_Doctor_ItemName);
                            condition = QUOTE([ARR_2(_player, ""kat_armband_doctor"")] call ACEFUNC(common,hasItem));
                            exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                            statement = QUOTE([ARR_3(_player, ""kat_armband_doctor"", 3)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
                        };

                        class Kat {
                            displayName = CSTRING(Armband_Kat_ItemName);
                            condition = QUOTE([ARR_2(_player, ""kat_armband_kat"")] call ACEFUNC(common,hasItem));
                            exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                            statement = QUOTE([ARR_3(_player, ""kat_armband_kat"", 3)] call FUNC(slingArmband));
                            showDisabled = 0;
                            icon = QPATHTOF(ui\ArmbandKat.paa);
                        };
                    };

                    class UnSlingLeftArm {
                        displayName = CSTRING(Armband_UnSling_Left_Arm);
                        condition = QUOTE(!(_player getVariable [ARR_2(QQGVAR(isLeftArmFree), false)]));
                        exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                        statement = QUOTE([ARR_2(_player, 0)] call FUNC(unSlingArmband));
                        showDisabled = 0;
                        icon = QPATHTOF(ui\ArmbandLeftArm.paa);
                    }; 

                    class UnSlingRightArm {
                        displayName = CSTRING(Armband_UnSling_Right_Arm);
                        condition = QUOTE(!(_player getVariable [ARR_2(QQGVAR(isRightArmFree), false)]));
                        exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                        statement = QUOTE([ARR_2(_player, 1)] call FUNC(unSlingArmband));
                        showDisabled = 0;
                        icon = QPATHTOF(ui\ArmbandRightArm.paa);
                    }; 

                    class UnSlingLeftLeg {
                        displayName = CSTRING(Armband_UnSling_Left_Leg);
                        condition = QUOTE(!(_player getVariable [ARR_2(QQGVAR(isLeftLegFree), false)]));
                        exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                        statement = QUOTE([ARR_2(_player, 2)] call FUNC(unSlingArmband));
                        showDisabled = 0;
                        icon = QPATHTOF(ui\ArmbandLeftLeg.paa);
                    }; 

                    class UnSlingRightLeg {
                        displayName = CSTRING(Armband_UnSling_Right_Leg);
                        condition = QUOTE(!(_player getVariable [ARR_2(QQGVAR(isRightLegFree), false)]));
                        exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                        statement = QUOTE([ARR_2(_player, 3)] call FUNC(unSlingArmband));
                        showDisabled = 0;
                        icon = QPATHTOF(ui\ArmbandRightLeg.paa);
                    };
                };

                class BubbleWrapPopping {
                    displayName = CSTRING(Bubble_Wrap_Ace_Action);
                    condition = QUOTE([ARR_2(_player, ""kat_Bubble_Wrap"")] call ACEFUNC(common,hasMagazine));
                    exceptions[] = {"isNotSwimming", "isNotInside", "notOnMap", "isNotSitting"};
                    statement = QUOTE(_player call FUNC(BubbleWrap));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\Bubble_Wrap_Item.paa);
                };
            };
        };
        class ACE_Actions {
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
            class ACE_MainActions {
                class KAT_UnloadAndCarryPatient {
                    displayName = CSTRING(CarryPatient);
                    condition = QUOTE(_target getVariable [ARR_2('ACE_isUnconscious', false)] && {!(isNull (objectParent _target))} && {isNull (objectParent _player)});
                    exceptions[] = {"isNotDragging", "isNotCarrying", "isNotInside"};
                    statement = QUOTE([ARR_2(_player, _target)] call FUNC(unloadAndCarryPatient));
                    icon = QACEPATHTOF(dragging,UI\icons\person_carry.paa);
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
                    exceptions[] = {"isNotDragging", "isNotCarrying", "isNotInside"};
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
                    exceptions[] = {"isNotDragging", "isNotCarrying", "isNotInside"};
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
                    exceptions[] = {"isNotDragging", "isNotCarrying", "isNotInside"};
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
                    exceptions[] = {"isNotDragging", "isNotCarrying", "isNotInside"};
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
                    exceptions[] = {"isNotDragging", "isNotCarrying", "isNotInside"};
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
                    exceptions[] = {"isNotDragging", "isNotCarrying", "isNotInside"};
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
                    exceptions[] = {"isNotDragging", "isNotCarrying", "isNotInside"};
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
                    exceptions[] = {"isNotDragging", "isNotCarrying", "isNotInside"};
                    statement = "";
                    insertChildren = QUOTE(call FUNC(addVehicleUnloadCarryPatientActions));
                    icon = QACEPATHTOF(dragging,UI\icons\person_carry.paa);
                };
            };
        };
    };
};
