## Understanding some economic implications using Time Series

### Introduction

The work is divided in 2 issues: 
-The relationship between the log of real personal disposable income (Y) and the log of real personal consumption expenditure (C) for the US economy over the period 
1960:1 to 2009:4.
-Review of the Purchasing Power Parity (PPP), which says that prices and exchange rates will remain in equilibrium. We will use data on the UK CPI, the US CPI and the $/£ exchange rate .

### Installation and load data set
The data file cons.dta contains quarterly data on the log of real personal disposable income (Y) 
and the log of real personal consumption expenditure (C). 
The file ppp.dta contains data on the UK CPI, the US CPI and the $/£ exchange rate

```markdown
cd "$home"  // the path to whatever directory the datafile is in

use "C:\Users\ivvan\Downloads\cons.dta", // load the file cons.dta 

drop if c==.
drop if y==. // drop missing values:in this case isn't necessary

tsset time, quarterly // tell stata time index is quarterly

```

### Topics discused

````markdown
# TEST OF NO COINTEGRATION WITH DICKEY FULLER
# KEYNESIAN CONSUMPTION FUNCTION
# DYNAMIC MULTIPLIERS
# REGRESSIONS: long run marginal effect of log income on log consumption
# ERROR CORRECTION MODEL AND HAC STANDARD ERROR
````

### Exercises (graphics/images attached in index.md file)

### 1.Work on the relationship between the log of real personal disposable income and the log of real personal consumption expenditure

#### (a) For each series, decide whether it has a unit root or not. Use a formal test.
If we look to the graphs of the series, we see there are clear trends, then data seems to be 
non-stationarity. For that reason, we suspect data is I(1). It must be a deterministic trend or 
random walk with drift. 
If we do an augmented dickey-fuller test on both series with trend (as there are trend), we see
we cannot reject the null hypothesis that there’s unit root.
H0 : Sum of coefficients = 1 H1 : Sum of coefficients < 1
But if we do the same test with the first differences, we get rid of the trend and we see that 
data is stationary as the test statistics of both series are bigger in absolute terms than the 
critical values at 10%,5%, and 1% Confidence level. It leads us to reject the null hypothesis that 
there’s unit root at the 1% Confidence level. Thus, as expected, our data is I(1) for both series.

#### (b)Regardless of the result in part a, assume now that both series have unit roots. Estimate the simple Keynesian consumption function (log consumption is a function of log income). What is the implication of non-stationarity of the series for the results of the regression?
The result looks pretty decent as the R-squared is mostly 1 and the coefficient is statistically significant, but that may be unreal.
Ct = ρ1Yt-1 + ρkYt-k + ε
If series are non-stationary, OLS will find anyway coefficients that make the series look in 
equilibrium, or in other words, cointegrated. And those coefficients are significant, but they 
are not true values as such equilibrium doesn’t exist actually. And as they are not real values,
we say OLS is biased. It would have been better to make a regression using the 1st differences 
as the series become stationary.


#### (c) Now estimate a DL version of the function. Use OLS and HAC corrected standard errors. Be clear about why you choose the particular number of lags in the regression.
A DL model is similar to an AR model, but instead of using lagged values of the variable itself, 
we use lag values of an explanatory variable. First, I took a regression with 3 lags as it looks a 
good number after seeing the ACF & PAC functions of both variables. As I proofed, data is I(1)
so we can make the regression with the first differences. Results show that there are 3 
coefficients which are statistically significant, so 3 lags are a good choice.
d.Ct = ρ0d.Yt + ρ1d.Yt-1 + ρ2d.Yt-2 + ρ3d.Yt-3 + ε
Then, in order to use the HAC standard errors, I need to specify the number of lags that I think 
there are in the error terms. I will use the next formula = 0.75 ∗ (T ^1/3), as computer 
simulations suggest is the best one. The result is 4.3, so I will take 4 lags as It’s the closest 
integer.
As it is also seen with the function corrgram, the ACF only has 1 lag out of the confidence 
interval and keeps oscillating while it is decaying. That suggests an AR(1) or MA(1). On the 
other hand, the PACF has several spikes and a big one at the end, which suggests the series is 
not random and that an ARMA model should be a used. Furthermore, the ACF is not decaying 
constantly, which means that just an AM model isn’t a good fit. To verify, if we test AR(1), 
MA(1) and ARMA(1,1) models, we appreciate the ARMA (1,1) has the most biggest BIC value in 
absolute terms.

