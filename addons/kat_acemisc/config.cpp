#include "BIS_AddonInfo.hpp"
class CfgPatches {
    class kat_aceMisc {
        units[] = {
            "KAT_stretcher",
            "KAT_stretcher_bag"
        };
        weapons[] = {

        };
        requiredVersion = 1.80;
        requiredAddons[] = {
            "ace_medical",
            "cba_settings",
            "A3_Static_F"
        };
        version = "1.0";
        versionStr = "1.0";
        author = "Katalam";
        authorUrl = "https://github.com/Katalam/kat_aceAdvMedical";
    };
};

#define MACRO_ADDITEM(ITEM,COUNT) class _xx_##ITEM { \
    name = #ITEM; \
    count = COUNT; \
};

class CfgMovesBasic {
	class ManActions {
		kat_stretcher = "kat_stretcher";
	};
};

class CfgMovesMaleSdr: CfgMovesBasic {
	class States {
		class Crew;
		class kat_stretcher: crew {
			file = "a3\anims_f\data\anim\sdr\inj\ainjppnemstpsnonwnondnon.rtm";
			interpolateTo[] = {"Unconscious", 0.02};
			leftHandIKCurve[] = {};
			rightHandIKCurve[] = {};
		};
	};
};

class CfgFunctions {
    class kat_aceMisc {
        file = "kat_aceMisc\functions";
        class functions {
            class addIVbag{};
            class attachStretcher{};
            class bandageRandomWound{};
            class conditionIV{};
            class conditionIVstand{};
            class events{};
            class getNumOpenWounds{};
            class handleInit{};
            class init{};
            class limitWounds{};
            class registerSettings{};
            class removeIVbag{};
            class stretcher{};
            class treatmentIV{};
        };
    };

    class kat_aceInteraction {
        tag = "ace_interaction";
        class ace_interaction {
            class addPassengersActions {
                file = "kat_aceMisc\functions\fn_addPassengersActions.sqf";
            };
        };
    };

};

class Extended_PreInit_EventHandlers {
    class kat_aceMisc_preInit {
        init = "call kat_aceMisc_fnc_registerSettings";
    };
};
class Extended_Init_EventHandlers {
    class CAManBase {
        class kat_aceMisc_init {
            init = "_this call kat_aceMisc_fnc_handleInit";
        };
    };
};
class Extended_PostInit_EventHandlers {
    class kat_aceMisc_postInit {
        init = "call kat_aceMisc_fnc_events";
    };
};

class cfgVehicles {
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
    class kat_stretcher_bag: weapon_bag_base {
        class assembleInfo {
            displayName = "Stretcher";
            assembleTo = "kat_stretcher";
            base = "";
            primary = 1;
            dissasembleTo[] = {};
        };
        author = "Katalam";
        scope = 2;
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_DismantledWeapons";
        displayName = "Stretcher (Packed)";
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
        displayName = "Stretcher";
        model = "\kat_acemisc\images\vurtual_stretcher.p3d";
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
        hideWeaponsCargo = true;
        ejectDeadCargo = 0;
        class Damage {
            tex[] = {};
            mat[] = {
                "kat_acemisc\images\seat.rvmat",
                "kat_acemisc\images\seat_destruct.rvmat"
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
        transportMaxMagazines = 12;
        class TransportItems;
        class CargoTurret;
        class Turrets {
            class MainTurret: CargoTurret {
                gunnerAction = "passenger_inside_2";
                gunnerInAction = "passenger_inside_2"; //fixes standing up in steat
                memoryPointsGetInGunner = "pos cargo";
                memoryPointsGetInGunnerDir = "pos cargo dir";
                gunnerName = "Armchair Warrior";
                gunnerCompartments = "Compartment1";
                proxyIndex = 1;
                isPersonTurret = 1;
                forceHideGunner = 1; //fixes being turned out in seat
                maxElev = 75;
                minElev = -75;
                maxTurn = 95;
                minTurn = -95;
                stabilizedInAxes = 3;
                primaryGunner = 1;
                dontCreateAI = 0;
                ejectDeadGunner = 0;
            };
        };
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
            init = "_this call kat_aceMisc_fnc_stretcher";
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

    class Man;
    class CAManBase: Man {
        class ACE_Actions {
            class ACE_Torso {
                class FieldDressing;
                class LimitWounds {
                    displayName = "$STR_kat_aceMisc_LIMITWOUNDS_Display";
                    condition = "[_player, _target, 'hand_l', 'LimitWounds'] call ace_medical_fnc_canTreatCached";
                    statement = "[_player, _target, 'hand_l', 'LimitWounds'] call ace_medical_fnc_treatment";
                    icon = "";
                };
            };
            class ACE_ArmLeft {
                class SalineIV;
                class SalineIV_Stand: SalineIV {
                    displayName = "$STR_kat_aceMisc_Display_IVStand";
                    condition = "[_player, _target, 'hand_l', 'SalineIV_Stand'] call ace_medical_fnc_canTreatCached";
                    statement = "[_player, _target, 'hand_l', 'SalineIV_Stand'] call ace_medical_fnc_treatment";
                };
            };
            class ACE_ArmRight {
                class SalineIV;
                class SalineIV_Stand: SalineIV {
                    displayName = "$STR_kat_aceMisc_Display_IVStand";
                    condition = "[_player, _target, 'hand_r', 'SalineIV_Stand'] call ace_medical_fnc_canTreatCached";
                    statement = "[_player, _target, 'hand_r', 'SalineIV_Stand'] call ace_medical_fnc_treatment";
                };
            };
            class ACE_LegLeft {
                class SalineIV;
                class SalineIV_Stand: SalineIV {
                    displayName = "$STR_kat_aceMisc_Display_IVStand";
                    condition = "[_player, _target, 'leg_l', 'SalineIV_Stand'] call ace_medical_fnc_canTreatCached";
                    statement = "[_player, _target, 'leg_l', 'SalineIV_Stand'] call ace_medical_fnc_treatment";
                };
            };
            class ACE_LegRight {
                class SalineIV;
                class SalineIV_Stand: SalineIV {
                    displayName = "$STR_kat_aceMisc_Display_IVStand";
                    condition = "[_player, _target, 'leg_r', 'SalineIV_Stand'] call ace_medical_fnc_canTreatCached";
                    statement = "[_player, _target, 'leg_r', 'SalineIV_Stand'] call ace_medical_fnc_treatment";
                };
            };
        };
    };
};

class ACE_Medical_Actions {
    class Advanced {
        class SalineIV;
        class SalineIV_Stand: SalineIV {
            displayName = "$STR_kat_aceMisc_Display_IVStand";
            requiredMedic = 0;
            condition = "kat_aceMisc_fnc_conditionIV";
            items[] = {};
            callbackSuccess = "[_player, _target, _selectionName, 'SalineIV', ['SalineIV']] call kat_aceMisc_fnc_treatmentIV";
            itemConsumed = 0;
        };
        class PersonalAidKit;
        class LimitWounds: PersonalAidKit {
            displayName = $STR_kat_aceMisc_LIMITWOUNDS_Display;
            displayNameProgress = $STR_kat_aceMisc_LIMITWOUNDS_Display;
            patientStateCondition = "kat_aceMisc_limitWounds_condition";
            condition = "[_target] call kat_aceMisc_fnc_getNumOpenWounds > 5 && (missionNamespace getVariable ['kat_aceMisc_limitWounds_enable', true])";
            treatmentTime = 8;
            callbackSuccess = "[_target] call kat_aceMisc_fnc_limitWounds";
        };
    };
};
