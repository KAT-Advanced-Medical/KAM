class CfgSounds {
    sounds[] = {};
    class GVAR(Reduction) {
        name = QGVAR(Reduction);
        sound[] = {QPATHTOF_SOUND(sounds\reduction.wav), "db + 20", 1, 20};
        titles[]    = {};
    };
    class GVAR(Vacuum) {
        name = QGVAR(Vacuum);
        sound[] = {QPATHTOF_SOUND(sounds\vacuum.ogg), "db + 10", 1, 20};
        titles[]    = {};
    };
};
