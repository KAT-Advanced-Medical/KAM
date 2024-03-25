class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class kat_gasmaskFilter : ACE_ItemCore {
        scope = 2;
        author = "DiGii";
        displayName = CSTRING(GasFilterItem);
        model = "\A3\weapons_F\ammo\mag_univ.p3d";
        picture = QPATHTOF(ui\gasmaskfilter_ca.paa);
        descriptionShort = CSTRING(GasFilterItem_desc);
        descriptionUse = CSTRING(GasFilterItem_desc);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };

    class kat_sealant : ACE_ItemCore {
        scope = 2;
        author = "DiGii";
        displayName = CSTRING(sealantItem);
        model = "\A3\Weapons_F\DummyItem.p3d";
        picture = QPATHTOF(ui\Sealant.paa);
        descriptionShort = CSTRING(sealantItem_desc);
        descriptionUse = CSTRING(sealantItem_desc);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 3;
        };
    };

    class CannonCore;
    class mortar_82mm: CannonCore {
        magazines[] += {
            "KAT_1Rnd_82mm_Mo_Type0",
            "KAT_5Rnd_82mm_Mo_Type0_AI",
            "KAT_1Rnd_82mm_Mo_TypeCS",
            "KAT_3Rnd_82mm_Mo_TypeCS_AI"
        };
    };
    class ACE_mortar_82mm;
    class ACE_mortar_82mm: mortar_82mm {
        magazines[] += {
            "KAT_1Rnd_82mm_Mo_Type0",
            "KAT_1Rnd_82mm_Mo_TypeCS"
        };
    };

    class GrenadeLauncher;
    class Throw: GrenadeLauncher {
        muzzles[] += {"ACE_M7A3Muzzle"};

        class ThrowMuzzle;
        class ACE_M7A3Muzzle: ThrowMuzzle {
            magazines[] = {"KAT_M7A3"};
        };
    };

    class Default;
    class Put: Default {
        muzzles[]+= {
            "ace_explosives_muzzle"
        };
        class PutMuzzle: Default {};
        class ace_explosives_muzzle: PutMuzzle {
            magazines[] += {
                "KAT_Gas_TripWireMine_Mag"
            };
        };
    };

    class weapon_GBU12Launcher;
    class KAT_CAS_M43_Bomb: weapon_GBU12Launcher {
        author = "DiGii";
        canLock = 2;
        scope=2;
        displayName = "M43 BZ LGB";
        maxRange = 5000;
        maxRangeProbab = 0.8;
        midRange = 2000;
        midRangeProbab = 0.85;
        minRange = 150;
        minRangeProbab = 0.6;
        magazines[] = {"KAT_CAS_M43_Mag","KAT_CAS_M43_Mag_x2"};
        maxControlRange = 8000;
        weaponLockDelay = 3;
        weaponLockSystem = 4;
    };

    class rockets_Skyfire;
    class KAT_CAS_R_80mm_GAS_POD: rockets_Skyfire {
        displayName = "Hydra GAS 19x";
        magazines[] = {"KAT_CAS_R_80mm_GAS_MAG"};
        scope=2;
    };
};
