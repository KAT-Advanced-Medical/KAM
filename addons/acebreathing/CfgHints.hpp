class CfgHints {
    class GVAR(Hint) {
        class ADDON {
            displayName = CSTRING(hint_name);
            description = CSTRING(hint_desc);
            tip = CSTRING(hint_tip);
            arguments[] = {};
            image = QPATHTOF(ui\larynx.paa);
        };
    };
};
