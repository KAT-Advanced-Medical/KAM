class CfgSounds
{
    sounds[] = {};
    class GVAR(pneumothoraxcough) {
        name = QGVAR(pneumothoraxcough);

        // filename, volume, pitch, distance (optional)
        sound[] = { QPATHTOF(audio\pneumothoraxcough.ogg), 5, 1, 2 };
        titles[] = {};
    };
    class GVAR(respiratorTone) {
        name = QGVAR(respiratorTone);

        // filename, volume, pitch, distance (optional)
        sound[] = { QPATHTOF(audio\respiratorTone.ogg), 5, 1, 2 };
        titles[] = {};
    };
};
