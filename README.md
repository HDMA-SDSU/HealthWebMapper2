<img src="imgs/HealthWebMapper2.png" width=364 height=288 align="right"/>

## HealthWebMapper2.0

[HealthWebMapper 2.0](https://haihonghuang.shinyapps.io/HealthWebMapper2/) is a web mapping application designed for visualizing cancer disparities in San Diego Sub-Regional Areas(SRAs). 

It was developed and hosted by: [R Shiny](https://shiny.rstudio.com/) and [shinyapps.io](https://www.shinyapps.io/)

HealthWebMapper2.0 URL: https://haihonghuang.shinyapps.io/HealthWebMapper2/

Demo datasets URL: https://github.com/HDMA-SDSU/HealthWebMapper2/tree/master/demo-datasets

Data source: [Live Well San Diego Data Access Portal](https://data.livewellsd.org/)


## How to use (Demo)
<img src="imgs/upload-panel.png" width=312 height=160 align="right"/>

1. Download preprocessed datasets: click the links [Lung_Cancer_Death_2015_SRA.csv](https://github.com/HDMA-SDSU/HealthWebMapper2/blob/master/demo-datasets/cancer_data/Lung_Cancer_Death_2015_SRA.csv) and [census2013.csv](https://github.com/HDMA-SDSU/HealthWebMapper2/blob/master/demo-datasets/socioeconomic%26demographic_data/census2013.csv); Click "Raw" button and Ctrl+S save the csv files into your loacal computers. 

2. Open [HealthWebMapper2.0](https://haihonghuang.shinyapps.io/HealthWebMapper2/) and input data    
    
   Step 1: upload Lung_Cancer_Death_2015_SRA.csv as cancer data   
   
   Step 2: upload census2013.csv as socioeconomic data
   
   <img src="imgs/selection-panel.png" width=312 height=140 align="right"/>     
   
   *After uploading two csv files, ignore the error in map panel. If upload correctly, the error message will fade and two side-by-side maps will automatically show up within a few seconds
   
   *The default maps will look the same showing attribute SRAID, please proceed to step 3 and 4 to select other attributes
           
   Step 3: Choose a case or rate
   
   Step 4: Choose a socioeconomic factor

3. Explore data
   
   <img src="imgs/map.png" width=350 height=230 align="right"/>
   
   * The side-by-side interacive maps allow you to pan, zoom in/out synchrounously
   
   * Switch basemaps and turn on/off overlayers (labels, hospitals and highways)
   
   * Click your interested areas to see details about selected data attributes
   
   &nbsp; 
 
   <img src="imgs/tool.png" width=350 height=160 align="right"/>  
   
   * Choose tool "summary" and click "Add Analysis" to get statistical overview about all the data attributes
   
   * Choose tool "correlation" and click "Add Analysis" to get correlation coefficient (Pearson's r). Pearson's r ranges from -1 to 1. The higher the absolute value of Pearson's r is, the stronger the correlation between two variables. However, correlation is not the same as causation.
   
   <img src="imgs/table-tab.png" width=350 height=250 align="right"/>  
   
   * You can change data selection and add more analysis results. For example, compare Pearson's correlation value between Age-Adjusted-Rate/Hispanic_Population and Age-Adjusted-Rate/Median Household Income, which socioeconomic factor is more correlated with lung cancer age adjusted mortality rate?
   
   * Switch to Cancer Data Table tab or Socioeconomic Data Table to view uploaded data
 
&nbsp;

> Noted:
>* County age-adjusted rates per 100,000 (2000 US standard population)    
>* Rates per 100,000 population
>* Please interpret with these results with caution - correlation, is not the same as causation. This tool visualizes patterns that can be used for exploratory analysis and hypothesis testing in order to form more complex and realistic models of cancer mortality, but should not alone be interpreted as a valid tool for prediction of cancer outcomes.

## Use your own data

See techincal document [TechDoc_DataPreprocess_HealthWebMapper2.pdf](https://github.com/HDMA-SDSU/HealthWebMapper2/blob/master/technical%20docs/TechDoc_DataPreprocess_HealthWebMapper2.pdf)

## Follow-up Survey

To help us improve HealthWebMapper, we invite you to take a short [online survey](https://arcg.is/18jquO) tell us your experience about HealthWebMapper2.0

URL: https://arcg.is/18jquO
