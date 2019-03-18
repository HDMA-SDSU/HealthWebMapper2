# HealthWebMapper2.0

HealthWebMapper 2.0 is a web mapping application designed for visualizing cancer disparities in San Diego County.

URL: https://haihonghuang.shinyapps.io/appr-upload/

# How to use (Demo)
1. download preprocessed datasets: Lung_Cancer_Death_2015_SRA.csv and census2013.csv

2. open [HealthWebMapper2.0](https://haihonghuang.shinyapps.io/appr-upload/) and input data

    step 1: upload Lung_Cancer_Death_2015_SRA.csv as cancer data
    
    step 2: upload census2013.csv as socioeconomic data
    
    *after uploading, two side-by-side maps will automatically show up within a few seconds
    
    step 3: Choose a case or rate
    
    step 4: Choose a socioeconomic factor

3. explore data

   * The side-by-side interacive synchrounous maps allow you to pan, zoom in/out, switch backgrounds and overlayers 
   * click your interested regions to see detail about your selected data attributes 
   * choose the summary tool and click button "Add Analysis" to get overview about all the data attribute 
   * choose the correlation tool and click button "Add Analysis" to get quantatative Pearson's correlation. You can change data selection and add more analysis results. For example, compare Pearson's correlation value between Age-Adjusted-Rate/Hispanic_Population and Age-Adjusted-Rate/Median Household Income, which socioeconomic factor is more correlated with lung cancer age adjusted mortality rate?
   * switch to Cancer Data Table tab or Socioeconomic Data Table to view your uploaded data

# Use your own data

See techincal document "data preprocessing "
