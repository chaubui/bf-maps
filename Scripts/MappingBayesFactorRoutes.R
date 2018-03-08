#############################################################
# This R code takes a Bayes Factor analysis generated from  #
# BEAST and SPREAD3, and develops a map to visualise highly #
# supported routes of spread                                #
#############################################################

# use the bf_maps function provided
# if you are making two maps, use the multiplot function provided

# load libraries

library("RQGIS")
library("rgdal")
library("maptools")
library("ggplot2")
library("rgeos")
library("dplyr")
library("ggrepel")


# Bayes Factor analyses were generated using SPREAD3.
# https://rega.kuleuven.be/cev/ecv/software/SpreaD3_tutorial
# The table should contain a "TO", "FROM" and "Bayes Factor" 
# column.
 
# In the SPREAD3 analysis, you needed to load a table of 
# location coordinates. You will need this table here  as 
# well.

# It may be good to group locations together for display.
# Each group of locations can be a different colour. 
# You will need to provide your table of location groupings here.

# I created a list of colours for locations as I had 
# specific colours that I wanted to use to represent each 
# Economic Division. You can make your own list of colours here.

col_list <- c("grey50", 
        "deeppink1", 
        "white", 
        "white",
        "gold1",
        "darkorchid3", 
        "#FF7F00", 
        "dodgerblue2",
        "seagreen3"
)

# load the basemap data. I downloaded my basemap of China 
# from gadm.org

spdf <- readOGR("C:/Users/Chau/workspace/20180307_R_GIS/Data/BayesFactorMapping/CHN_adm_shp/CHN_adm1.shp", 
                "CHN_adm1", 
                verbose = TRUE, 
                stringsAsFactors = FALSE)

# create some maps using the function
  
  #H5N1
    bf_maps(BFfile_dir = "C:/Users/Chau/workspace/20180307_R_GIS/Data/BayesFactorMapping/H5N1_BF.csv", # BF file
          coordinate_dir = "C:/Users/Chau/workspace/20180307_R_GIS/Data/BayesFactorMapping/H5coordinates.txt", # coordinate file
          locationGroup_dir = "C:/Users/Chau/workspace/20180307_R_GIS/Data/BayesFactorMapping/EDclassifications.csv", #location groups
          col_list = col_list,
          spdf = spdf,
          graph_title = "H5N1") # name your graph here

  #H7N9
    bf_maps(BFfile_dir = "C:/Users/Chau/workspace/20180307_R_GIS/Data/BayesFactorMapping/H7N9_BF.csv", # BF file
            coordinate_dir = "C:/Users/Chau/workspace/20180307_R_GIS/Data/BayesFactorMapping/H7coordinates.txt", # coordinate file
            locationGroup_dir = "C:/Users/Chau/workspace/20180307_R_GIS/Data/BayesFactorMapping/EDclassifications.csv", #location groups
            col_list = col_list,
            spdf = spdf,
            graph_title = "H7N9")

# If you are making two graphs, call multiplot function
  
  multiplot(H5N1, H7N9, cols = 1)

# you can save the plot as a pdf
# I used an A4 portrait size for my two maps 

