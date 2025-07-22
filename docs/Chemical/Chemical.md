# Chemical

Chemical warfare system featuring various types of toxic agents.

## Modules

Modules are availbe in zeus and eden.
WARNING: When you want to remove zone, remove module unit, DO NOT REMOVE HELPER (unit in empty side)
if you delete helper, particles will stay in zone.
You can configure in module it will have particle effects or not. Also if particle efects color will be same for every gas tier or custom for each one.

## Agents

There are four main types of agents:

**Tier 1: CS Gas**  
Non-lethal. Mainly used in riot control situations. Has a chance to cause weapon drops. Causes intense eye irritation and tearing.  
**Counter:** Gas mask.

**Tier 2: Pulmonary Agent**  
Lethal. Causes coughing and respiratory symptoms.  
**Counter:** Gas mask.

**Tier 3: Blister Agent**  
Lethal. Causes respiratory symptoms and severe burn injuries. When contamination is enabled you will take damage until you use decon kit.  
**Counter:** Sealed CBRN suit and gas mask.

**Tier 4: Nerve Agent**  
Lethal and highly dangerous. Can penetrate standard filters. The gas infection triggers a loop, the subsequent stages of which cause increasingly greater damage, starting with pain, progressing to respiratory failure, and ending with death. The time between each cycle can be configured in the add-on settings.
**Counter:** CBRN suit, gas mask, and SCBA (Self-Contained Breathing Apparatus).

## Chemical Detector

Adds a chemical detector. You first need to enable the detector. 

The chemical detector displays the actual time on the left and the zone intensity on the right. The color of the display depends on the zone tier:

- **Transparency:** No gas  
- **Green:** CS gas  
- **Yellow:** Pulmonary agent  
- **Orange:** Blister agent  
- **Red:** Nerve agent  

## Counters

All countermeasures can be configured in **Addons Settings > KAT Chemical**.

### Gas mask

Gas mask configured in addons settings provides protection for tier 1,2,3 agents. It also cooperate with SCBA to protect against tier 4 agent. Gas mask provide protection only when filter is durable, or oxygen is provided by SCBA. the filter wears out with use.

### SCBA

SCBA - Self-Contained Breathing Apparatus. When turned on provides fresh air.

In this section i will use oxygen and air interchangeably.
To work you first need to enable SCBA under ace self inetraction menu > kat equipment. To enable you need to wear gas mask.
You can check remaining oxygen under this same menu.
Capacity and working time can be set under addons settings menu. 
Capacity is expressed in remaining usage time.
When oxygen is provided there is small O2 icon i your botoom-left screen corner. Based on color of icon you can know about remaining capacity. When the icon is yellow you have 5 minutes of oxygen left, when red you have 1 minute of oxygen left. When icon isnt visible there is no oxygen provided.
You can recharge your scuba, by ace interaction at configured objects, default it is scuba cylinder from vanilla/contact dlc.

## Hoses segments and filters visibility

When you have vannila/contact dlc equipment, when you turned on scba there will be autoamtic script which enables visbility of hose segments. Support equipemnt: SCUBA, Combat unit respirator, APR Nato, Regulator Facepiece.

## Mask overley

Gas maks overlays can be configured in addons settings. Vanilla gas mask have build in overlay, but kam add them glass effect.

## Medicine

All types of poisoning can be treated with **Atropine**.

To decontaminate yourself you need any ace saline, and the interaction is available under advanced tab.
