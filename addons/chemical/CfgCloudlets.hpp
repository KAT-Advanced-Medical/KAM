class CfgCloudlets {
    class Default;
    class KAT_TripWireGas: Default {
        lifeTime = 0;
        beforeDestroyScript = QPATHTOF(functions\fnc_GasTripEffect.sqf);
    };

    class KAT_CAS_GAS_Explosion_FX_Script: Default {
        lifeTime = 0;
        beforeDestroyScript = QPATHTOF(functions\fnc_CASCreateGas.sqf);
    };

    class KAT_CAS_GAS_Explosion_FX: Default {
        interval = 0.03;
        circleRadius = 0;
        circleVelocity[] = {0,0,0};
        particleFSNtieth = 16;
        particleFSIndex = 7;
        particleFSFrameCount = 48;
        particleFSLoop = 1;
        angleVar = 360;
        particleShape = "\A3\data_f\ParticleEffects\Universal\Universal";
        particleType = "Billboard";
        timerPeriod = 1;
        lifeTime = 3;
        moveVelocity[] = {0,2,0};
        rotationVelocity = 0;
        weight = 0.05;
        volume = 0.04;
        rubbing = 0.025;
        size[] = {3,7,10};
        color[] =
        {
            {0.3,0.3,0.3,0},
            {0.3,0.3,0.3,0.2},
            {0.3,0.3,0.3,0.3},
            {0.3,0.3,0.3,0.3},
            {0.3,0.3,0.3,0.3},
            {0.3,0.3,0.3,0.32},
            {0.471, 0.565, 0.064,0.4},
            {0.571, 0.665, 0.084,0.3},
            {0.671, 0.765, 0.184,0.1},
            {0.671, 0.765, 0.184,0}
        };
        animationSpeed[] = {0.5,0.3};
        randomDirectionPeriod = 0.2;
        randomDirectionIntensity = 0.1;
        onTimerScript = "";
        beforeDestroyScript = "";
        lifeTimeVar = 2.5;
        positionVar[] = {0.2,0.2,0.2};
        moveVelocityVar[] = {1.8,1,1.8};
        rotationVelocityVar = 20;
        sizeVar = 0.3;
        colorVar[] = {0,0,0,0.3};
        randomDirectionPeriodVar = 0.2;
        randomDirectionIntensityVar = 0.05;
        coreIntensity = 0;
        coreDistance = 0;
        damageTime = 0;
        damageType = "";
        angle = 0;
        position[] = {0,0,0};
    };

    class GVAR(Toxic_Gas_Particles): Default {
        interval = 0.05;
        circleRadius = 0;
        circleVelocity[] = {0,0,0};
        particleFSNtieth = 16;
        particleFSIndex = 7;
        particleFSFrameCount = 16;
        particleFSLoop = 1;
        angleVar = 1;
        particleShape = "\A3\data_f\ParticleEffects\Universal\Universal.p3d";
        particleType = "Billboard";
        timerPeriod = 1;
        lifeTime = 10;
        moveVelocity[] = {0,0,0};
        rotationVelocity = 1;
        weight = 100;
        volume = 1;
        rubbing = 0.01;
        size[] = {0.3,4,0};
        color[] =
        {
            {0.3, 0.3, 0.3, 0},
            {0.4, 0.45, 0.1, 0.25},
            {0.45, 0.55, 0.1, 0.4},
            {0.5, 0.6, 0.12, 0.35},
            {0.55, 0.65, 0.15, 0.2},
            {0.6, 0.7, 0.17, 0}
        };
        animationSpeed[] = {0.5,0.3};
        randomDirectionPeriod = 1;
        randomDirectionIntensity = 0.04;
        onTimerScript = "";
        beforeDestroyScript = "";
        lifeTimeVar = 5;
        positionVar[] = {0,0,0};
        moveVelocityVar[] = {0.5,0,0.5};
        rotationVelocityVar = 10;
        sizeVar = 0;
        colorVar[] = {0,0,0,0.35};
        randomDirectionPeriodVar = 0;
        randomDirectionIntensityVar = 0;
        coreIntensity = 0;
        coreDistance = 0;
        damageTime = 0;
        damageType = "";
        angle = 0;
        position[] = {0,0,0};
        onSurface = 1;
        surfaceOffset = 0;
        bounceOnSurface = 0;
        ignoreWind = 1;
    };

    class GVAR(Toxic_Gas_Wisps): GVAR(Toxic_Gas_Particles) {
        interval = 0.1;
        lifeTime = 6;
        lifeTimeVar = 3;
        size[] = {0.1, 1.5, 0};
        moveVelocity[] = {0, 0, 0.3};
        moveVelocityVar[] = {0.3, 0.3, 0.2};
        onSurface = 0;
        rubbing = 0.05;
        color[] =
        {
            {0.4, 0.5, 0.1, 0},
            {0.45, 0.55, 0.12, 0.15},
            {0.5, 0.6, 0.15, 0.1},
            {0.5, 0.6, 0.15, 0}
        };
    };

    // Phosgene — pale grey-white, faint
    class GVAR(Phosgene_Gas_Particles): GVAR(Toxic_Gas_Particles) {
        color[] = {
            {0.7, 0.7, 0.7, 0},
            {0.78, 0.78, 0.76, 0.20},
            {0.82, 0.82, 0.80, 0.30},
            {0.85, 0.85, 0.82, 0.25},
            {0.85, 0.85, 0.82, 0.15},
            {0.85, 0.85, 0.82, 0}
        };
    };
    class GVAR(Phosgene_Gas_Wisps): GVAR(Toxic_Gas_Wisps) {
        color[] = {
            {0.78, 0.78, 0.76, 0},
            {0.85, 0.85, 0.82, 0.10},
            {0.88, 0.88, 0.85, 0.08},
            {0.88, 0.88, 0.85, 0}
        };
    };

    // Mustard — yellowish-brown, garlic-thick
    class GVAR(Mustard_Gas_Particles): GVAR(Toxic_Gas_Particles) {
        color[] = {
            {0.45, 0.35, 0.10, 0},
            {0.55, 0.42, 0.12, 0.30},
            {0.62, 0.48, 0.15, 0.45},
            {0.65, 0.50, 0.16, 0.40},
            {0.65, 0.50, 0.16, 0.20},
            {0.65, 0.50, 0.16, 0}
        };
    };
    class GVAR(Mustard_Gas_Wisps): GVAR(Toxic_Gas_Wisps) {
        color[] = {
            {0.55, 0.42, 0.12, 0},
            {0.62, 0.48, 0.15, 0.18},
            {0.65, 0.50, 0.16, 0.13},
            {0.65, 0.50, 0.16, 0}
        };
    };

    // Sarin — almost invisible, very faint warm tint
    class GVAR(Sarin_Gas_Particles): GVAR(Toxic_Gas_Particles) {
        color[] = {
            {0.75, 0.72, 0.65, 0},
            {0.80, 0.77, 0.70, 0.06},
            {0.82, 0.79, 0.72, 0.10},
            {0.82, 0.79, 0.72, 0.08},
            {0.82, 0.79, 0.72, 0.04},
            {0.82, 0.79, 0.72, 0}
        };
    };
    class GVAR(Sarin_Gas_Wisps): GVAR(Toxic_Gas_Wisps) {
        color[] = {
            {0.80, 0.77, 0.70, 0},
            {0.82, 0.79, 0.72, 0.04},
            {0.82, 0.79, 0.72, 0.03},
            {0.82, 0.79, 0.72, 0}
        };
    };

    // VX — oily amber, persistent and visible
    class GVAR(VX_Gas_Particles): GVAR(Toxic_Gas_Particles) {
        color[] = {
            {0.50, 0.38, 0.05, 0},
            {0.60, 0.45, 0.08, 0.25},
            {0.70, 0.52, 0.10, 0.40},
            {0.72, 0.55, 0.12, 0.35},
            {0.72, 0.55, 0.12, 0.18},
            {0.72, 0.55, 0.12, 0}
        };
    };
    class GVAR(VX_Gas_Wisps): GVAR(Toxic_Gas_Wisps) {
        color[] = {
            {0.60, 0.45, 0.08, 0},
            {0.70, 0.52, 0.10, 0.18},
            {0.72, 0.55, 0.12, 0.13},
            {0.72, 0.55, 0.12, 0}
        };
    };

    class KAT_CAS_GAS_FX: Default {
        interval = 0.03;
        circleRadius = 0;
        circleVelocity[] = {0,0,0};
        particleFSNtieth = 16;
        particleFSIndex = 7;
        particleFSFrameCount = 48;
        particleFSLoop = 1;
        angleVar = 360;
        particleShape = "\A3\data_f\ParticleEffects\Universal\Universal.p3d";
        particleType = "Billboard";
        timerPeriod = 1;
        lifeTime = 3;
        moveVelocity[] = {1,0,1};
        rotationVelocity = 0;
        weight = 0.05;
        volume = 0.04;
        rubbing = 0.025;
        size[] = {1,3,4};
        color[] =
        {
            {0.3,0.3,0.3,0},
            {0.4,0.4,0.4,0.2},
            {0.371, 0.465, 0.044,0.3},
            {0.471, 0.565, 0.084,0.2},
            {0.671, 0.765, 0.184,0.1},
            {0.671, 0.765, 0.184,0}
        };
        animationSpeed[] = {0.5,0.3};
        randomDirectionPeriod = 0.2;
        randomDirectionIntensity = 0.1;
        onTimerScript = "";
        beforeDestroyScript = "";
        lifeTimeVar = 2.5;
        positionVar[] = {0,0,0};
        moveVelocityVar[] = {-1,0.5,-1};
        rotationVelocityVar = 20;
        sizeVar = 0.3;
        colorVar[] = {0,0,0,0.3};
        randomDirectionPeriodVar = 0.2;
        randomDirectionIntensityVar = 0.05;
        coreIntensity = 0;
        coreDistance = 0;
        damageTime = 0;
        damageType = "";
        angle = 0;
        position[] = {0,0.2,0};
    };
};

class KAT_TripWireGasEffect {
    class spawnGAS {
        simulation = "particles";
        type = "KAT_TripWireGas";
        position = "explosionPos";
    };
};

class KAT_GAS_ClusterExplosion {
    class ExplosionEffect {
        simulation = "particles";
        type = "KAT_CAS_GAS_Explosion_FX";
        position = "explosionPos";
        lifeTime = 2;
        particleFSLoop = 1;
    };
    class CAS_GAS_Effect {
        simulation = "particles";
        type = "KAT_CAS_GAS_FX";
        position = "explosionPos";
        lifeTime = 240;
        particleFSLoop = 1;
    };
    class GAS_Script {
        simulation = "particles";
        type = "KAT_CAS_GAS_Explosion_FX_Script";
        position = "explosionPos";
    };
};

class KAT_CAS_R_HYDRA_Explosion {
    class CAS_R_GAS_Effect {
        simulation = "particles";
        type = "KAT_CAS_GAS_FX";
        position = "explosionPos";
        lifeTime = 240;
        particleFSLoop = 1;
    };
    class R_GAS_Script {
        simulation = "particles";
        type = "KAT_CAS_GAS_Explosion_FX_Script";
        position = "explosionPos";
    };
};

