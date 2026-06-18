## Protection Tiers

Every agent is assigned a **protection tier** that tells you what gear you need to survive it. The tier shown in module dropdowns is about *required protection*, not how dangerous the agent is.

| Tier | Gear required | Agents |
|------|---------------|--------|
| **Level 0** | None (a mask still protects the airway; eyes are still affected by CS) | CS / Tear gas |
| **Level 1** | Gas mask | Chlorine, Phosgene |
| **Level 2** | **Full CBRN suit** — gas mask **and** a whitelisted uniform | Mustard, Sarin, VX |

### What counts as protection

- **Gas mask** — any mask in the accepted-masks list. Out of the box that's `G_AirPurifyingRespirator_01_F`, `kat_mask_M50`, and `kat_mask_M04`. A mask must actually be worn and still have filter life remaining.
- **Filter life** — masks last **15 minutes** of active protection by default. When the filter is spent, the mask stops protecting you. Carry a **gas mask filter** (`kat_gasmaskFilter`) and use the *Replace gas mask filter* self-action to reset it.
- **CBRN suit** — for Level 2 agents the mask alone is not enough. You also need a uniform that the mission has whitelisted. The default whitelist contains the vanilla CBRN suit (`U_C_CBRN_Suit_01_Blue_F`); mission makers add their own (see [CBA settings](#mission-configuration-cba-settings)).

> **Common mistake:** wearing a mask into a mustard or sarin cloud and assuming you're safe. You're not. Level 2 agents go through the skin — only the full suit stops them.

---
