
<!-- README.md is generated from README.Rmd. Please edit that file -->
ggshp
=====

The goal of ggshp is to take a shp file and transform it into something that can easily be used in ggplot2.

Installation
------------

You can install the ghetto version of ggshp from [github](https://github.com/ashirazist/ggshp) with:

``` r
githubinstall("ggshp")
```

Example
-------

This is a basic example which shows you how to solve a common problem:

Yuck. A shp file. Use one of our three functions.

``` r
dtib <- FunTeam7(dhsp)

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
