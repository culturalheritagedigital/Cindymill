---
title: "Mechanical Parts"
image: 
  path: /assets/images/mechanicalparts_title.jpg
  thumbnail: /assets/images/mechanicalparts_title.jpg
---
This section covers all mechanical parts and tools needed for the build.

## Dimensions of the Machine

All data given in this section is for a machine with the following dimensions:
- Outer frame dimensions: 1000 x 640 mm
- Work Area: 750 x 475 mm

I would not recommend to increase the length of the gantry since you would loose rigidity. The length perpendicular to the portal is less critical in terms of stiffness because the frame is screwed to the ground. However, prices for longer ball screws and rails increase non-linearly, so be warned.
It is a good idea to ask yourself how big your machine **really** needs to be. Bigger is not automatically better because the stiffness is significantly reduced. And we want the machine to be as rigid as possible so that we can mill with precision.
In retrospect, I would have built the non-gantry axis even shorter than it is now.

If you choose to build the machine with other dimensions than stated, you will only have to change the length of profiles, ball screws, and rails. Note that available sizes change gradually (50-100 mm steps). All other parts stay the same no matter the size.

**Examples:**

- Shorten the portal by 50 mm: 

| Part Name        | Old Dimensions        | New Dimension  | 
| -------------    |:-------------      | :-----  | 
| Ball screw SFU1605 | 1x 650 mm                    | 1x  600 mm       |     
| Linear Rail MGN12 | 2x 650 mm                    | 2x 600 mm       |  
| Gantry Profile    | 2x 40x60x666 mm                    |  2x 40x60x616 mm       | 
| Frame Profile     | 2x 40x40x560 mm                    |  2x 40x40x510 mm        |   

- Shorten the frame (perpendicular to the portal) by 100 mm: 

| Part Name        | Old Dimensions        | New Dimension  | 
| -------------    |:-------------      | :-----  | 
| Ball screw SFU1605 | 2x 1000 mm                    | 2x  900 mm       |     
| Linear Rail MGN12 | 2x 1000 mm                    | 2x 900 mm       |  
| Frame Profile     | 2x 40x80x1000 mm                    |  2x 40x80x900 mm        |   

## Extruded Aluminum Profiles

