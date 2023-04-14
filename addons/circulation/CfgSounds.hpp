class CfgSounds {
    sounds[] = {};
    class GVAR(HeartRate) {
        name = QGVAR(HeartRate);
        sound[] = {QPATHTOF_SOUND(sounds\heartrate.wav), "db + 2", 1, 15};
        titles[]    = {};
    };
    class GVAR(NoHeartRate) {
        name = QGVAR(NoHeartRate);
        sound[] = {QPATHTOF_SOUND(sounds\noheartrate.wav), "db + 2", 1, 15};
        titles[]    = {};
    };
    class GVAR(NoShock) {
        name = QGVAR(NoShock);
        sound[] = {QPATHTOF_SOUND(sounds\noshock.wav), "db + 2", 1, 15};
        titles[]    = {};
    };
};
