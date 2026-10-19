# =====================================================================
# DATA ANALYTICS - MOCK TEST REVISION NOTES (Questions 1-28)
# Run a section with Ctrl+Enter, or the whole file with Ctrl+Shift+Enter
# =====================================================================

# ---- QUICK CHEAT SHEET ---------------------------------------------
# SE of mean ........ sd(x)/sqrt(length(x))        (NOT sd(x)!)
# z-score ........... (x - mean) / sd
# value from z ...... mean + z * sd
# p(X <= q) ......... pnorm(q, mean, sd)    pbinom(q, n, p)   ppois(q, lambda)
# q for a prob ...... qnorm(p, mean, sd)
# t-test ............ t.test(x, mu=, alternative="greater")   one sample
#                     t.test(after, before, paired=TRUE, alternative="greater")
# p < 0.05 ........ reject H0   |   p >= 0.05 ..... fail to reject ("accepted")
# Shapiro-Wilk ...... H0 = data IS normal. p < 0.05 -> normality rejected
# Odds ratio ........ (a/b) / (c/d) ;  Odds = p / (1-p)
# Sensitivity ....... TP / (TP + FN)   (recall)
# Specificity ....... TN / (TN + FP)


# ---- Q1: Standard error of the mean --------------------------------
# Die rolls 1,4,1,2,5,3,6,2,3,3 -> SE = sd / sqrt(n)
x <- c(1, 4, 1, 2, 5, 3, 6, 2, 3, 3)
sd(x) / sqrt(length(x))              # 0.516   <-- ANSWER 0.516
# TRAP: sd(x) = 1.633 is the standard DEVIATION, not the standard error.


# ---- Q2: Paired t-test (mock vs actual marks) ----------------------
# Same students measured twice -> PAIRED. "Improvement" -> one-sided "greater"
mock   <- c(55, 77, 51, 52, 47, 51, 72, 66, 73, 55)
actual <- c(49, 79, 66, 55, 57, 63, 77, 69, 74, 65)
t.test(actual, mock, paired = TRUE, alternative = "greater")
# p-value = 0.011  ->  < 0.05  ->  null hypothesis REJECTED
# ANSWER: 0.011, rejected
# Order matters: actual first, mock second, because H1 = actual > mock.


# ---- Q3: One-sample t-test (heights) -------------------------------
# H0: mean = 1.75   H1: mean > 1.75
h <- c(1.73, 1.77, 1.78, 1.93, 1.82, 1.85, 1.79, 1.77, 1.89, 1.95,
       1.49, 1.87, 1.85, 1.74, 1.92)
t.test(h, mu = 1.75, alternative = "greater")
# p-value = 0.029  ->  < 0.05  ->  REJECTED
# ANSWER: 0.029, rejected


# ---- Q4: Which distribution? ---------------------------------------
# Count of events per time period with a known average rate -> POISSON
# ANSWER: B (Poisson).   Binomial = fixed n trials, yes/no each.
# e.g. P(10 sales in a day) = dpois(10, lambda = 7)


# ---- Q5: Top 10% cut-off of a normal distribution ------------------
# Top 10% => 90th percentile
qnorm(0.90, mean = 53, sd = 9)       # 64.53   <-- ANSWER 64.53
# (equivalent: qnorm(0.10, 53, 9, lower.tail = FALSE))


# ---- Q6: 68-95-99.7 rule -------------------------------------------
# Within 1 sd ~68%, within 2 sd ~95%, within 3 sd ~99.7%
pnorm(1) - pnorm(-1)                 # 0.6827
# ANSWER: FALSE (it is ~68%, not 80%)


# ---- Q7: Why shuffle rows + set.seed() ------------------------------
# set.seed(n)       -> reproducible random numbers   (A)
# shuffle rows      -> removes any ordering bias in the data (D)
# ANSWER: A and D
# NOT B (shuffling doesn't make data normal), NOT C (overfitting is
# avoided by train/test split, cross-validation, simpler models).
# Typical use:
#   set.seed(1)
#   df <- df[sample(nrow(df)), ]


# ---- Q8: Box plot shows --------------------------------------------
# Median (thick line), quartiles/IQR (box), whiskers + outliers
# ANSWER: A (Median) and E (Interquartile range)
# NOT mean, variance, sd, correlation.
boxplot(mtcars$mpg)


