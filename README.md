# 2023 Cyclistic Case Study

This is the case study of Cyclistic for 2023 that was done as part of Google’s Data Analytics Certificate course.

The data was downloaded from [here.](https://divvy-tripdata.s3.amazonaws.com/index.html) All the raw R programming code can be found [here.](https://github.com/mangonerd/2023-cyclistic-case/blob/main/raw_r_code.R)

## Table of Contents

1.  [Introduction](#introduction)

## Introduction
### Summary
The case is about a ride sharing company that is focused on bicycles. They are trying to convert their casual riders into registered members in order to increase revenue.
We can see from analyzing the data that **Members** are mainly using the service to commute, showing peak usage around 9AM and 5PM. While **Casual** users to a limited extent uses the service to commute, but the majority of them use the service during weekends around afternoons for leiserly rides along the coast. My recommendation are therefore as follows:
1. Come up with compelling offers and ads to show casual users the benefits of becoming a member.
2. Target the casual users during weekend around the peak time to encourage them to use Cyclistic for commuting.
3. Target the casual users during workdays around the commuting times to encourage becoming members.

Further studies can be done in the following areas:
1. Tracking user IDs to find behavior patterns
2. Monitoring the effects of 

### Setting up environment and importing data
The packages used are: `tidyverse`, and `scales`. Specifically `dplyr`, `ggplot2`, and `readr` was used from `tidyverse`. 
Firstly, I downloaded the data (inside a subfolder named Data in the working directory) and imported it into Rstudio using the following code:
```{r import files}
df_ori <- list.files(path = "./Data", pattern = "*.csv", full.names = TRUE) %>%
  lapply(read_csv) %>%
  bind_rows()
```
This code automatically scans for all `.csv` files within the Data folder and combines them into a dataframe named `df_ori`.
Now to get an idea about the data, we can use various functions:
``` {r getting an idea of the data}
summary(df)
colnames(df)
colSums(is.na(df)) #how many NA values in each columns
unique(df$rideable_type) #seeing unique values
unique(df$member_casual)
```