#### d) Explain in words what are the economic implications of the coefficients.
The first coefficient is 0.33, which says if income increases 1% in this period, consumption only 
increases 0.33% this period.
Then, if income increases 1% this period, consumption only increases 0.23% in the next period. 
It can also be seen backwards. An increase on income of 1% one period ago increases
consumption on 0.23 % this period.
The coefficient for 2 lags is 0.71, which means that an increase on income of 1% two period 
ago, increases consumption on 0.71% this period. But we can think about this effect as 0 as it’s 
not statistically significant.
The coefficient for 3 lags is 0.1, which means that an increase on income of 1% three periods
ago, increases consumption on 0.1% this period. 
We see consumption is affected by income, but not just contemporaneously. What people 
earns today, it will affect the consumption today, and even more the one in next periods.

#### (e) Calculate the long run marginal effect of log income on log consumption. Test the hypothesis that this is equal 1.
The long run marginal effect are the cumulative dynamic multipliers. The cumulative dynamic 
multipliers are the sum of the dynamic multipliers in a regression. In order to calculate them, 
we need a distributed lag model. We used 4 lags as It seems convenient after looking at the 
correlation functions.
Ct = ρ0 Yt + ρ1Yt-1 + ρ2Yt-2 + ρ3Yt-3 + ρ4Yt-4 + ε
Let’s test the null hypothesis that the sum of the dynamic multipliers, which are the 
coefficients, equal to 1. In this case, the sum of the multipliers is 1.03 which it’s mostly 1. Then 
we cannot reject that null hypothesis it’s true.
H0 : Unit root/Non-stationarity , H1 : Stationarity H0 : ρ1 + ρ2 + ρ3 + ρ4= 1

#### (f) In your opinion, does the model meet the requirements of the DL model in term of the exogeneity of the regressors?
There’s no exogeneity as I believe there’s simultaneity bias between consumption 
expenditure and income. Both variables influence each other. Following economic intuition, it 
is true that if people have higher income, they will be able to consume more. But on the other 
hand, if consumption increases, firms will obtain more profits and that might produce an 
increase on salaries of workers, which means a shift in income.

### 2.Purchasing Power Parity (PPP)

#### (a) Assess the stationarity of the time series and their order of integration.
First, we look at the graphs of the series, and we see all of them have a trend. I expect there’s 
non-stationarity. Let’s do an augmented dickey fuller test whose null hypothesis is there’s unit 
root, or in other words, non-stationarity.
H0 : Sum of coefficients = 1 (unit root) , H1 : Sum of coefficients < 1
The US CPI has a t statistic bigger in absolute terms than every critical value, can reject the null 
hypothesis that there’s non-stationarity at the 1% Confidence level. H0 : yt ∼ I(1) H1 : yt ∼ I(0)
We see that both the exchange rate and UK CPI have t statistics that are between the critical 
values, so we cannot reject the null hypothesis that there’s non-stationarity at 1% confidence 
level. We could actually reject the null hypothesis that there’s stationarity in the UK CPI at 5% 
level.
But if we make a dickey fuller test of the first difference of the exchange rate and UK CPI, the t 
statistics are much bigger in absolute terms than all critical values, thus, we can reject the 
hypothesis that they are non-stationary at the 1% Confidence level. Overall, We find then that 
exchange rate and UK CPI are I(1) and US CPI is I(0).

#### (b) Explain how PPP implies that the 3 variables are cointegrated.
The PPP states that the inflation of two countries have a direct relationship with the future 
exchange rate between the currencies of both countries.
It has generally the next formula → S1 = S0(1+ UK CPI/1+ US CPI), where S1 and S0 are the 
estimated future and current exchange rate respectively between the pound and the American 
dollar. 
Cointegration technically means a linear combination of I(1) variables that becomes I(0). We 
say that the PPP variables are cointegrated as the deviation of one variable and the change in 
another one cancel each-other out, meaning that there’s usually an equilibrium in the 
relationship between both currencies and exchange rate, and if there’s not, variables will 
return to the equilibrium in the long term. Shocks to variables may persist forever but 
deviations from equilibrium don’t.
For example, if UK CPI increases more than US CPI, I will have less purchasing power if I 
transfer my dollars to pounds. But that’s not true because if we attend to the PPP formula, an 
increase of UK CPI over US CPI means a higher exchange rate in the next period, so my dollars 
would appreciate over the pound, meaning that my purchasing power would be approximately 
the same as before.

