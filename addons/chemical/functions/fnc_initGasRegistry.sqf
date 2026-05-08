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
    ["effectFunc",     LINKFUNC(effect_vx)]
]] call _add;
