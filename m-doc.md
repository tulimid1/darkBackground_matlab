---
layout: page
title: MATLAB
permalink: /MATLAB/
---

# [darkBackground](https://github.com/tulimid1/darkBackground_matlab/blob/main/darkBackground.m) 
---

Change figure and axes background and foreground. See [darkBackground_examples.mlx](https://github.com/tulimid1/darkBackground_matlab/blob/main/darkBackground_examples.mlx) for a notebook of given examples. 

## Syntax
---
[darkBackground()](#a)

[darkBackground(Name, Value)](#b)

## Description
---
### A
darkBackground() updates figure properties to have black background and white foreground. [example](#example-1)

### B
darkBackground([Name, Value)](#name-value-arguments) updates figure properties to have black background and white foreground with additional options specified by one or more name-value pair arguments. For example, you can specify a different background color or foreground color. [example](#example-2)

## Examples 
---
### Example 1
Copied code from MATLAB `yyaxis` function example (but give it a dark background). 

    x = linspace(0,10);
    y = sin(3*x);
    yyaxis left
    plot(x,y)

    z = sin(3*x).*exp(0.5*x);
    yyaxis right
    plot(x,z)
    ylim([-150 150])
    
    darkBackground()
    
![fig1](/assets/ex1.png)
    
### Example 2
Description

    CODE
    
![fig2](/assets/ex2.png)

### Name-Value Arguments

Specified optional comma-separated pairs of ```Name,Value``` arguments. ```Name``` is the is the argument name and ```Value``` is the corresponding value. ```Name``` musta ppear inside single or double quotes. You can specify several name and value pair arguments in any order as ```Name1,Value1,...,NameN,ValueN```. 

**Example**: ```'name1', value1, 'name2', value2``` specifies blah blah blah.

### ```name1```
Short description (default=X)

Long description

Data Types: (X, Y)

### ```value1```
Short description (default=X)

Long description

Data Types: (X, Y)

## More About 
---

## Tips 
---

## Issues and Discussion
---

[Issues](https://github.com/tulimid1/TASK/issues) and [Discussion](https://github.com/tulimid1/TASK/discussions).

If you don't know how to use github (or don't want to), just send me an [email](mailto:tulimid@udel.edu). 