# ---- Q9: Most strongly correlated pair in iris ----------------------
cor(iris[, 1:4])
# Petal.Length vs Petal.Width = 0.963 (highest)
# ANSWER: A (Petal.Length) and D (Petal.Width)


# ---- Q10: Odds ratio ------------------------------------------------
# Home: 6 wins, 4 losses -> odds 6/4 ; Away: 4 wins, 6 losses -> odds 4/6
(6 / 4) / (4 / 6)                    # 2.25   <-- ANSWER 2.25


# ---- Q11: Increase the mean of a normal distribution ---------------
# Mean = location (centre).  sd = spread (width).
# ANSWER: A (shifts to the right)


# ---- Q12: Hypothesis testing logic ----------------------------------
# We reject H0 when the result would be UNLIKELY due to chance (small p).
# ANSWER: FALSE


# ---- Q13: Value from a z-score --------------------------------------
11 + 1.7 * 6                        # 21.2   <-- ANSWER 21.2


# ---- Q14: Linear regression  Petal.Length ~ Sepal.Length ------------
model <- lm(Petal.Length ~ Sepal.Length, data = iris)   # y ~ x
coef(model)
# a (intercept) = -7.10 ,  b (slope) = 1.86     <-- ANSWER a=-7.10, b=1.86
# Formula is y ~ x : y (predicted) goes on the LEFT.


# ---- Q15: tapply (mean mpg by cylinders) ----------------------------
tapply(mtcars$mpg, mtcars$cyl, mean)
# 4 cyl = 26.66   <-- ANSWER 26.66   (6 cyl = 19.74, 8 cyl = 15.10)


# ---- Q16: Logical indexing -----------------------------------------
v <- c(2, 5, 9, 1, 7)
v[v > 4]                             # 5 9 7  -> the VALUES that are > 4
# ANSWER: C.   (indexes would be which(v > 4))


# ---- Q17: Matching topics -------------------------------------------
# Exploratory Data Analysis ... Descriptive Analytics
# Hypothesis Testing .......... Inferential Statistics
# Standard Deviation .......... Measures of Variability
# Linear Regression ........... Predictive Analytics
# (Classification is the unused distractor)


# ---- Q18: Grouping similar houses -----------------------------------
# No labels, find groups of similar items -> CLUSTERING (unsupervised)
# ANSWER: D.   Classification needs known labels; regression predicts a number.


# ---- Q19: Coin tossed 3 times, P(less than 2 heads) -----------------
# "Less than 2" = 0 or 1 heads
pbinom(1, size = 3, prob = 0.5)      # 0.5
# ANSWER: TRUE


# ---- Q20: Shapiro-Wilk on airquality$Temp ---------------------------
shapiro.test(airquality$Temp)
# W = 0.9768, p-value = 0.009  ->  < 0.05
# ANSWER: 0.009, rejected   (data is NOT normal)


# ---- Q21: Assumptions of a t-test -----------------------------------
# 1) data (approximately) normally distributed
# 2) homoscedasticity = equal variances
# ANSWER: A and C
# NOT B (t-test is made for SMALL samples), NOT D (p-value is a result).


# ---- Q22: Proportion taller than 1.85 m -----------------------------
# "taller than" = upper tail
pnorm(1.85, mean = 1.70, sd = 0.11, lower.tail = FALSE)   # 0.0863
# ANSWER: 0.086


# ---- Q23: Uses of logistic regression -------------------------------
# Binary classifier (C) and odds ratios from exp(coef(model)) (D)
# ANSWER: C and D.   Predicting a real number = linear regression.
#   glm(y ~ x, data = df, family = binomial)


# ---- Q24: Simulate 100 die rolls ------------------------------------
set.seed(1)                          # MUST be run right before sample()
rolls <- sample(1:6, 100, replace = TRUE)
mean(rolls)                          # 3.52   <-- ANSWER 3.52
# replace = TRUE is essential for dice.


# ---- Q25: z-score ----------------------------------------------------
(-1 - 7) / 5                         # -1.6   <-- ANSWER -1.6


# ---- Q26: Binomial, at most 5 failures out of 1000 -------------------
# "at most 5" = P(X <= 5) -> pbinom (cumulative)
pbinom(5, size = 1000, prob = 0.01)  # 0.0661  <-- ANSWER 0.066
# dbinom = exactly k ; pbinom = k or fewer


