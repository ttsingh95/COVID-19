setwd("/Users/Tatiksha/Documents/Customer Social Analytics/Final Project")
patient<- read.csv("patient_FOR_R.csv")

library("survival")
library("survminer")
library(dplyr)
library(ggplot2)
library(ggsci)
library(data.table)

head(patient)
patient <- patient %>% mutate(age = 2020- patient$birth_year) #adding a new column called age

#Univariate Cox regression
res.cox <- coxph(Surv(time, survival) ~ sex_dummy, data = patient)
res.cox
summary(res.cox)

#Hazard ratio interpretation
#The exponentiated coefficients (exp(coef) = exp(0.0728) = 1.076), also known as hazard ratios give the effect size of covariates
#Being female (sex=2) increases the hazard by a factor of 1.076
#Being female is associated with a (good?) prognostic.

#applying the univariate coxph function to multiple covariates at once
covariates <- c("age", "sex_dummy",  "disease")
univ_formulas <- sapply(covariates,
                        function(x) as.formula(paste('Surv(time, survival)~', x)))

univ_models <- lapply( univ_formulas, function(x){coxph(x, data = patient)})



# Extracting data 
univ_results <- lapply(univ_models,
                       function(x){ 
                         x <- summary(x)
                         p.value<-signif(x$wald["pvalue"], digits=2)
                         wald.test<-signif(x$wald["test"], digits=2)
                         beta<-signif(x$coef[1], digits=2);#coeficient beta
                         HR <-signif(x$coef[2], digits=2);#exp(beta)
                         HR.confint.lower <- signif(x$conf.int[,"lower .95"], 2)
                         HR.confint.upper <- signif(x$conf.int[,"upper .95"],2)
                         HR <- paste0(HR, " (", 
                                      HR.confint.lower, "-", HR.confint.upper, ")")
                         res<-c(beta, HR, wald.test, p.value)
                         names(res)<-c("beta", "HR (95% CI for HR)", "wald.test", 
                                       "p.value")
                         return(res)
                         #return(exp(cbind(coef(x),confint(x))))
                       })
res <- t(as.data.frame(univ_results, check.names = FALSE))
as.data.frame(res)

#with older age and underlying diseases, survival rate is low
#sex is not statistically significant - no major difference in terms of surival rate for gender


#Cox regression of time to death on time-constant covariates
res.cox <- coxph(Surv(time, survival) ~ age + sex_dummy + disease , data =  patient)
summary(res.cox)

#In the multivariate Cox analysis, the covariate disease is significant (p < 0.05)
#However, the covariates age and sex fail to be significant:
#(p = 0.24 and 0.79, respectively which is greater than 0.05)


# Plotting the baseline survival function

ggsurvplot(survfit(res.cox), data = patient)


sex_fit<- survfit(Surv(time, survival) ~ sex_dummy, data = patient)
#age_fit <- survfit(Surv(time, survival) ~ age, data= patient) need to put into age buckets for visualizing it
disease_fit <- survfit(Surv(time, survival) ~ disease, data= patient)
#Drawing survival curves
ggsurvplot(sex_fit,
               palette = c("Skyblue2", "Thistle2"),
               Title='Survival Curve', 
               legend.labs= c('Male',"Female"),
               pval = TRUE,
               conf.int = TRUE,
               risk.table = TRUE, 
               risk.table.y.text.col = TRUE)
ggsurvplot(disease_fit,
           palette = c("Skyblue2", "Thistle2"),
           main='Survival Curve',
           legend.labs= c("No Underlying Disease (=0)", "Underlying Disease(=1)"),
           pval = TRUE,
           conf.int = TRUE,
           risk.table = TRUE, 
           risk.table.y.text.col = TRUE)


#need to put age into bins- otherwise it shows too many points
#ggsurvplot(age_fit)

#age buckets
patient<- patient[!(is.na(patient$age) | patient$age==""), ]
agebreaks <- c(0,10,20,30,40,50,60,70,80,500)
agelabels <- c("0-9","10-19","20-29","30-39",
               "40-49","50-59","60-69",
               "70-79","80+")
setDT(patient)[ , agegroups := cut(age, 
                                      breaks = agebreaks, 
                                      right = FALSE, 
                                      labels = agelabels)]

agegroup_fit <- survfit(Surv(time, survival) ~ agegroups, data= patient)

ggsurvplot(agegroup_fit,
           main='Survival Curve')
           