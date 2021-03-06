
<!-- README.md is generated from README.Rmd. Please edit that file -->
ggshp
=====

The goal of ggshp is to take a shp file and transform it into something that can easily be used in ggplot2.

Installation
------------

You can install the not-quite functioning version of ggshp from [github](https://github.com/ashirazist/ggshp) with:

``` r
githubinstall("ggshp")
```

Our team struggled to address package building and testing errors because (i) the functions we chose to build weren't necessarily robust to other shp file intputs and (ii) we didn't get the same errors on our individual machines, making it difficult to trouble shoot. We also originally tried to build more robust testing, but those quickly became unmanageable to address with all of the other problems we ran across. Package building can be a real time suck.

Example
-------

This is a basic example which shows you how to solve a common problem:

Yuck. A shp file. Use one of our three functions.

``` r

# NOTE: dhsp is the path to the shp file
dtib <- team_7(dhsp)

dtib %>% 
   ggplot(aes(x = long, y = lat, group = group)) + 
   geom_polygon(fill = "white", colour = "black", lwd = 1)+
   theme_bw()+
   coord_quickmap()
```

Team Members
------------

-   Virginia (Gina) Nichols
-   Amin Shirazi
-   Qing He
