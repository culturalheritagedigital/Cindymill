---
title: "Speeds and Feeds - How to calculate Milling Parameters for Hobby Machines"
read_time: true
layout: post
categories:
  - start
tags:
  - content
image: "/assets/images/feedsandspeeds1.jpg"
---
Successful milling depends on a large number of factors. However, if you pay attention to a few things and operate a suitable milling cutter with the correct feed rate and spindle speed, then you are already doing a lot of things right. This way you will get good results quickly and avoid frustration and local fires.

When I built my first CNC machine, I had no idea which milling cutter to use and at what speeds, depths of cut, etc.
So I randomly ordered a handful of cheap but shiny milling cutters from Aliexpress (some were even coated in bright colors!). Length, diameter, number of teeth? No idea!
Then the first attempts to mill a pattern in a wooden panel: I used some random settings I had seen on Youtube and after five minutes the workpiece burned brightly...

This article is designed to help you prevent all of that.
<!-- The aim is to give you a first insight into the topic. I cannot deal with everything in great depth, first because I may not be able to do it at all, and second, because it does not help you if I bombard you with 20 pages of text. -->
It is supposed to be firstly an introduction into the topic, e.g. to help you to understand what the different parameters do, and secondly, to be a source to look up and a help for calculating the parameters in everyday life.

<!-- There are two formulas that we have to deal with a little bit, but we don't need math that we wouldn't have learned in school. -->
There are various articles on the Internet that deal with this topic, but rarely do they go into the peculiarities of a milling machine like the ones we have. So this article also deals specifically with the limitations we face as hobbyists and how we can get around them.

## How do we calculate feed rate and spindle speed?
<!-- In the following section I will guide you through the calculation of "feeds and speeds", which highly depend on your tool, the material of your workpiece and the properties of your machine. We will learn abbreviations for the parameters which are mostly language independent.  -->

### Spindle Speed
We start with calculating the **spindle speed** $$n$$, which is the rotational frequency of the spindle in revolutions per minute [rev/min]. Let's take a look at the corresponding formula:

$$ n = \frac{v_c \times 1000}{d \times 3.14} $$
 
For the calculation we only need two other values:


### Cutting Speed
$$v_c$$ is the so-called **cutting speed** [m/min], which is the velocity difference between the tool and the surface of your workpiece. This value mainly depends on the workpiece material, but also on the cutter and the rigidity of your machine. 



