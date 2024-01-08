# 2023 Cyclistic Case Study

This is the case study of Cyclistic for 2023 that was done as part of Google’s Data Analytics Certificate course.
## Links
1. The data was downloaded from here: [Data Source](https://divvy-tripdata.s3.amazonaws.com/index.html)
2. All the raw R programming code can be found in this repository. [Raw R Code](https://github.com/mangonerd/2023-cyclistic-case/blob/main/raw_r_code.R)
3. The Tableau dashboard can be found here: [Tableau Dashboard](https://public.tableau.com/shared/J554PR5P6) (Unfortunately, github does not allow directly embedding the dashboard)

## Table of Contents

1.  [Introduction](#introduction)
    1. [Setting up environment and importing data](#setting-up-environment-and-importing-data)
    2. [Exploring the Data](#exploring-the-data)



## Introduction
### Summary
The case is about a ride sharing company that is focused on bicycles. They are trying to convert their casual riders into registered members in order to increase revenue.
We can see from analyzing the data that **Members** are mainly using the service to commute, showing peak usage around 9AM and 5PM. While **Casual** users to a limited extent uses the service to commute, but the majority of them use the service during weekends around afternoons for leiserly rides along the coast. My recommendation are therefore as follows:
1. Come up with compelling offers and ads to show casual users the benefits of becoming a member.
2. Target the casual users during weekend around the peak time to encourage them to use Cyclistic for commuting.
3. Target the casual users during workdays around the commuting times to encourage becoming members.

Further studies can be done in the following areas:
1. Tracking user IDs to find behavior patterns.
2. Monitoring the effects of advertisements and making changes accordingly.

### Setting up environment and importing data
The packages used are: `tidyverse`, and `scales`. Specifically `dplyr`, `ggplot2`, and `readr` was used from `tidyverse`. 
Firstly, I downloaded the data (inside a subfolder named Data in the working directory) and imported it into Rstudio using the following code:
```{r import files}
df_ori <- list.files(path = "./Data", pattern = "*.csv", full.names = TRUE) %>%
  lapply(read_csv) %>%
  bind_rows()
```
This code automatically scans for all `.csv` files within the Data folder and combines them into a dataframe named `df_ori`.

### Exploring the data
Now to get an idea about the data, we can use various functions:
``` {r getting an idea of the data}
summary(df)
colnames(df)
colSums(is.na(df)) #how many NA values in each columns
unique(df$rideable_type) #seeing unique values
unique(df$member_casual)
```
Interestingly through my exploration, I found some observations where ride **Start Time** was greater than **End Time**, which basically means the ride ended even before it started. (😆)
The case study is only about human users. So, these miraculous riders had to go.
```
df_pop <- filter(df_ori, started_at<ended_at)
```

At this point, I created a sample 


Here is a histogram of the ride length. The scale is in log10, and the data was filtered to discard outliers.

![Ride Length](plots/ride_length.png)
<details>
  <summary>Click to see code</summary>
  
```{r generating histogram of ride length}
 df %>%
  filter(ride_len < 10000 & ride_len > 60) %>% # Filtering out extremes
  ggplot() +
  geom_histogram(aes(x=as.numeric(ride_len)), bins = 50, fill = "#00aa8855", color = "#00aa88")+
  facet_wrap(~member_casual)+
  scale_y_continuous(labels = unit_format(unit = "K", scale = 1e-3))+
  scale_x_log10(labels = unit_format(unit = "min", scale = 1/60), n.breaks = 15)+
  theme(axis.text.x = element_text(angle = -90, hjust = 1, vjust = 0.5))+
  labs(x = "Ride Length", y = "Count of Rides")
```
</details>

As we can see from the histogram, the ride length is more or less the same among the users, albeit the 




