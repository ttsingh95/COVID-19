# COVID-19

Back in February when things didn't seem like Coronavirus would get to where it is now, I set out to make use of the growing influx of data in Kaggle. I came across Johns Hopkins Dashboard and was inspired to work on a project that made use of skills I picked up within my Customer and Social Analytics class. I worked in a group of 3 for this project, however the code presented here is solely mine.

I reworded the research paper and presentation to include my work predominately with about 20% of the paper and presentation belonging to my other teammate.

## Current Files in this repository inclulde: ##
- Exploratory Analysis for South Korea and Global Cases in Python using Plotly, Folium, Seaborn, Matplotlib
- R code for the Statistical Analysis : Survival Analysis and Cox Proportional-Hazards Model
- Research Paper discussing insights found based on the analysis [yet to include]
- Presentation in a .pdf format


## What is Cox Proportional-Hazards Model? ##
Simply put, it is a regression model used predominantly in medical research to investigate the relationship between patients' survival time and one or more predictor variables. 

I chose to use this model since it works for both quantitative and categorical variables, as opposed to Kaplan-Meier curves and logrank tests which work with only categorical variables such as sex, and I was also using age as a predictor variable 

For this analysis, I used 3 variables: Sex (Male=1, Female=2), Age, Disease (0= no underlying disease, 1= underlying disease) to assess what risk factors what could be decreasing the likelihood of survival for infected patients 

