class CfgSounds
{
    sounds[] = {};
    class normalbreathing {
        name = "clear_lungs";

        // filename, volume, pitch, distance (optional)
        sound[] = { QPATHTOF(audio\Clear_Lung_Sounds.ogg), 2, 1, 3 };
        titles[] = {};
    };
    class tensionpneumothoraxbreathing {
        name = "tension_lungs";

        // filename, volume, pitch, distance (optional)
        sound[] = { QPATHTOF(audio\Tension_sounds.ogg), 2, 1, 3 };
        titles[] = {};
    };
    class hemothoraxbreathing {
        name = "hemo_lungs";

        // filename, volume, pitch, distance (optional)
        sound[] = { QPATHTOF(audio\hemo_sounds.ogg), 2, 1, 3 };
        titles[] = {};
    };

    class GVAR(pneumothoraxcough) {
        name = QGVAR(pneumothoraxcough);

        // filename, volume, pitch, distance (optional)
        sound[] = { QPATHTOF(audio\pneumothoraxcough.ogg), 5, 1, 2 };
        titles[] = {};
    };
};  