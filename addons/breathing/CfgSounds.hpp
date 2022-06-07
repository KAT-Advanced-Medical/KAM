class CfgSounds
{
    sounds[] = {};
    class normalbreathing {
        name = "clear_lungs";

        // filename, volume, pitch, distance (optional)
        sound[] = { QPATHTOF(audio\Clear_Lung_Sounds.ogg), 2, 1, 3 }; // Yethe: First number should be changed so it can be adjusted in cba settings.
        titles[] = {};
    };
    class tensionpneumothorax {
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
};