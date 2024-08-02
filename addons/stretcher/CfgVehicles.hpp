class CBA_Extended_EventHandlers_base;
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
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
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

    class Air;
    class Helicopter: Air {
        class ACE_Actions {
            class ACE_MainActions {
                class KAT_AttachHeliStretcher {
                    displayName = CSTRING(AttachHeliStretcher);
                    condition = QUOTE([ARR_2(_player,_target)] call FUNC(canAttachHeliStretcher));
                    statement = QUOTE([ARR_2(_player,_target)] call FUNC(attachHeliStretcher));
                    icon = QPATHTOF(ui\stretcher.paa);
                };
                class KAT_DetachHeliStretcher {
                    displayName = CSTRING(DetachHeliStretcher);
                    condition = QUOTE([ARR_2(_player,_target)] call FUNC(canDetachHeliStretcher));
                    statement = QUOTE([ARR_2(_player,_target)] call FUNC(detachHeliStretcher));
                    icon = QPATHTOF(ui\stretcher.paa);
                };
            };
        };
        class ACE_SelfActions {
            class KAT_DeployStretcher {
                displayName = CSTRING(DeployHeliStretcher);
                condition = QUOTE(_player call FUNC(canDeployStretcher));
                statement = QUOTE([ARR_2(_player,_target)] call FUNC(deployStretcher));
                icon = QPATHTOF(ui\downarrow.paa);
            };

            class KAT_LowerStretcher {
                displayName = CSTRING(LowerHeliStretcher);
                condition = QUOTE(_player call FUNC(canAdjustRopes));
                statement = QUOTE([ARR_2(_player,_target)] call FUNC(lowerStretcher));
                icon = QPATHTOF(ui\downarrow.paa);
            };

            class KAT_RaiseStretcher {
                displayName = CSTRING(RaiseHeliStretcher);
                condition = QUOTE(_player call FUNC(canAdjustRopes));
                statement = QUOTE([ARR_2(_player,_target)] call FUNC(raiseStretcher));
                icon = QPATHTOF(ui\uparrow.paa);
            };

            class KAT_RetractStretcher {
                displayName = CSTRING(RetractHeliStretcher);
                condition = QUOTE(_player call FUNC(canAdjustRopes));
                statement = QUOTE([ARR_2(_player,_target)] call FUNC(retractStretcher));
                icon = QPATHTOF(ui\uparrow.paa);
            };
        };
    };
};
