# COVID-19

Worked in a team of 3 to conduct an in-depth analysis of Coronavirus since it is the focal point not only within USA, but globally. It has  affected 128,343 people as of 3/12/2020 with cases growing daily.

We explored Global, US, and South Korean cases in our analysis

[I will continue to update this repository as I deepen my analysis further]

Current Files in this repository inclulde:
- Exploratory Analysis for South Korea and Global Cases in Python using Plotly, Folium, Seaborn, Matplotlib
- Multivariate Cox Proportional-Hazards Model in R

# What is Cox Proportional-Hazards Model? 
Simply put, it is a regression model used predominantly in medical research to investigate the relationship between patients' survival time and one or more predictor variables. 

We chose to use this model since it works for both quantitative and categorical variables, as opposed to Kaplan-Meier curves and logrank tests which work with only categorical variables such as sex, and we were also using age as a predictor variable 

For this analysis, we used 3 variables: Sex (Male=1, Female=2), Age, Disease (0= no underlying disease, 1= underlying disease) to assess what risk factors what could be decreasing the likelihood of survival for infected patients 

