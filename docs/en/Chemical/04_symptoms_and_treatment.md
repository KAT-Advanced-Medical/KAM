# Symptoms and Treatment

---

## Table of Contents

1. [How Symptoms Progress](#how-symptoms-progress)
2. [Treatment Reference](#treatment-reference)
---

## How Symptoms Progress

Some agents are about a single timeline; the lethal ones are about deadlines you have to beat. The diagrams below use the **default** timings — all of them are configurable.

### Mustard — escalating contamination

```
  EXPOSURE
     |
     |  contamination applied immediately (skin + gear)
     v
  [ 0s ]------------------------------------------------------>
     :
     :  ~40-100s    EYE INJURIES (vision impaired, possibly both eyes)
     :     |
     :     v  ~100-240s    SKIN BURNS begin (wounds + lung damage + pain)
     :        |
     :        v  every 40s    RE-APPLIED while still contaminated
     :           |               (leaving the cloud does NOT stop this)
     :           v
   DECON KIT  --> clears contamination + cancels pending timers --> safe
```

### Sarin — the 90-second clock

```
  EXPOSURE
     |
  [ 0s ]--------[ 30s ]--------[ 60s ]--------[ 90s ]----> DEATH
                  |              |              |
                vomit       unconscious    cardiac arrest
     \________________ ATNAA window ________________/
        Inject any time before 90s to abort the chain.
```

### VX — slower clock, but it resets

```
  EXPOSURE (sets BOTH nerve exposure AND skin contamination)
     |
  [ 0s ]--------[ 60s ]--------[ 120s ]--------[ 240s ]----> DEATH
                  |               |               |
                vomit        unconscious     cardiac arrest

   ATNAA  --> clears nerve exposure, aborts THIS chain
      |
      |  ...but every 40s the contamination tick re-poisons you,
      |     starting a NEW chain --------------------------------+
      |                                                          |
   DECON KIT --> clears contamination, stops the tick <---------+
                 (you are only truly safe once BOTH are done)
```

### Phosgene — the delayed ambush

```
  EXPOSURE
     |
  [ 0s ]======== no symptoms, feels fine ========[ 2-6 min ]----> COLLAPSE
                                                       |
                                          pulmonary edema:
                                          coughing + reduced breathing
                                          (fires even after leaving the cloud)
                  ATROPINE clears it -- before or after onset.
```

### Chlorine — straightforward

```
  IN CLOUD ---[ ~30s ]---> coughing + air poisoning ---> ATROPINE clears it
```

---


## Treatment Reference

Match the symptom you see in the medical menu to the right item.

| What you see / know | Agent class | Item to use | Notes |
|---------------------|-------------|-------------|-------|
| Intoxication / air poisoning, coughing | Chlorine, Phosgene | **Atropine** | Works during or after onset; this is the legacy behaviour |
| "Nerve Agent Exposure" (red), vomiting, heading to cardiac arrest | Sarin, VX | **ATNAA auto-injector** | Must beat the cardiac-arrest deadline; aborts the chain |
| "Skin Contamination" (orange), recurring burns | Mustard, VX | **Decontamination Kit** | Stops the 40-second re-poison tick; cancels pending mustard timers |
| Eye injuries, burn wounds | Mustard (after onset) | Standard ACE/KAT wound care | Treat as ordinary injuries once they've appeared |
| Both contamination **and** nerve exposure | **VX** | **ATNAA + Decon Kit** | Both are required — see VX above |

### Treating a casualty — quick flow

```
   Casualty down in / after a chemical attack
              |
   Is it safe for YOU? (mask / suit on, or move them out)
              |
   Identify the agent (M8 paper, JCAD, symptoms in menu)
              |
      +-------+-----------------------------+
      |       |                             |
  choking   nerve agent              skin contamination
  (intox)   (red line)               (orange line)
      |       |                             |
  ATROPINE  ATNAA  -----> still contaminated? --> DECON KIT
              |                                       |
       (beat the cardiac                     (stops re-poisoning)
        arrest deadline)
              |
   Then treat residual wounds, burns, eye injuries as normal.
```

{% hint style="info" %}
ATNAA mirrors atropine's profile (a heart-rate boost, up to 3 doses, applied to arms or legs) but is specifically the nerve-agent antidote. Keep both in a medic's kit — atropine for the chokers, ATNAA for the nerves.
{% endhint %}

---