# ---- Q27: Skew -------------------------------------------------------
# Most scores high, a few very low = LEFT (negative) skew.
# Low outliers drag the mean down, median stays high -> median > mean.
# ANSWER: TRUE


# ---- Q28: Sensitivity ------------------------------------------------
# Positive class = purchased. 40 actual positives: TP = 20, FN = 20
20 / (20 + 20) * 100                 # 50     <-- ANSWER 50
# (Specificity here = 50 / 60 = 83%)



# =====================================================================
# DATA ANALYTICS - MOCK TEST REVISION NOTES (Questions 1-28)
# Each section: exact QUESTION, then R code, then ANSWER + why.
# Run a section with Ctrl+Enter, or the whole file with Ctrl+Shift+Enter
# =====================================================================

# ---- QUICK CHEAT SHEET ---------------------------------------------
# SE of mean ........ sd(x)/sqrt(length(x))        (NOT sd(x)!)
# z-score ........... (x - mean) / sd
# value from z ...... mean + z * sd
# p(X <= q) ......... pnorm(q, mean, sd)    pbinom(q, n, p)   ppois(q, lambda)
# q for a prob ...... qnorm(p, mean, sd)
# t-test ............ t.test(x, mu=, alternative="greater")   one sample
#                     t.test(after, before, paired=TRUE, alternative="greater")
# p < 0.05 ........ reject H0   |   p >= 0.05 ..... fail to reject ("accepted")
# Shapiro-Wilk ...... H0 = data IS normal. p < 0.05 -> normality rejected
# Odds ratio ........ (a/b) / (c/d) ;  Odds = p / (1-p)
# Sensitivity ....... TP / (TP + FN)   (recall)
# Specificity ....... TN / (TN + FP)


# =====================================================================
# Q1  (2 points)
# QUESTION:
#   Suppose a die is rolled ten times and the results are 1, 4, 1, 2, 5,
#   3, 6, 2, 3, 3. Use relevant functions in R to determine the standard
#   error of the mean and give the answer to 3 decimal places.
# =====================================================================
x <- c(1, 4, 1, 2, 5, 3, 6, 2, 3, 3)
sd(x) / sqrt(length(x))              # 0.516
# ANSWER: 0.516
# TRAP: sd(x) = 1.633 is the standard DEVIATION, not the standard error.


# =====================================================================
# Q2  (2 points)
# QUESTION:
#   A group of students got the following marks in a mock test:
#   55, 77, 51, 52, 47, 51, 72, 66, 73, 55
#   Their corresponding marks in the actual test were:
#   49, 79, 66, 55, 57, 63, 77, 69, 74, 65
#   Using the appropriate t test to determine whether there was an
#   improvement in the marks results in a p-value of [ ____ ] and hence
#   the null hypothesis that the results are not significantly higher
#   than those in the mock test can be [ ____ ].
#   (The answer for the first blank should be given to three decimal
#   places and you should enter "rejected" or "accepted" for the second
#   blank.)
# =====================================================================
mock   <- c(55, 77, 51, 52, 47, 51, 72, 66, 73, 55)
actual <- c(49, 79, 66, 55, 57, 63, 77, 69, 74, 65)
t.test(actual, mock, paired = TRUE, alternative = "greater")
# ANSWER: 0.011 , rejected      (p < 0.05)
# Same students measured twice -> PAIRED. "Improvement" -> one-sided "greater".
# Order matters: actual first, mock second, because H1 = actual > mock.


# =====================================================================
# Q3  (2 points)
# QUESTION:
#   The mean height of a group of men is claimed to be 1.75 m. Here is a
#   sample of observed heights:
#   1.73, 1.77, 1.78, 1.93, 1.82, 1.85, 1.79, 1.77, 1.89, 1.95, 1.49,
#   1.87, 1.85, 1.74, 1.92
#   Consider the null hypothesis that the mean is 1.75 and the
#   alternative hypothesis that the mean is greater than 1.75.
#   When a t test is used, the p-value for the sample heights is [ ____ ]
#   and hence the null hypothesis can be [ ____ ].
#   (The answer for the first blank should be given to three decimal
#   places and you should enter "rejected" or "accepted" for the second
#   blank.)
# =====================================================================
h <- c(1.73, 1.77, 1.78, 1.93, 1.82, 1.85, 1.79, 1.77, 1.89, 1.95,
       1.49, 1.87, 1.85, 1.74, 1.92)
