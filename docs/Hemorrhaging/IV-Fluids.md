# IV Fluids

## IV/IO

In order to administer IV fluids, you need to first establish an Intravenous (IV) or Intraosseous (IO) needle (if it is enabled in settings). KAM comes with two needle types:

- **[16g IV](/Equipment/16g%20IV.md)**: Only works on limbs with minor damage and no tourniquets
- **[FAST IO](/Equipment/FAST%20IO.md)**: Only works on the torso, but causes pain

### IV Obstruction

If you push [TXA](/Pharmacy/IV-Medication.md#txa) or [EACA](/Pharmacy/IV-Medication.md#eaca), there is a chance that the IV/IO line can become obstructed. If you notice that drugs aren't kicking in or fluid isn't flowing, perform the "Inspect Catheter" action to check for obstructions. If there is one, you will need to flush the line with saline by using the "Saline Flush". This requires that you have at least 30 ml of Saline attached to the IV/IO.

## Fluid Types

There are three types of fluids: Saline, Blood, & Plasma. While all fluids increase the amount of blood you have in your body, each affects [coagulation](/Hemorrhaging/Blood-Loss.md#coagulation) & your [kidney pH](/Nephrology/Kidney-Function.md#kidney-ph) in different ways.

>[!NOTE]
>All fluids in this mod don't expire (yet...)

<table style="undefined;table-layout: fixed; width: 394px">
<colgroup>
<col style="width: 69px">
<col style="width: 94px">
<col style="width: 94px">
<col style="width: 140px">
</colgroup>
<thead>
  <tr>
    <th></th>
    <th>Volume (ml)</th>
    <th>pH Change</th>
    <th>Coagulation Factor</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td rowspan="3">Saline</td>
    <td>1000</td>
    <td>-750<br></td>
    <td>0</td>
  </tr>
  <tr>
    <td>500</td>
    <td>-350</td>
    <td>0</td>
  </tr>
  <tr>
    <td>250</td>
    <td>-150</td>
    <td>0</td>
  </tr>
  <tr>
    <td rowspan="3">Plasma</td>
    <td>1000</td>
    <td>+500</td>
    <td>15</td>
  </tr>
  <tr>
    <td>500</td>
    <td>+250</td>
    <td>10</td>
  </tr>
  <tr>
    <td>250</td>
    <td>+100</td>
    <td>5</td>
  </tr>
  <tr>
    <td rowspan="3">Blood</td>
    <td>1000</td>
    <td>+800</td>
    <td>12</td>
  </tr>
  <tr>
    <td>500</td>
    <td>+400</td>
    <td>8</td>
  </tr>
  <tr>
    <td>250</td>
    <td>+200</td>
    <td>4</td>
  </tr>
</tbody>
</table>

>[!HINT]
>Want to save some fluids? Removing an IV with fluid still attached will put the remaining fluid in your inventory. 


### Blood Type

When administering blood, make sure you administer the proper type. If you administer an incompatible blood type, the patient will suffer from a decreased HR. This can only be treated by [painkillers](/Pharmacy/Oral-Medication.md#pain-killers).

#### Blood Type Chart

Compatible blood types are marked with an "x"

<table style="undefined;table-layout: fixed; width: 453px">
<colgroup>
<col style="width: 80px">
<col style="width: 40px">
<col style="width: 40px">
<col style="width: 40px">
<col style="width: 40px">
<col style="width: 40px">
<col style="width: 40px">
<col style="width: 40px">
<col style="width: 40px">
<col style="width: 40px">
</colgroup>
<thead>
  <tr>
    <th></th>
    <th colspan="9">Donor</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td rowspan="9"><b>Recipient</b></td>
    <td></td>
    <td>O-</td>
    <td>O+</td>
    <td>B-</td>
    <td>B+</td>
    <td>A-</td>
    <td>A+</td>
    <td>AB-</td>
    <td>AB+</td>
  </tr>
  <tr>
    <td>AB+</td>
    <td>x</td>
    <td>x</td>
    <td>x</td>
    <td>x</td>
    <td>x</td>
    <td>x</td>
    <td>x</td>
    <td>x</td>
  </tr>
  <tr>
    <td>AB-</td>
    <td>x</td>
    <td></td>
    <td>x</td>
    <td></td>
    <td>x</td>
    <td></td>
    <td>x</td>
    <td></td>
  </tr>
  <tr>
    <td>A+</td>
    <td>x</td>
    <td>x</td>
    <td></td>
    <td></td>
    <td>x</td>
    <td>x</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>A-</td>
    <td>x</td>
    <td></td>
    <td></td>
    <td></td>
    <td>x</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>B+</td>
    <td>x</td>
    <td>x</td>
    <td>x</td>
    <td>x</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>B-</td>
    <td>x</td>
    <td></td>
    <td>x</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>O+</td>
    <td>x</td>
    <td>x</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>O-</td>
    <td>x</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</tbody>
</table>

### Transfusing Blood

>[!WARNING]
>This section is still under construction! Come back later!

