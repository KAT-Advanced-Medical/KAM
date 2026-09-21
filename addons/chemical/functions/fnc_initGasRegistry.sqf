#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Builds the gas registry hashmap. Each entry maps a gas-id string to a
 * properties hashmap consumed by fnc_poison and the per-gas effect functions.
 *
 * Also builds the legacy int-to-id lookup so existing CfgAmmo entries
 * (KAT_toxicLvL = 0/1) keep working unchanged.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

GVAR(gasRegistry) = createHashMap;
GVAR(toxicLvLToId) = createHashMap;

private _add = {
    params ["_id", "_props"];
    _props set ["id", _id];
    GVAR(gasRegistry) set [_id, _props];
    GVAR(toxicLvLToId) set [_props get "toxicLvL", _id];
};

["cs", createHashMapFromArray [
    ["toxicLvL",       0],
    ["displayName",    LLSTRING(CSGas_MFDNAME)],
    ["smellHintKey",   ""],
    ["requiresCBRN",   false],
    ["decontaminable", false],
    ["persistent",     false],
    ["m8Color",        ""],
    ["lungPotency",    0],
    ["lungInjuryCap",  0],
    ["lungLCt",        45],
    ["lungProgression",        0],
    ["lungProgressiveMin",  0.35],
    ["effectFunc",     LINKFUNC(effect_cs)]
]] call _add;

["chlorine", createHashMapFromArray [
    ["toxicLvL",       1],
    ["displayName",    LLSTRING(ToxicGas_MFDNAME)],
    ["smellHintKey",   "STR_KAT_Chemical_Smell_Chlorine"],
    ["requiresCBRN",   false],
    ["decontaminable", false],
    ["persistent",     false],
    ["m8Color",        ""],
    ["lungPotency",    1],
    ["lungInjuryCap",  0.7],
    ["lungLCt",        45],
    ["lungProgression",  0.00025],
    ["lungProgressiveMin",  0.35],
    ["effectFunc",     LINKFUNC(effect_chlorine)]
]] call _add;

["phosgene", createHashMapFromArray [
    ["toxicLvL",       2],
    ["displayName",    LLSTRING(Phosgene_MFDNAME)],
    ["smellHintKey",   "STR_KAT_Chemical_Smell_Phosgene"],
    ["requiresCBRN",   false],
    ["decontaminable", false],
    ["persistent",     false],
    ["m8Color",        ""],
    ["lungPotency",    1.6],
    ["lungInjuryCap",  0.9],
    ["lungLCt",        45],
    ["lungProgression",   0.0007],
    ["lungProgressiveMin",  0.15],
    ["effectFunc",     LINKFUNC(effect_phosgene)]
]] call _add;

["mustard", createHashMapFromArray [
    ["toxicLvL",       3],
    ["displayName",    LLSTRING(Mustard_MFDNAME)],
    ["smellHintKey",   "STR_KAT_Chemical_Smell_Mustard"],
    ["requiresCBRN",   true],
    ["decontaminable", true],
    ["persistent",     false],
    ["m8Color",        "red"],
    ["lungPotency",    0.6],
    ["lungInjuryCap",  0.6],
    ["lungLCt",        45],
    ["lungProgression",  0.00033],
    ["lungProgressiveMin",  0.35],
    ["effectFunc",     LINKFUNC(effect_mustard)]
]] call _add;

["sarin", createHashMapFromArray [
    ["toxicLvL",       4],
    ["displayName",    LLSTRING(Sarin_MFDNAME)],
    ["smellHintKey",   ""],
    ["requiresCBRN",   true],
    ["decontaminable", false],
    ["persistent",     false],
    ["m8Color",        "yellow"],
    ["lungPotency",    0.8],
    ["lungInjuryCap",  0.2],
    ["lungLCt",        45],
    ["lungProgression",        0],
    ["lungProgressiveMin",  0.35],
    ["effectFunc",     LINKFUNC(effect_sarin)]
]] call _add;

["vx", createHashMapFromArray [
    ["toxicLvL",       5],
    ["displayName",    LLSTRING(VX_MFDNAME)],
    ["smellHintKey",   ""],
    ["requiresCBRN",   true],
    ["decontaminable", true],
    ["persistent",     true],
    ["m8Color",        "green"],
    ["lungPotency",    0.8],
    ["lungInjuryCap",  0.2],
    ["lungLCt",        45],
    ["lungProgression",        0],
    ["lungProgressiveMin",  0.35],
    ["effectFunc",     LINKFUNC(effect_vx)]
]] call _add;