t.test(h, mu = 1.75, alternative = "greater")
# ANSWER: 0.029 , rejected      (p < 0.05)


# =====================================================================
# Q4  (1 point)
# QUESTION:
#   If the number of sales made by an estate agency is 7 per day on
#   average, what distribution would be most suitable for modelling
#   their sales over a period of time?
#     A. Binomial distribution
#     B. Poisson distribution
#     C. Uniform distribution
#     D. Normal distribution
# =====================================================================
# ANSWER: B (Poisson)
# Count of events per time period with a known average rate -> POISSON.
# Binomial = fixed number of trials, yes/no each.
dpois(10, lambda = 7)                # e.g. P(exactly 10 sales in a day)


# =====================================================================
# Q5  (1 point)
# QUESTION:
#   If the test scores of a group of students are normally distributed
#   with a mean of 53 and a standard deviation of 9, what is the minimum
#   score a student must obtain to be in the top 10% of students? Round
#   your answer to 2 decimal places.
# =====================================================================
qnorm(0.90, mean = 53, sd = 9)       # 64.53
# ANSWER: 64.53
# Top 10% => 90th percentile. (Same: qnorm(0.10, 53, 9, lower.tail = FALSE))


# =====================================================================
# Q6  (1 point)
# QUESTION:
#   For a normal distribution, approximately 80% of data lies within 1
#   standard deviation of the mean.
#     True / False
# =====================================================================
pnorm(1) - pnorm(-1)                 # 0.6827
# ANSWER: FALSE
# 68-95-99.7 rule: ~68% within 1 sd, ~95% within 2 sd, ~99.7% within 3 sd.


# =====================================================================
# Q7  (1 point)  -- select more than 1 answer
# QUESTION:
#   In R, why would you randomly reorder the rows in a dataset and set
#   the seed before doing data analytics/machine learning? Select more
#   than 1 answer.
#     A. To ensure that you can reproduce the same results
#     B. To ensure that the data is normally distributed
#     C. To avoid overfitting
#     D. To ensure that there is no bias in the order of cases/rows in
#        the data set
# =====================================================================
# ANSWER: A and D
# set.seed(n)  -> reproducible random numbers (A)
# shuffling    -> removes any ordering bias in the data (D)
# NOT B (shuffling doesn't make data normal)
# NOT C (overfitting is avoided by train/test split, cross-validation,
#        simpler models)
set.seed(1)
# df <- df[sample(nrow(df)), ]       # typical shuffle


# =====================================================================
# Q8  (2 points)  -- select more than 1 answer
# QUESTION:
#   A box plot visualises the (select more than one answer):
#     A. Median
#     B. Variance
#     C. Mean
#     D. Standard deviation
#     E. Interquartile range
#     F. Correlation
# =====================================================================
boxplot(mtcars$mpg)
# ANSWER: A (Median) and E (Interquartile range)
# Thick line = median, box = IQR (Q1 to Q3), whiskers + outlier dots.


# =====================================================================
# Q9  (2 points)  -- select up to 4 options
# QUESTION:
#   In the iris dataset, the two variables that are most strongly
#   correlated are: (Hint: use the cor function.)
#     A. Petal.Length
#     B. Sepal.Width
#     C. Sepal.Length
#     D. Petal.Width
# =====================================================================
cor(iris[, 1:4])
# ANSWER: A (Petal.Length) and D (Petal.Width)   r = 0.963


# =====================================================================
# Q10  (2 points)
# QUESTION:
#   If a football team won 6 of their last 10 home games and won 4 of
#   their last 10 away games, what is the odds ratio for the team
#   winning at home compared to winning away? Give your answer to 2
#   decimal places.
# =====================================================================
(6 / 4) / (4 / 6)                    # 2.25
# ANSWER: 2.25
# Home odds = 6 wins : 4 losses = 6/4.  Away odds = 4 : 6 = 4/6.


# =====================================================================
# Q11  (1 point)
# QUESTION:
#   If the mean of a given normal distribution is INCREASED, the
#   distribution will:
#     A. Shift to the right
#     B. Get narrower
#     C. Get wider
#     D. Shift to the left
# =====================================================================
# ANSWER: A (Shift to the right)
# Mean = location (centre). Standard deviation = spread (width).


