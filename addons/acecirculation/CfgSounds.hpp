class CfgSounds {
    sounds[] = {};
    class GVAR(HeartRate) {
        name = QGVAR(HeartRate);
        sound[] = {QPATHTOF(sounds\heartrate.wav), db + 2, 1, 15};
        titles[]    = {};
    };
    class GVAR(NoHeartRate) {
        name = QGVAR(HeartRate);
        sound[] = {QPATHTOF(sounds\noheartrate.wav), db + 2, 1, 15};
        titles[]    = {};
    };
    class GVAR(NoShock) {
        name = QGVAR(HeartRate);
        sound[] = {QPATHTOF(sounds\noshock.wav), db + 2, 1, 15};
        titles[]    = {};
    };
    class GVAR(TakePainKiller) {
        name = QGVAR(HeartRate);
        sound[] = {QPATHTOF(sounds\take_painkillers.wav), db + 2, 1, 15};
        titles[]    = {};
    };
};
