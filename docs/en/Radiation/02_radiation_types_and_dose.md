# Radiation Types & Dose

Radiation isn't one thing. The system models **four types**, and the type decides almost everything that matters: what stops it, how it hurts you, and whether you even need to worry about it from across the room. A source can emit any mix of the four — a reactor leak is mostly gamma and neutron, fallout is beta and gamma, a dirty bomb is a bit of everything.

## The four types at a glance

| Type | Penetration | What stops it | Main threat | Skin burns? |
|------|-------------|---------------|-------------|-------------|
| **Alpha** | Almost none | Skin, clothing, a gas mask | **Inhalation only** — harmless outside, lethal inside | No (minor) |
| **Beta** | Low | A CBRN suit; heavy cover | Skin/surface burns + light whole-body | **Yes** |
| **Gamma** | High | Mass, distance, vehicles | Whole-body dose, penetrates almost everything | No (minor) |
| **Neutron** | Very high | Only thick shielding / vehicles | Whole-body dose, most damaging per Gy | No |

### Alpha

Alpha particles can't get through your skin or a layer of cloth, so an alpha source sitting on the ground next to you is, externally, almost harmless. The catch is **inhalation**. Breathe alpha-emitting dust without a gas mask and it lodges inside you, where there's no skin to stop it — and it just *keeps* dosing you, long after you've walked away.

- **External danger:** essentially none.
- **The real danger:** internal contamination. No mask = you breathe it in and your accumulated dose keeps climbing after you leave.
- **Protection that matters:** a **gas mask**. Nothing else changes much.

> Alpha is the textbook argument for masking up in any dusty contaminated area even when the geiger reads low — the rate can be modest while the stuff you're inhaling is the part that kills you.

### Beta

Beta is the burner. It doesn't penetrate deep, so it dumps its energy in your skin — which means **radiation burns** on exposed body parts, plus a smaller whole-body contribution. Light shielding goes a long way here.

- **External danger:** skin burns on exposed parts; mild whole-body dose.
- **Protection that matters:** a **full CBRN suit** nearly stops it; a gas mask helps a little; sitting in a vehicle cuts it.
- **Handling note:** picking up a beta source concentrates the burns on your hands and arms — see the carryable source in [Zeus & mission makers](07_zeus_and_MissionMakers.md).

### Gamma

Gamma is the one most people picture: high-energy, penetrating, and indifferent to your gas mask. It drives **whole-body dose** — the number that pushes you up the radiation-sickness tiers — and the only real defences are **mass, distance, and getting behind something solid.**

- **External danger:** whole-body dose, the primary driver of acute radiation syndrome.
- **Protection that matters:** vehicles and terrain (moderate), dedicated rad-gear (some), distance (always). A mask or suit barely touch it.
- **Burns:** negligible — gamma's skin contribution is tiny by design, so a pure gamma source won't cover you in burns.

### Neutron

The most penetrating of the lot and the most biologically damaging per unit of dose. Neutron radiation shrugs off masks and suits almost entirely; only the bulk of a vehicle or serious shielding makes a dent.

- **External danger:** whole-body dose, weighted heavier than gamma for the same rate.
- **Protection that matters:** vehicles and heavy cover, and not much else.
- **Sources:** typically reactor cores and certain weapon scenarios.

---

## The three ways radiation doses you

The same exposure is split across three separate "books," because they behave completely differently and are treated completely differently.

```
   A RADIATION SOURCE
          |
   +------+--------------------+-------------------------+
   |                           |                         |
 WHOLE-BODY                 PER-LIMB                  INTERNAL
 (penetrating               (skin dose on            (breathed-in
  gamma/neutron)             exposed parts)            contamination)
   |                           |                         |
 accumulated dose          radiation BURNS           keeps dosing you
 -> sickness tiers         on body parts             after you leave
   |                           |                         |
 reduced by                reduced by                cleared ONLY by
 shielding                 a CBRN suit               chelation, never
                                                     by washing
```

- **Whole-body dose** — the big one. Gamma and neutron pour into this; it's what climbs the [radiation-sickness tiers](04_radiation_sickness.md). Your shielding reduces how fast it accrues.
- **Per-limb skin dose** — beta (and handling a source point-blank) deposit dose on specific body parts. Cross a threshold and you get a **radiation burn** wound on that part, treated like any other burn through ACE/KAT medical.
- **Internal contamination** — breathe in particulates (mostly alpha, some beta) without a mask and you accumulate an internal burden that converts to whole-body dose slowly over time. This is the dose that **keeps rising after you've left the source.**

---

## Dose rate vs accumulated dose (again, because it matters)

- **Dose rate** (Gy/h) is the field strength where you're standing — the geiger number. It is **not** reduced by your gear, because a geiger measures the environment, not you.
- **Accumulated dose** (Gy) is what your body has absorbed. **This** is reduced by shielding, and it's what makes you sick.

The practical upshot: to check whether a suit or a vehicle is actually protecting you, don't watch the geiger rate — watch how fast the **accumulated** dose climbs. A good shield barely changes the rate reading but dramatically slows the dose you bank.

> **Mission makers:** the per-type behaviour — how much each type weights into whole-body vs skin vs inhalation, and how each piece of gear shields it — is defined in the type *profiles* and is fully tunable. See the [profiles note in Zeus & mission makers](07_zeus_and_MissionMakers.md).

---