# =====================================================================
# Q12  (1 point)
# QUESTION:
#   In hypothesis testing, the idea is to reject the null hypothesis if
#   the result could quite plausibly be due to chance.
#     True / False
# =====================================================================
# ANSWER: FALSE
# We reject H0 when the result would be UNLIKELY due to chance (small p).


# =====================================================================
# Q13  (1 point)
# QUESTION:
#   For a normal distribution with a mean of 11 and a standard deviation
#   of 6, what is the value associated with a z-score of +1.7?
# =====================================================================
11 + 1.7 * 6                         # 21.2
# ANSWER: 21.2


# =====================================================================
# Q14  (2 points)
# QUESTION:
#   Apply linear regression to use the variable Sepal.Length (x) in the
#   iris dataset to predict Petal.Length (y) using the lm function in R.
#   This gives an estimate for y in the form a + bx where the values
#   obtained from this process are a = [ ____ ] and b = [ ____ ].
#   (There is no need to divide the dataset into training and test data
#   for this question. Your answers should be given to 2 decimal places.)
# =====================================================================
model <- lm(Petal.Length ~ Sepal.Length, data = iris)   # y ~ x
coef(model)
# ANSWER: a = -7.10 , b = 1.86
# Formula is y ~ x : the thing being predicted (y) goes on the LEFT.


# =====================================================================
# Q15  (1 point)
# QUESTION:
#   In the mtcars dataset, find the mean miles per gallon (mpg) for cars
#   with 4 cylinders (cyl). State your answer to 2 decimal places.
#   (Hint: use the tapply function.)
# =====================================================================
tapply(mtcars$mpg, mtcars$cyl, mean)
# ANSWER: 26.66     (6 cyl = 19.74, 8 cyl = 15.10)


# =====================================================================
# Q16  (1 point)
# QUESTION:
#   Which one of the following statements best describes the result of
#   the following code in R where v is a numeric vector?
#       x <- v[v > 4]
#     A. x is a vector containing all the elements of v after the 4th index
#     B. x is a vector containing the indexes of all the elements of v
#        that are greater than 4
#     C. x is a vector containing all the elements of v that are greater
#        than 4
#     D. x is true if v contains at least one element greater than 4
# =====================================================================
v <- c(2, 5, 9, 1, 7)
v[v > 4]                             # 5 9 7  (the VALUES)
which(v > 4)                         # 2 3 5  (the INDEXES - this is option B)
# ANSWER: C


# =====================================================================
# Q17  (2 points)  -- matching
# QUESTION:
#   Match each topic to its corresponding area of Data Analytics /
#   Statistics.
#   Prompts:  1 Exploratory Data Analysis
#             2 Hypothesis Testing
#             3 Standard Deviation
#             4 Linear Regression
#   Answers to choose from: Classification, Inferential Statistics,
#             Descriptive Analytics, Measures of Variability,
#             Predictive Analytics
# =====================================================================
# ANSWER:
#   Exploratory Data Analysis .... Descriptive Analytics
#   Hypothesis Testing ........... Inferential Statistics
#   Standard Deviation ........... Measures of Variability
#   Linear Regression ............ Predictive Analytics
#   (Classification is the unused distractor)


# =====================================================================
# Q18  (1 point)
# QUESTION:
#   Suppose you have information about the size, location, number of
#   bedrooms and price of houses. The problem of finding groups of
#   houses that are similar in terms of these features is known as:
#     A. Regression
#     B. Rule mining
#     C. Classification
#     D. Clustering
# =====================================================================
# ANSWER: D (Clustering)
# No labels, finding groups of similar items = clustering (unsupervised).
# Classification needs known labels; regression predicts a number.


# =====================================================================
# Q19  (1 point)
# QUESTION:
#   If a fair coin is tossed three times, the probability of getting
#   less than two heads is 1/2.
#     True / False
# =====================================================================
pbinom(1, size = 3, prob = 0.5)      # 0.5
# ANSWER: TRUE
# "Less than 2" = 0 or 1 heads = 1/8 + 3/8 = 4/8.


