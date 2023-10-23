class CfgSounds {
    sounds[] = {};
    class GVAR(TakePainKiller) {
        name = QGVAR(TakePainKiller);
        sound[] = {QPATHTOF_SOUND(sounds\take_painkillers.wav), "db + 2", 1, 15};
        titles[]    = {};
    };
    class GVAR(Slap) {
        name = QGVAR(Slap);
        sound[] = {QPATHTOF_SOUND(sounds\slap.ogg), "db + 20", 1, 20};
        titles[]    = {};
    };
};