#### (c) Test whether they are, in fact, cointegrated.
If we think there is an equilibrium relationship, the deviations from the equilibrium should be 
modelled by the residuals in the regression. First, let’s do a VAR of the variables to get 
residuals.
Then, I will do an ADF test where the null hypothesis is that residuals are I(1), or not 
cointegrated:
H0 : ε t ∼ I(1) , H1 : ε t ∼ I(0)
It’s a test of no cointegration. I add the notrend command as there’s no trend in residuals, and 
they seem stationary. We use 2 lags as It seems appropriate after looking at BIC.
It is true that the critical values are not actually the real ones, as residuals are not data. It’s not 
something we could directly observe from the past as it comes from a previous statistical 
procedure. We can use special critical values, but anyway it shouldn’t be a problem as the t 
statistic is much bigger in absolute terms than the critical values at every significance level. We 
can reject the null hypothesis that residuals are not cointegrated at 1% confidence level. Then, 
we can say residuals are stationary at 1% confidence level, thus we expect the 3 variables are 
cointegrated as there’s an equilibrium relationship.

#### (d) Regardless of the result of part c, estimate an error-correction model. Interpret the coefficients.
An ECM estimates how much a variable is “corrected” after it deviates, as the residual
measures the deviations of such variable. I estimate 3 different regressions to see the ECM for 
each variable. Let’s interpret one of them:
d.e = d. et-1 + d.CPI_USt-1 + d.CPI_UKt-1 + d. et-2 + d.CPI_USt-2 + d.CPI_UKt-2 + Ut-1 
In this case, if exchanges rates deviates 1% in a positive direction, they will go down a 0.96 %.
We say the deviation is corrected, which is what I expected.

#### (e) There is a weaker form of PPP which states that inflation in both countries and the change in the exchange rate have an equilibrium relationship. Test for the presence of this equilibrium relationship.
Inflation means the change of prices from one period to another. As previously, I do a VAR but 
now with the difference of the 3 variables to obtain residuals.
Then, to test for cointegration, l do an ADF test where the null hypothesis is that residuals are 
I(1), or not cointegrated. So, it’s a test of no cointegration. H0 : εt ∼ I(1) , H1 : ε t ∼ I(0)
I add the notrend command as there’s no trend in residuals, and they seem stationary. We use 
in this case 1 lag as It seems appropriate after looking at BIC.
The t statistic is much bigger in absolute terms than the critical values at every significance 
level. No matter if those critical values are the real ones, the difference between them and the 
test statistic is huge. So, we can reject the null hypothesis that residuals are not cointegrated 
at 1% confidence level. Then, we can say residuals are stationary with 99% confidence, thus 
inflation in both countries and the change in the exchange rate have probably an equilibrium 
relationship.

#### (f) Estimate the resulting error correction model that would hold in the presence of weak PPP. Interpret the coefficients.
We measure the equilibrium relationship between the difference of the variables of the PPP.
So, in order to measure the ECM, we have to make regressions with the difference on the 
difference of the 3 original variables and the 1 lag error term.
d.change_e = d.change_et-1 + d.infl_UKt-1 + d.infl_USt-1 + Ut-1 
If a change in exchange rate deviates 1%, then it will be corrected by declining 1.04%. It makes 
sense as exchange rates tends to be in equilibrium most of the time.
d.inflation_UK = d.change_et-1 + d.infl_UKt-1 + d.infl_USt-1 + Ut-1 
If a change in UK inflation deviates 1%, then it will be corrected by declining 0.96%. 
d.inflation_US = d.change_et-1 + d.infl_UKt-1 + d.infl_USt-1 + Ut-1 
If a change in US inflation deviates 1%, then it will be corrected by declining 0.52%. Deviations 
in inflation produce a greater correction in UK than U.S.

````
___


### References

"Time Series Analysis: Forecasting and Control", 5th Edition, George E. P. Box, Gwilym M. Jenkins, Gregory C. Reinsel, Greta M. Ljung