# =====================================================================
# Q20  (2 points)
# QUESTION:
#   The Shapiro-Wilk test for the Temp variable in the airquality
#   dataset gives a p-value of [ ____ ] and hence the hypothesis of
#   normality can be [ ____ ].
#   (The answer for the first blank should be given to three decimal
#   places and you should enter "rejected" or "accepted" for the second
#   blank. Note that the airquality dataset is available in R.)
# =====================================================================
shapiro.test(airquality$Temp)
# ANSWER: 0.009 , rejected      (W = 0.9768; p < 0.05 so NOT normal)


# =====================================================================
# Q21  (2 points)  -- select up to 4 options
# QUESTION:
#   What are the two main statistical assumptions made when performing
#   a t-test?
#     A. Data is normally distributed
#     B. Large data sample
#     C. Homoscedasticity
#     D. Low p-value
# =====================================================================
# ANSWER: A and C
# Normality + homoscedasticity (equal variances).
# NOT B (t-test is made for SMALL samples), NOT D (p-value is a result).


# =====================================================================
# Q22  (1 point)
# QUESTION:
#   If the heights of a group of people are normally distributed with a
#   mean of 1.70 m and a standard deviation of 0.11 m, what proportion
#   of the group is taller than 1.85 m? Answer as a decimal rounded to
#   3 decimal places.
# =====================================================================
pnorm(1.85, mean = 1.70, sd = 0.11, lower.tail = FALSE)   # 0.0863
# ANSWER: 0.086
# "taller than" = UPPER tail.


# =====================================================================
# Q23  (1 point)  -- select up to 4 options
# QUESTION:
#   In data analysis, what are the two main uses for using logistic
#   regression?
#     A. Normalisation
#     B. Predicting a real-valued quantity
#     C. Building a binary classifier
#     D. Calculating odds ratios
# =====================================================================
# ANSWER: C and D
# glm(y ~ x, data = df, family = binomial)   ; exp(coef(model)) = odds ratios
# Predicting a real number = linear regression (so NOT B).


# =====================================================================
# Q24  (2 points)
# QUESTION:
#   Use the sample function to simulate rolling a die 100 times and then
#   give the mean result of these rolls to 2 decimal places. Before
#   calling the sample function run the following code:
#       set.seed(1)
# =====================================================================
set.seed(1)                          # MUST be run right before sample()
rolls <- sample(1:6, 100, replace = TRUE)
mean(rolls)                          # 3.52
# ANSWER: 3.52
# replace = TRUE is essential for dice.


# =====================================================================
# Q25  (1 point)
# QUESTION:
#   For a normal distribution with a mean of 7 and a standard deviation
#   of 5, what is the z-score for a observed value of -1?
# =====================================================================
(-1 - 7) / 5                         # -1.6
# ANSWER: -1.6


# =====================================================================
# Q26  (2 points)
# QUESTION:
#   A data centre has 1,000 hard drives, and each has a 1% chance of
#   failing in a given year. What is the probability that at most 5
#   hard drives fail in a year? Give your answer to 3 decimal places and
#   as a probability rather a percentage, e.g. 0.125 rather than 12.5%.
# =====================================================================
pbinom(5, size = 1000, prob = 0.01)  # 0.0661
# ANSWER: 0.066
# "at most 5" = P(X <= 5) -> pbinom (cumulative). dbinom = exactly k.


# =====================================================================
# Q27  (1 point)
# QUESTION:
#   If most of the scores in a test are very high (80-90%) but some are
#   much lower, you would expect the median to be greater than the mean.
#     True / False
# =====================================================================
# ANSWER: TRUE
# Left (negative) skew: low outliers drag the mean down, median stays high.


# =====================================================================
# Q28  (1 point)
# QUESTION:
#   Suppose a machine learning algorithm is used to predict whether an
#   online customer will purchase a product (positive class) or not
#   (negative class). In test cases, 40 people purchased the item and
#   the algorithm got 20 of these right and 20 wrong, while 60 people
#   did not purchase the item and the algorithm got 50 of these cases
#   right and 10 wrong. What is the sensitivity of these results as a
#   percentage (to the nearest whole number)?
# =====================================================================
TP <- 20; FN <- 20; TN <- 50; FP <- 10
TP / (TP + FN) * 100                 # 50
# ANSWER: 50
# Specificity here = TN / (TN + FP) = 50/60 = 83%
