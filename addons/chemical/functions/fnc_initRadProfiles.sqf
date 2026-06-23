#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Builds the radiation type-profile and source-preset registries.
 *
 * GVAR(radProfiles): type-id -> [wbWeight, skinWeight, inhaleWeight, qualityFactor, [maskF, cbrnF, radGearF, vehicleF]]
 *   wbWeight       - fraction of shielded external rate that becomes whole-body dose
 *   skinWeight     - fraction that becomes local skin/limb dose (beta burns)
 *   inhaleWeight   - fraction of raw rate that becomes internal burden when unmasked
 *   qualityFactor  - biological weighting on whole-body dose (neutron/alpha high)
 *   [..F]          - per-gear external absorbed-dose multipliers (0 = blocks fully)
 *
 * GVAR(radPresets): preset-id -> [alpha, beta, gamma, neutron] dose-rate (Gy/h)
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

GVAR(radProfiles) = createHashMapFromArray [
    ["alpha",   [0,   0.05, 1.0, 20, [0,    0,    0,    0   ]]],
    ["beta",    [0.1, 1.0,  0.3, 1,  [0.7,  0.1,  0.1,  0.2 ]]],
    ["gamma",   [1.0, 0.05, 0.05, 1, [0.97, 0.9,  0.4,  0.5 ]]],
    ["neutron", [1.2, 0,    0,   10, [1,    0.97, 0.7,  0.7 ]]]
];

GVAR(radPresets) = createHashMapFromArray [
    ["custom",       [0,  0,  0,  0 ]],
    ["Cobalt60",     [0,  0,  50, 0 ]],
    ["Reactor",      [0,  0,  40, 20]],
    ["Fallout",      [0,  30, 20, 0 ]],
    ["AlphaEmitter", [50, 5,  0,  0 ]],
    ["DirtyBomb",    [20, 30, 25, 0 ]]
];