If you buy high quality milling cutters, the manufacturer usually provides tables with $$v_c$$ values dependent on the tool and material you want to use. 
For cheap cutters from China we unfortunately don't have those values.
The table below shows parameters as provided by the company [Sorotec](https://www.sorotec.de/shop/){:target="_blank"}. These values ​​are given for their own cutters in combination with a very stiff machine. However, they give us good guide values and can later be fine-tuned for our machine:


| Material    | $$ v_c $$  
| -------------    |-------------:      | -----:  | -------------: |-------------:     | -----:      |  -----:      |  -----:      |  -----:      |
| Aluminum (wrought alloy) | <span style="color:red">500</span> 
| Soft Plastic | 600 
| Hard Plastic | 550 
| Hard Wood | 450 
| Soft Wood | 500 |
| MDF | 450 
| Brass, Copper, Bronze | 365 

Some short notes about $$v_c$$:
- The stiffer the machine, the higher the cutting speeds that can be achieved. For our hobby machines, published values ​​are often very ambitious and can be reduced if needed (at the expense of  production time).
- The specified cutting speeds are mostly given for professional production, where a short tool life is often accepted for faster production times. For me it's the other way around: I prefer to wait a little longer for a better tool life. So, another argument to lower $$ v_c $$ if needed.

### Tool Diameter

$$d$$ is the **tool diameter** in [mm]. 
- In general: your milling cutter should be as short and thick as possible. The thickness is limited by the collet of your spindle, ER11 allows $$ d $$ = 7 mm max.
- Side note: The $$ \times 1000 $$ in the formula for $$v_c$$ is only there, so that you can use mm for the tool diameter instead of meters. 




### Example:
> Let's assume we want to mill with a 4 mm cutter in aluminum.
>
> We are looking for the $$v_c$$ entry for aluminum in the table (<span style="color:red">500</span>) and use $$d$$ = 4:
>
> $$ n = \frac{500 \times 1000}{4 \times 3.14} = 39808 $$ 

If the calculated value is higher than our maximum spindle speed, we have to reduce $$n$$ to the highest possible value. If we take a look again at the formula, by lowering $$n$$, we in fact lower $$ v_c $$ (if $$d$$ stays constant) which should be ok, as we have seen above.

Another possibility to achieve a realistic $$n$$ would be to change the tool diameter $$d$$: Doubling the diameter halves the resulting spindle speed. However, since we usually start with a very limited selection of cutters, this should rarely be a real option.

>My spindle can do $$n$$ = 24000 max, so that's the value I'll take.

### Feed Rate

Now that we know our spindle speed, we can calculate the corresponding **feed rate** $$v_f$$, which is basically, how far the center line of our tool will move in one minute [mm/min]. Let's take a look at the corresponding formula:

$$ v_f = n \times z \times f_z   $$

We already know $$n$$, two more values are needed:

### Number of Teeth

$$z$$ is the **number of teeth** of your milling cutter. A "tooth" is a cutting edge alongside your tool.

If you buy milling cutters, they are mostly named as "1-Flute", "2-Flute", etc. "Flutes" are the deep helical grooves running up the cutter. There is almost always one flute per tooth, so you can use the number of flutes for $$z$$.

### Feed per Tooth

$$f_z$$ is the **feed per tooth**, which is the size of the bite the tool takes per tooth and rotation [mm]. It determines the actual thickness of each chip removed by each tooth. 
Again, these values are usually given by the cutter manufacturer and depend on factors like the workpiece material, the tool diameter $$d$$, and others.
We take the table provided by [Sorotec](https://www.sorotec.de/shop/){:target="_blank"} as guide values:


| Material    | $$ f_z $$    
|| $$d$$ = 1  | $$d$$ = 2  | $$d$$ = 3  | $$d$$ = 4  | $$d$$ = 5  | $$d$$ = 6
| -------------    |-------------:      | -----:  | -------------: |-------------:     | -----:      |  -----:      |  -----:      |  -----:      |
| Aluminum (wrought alloy) |  0.010 | 0.020 | 0.025 | <span style="color:red">0.050</span> | 0.050 | 0.050 |
| Soft Plastic |  0.025 | 0.030 | 0.035 | 0.045 | 0.065 | 0.090 |
| Hard Plastic |  0.015 | 0.020 | 0.025 | 0.050 | 0.060 | 0.080 |
| Hard Wood |  0.020 | 0.025 | 0.030 | 0.035 | 0.045 | 0.055 |
| Soft Wood |  0.025 | 0.030 | 0.035 | 0.040 | 0.050 | 0.060 |
| MDF |  0.030 | 0.040 | 0.045 | 0.050 | 0.060 | 0.070 |
| Brass, Copper, Bronze |  0.015 | 0.020 | 0.025 | 0.025 | 0.030 | 0.050 |


### Example:
> We continue our example from above, assuming that our 4 mm cutter has 4 teeth.
>
>We use $$n$$ = 24000 and $$z$$ = 4, then we are looking for the $$f_z$$ entry for aluminum and $$d$$ = 4 in the table (<span style="color:red">0.050</span>):
>
>$$ v_f = 24000 \times 4 \times 0.05 = 4800  $$
>

<!-- While setting up the controller software you have certainly tested the maximum travel speeds for your individual axes. These values ​​are limited by the rigidity of your machine, the operating voltage, the lengths of the ball screws, friction in the mechanical components, etc. -->
For professional machines it might not be any problem to go that fast, but for a hobby machine 4800 mm/min can be completely out of reach. 

So, what could we change? Let's take a look at the formula:

- We could further lower $$n$$ (and, thereby, $$v_c$$) but we already did, so maybe there are better ways.

- A simple way to achieve feasible values ​​is to change the number of teeth. Since $$z$$ is a simple factor, halving $$z$$ also means halving the feed rate. 

>In our example, $$z$$ = 2 would lead to $$v_f$$ = 2400, or $$z$$ = 1 would lead to $$v_f$$ = 1200.

The 4-flute cutter from the example was chosen to illustrate one of the problems, we might have with those cutters. They should theoretically produce better surfaces but they need feed rates we might not be able to achieve with our machines (There is more about pros and cons for different cutters but maybe that's a topic for another article).

My shiny 4-flute cutters that I originally bought are all on the shelf and I almost only mill with 1- and 2-flute cutters, partly because they give me feed rates that I can realize. [Here is a list of cutters I use.]({{ '/parts/electronic_parts/' | relative_url }}){:target="_blank"}

That's it for now, I hope it wasn't too long! 
If you have questions or comments feel free to join our [facebook group!]({{ '/parts/electronic_parts/' | relative_url }}){:target="_blank"}

Happy milling!

- For a deeper dive into feeds and speeds you can start with the [Wikipedia entry](https://en.wikipedia.org/wiki/Speeds_and_feeds){:target="_blank"}.

- The table with milling parameters can be [downloaded here](https://webseite.sorotec.de/download/fraesparameter/cutting_param_facemillcutter.pdf){:target="_blank"}.

**Here are some milling cutters I can recommend:** 

These are cutters I use for **clearing pockets and contours** in wood, acrylic and aluminum:

| Part Name        | 
| 1/8" 1-flute (Aluminum) |     [Amazon](https://amzn.to/3qzSjmb){:target="_blank"}   |    [Aliexpress](https://s.click.aliexpress.com/e/_99oJUG){:target="_blank"}            |       |             |
| 1/8" 2-flute (Wood, Plastic) |      [Amazon](https://amzn.to/3Ae1KMi){:target="_blank"}        |                |       |             |
| 1/8" 1-flute (Wood, Plastic) |      [Aliexpress](https://s.click.aliexpress.com/e/_Akhe1K){:target="_blank"}       |            |      |             |
| 6mm 2-flute (Wood) |             [Amazon](https://amzn.to/3h8IIQe){:target="_blank"}         |  [Aliexpress](https://s.click.aliexpress.com/e/_AWTAa8){:target="_blank"}    |             |



**Cutters for engraving**, I used them for plywood and acrylic so far:

| Part Name        | 
| Engraving bit |      [Amazon](https://amzn.to/3xaB8Kh){:target="_blank"}   |   [Aliexpress](https://s.click.aliexpress.com/e/_A1k2o0){:target="_blank"}     





**Chamfer bits** are good for finishing edges after cutting. I have several with 3-6 mm diameter and use them for all materials:

| Part Name        |
| Chamfer bit |      [Amazon](https://amzn.to/2TpJbnM){:target="_blank"}    |   [Aliexpress](https://s.click.aliexpress.com/e/_ALjXuG){:target="_blank"}    


---

This page contains affiliate links. If you use these links to buy something I may earn a commission at no additional cost to you, which helps me to maintain this website. Thanks.