All used T-slot profiles are "I-Type slot 5" based, which means that a cross-section with one T-slot on each side has the dimensions 20 mm x 20 mm and the slot has 5 mm width.
As far as I learned, there are two types of extrusions in Europe, I-type (by the company Item) and B-type (by the company Bosch). The profiles I initially ordered from Banggood were neither one nor the other. Accordingly, the nuts you order fit sometimes better and sometimes worse. This makes the precise alignment of the rails on the profiles unnecessarily difficult. So for the second build I ordered everything I-type based from Europe and it fits way better. The nuts even have small bars which help to center them in the slot (that's also the reason why I switched from hammer nuts to those which you have to slide into the slot before closing it).
So compare the prices from banggood vs. quality profiles from Europe/US, for me it was even cheaper to order them locally.

Another important point: The "I-Type slot 5" profiles have tapholes for M5 threads (diameter 4.3 mm). All plates which are screwed to profile ends are prepared for M5. If you buy another system check for the taphole diameter. If needed I can export a set of plate files which are prepared for M6, just send me a message. 

![tools]({{ '/assets/images/itype5.jpg' | relative_url }})

| Part Name        | Quantity       | Dimensions       |
| -------------    |:-------------: | :-----           | -------------: |:-------------:     | -----:           |
| Frame Profiles    |  2            | 40 x 80 x 1000   |                                                        | [ebay](https://ebay.us/sN9eL3){:target="_blank"} | [Motedis](https://www.motedis.com/shop/Aluprofile/Aluprofil-40x80-I-Typ-Nut-5::3799.html){:target="_blank"}                  |             |
|                   |  2            | 40 x 40 x 560    | [Amazon](https://amzn.to/3jEKvht){:target="_blank"}    | [ebay](https://ebay.us/j6LjRD){:target="_blank"} | [Motedis](https://www.motedis.com/shop/Aluprofile/Aluprofil-40x40-I-Typ-Nut-5::686.html){:target="_blank"}                |             |
|  Gantry Profiles  |   2           | 40 x 60 x 666    | [Amazon](https://amzn.to/3heS3WB){:target="_blank"}    | [ebay](https://ebay.us/Wt5Shb){:target="_blank"} | [Motedis](https://www.motedis.com/shop/Aluprofile/Aluprofil-60x40-I-Typ-Nut-5::737.html){:target="_blank"}                   |             |
|  Z Axis Profiles  |   2           |  20 x 20 x 270   | [Amazon](https://amzn.to/366R8kK){:target="_blank"}    | [ebay](https://ebay.us/PpNqCB){:target="_blank"} | [Motedis](https://www.motedis.com/shop/Aluprofile/Aluprofil-20x20-I-Typ-Nut-5::1076.html){:target="_blank"}                          |
|  T-nut with bar I-Typ Nut 5 [M3]  |   150           |     | [Amazon](https://amzn.to/3AnZrXg){:target="_blank"}    | [ebay](https://ebay.us/Ysmv9w){:target="_blank"} | [Motedis](https://www.motedis.com/shop/Nutprofil-Zubehoer/In-der-Nut/Nutenstein-mit-Steg-I-Typ-Nut-5-M3::4224.html){:target="_blank"}                               |
|  T-nut with bar I-Typ Nut 5 [M5]  |   50          |     | [Amazon](https://amzn.to/3wdl4WT){:target="_blank"}    | [ebay](https://ebay.us/lpHojt){:target="_blank"} | [Motedis](https://www.motedis.com/shop/Nutprofil-Zubehoer/In-der-Nut/Nutenstein-mit-Steg-I-Typ-Nut-5-M5::4226.html){:target="_blank"}                          |
|  Brackets I-Typ Nut 5  |   5-10          |     | [Amazon](https://amzn.to/3AmN7X7){:target="_blank"}    | [ebay](https://ebay.us/Z5UlBC){:target="_blank"} | [Motedis](https://www.motedis.com/shop/Nutprofil-Zubehoer/Winkel-fuer-Aluprofil/Winkel-20-I-Typ-Nut-5::732.html){:target="_blank"}                |             |

The number of M3 T-nuts takes into account that you use every borehole in the rails - which I highly recommend for the greatest possible rigidity. 


For the connections between fixed block bearings and the frame you need threaded steel sockets (inner thread diameter M6, outer diameter 10 mm, length 30 and 40 mm). If the links don't work for you, search for the following keywords: "Threaded sockets", "long nuts", "round long nuts", "connecting nuts", "threaded sleeves".

| Part Name        | Quantity            |
| -------------    |:-------------:      | -----:  | -------------: |:-------------:     | -----:      |
| Portal Axis: Threaded sockets M6 x 10 x 30  |      4               |  [ebay](https://ebay.us/vBWF3L){:target="_blank"}       |  [Amazon](https://amzn.to/3hz61RV){:target="_blank"}{:target="_blank"}               |     [Aliexpress](https://s.click.aliexpress.com/e/_A11cnq){:target="_blank"}{:target="_blank"}               |             |
| Frame Axis: Threaded sockets M6 x 10 x 40  |    8                 | [ebay](https://ebay.us/vBWF3L){:target="_blank"}        |   [Amazon](https://amzn.to/3AtfEuq){:target="_blank"}{:target="_blank"}              |                    |             |

I ordered more than enough, if you can't find them send me a message in our facebook group!

You will need to cut M5 threads into the ends of the profiles (and M6 threads into one of the milled plates), I have bought this [set of thread cutters](https://amzn.to/3dXKEc2){:target="_blank"}, [this](https://s.click.aliexpress.com/e/_9J87Qs){:target="_blank"} would be an alternative from China.


## Motion
### Ball Screws, Bearing Blocks, and Couplers

The Cindymill uses ball screws on all axes. There are cheaper solutions but, in contrast to trapezoidal screws, they have negligible "backlash" (put a nut on a screw and move it in both axial directions without turning it. If you can feel it moving that's backlash, which means that you mill with less precision because you first move the screw freely in the thread each time you change direction). "SFU" is the DIN type of ball screw, "1605" means that the outer diameter is 16 mm and the gradient is 5 mm per rotation.

| Part Name        | Quantity            | Length
| -------------    |:-------------:      | -----:  | -------------: |:-------------:     | -----:      |
| Frame Ball Screw SFU1605 |  2 |  1000 | [Amazon](https://amzn.to/2VlneXO){:target="_blank"}  | [ebay](https://ebay.us/1Zq9bS){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_ABfqmU){:target="_blank"} 
| Portal Ball Screw SFU1605 |  1 | 650 | [Amazon](https://amzn.to/3hqFWpG){:target="_blank"}  | [ebay](https://ebay.us/1Zq9bS){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_AEOMeU){:target="_blank"}
| Z Axis Ball Screw SFU1204 |  1 | 250 | [Amazon](https://amzn.to/3hqGwDS){:target="_blank"}  | [ebay](https://ebay.us/1Zq9bS){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_AatEmy){:target="_blank"}    | 

You need two bearing blocks per ball screw: BK12 and BF12 for SFU1605, BK10 and BF10 for SFU1204. If they are not part of a ball screw set, you will need to order them separately. 
To be able to attach them to the frame the blocks have to have holes in axial direction. Be sure that the blocks you order have these holes (see image below). 
![tools]({{ '/assets/images/fixedblock1.jpg' | relative_url }})

| Part Name        | Quantity            
| -------------    |:-------------   | -----:  | -------------: |:-------------:     | -----:      |
| BK12 + BF12 |  3 (2x frame + 1x portal) |   [Amazon](https://amzn.to/3AJaSZU){:target="_blank"}  | [ebay](https://ebay.us/zruIib){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_9uXiU0){:target="_blank"}    | 
| BK10 + BF10 |  1 (1x Z axis)            |   [Amazon](https://amzn.to/3yzkHYd){:target="_blank"}  | [ebay](https://ebay.us/zruIib){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_AUEty8){:target="_blank"}    |

Future alternative: FF12, FK12..

To connect the motors to the ball screws you need couplers. NEMA23 motors usually have a shaft diameter of either 6.35 mm or 8 mm (check the motors you ordered!). The ends of the ball screws have 10 mm (SFU1605) and 8 mm (SFU1204) diameter.

| Part Name        | Quantity            
| -------------    |:-------------   | -----:  | -------------: |:-------------:     | -----:      |
| SFU1605 Coupler 6.35/8 x 10 mm |  3 (2x frame + 1x portal) |   [Amazon](https://amzn.to/3jQVdl7){:target="_blank"}  | [ebay](https://ebay.us/3OATsy){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_AZzXve){:target="_blank"}    | 
| SFU1204 Coupler 6.35/8 x 8 mm |  1 (1x Z axis)             |   [Amazon](https://amzn.to/3AFeNqA){:target="_blank"}  | [ebay](https://ebay.us/3OATsy){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_99yORA){:target="_blank"}    |



### Linear Rails

The Cindymill uses MGN12 linear rails. Again, "MGN" is the type, "12" is the width of the rail in mm. The corresponding blocks travelling on the rail are called "MGN12H". You need 12 of them - usually you will get one block with an ordered rail, just order the remaining number of blocks to have 12 in total. 

| Part Name        | Quantity            | Length
| -------------    |:-------------:      | -----:  | -------------: |:-------------:     | -----:      |
| Frame Rails MGN12 |  2                  | 1000          |   [Amazon](https://amzn.to/3dXEp8b){:target="_blank"}  | [ebay](https://ebay.us/kw9Rj2){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_9jvjbE){:target="_blank"}    |
| Portal Rails MGN12 |  2                  | 650          |   [Amazon](https://amzn.to/3dXEp8b){:target="_blank"}  | [ebay](https://ebay.us/kw9Rj2){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_Aq8oRe){:target="_blank"}    |
| Z Axis Rails MGN12 |  2                  | 250          |   [Amazon](https://amzn.to/3dXEp8b){:target="_blank"}  | [ebay](https://ebay.us/xlpSGT){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_AWJdji){:target="_blank"}    |
| Rail Blocks MGN12H |  12                 |              |   [Amazon](https://amzn.to/36j5azI){:target="_blank"}  | [ebay](https://ebay.us/Q0SoZU){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_AlHHyU){:target="_blank"}    |

Ball screws and linear rails from China are usually covered in a coating for preservation against rusting, this is not lubrication! It is recommended to degrease the components (I used [bike chain cleaner](https://amzn.to/36p3817){:target="_blank"}, acetone is also possible) and to lubricate them properly (I used [this grease](https://amzn.to/3edChtl){:target="_blank"} for the bearings and a [silicone oil](https://amzn.to/3o6SyWt){:target="_blank"} to cover the metal surfaces).

## Printed Parts

Plastic is too flexible to be used meaningfully as important parts in a milling machine. In particular, components that are subject to constantly changing high loads should be built as rigid as possible. The only printed parts in the Cindymill are spacers. 
In the [Github repository](https://github.com/culturalheritagedigital/Cindymill/tree/main/Printed_Parts) you will find a folder named _"/Printed_Parts/"_.

On the top level you will find these spacers for the Z axis:

| Part Name        | Quantity      |       Purpose      |       
| -------------    |:-------------:      | :-------------:      | 
| _'Z_Axis_Frame_Spacer.stl'_              | 8                   |    Connects the Z axis 2020 profiles to the backplate.                |  

These parts are really small, you could theoretically mill them but it's not worth the effort. Print them heavy, e.g. 5 perimeters, 25% infill.

![printed_parts]({{ '/assets/images/printed_spacers1.jpg' | relative_url }})

Then there is a folder _"/Spacers_you_could_print/"_ which includes spacers which are also given as DXF files to be milled but could also be printed if not possible otherwise. If you decide to print them, choose very heavy settings, e.g. 5 perimeters, 50% infill.

In the folder _"/Tools/"_ you will find useful helpers for aligning the linear rails:

| Part Name        | Quantity      |      
| -------------    |:-------------:      | :-------------:      | 
| _'Cindymill_Portal_Rail_Alignment_Tool.stl'_              | 1                   |    
| _'Cindymill_Z_Rail_Alignment_Tool.stl'_              | 1                   |    

If you don't have a printer yet, I can recommend an [Ender 3 Pro](https://s.click.aliexpress.com/e/_A3jDs8){:target="_blank"} to start. It is generally well respected and has a vital community.
The [Prusa Mini+](https://shop.prusa3d.com/en/66-original-prusa-mini){:target="_blank"} would eventually be more reliable but is also more expensive.

![printed parts]({{ '/assets/images/printed_parts4.jpg' | relative_url }})

## Screws

The required screws are split up for the case that you need them separately (e.g. if you want to build only the Z axis). If you need all of them take the total list.
I order all my screws from one eBay trader (all given ebay links below), it's inexpensive, reliable and fast but shipping could be too high if you order from outside germany - compare the prices..

Note that most of the screws are DIN912 ("allen screws") but for the portal you will need 8x M5x25 ISO7380 ("pan head screws") to avoid contact with the frame rails (marked red in the image below). You could also use only ISO7380 instead of DIN912 if you prefer the look but I think they are a bit more expensive..

![pan head screws]({{ '/assets/images/panheadscrews.jpg' | relative_url }})


### Frame

| Part Name   | DIN     | Quantity            |
| -------------    |:-------------:      | -----:  | -------------: |:-------------:     | -----:      |
| M3 x 08 | 912 |      80               |   [Amazon](https://amzn.to/36kw0aP){:target="_blank"}  | [ebay](https://ebay.us/unSMKf){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_9v9gwG){:target="_blank"} 
| M5 x 14 | 912 |      16               |   [Amazon](https://amzn.to/3ka3H7d){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_AnH9NW){:target="_blank"}
| M5 x 20 | 912 |      32               |   [Amazon](https://amzn.to/3wle2Q0){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_AnL8TW){:target="_blank"}
| M5 x 35 | 912 |      8               |   [Amazon](https://amzn.to/3hq1BOv){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_9Q3PzQ){:target="_blank"}
| M5 x 40 | 912 |      8               |     | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_AN8U7m){:target="_blank"}
| M5 Nuts | 934 |      24               |   [Amazon](https://amzn.to/3AJaaf9){:target="_blank"}  | [ebay](https://ebay.us/NXSorF){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_ASsVxw){:target="_blank"}
| M6 x 20 | 912 |      8               |   [Amazon](https://amzn.to/2TIx9Gy){:target="_blank"}  | [ebay](https://ebay.us/BVlZiy){:target="_blank"}  |   [Aliexpress](https://s.click.aliexpress.com/e/_9GJc3e){:target="_blank"}


### Portal

| Part Name    | DIN    | Quantity            |
| -------------    |:-------------:      | -----:  | -------------: |:-------------:     | -----:      |
| M3 x 08 | 912 |      52              |   [Amazon](https://amzn.to/36kw0aP){:target="_blank"}  | [ebay](https://ebay.us/unSMKf){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_9v9gwG){:target="_blank"}
| M3 x 14 | 912 |      16              |   [Amazon](https://amzn.to/3dXgWnE){:target="_blank"}  | [ebay](https://ebay.us/unSMKf){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_9v3Lm0){:target="_blank"}
| M5 x 10 | 912 |      20               |   [Amazon](https://amzn.to/3qTAj6p){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_AEXim4){:target="_blank"}
| M5 x 20 | 912 |      36               |   [Amazon](https://amzn.to/3wle2Q0){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_AnL8TW){:target="_blank"}
| M5 x 25 | ISO7380 |       8           |   [Amazon](){:target="_blank"}  | [ebay](https://ebay.us/kziEqp){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_ApGhio){:target="_blank"}
| M5 x 30 | 912 |      4               |   [Amazon](https://amzn.to/3k41UAa){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_A9luZi){:target="_blank"}
| M5 x 35 | 912 |      8               |   [Amazon](https://amzn.to/3hq1BOv){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_9Q3PzQ){:target="_blank"}
| M5 x 40 | 912 |      4               |   | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_AN8U7m){:target="_blank"}
| M5 Nuts | 934 |      12               |   [Amazon](https://amzn.to/3AJaaf9){:target="_blank"}  | [ebay](https://ebay.us/NXSorF){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_ASsVxw){:target="_blank"}
| M6 x 20 | 912 |      8               |   [Amazon](https://amzn.to/2TIx9Gy){:target="_blank"}  | [ebay](https://ebay.us/BVlZiy){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_9GJc3e){:target="_blank"}


### Z Axis

| Part Name    | DIN    | Quantity            |
| -------------    |:-------------:      | -----:  | -------------: |:-------------:     | -----:      |
| M3 x 08 | 912 |        20            |   [Amazon](https://amzn.to/36kw0aP){:target="_blank"}  | [ebay](https://ebay.us/unSMKf){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_9v9gwG){:target="_blank"}
| M3 x 14 | 912 |        32            |   [Amazon](https://amzn.to/3dXgWnE){:target="_blank"}  | [ebay](https://ebay.us/unSMKf){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_9v3Lm0){:target="_blank"}
| M4 x 12 | 912 |       6              |   [Amazon](https://amzn.to/2VgnqY9){:target="_blank"}  | [ebay](https://ebay.us/uPMZYR){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_AkfwlS){:target="_blank"}
| M5 x 14 | 912 |          4           |   [Amazon](https://amzn.to/3ka3H7d){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_AnH9NW){:target="_blank"}
| M5 x 20 | 912 |          10           |   [Amazon](https://amzn.to/3wle2Q0){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_AnL8TW){:target="_blank"}
| M5 x 22 | 912 |       8              |   [Amazon](https://amzn.to/3xqQ333){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  | 
| M5 x 25 | 912 |           4          |   [Amazon](https://amzn.to/3ADBpaO){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_99Ohkk){:target="_blank"}
| M5 x 30 | 912 |           4          |   [Amazon](https://amzn.to/3k41UAa){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_A9luZi){:target="_blank"}
| M5 Nuts | 934 |        4             |   [Amazon](https://amzn.to/3AJaaf9){:target="_blank"}  | [ebay](https://ebay.us/NXSorF){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_ASsVxw){:target="_blank"}
| M6 x 20 | 912 |       8              |   [Amazon](https://amzn.to/3AGbW0r){:target="_blank"}  | [ebay](https://ebay.us/BVlZiy){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_AtGZTE){:target="_blank"}
| M6 x 40 | 912 |       6              |   [Amazon](https://amzn.to/3yCPOCa){:target="_blank"}  | [ebay](https://ebay.us/BVlZiy){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_9Q0wMu){:target="_blank"}

<div class="sketchfab-embed-wrapper"> <iframe title="Cindymill Screws" frameborder="0" allowfullscreen mozallowfullscreen="true" webkitallowfullscreen="true" allow="fullscreen; autoplay; vr" xr-spatial-tracking execution-while-out-of-viewport execution-while-not-rendered web-share width="360" height="360" src="https://sketchfab.com/models/facda34b1e9b4363be5d3bd389e1f73b/embed?autospin=1&autostart=1"> </iframe> </div>


<!-- ![tools]({{ '/assets/images/screws1.png' | relative_url }}) -->

### Total

| Part Name    | DIN    | Quantity            |
| -------------    |:-------------:      | -----:  | -------------: |:-------------:     | -----:      |
| M3 x 08 | 912 |        152            |   [Amazon](https://amzn.to/36kw0aP){:target="_blank"}  | [ebay](https://ebay.us/unSMKf){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_9v9gwG){:target="_blank"}
| M3 x 14 | 912 |        48            |   [Amazon](https://amzn.to/3dXgWnE){:target="_blank"}  | [ebay](https://ebay.us/unSMKf){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_9v3Lm0){:target="_blank"}
| M4 x 12 | 912 |        6              |   [Amazon](https://amzn.to/2VgnqY9){:target="_blank"}  | [ebay](https://ebay.us/uPMZYR){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_AkfwlS){:target="_blank"}
| M5 x 10 | 912 |        20             |   [Amazon](https://amzn.to/3qTAj6p){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_AEXim4){:target="_blank"}
| M5 x 14 | 912 |          20           |   [Amazon](https://amzn.to/3ka3H7d){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_AnH9NW){:target="_blank"}
| M5 x 20 | 912 |          78          |   [Amazon](https://amzn.to/3wle2Q0){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_AnL8TW){:target="_blank"}
| M5 x 22 | 912 |       8              |   [Amazon](https://amzn.to/3xqQ333){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  | 
| M5 x 25 | ISO7380 |           8      |  |    [ebay](https://ebay.us/kziEqp){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_ApGhio){:target="_blank"}
| M5 x 25 | 912 |           4          |   [Amazon](https://amzn.to/3ADBpaO){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_99Ohkk){:target="_blank"}
| M5 x 30 | 912 |           8          |   [Amazon](https://amzn.to/3k41UAa){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_A9luZi){:target="_blank"}
| M5 x 35 | 912 |          16          |   [Amazon](https://amzn.to/3hq1BOv){:target="_blank"}  | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_9Q3PzQ){:target="_blank"}
| M5 x 40 | 912 |           12          |     | [ebay](https://ebay.us/xaZs3E){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_AN8U7m){:target="_blank"}
| M5 Nuts | 934 |        40            |   [Amazon](https://amzn.to/3AJaaf9){:target="_blank"}  | [ebay](https://ebay.us/NXSorF){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_ASsVxw){:target="_blank"}
| M6 x 20 | 912 |          24           |   [Amazon](https://amzn.to/2TIx9Gy){:target="_blank"}  | [ebay](https://ebay.us/BVlZiy){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_9GJc3e){:target="_blank"}
| M6 x 40 | 912 |       6              |   [Amazon](https://amzn.to/3yCPOCa){:target="_blank"}  | [ebay](https://ebay.us/BVlZiy){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_9Q0wMu){:target="_blank"}



## Tools

When I started setting up the machine, the first thing I did was to dump my cheap digital caliper. All information given in hundredths was not reliable at all. 
And you need this tool constantly to measure deviations in the workpiece, to check the diameter of milling cutters, etc.
As a cheaper option, I would recommend an analog caliper. If it can be a little more expensive, nothing beats a Mitutoyo from Japan, which has an uncertainty of + -0.01 mm. I wouldn't buy a Mitutoyo from Banggood or Aliexpress because chances are high that you get a fake one. I bought mine at Amazon and checked it for originality with some comparison videos on Youtube (just search for "Mitutoyo fake caliper").



| Part Name        | Quantity            |
| -------------    |:-------------:      | -----:  | -------------: |:-------------:     | -----:      |
| Caliper (analog)  |      1               |   [Amazon](https://amzn.to/3hM3B2z){:target="_blank"}  | [ebay](https://ebay.us/MIRhC8){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_A1EZI4){:target="_blank"}    |
| Mitutoyo Caliper (digital) |    1         |   [Amazon](https://amzn.to/3wqALtR){:target="_blank"}  |

Another very important tool is a dial indicator which is used to align the axes and to get parallelism and squareness of your frame/portal. Again, there are cheap and expensive alternatives. I ordered a cheap one to start but recently upgraded to a Mitutoyo (again, don't buy it at Aliexpress, it will be fake): 

| Part Name        | Quantity            |
| -------------    |:-------------:      | -----:  | -------------: |:-------------:     | -----:      |
| Cheap Dial Indicator |      1               |   [Amazon](https://amzn.to/2VbpVLk){:target="_blank"}  | [ebay](https://ebay.us/um3hux){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_9QXALi){:target="_blank"}    |
| Mitutoyo Dial Indicator |    1              |   [Amazon](https://amzn.to/36hPEUS){:target="_blank"}  | [ebay](https://ebay.us/ofJ08A){:target="_blank"}  
| Magnetic Measuring Stand |    1             |   [Amazon](https://amzn.to/3edP8vB){:target="_blank"}  | [ebay](https://ebay.us/9AoXCm){:target="_blank"}  | [Aliexpress](https://s.click.aliexpress.com/e/_A1mxlw){:target="_blank"}    |

![tools]({{ '/assets/images/tools.jpg' | relative_url }})




[Back to Parts]({{ '/parts/' | relative_url }})

---


This page contains affiliate links. If you use these links to buy something I may earn a commission at no additional cost to you, which helps me to maintain this website. Thanks.