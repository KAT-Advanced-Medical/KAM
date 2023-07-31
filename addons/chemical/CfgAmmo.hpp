class cfgAmmo
{
    class SmokeShellArty;
    class KAT_SmokeShellArty: SmokeShellArty{
        smokeColor[] = {0,0,0,0};
    };
    
    class Smoke_82mm_AMOS_White;
    class Sh_82mm_AMOS_Type0: Smoke_82mm_AMOS_White 
    {
        KAT_projectile = 1;
        KAT_lifetime = 90;
        KAT_radius = 10;
        KAT_toxicLvL = 0;
        soundFakeFall[] = {"soundFakeFall0",0.25,"soundFakeFall1",0.25,"soundFakeFall2",0.25,"soundFakeFall3",0.25};
        soundFakeFall0[] = {"a3\Sounds_F\weapons\falling_bomb\fall_01",3.16228,1,1000};
        soundFakeFall1[] = {"a3\Sounds_F\weapons\falling_bomb\fall_02",3.16228,1,1000};
        soundFakeFall2[] = {"a3\Sounds_F\weapons\falling_bomb\fall_03",3.16228,1,1000};
        soundFakeFall3[] = {"a3\Sounds_F\weapons\falling_bomb\fall_04",3.16228,1,1000};
        whistleDist = 20;
        whistleOnFire = 2;
        submunitionAmmo = "KAT_SmokeShellArty";
    };
    class Sh_82mm_AMOS_TypeCS: Sh_82mm_AMOS_Type0
    {
        KAT_projectile = 1;
        KAT_lifetime = 60;
        KAT_radius = 10;
        KAT_toxicLvL = 1; //cs
    };

    class SmokeShell;
    class KAT_G_M7A3: SmokeShell 
    {
        KAT_csGas = 1;
        model = QPATHTOF(ui\m7a3_throw.p3d);
        dangerRadiusHit = -1;
        suppressionRadiusHit = 20;
        typicalSpeed = 22;
        cost = 40;
        explosive = 1E-7;
        deflecting = 15;
        explosionTime = 4;
        timeToLive = 20;
        grenadeBurningSound[] = {};
        aiAmmoUsageFlags = "64"; // infantry
        smokeColor[] = {0,0,0,0};
        effectsSmoke = "ACE_M84FlashbangEffect";
        whistleDist = 0;
        grenadeFireSound[] = {};
    };

    class APERSTripMine_Wire_Ammo;
    class KAT_Gas_TripWireMine_Ammo: APERSTripMine_Wire_Ammo {
        SoundSetExplosion[] = {};
        defaultMagazine = "KAT_Gas_TripWireMine_Mag"; //Mag that gets dropped after defuse
        hit = 0;
        indirectHit = 0;
        indirectHitRange = 0;
        soundHit[] = {"A3\Sounds_F\weapons\smokeshell\smoke_3",1.25893,1,100};
        explosionEffects = "KAT_GASTripEffect"; 
        CraterEffects = "";
        soundTrigger[] = {"",1,1};
        class CamShakeExplode {
            power = 0;
            duration = 0;
            frequency = 0;
            distance = 0;
        };
    };

    class KAT_GASTrip_SmokeEffect: SmokeShell {
        triggerTime = 0.1;
        ace_explosives_size = 0;
        smokeColor[] = {0.671, 0.765, 0.184,1};
    };

    class BombCore;
    //class Bo_GBU12_LGB;
    class BombCluster_01_Ammo_F;
    class KAT_CAS_M43_Ammo: BombCluster_01_Ammo_F {
        aiAmmoUsageFlags = "64 + 128 + 512";
        allowAgainstInfantry = 1;
        autoSeekTarget = 1;
        canLock=1;
        cameraViewAvailable = 1;
        CraterEffects = "BombCrater";
        CraterWaterEffects = "ImpactEffectsWaterExplosion";
        cost = 0.1;
        explosionTime = 2;
        explosionForceCoef = 5;
        explosive = 0.95;
        ExplosionEffects = "BombExplosion"; 
        flightProfiles[] = {"LoalAltitude"};
        hit = 0;
        indirectHit = 0;
        indirectHitRange = 0;
        irLock = 0;
        laserLock = 1;
        lightColor[] = {1, 0.15, 0, 1};
        maneuvrability = 16;
        model = "\A3\Weapons_F\Ammo\Bomb_01_fly_F";
        nvLock = 1;
        simulation = "shotMissile";
        soundFly[] = {"A3\Sounds_F\arsenal\weapons\Launchers\RPG32\Fly_RPG32",1,1,500};
        weaponLockSystem = 4;
        weaponType = "Default";
        triggerDistance = 250;
        triggerSpeedCoef[] = {0.8,1};
        submunitionAmmo="KAT_CAS_M43_Ammo_sub";
        class CamShakeExplode
        {
            power = 20;
            duration = 2;
            frequency = 5;
            distance = 250;
        };

        
    };
    class Mo_cluster_Bomb_01_F;
    class KAT_CAS_M43_Ammo_sub: Mo_cluster_Bomb_01_F {
        hit = 0;
        indirectHit = 0;
        indirectHitRange = 0;
        explosionEffects = "KAT_GAS_ClusterExplosion"; 
    };

    class R_80mm_HE;
    class KAT_CAS_R_80mm_GAS_AMMO: R_80mm_HE {
        hit = 0;
        indirectHit = 0;
        indirectHitRange = 0;
        explosionEffects = "KAT_CAS_R_HYDRA_Explosion"; //HERocketExplosion
    };
};