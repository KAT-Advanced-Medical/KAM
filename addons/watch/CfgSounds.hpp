class CfgSounds {
    class GVAR(watchAlarm) {
        name = QGVAR(watchAlarm);
        sound[] =
        {
            QPATHTOF(audio\watchAlarm.ogg),
            5,
            1,
            10
        };
        titles[] = {};
    };
    class GVAR(watchVibrate) {
        name = QGVAR(watchVibrate);
        sound[] =
        {
            QPATHTOF(audio\watchVibrate.ogg),
            5,
            1,
            10
        };
        titles[] = {};
    };
};
