// Heart rhythm chart of the guided training, shown on the left of the screen during the cardiac steps.
// The ECG images of KAM are square with the trace in a band across them and the rest transparent,
// so each picture is moved up until only its band shows under its label.

// Height of a whole ECG image, the width keeps it square on any screen
#define CHART_IMG_H (0.45 * safezoneH)
#define CHART_W (CHART_IMG_H * pixelW / pixelH)
#define CHART_X (safezoneX + 0.01 * safezoneW)
// Where the trace band starts in the image and how tall it is, as a part of the image
#define CHART_BAND_TOP 0.18
#define CHART_BAND_H (0.26 * CHART_IMG_H)
#define CHART_PADDING (0.01 * safezoneH)
#define CHART_TITLE_H (0.035 * safezoneH)
#define CHART_LABEL_H (0.05 * safezoneH)
#define CHART_ROW_H (CHART_LABEL_H + CHART_BAND_H + CHART_PADDING)
#define CHART_H (CHART_TITLE_H + 4 * CHART_ROW_H + CHART_PADDING)
#define CHART_Y (safezoneY + (safezoneH - CHART_H) / 2)
#define CHART_ROW_Y(N) (CHART_Y + CHART_TITLE_H + N * CHART_ROW_H)

#define CHART_ROW(NAME,N,IMAGE,LABEL) \
    class GVAR(DOUBLES(NAME,Label)): GVAR(chartLabel) { \
        y = QUOTE(CHART_ROW_Y(N)); \
        text = CSTRING(LABEL); \
    }; \
    class GVAR(DOUBLES(NAME,Image)): GVAR(chartImage) { \
        y = QUOTE(CHART_ROW_Y(N) + CHART_LABEL_H - CHART_BAND_TOP * CHART_IMG_H); \
        text = QPATHTOEF(circulation,ui\IMAGE.paa); \
    }

class RscText;
class RscPicture;
class RscStructuredText;

class GVAR(chartLabel): RscStructuredText {
    idc = -1;
    x = QUOTE(CHART_X);
    y = QUOTE(CHART_Y);
    w = QUOTE(CHART_W);
    h = QUOTE(CHART_LABEL_H);
    size = QUOTE(0.022 * safezoneH);
    colorBackground[] = {0, 0, 0, 0};
    text = "";
};

class GVAR(chartImage): RscPicture {
    idc = -1;
    style = 48;
    x = QUOTE(CHART_X);
    y = QUOTE(CHART_Y);
    w = QUOTE(CHART_W);
    h = QUOTE(CHART_IMG_H);
    colorText[] = {1, 1, 1, 1};
    text = "";
};

class RscTitles {
    class GVAR(rhythmChart) {
        idd = -1;
        movingEnable = 0;
        duration = 1e10;
        fadeIn = 0;
        fadeOut = 0;

        class controlsBackground {
            class GVAR(chartBackground): RscText {
                idc = -1;
                x = QUOTE(CHART_X - CHART_PADDING);
                y = QUOTE(CHART_Y - CHART_PADDING);
                w = QUOTE(CHART_W + 2 * CHART_PADDING);
                h = QUOTE(CHART_H + CHART_PADDING);
                colorBackground[] = {0, 0, 0, 0.7};
                text = "";
            };
        };

        class controls {
            class GVAR(chartTitle): GVAR(chartLabel) {
                h = QUOTE(CHART_TITLE_H);
                size = QUOTE(0.03 * safezoneH);
                text = CSTRING(Tutorial_RhythmChart_Title);
            };
            CHART_ROW(sinus,0,ekg_sinus,Tutorial_Rhythm_Sinus);
            CHART_ROW(vf,1,ekg_vf,Tutorial_Rhythm_VF);
            CHART_ROW(vt,2,ekg_vt,Tutorial_Rhythm_VT);
            CHART_ROW(asystole,3,ekg_asystole,Tutorial_Rhythm_Asystole);
        };
    };
};
