# Setting up the environment
install.packages("tidyverse")
library(tidyverse)
library(scales)



# Read & combine all CSV files in the "Data" folder inside the working directory
df_ori <- list.files(path = "./Data", pattern = "*.csv", full.names = TRUE) %>%
  lapply(read_csv) %>%
  bind_rows()


# Getting an idea of the data
summary(df)
colnames(df)
colSums(is.na(df)) #how many NA values in each columns
unique(df$rideable_type) #seeing unique values
unique(df$member_casual)

# cleaning data
df <- filter(df_ori, started_at<ended_at) #discarding rides that start AFTER end time

#creating a sample of 100000
#df <- sample_n(df_pop, 200000)

# Calculating the weekday of start date
df$started_at_weekday <- wday(df$started_at, label = TRUE, abbr = FALSE, week_start = 1)

# Calculating the total ride time (ride_len)
df$ride_len <- difftime(df$ended_at, df$started_at, units = "secs")


# write the clean data to a CSV for Tableau
#write_csv(df, "2023_Cyclistic_Cleaned.csv")


# Total rides per weekday for each rider type
df %>% 
  ggplot() +
  geom_bar(aes(started_at_weekday, fill = member_casual))+
  facet_wrap(~member_casual)+
  scale_y_continuous(labels = unit_format(unit = "K", scale = 1e-3))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  labs(x = "Weekday", y = "Count of Rides", fill = "User Type")

# Histogram of ride length (logarithmic scale)
df %>%
  filter(ride_len < 10000 & ride_len > 60) %>% # Filtering out extremes
  ggplot() +
  geom_histogram(aes(x=as.numeric(ride_len)), bins = 50, fill = "#00aa8855", color = "#00aa88")+
  facet_wrap(~member_casual)+
  scale_y_continuous(labels = unit_format(unit = "K", scale = 1e-3))+
  scale_x_log10(labels = unit_format(unit = "min", scale = 1/60), n.breaks = 15)+
  theme(axis.text.x = element_text(angle = -90, hjust = 1, vjust = 0.5))+
  labs(x = "Ride Length", y = "Count of Rides")

# Calculate proportion of membership
member_percent <- df %>% 
  group_by(member_casual) %>%
  summarise(count = n()) %>% 
  mutate(per = 100*count/sum(count))

print(member_percent)
