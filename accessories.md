---
title: "Accessories"
layout: page
image: 
  path: /assets/images/accessories_title1.jpg
  thumbnail: /assets/images/accessories_title1.jpg
---
This section covers various (mostly printed) accessories which make the machine more convenient to use. 
You will find all relevant stl and stp files in this folder */Printed_Parts/Accessories/* on [Github](https://github.com/culturalheritagedigital/Cindymill){:target="_blank"}.

## Limit Switches

Limit switches allow to home your machine so that there is no risk of an axis being moved beyond its limits.
I had mechanical switches before, but too often these did not trigger, e.g. because a screw or chips had jammed in the lever. Now I use inductive sensors (NPN NC) which trigger contactless:

| Part Name        | Quantity            | 
| -------------    |:-------------:      | -----:  | -------------: |:-------------:     | -----:      |
| Inductive proximity switch LJ12A3-4-Z/AX (NPN NC) | 3  |  [Amazon](https://amzn.to/3m2Fejq){:target="_blank"} | [eBay](https://ebay.us/EYmSNV){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_AWNgfT){:target="_blank"}      |  

These sensors trigger at 4 mm distance with steel, with aluminum you will need to bring them to 2 mm distance. Print the holders (2x the one for X/Y, 1x for Z) and screw them to the profiles (4x M3x10 for X/Y, 2x M3x14 for Z). 

![limit]({{ '/assets/images/addons/limitswitches/limitswitch1.jpg' | relative_url }})

![limit]({{ '/assets/images/addons/limitswitches/limitswitch5.jpg' | relative_url }})

## Cable Chains

I bought 15 mm wide cable chains from [eBay](https://ebay.us/12995k){:target="_blank"}, they have enough space for motor cables, limit switches, light, etc. Use the given formula to calculate the required length for your build dimensions (for the length of your frame and the width of your portal). You will need 2 connecting elements per chain. 
Print the Z axis cable chain holder (the thing that looks like a cracker), the other three ends can be attached directly to the extruded profiles. The "fixature" things help to screw the chain down to the profiles.

![limit]({{ '/assets/images/addons/cablechain/cablechain1.jpg' | relative_url }})



## Vacuum Cleaner Holder 
I got tired of having to stand next to the machine with a vacuum cleaner for ages. There are various commercial holders but they can easily cost around 100€. 
I designed a cheap printable vacuum cleaner holder for my 1.5 kW spindle. Parts cost around 15€ total so it should be a good alternative to commercial solutions.

The spindle:

| Part Name        | Quantity            | | | | 
| -------------    |:-------------:      | -----:  | -------------: |:-------------:    | 
| 1.5kW Spindle + Frequency Converter Air cooled | 1  |  [Amazon](https://amzn.to/2UVZ45Q){:target="_blank"} | [eBay](https://ebay.us/H6Srn0){:target="_blank"}  |  [Aliexpress](https://s.click.aliexpress.com/e/_AK3cet){:target="_blank"}      |            

[The brush is from Sorotec](https://www.sorotec.de/shop/Brushes-for-magnetic-suction-shoe-65---80mm-6831.html){:target="_blank"} and fits perfectly. [This one from Ebay should also work](https://www.ebay.de/itm/263497817763?hash=item3d59b19ea3:g:u5YAAOSwPqphOeV1&mkcid=1&mkrid=707-53477-19255-0&siteid=77&campid=5338816808&customid=1&toolid=10001&mkevt=1){:target="_blank"}, maybe you will have to cut the brush hair a bit.
You will need 6 cylindrical 5x5 mm neodymium magnets from [Aliexpress](https://s.click.aliexpress.com/e/_AZul65){:target="_blank"} or [Ebay](https://ebay.us/ZtPik9){:target="_blank"} and a screw (M5x45-50) with nut.

The cleaner hose I use is from Festool (upper diameter 37.5 mm, lower 34.5 mm, don't know if there's a standard). If your cleaner hose doesn't fit take the step file, fill the hole and put in a new one with your needed specs.
I used PETG (the spindle gets warm, no PLA!) with 4 perimeters, 20% infill to print the parts.

![limit]({{ '/assets/images/addons/vacuum/vacuum1.jpg' | relative_url }})

![limit]({{ '/assets/images/addons/vacuum/vacuum2.jpg' | relative_url }})

<!-- ## Lighting

Coming soon! -->


---
This page contains affiliate links. If you use these links to buy something I may earn a commission at no additional cost to you, which helps me to maintain this website. Thanks.