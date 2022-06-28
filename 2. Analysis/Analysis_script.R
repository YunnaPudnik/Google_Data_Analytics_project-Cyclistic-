library(readr)
library(tidyverse)
library(dplyr)
library(lubridate)
library(skimr)
library(janitor)
library(scales)

# Combine all 12 data frames into one
  
df6 <- read.csv("C:/12_months_of_Cyclistic_trip_data/CSV/202106-divvy-tripdata.csv")
df7 <- read.csv("C:/12_months_of_Cyclistic_trip_data/CSV/202107-divvy-tripdata.csv")
df8 <- read.csv("C:/12_months_of_Cyclistic_trip_data/CSV/202108-divvy-tripdata.csv")
df9 <- read.csv("C:/12_months_of_Cyclistic_trip_data/CSV/202109-divvy-tripdata.csv")
df10 <- read.csv("C:/12_months_of_Cyclistic_trip_data/CSV/202110-divvy-tripdata.csv")
df11 <- read.csv("C:/12_months_of_Cyclistic_trip_data/CSV/202111-divvy-tripdata.csv")
df12 <- read.csv("C:/12_months_of_Cyclistic_trip_data/CSV/202112-divvy-tripdata.csv")
df1 <- read.csv("C:/12_months_of_Cyclistic_trip_data/CSV/202201-divvy-tripdata.csv")
df2 <- read.csv("C:/12_months_of_Cyclistic_trip_data/CSV/202202-divvy-tripdata.csv")
df3 <- read.csv("C:/12_months_of_Cyclistic_trip_data/CSV/202203-divvy-tripdata.csv")
df4 <- read.csv("C:/12_months_of_Cyclistic_trip_data/CSV/202204-divvy-tripdata.csv")
df5 <- read.csv("C:/12_months_of_Cyclistic_trip_data/CSV/202205-divvy-tripdata.csv")

bike_rides <- rbind(df1, df2, df3, df4, df5, df6, df7, df8, df9, df10, df11, df12)
View(bike_rides)

bike_rides <- janitor::remove_empty(bike_rides, which = c("rows", "cols"))
dim(bike_rides)

# Convert Date/Time into Time/Date stamp
  
bike_rides$started_at <- lubridate::ymd_hms(bike_rides$started_at)
bike_rides$ended_at <- lubridate::ymd_hms(bike_rides$ended_at)

# Create "hour" field
bike_rides$start_hour <- lubridate::hour(bike_rides$started_at)
bike_rides$end_hour <- lubridate::hour(bike_rides$ended_at)

#Add column “ride_length" and calculate the length of each ride
  
bike_rides$ride_length <- (bike_rides$ended_at - bike_rides$started_at)

#Convert seconds into minutes

bike_rides$ride_length <- difftime(bike_rides$ended_at, bike_rides$started_at, units = c("mins"))

# Add new columns to provide wider data
  
bike_rides$date <- as.Date(bike_rides$started_at) 
bike_rides$year <- format(as.Date(bike_rides$date), "%Y") 
bike_rides$month <- format(as.Date(bike_rides$date), "%m") 
bike_rides$day <- format(as.Date(bike_rides$date), "%d")
bike_rides$day_of_week <- wday(bike_rides$started_at)

# Errors check up
bike_rides %>% filter(ride_length <= 0)

# Delete 92 rows with negative values
bike_rides <- bike_rides[bike_rides$ride_length > 0, ]

# Clean column names and check for duplicate

bike_rides %>%    
  clean_names() %>%    
  unique()

# Export cleaned df to a new csv 
write_csv(bike_rides,"C:/12_months_of_Cyclistic_trip_data/2021-2022_divvy-tripdata_cleaned.csv")

# Descriptive analysis on ride_length (all figures in minutes and seconds)

summary(bike_rides$ride_length)

# Compare members and casual users
aggregate(bike_rides$ride_length ~ bike_rides$member_casual, FUN = mean)
aggregate(bike_rides$ride_length ~ bike_rides$member_casual, FUN = median)
aggregate(bike_rides$ride_length ~ bike_rides$member_casual, FUN = max)
aggregate(bike_rides$ride_length ~ bike_rides$member_casual, FUN = min)

# See the average ride time by each day for members vs casual users
aggregate(bike_rides$ride_length ~ bike_rides$member_casual + bike_rides$day_of_week, , FUN = mean)

# Sort days of the week
bike_rides$day_of_week <- weekdays(bike_rides$started_at)  

# Analyze ridership data by type and weekday
bike_rides %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%  
  group_by(member_casual, weekday) %>%  
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>%    
  arrange(member_casual, weekday)

# Visualize the number of rides by rider type

bike_rides %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%  
  group_by(member_casual, weekday) %>%  
  summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>%    
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") +
scale_y_continuous(labels = comma)

# Visualize average duration of ride by rider type

bike_rides %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%  
  group_by(member_casual, weekday) %>%  
  summarise(number_of_rides = n(),average_duration = mean(ride_length)) %>%    
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge")+
  scale_y_continuous(labels = comma)

#Export some data for analysis

# Total and Average number of weekly rides by rider type
summary_wd <- bike_rides %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%  
  group_by(member_casual, weekday) %>%  
  summarise(number_of_rides = n(),
  average_duration = mean(ride_length)) %>%    
  arrange(member_casual, weekday)
write_csv(summary_wd, "C:/12_months_of_Cyclistic_trip_data/summary_ride_length_weekday.csv")


# Total and Average number of monthly rides by rider type

summary_month <- bike_rides %>% 
  mutate(month = month(started_at, label = TRUE)) %>%  
  group_by(member_casual, month) %>%  
  summarise(number_of_rides = n(),
  average_duration = mean(ride_length)) %>%    
  arrange(month, member_casual)
write_csv(summary_month,"C:/12_months_of_Cyclistic_trip_data/summary_ride_length_month.csv")

# Stations most used by each user group

summary_station <- bike_rides %>% 
  mutate(station = start_station_name) %>%
  drop_na(start_station_name) %>% 
  group_by(start_station_name, member_casual) %>%  
  summarise(number_of_rides = n()) %>%    
  arrange(number_of_rides)
write_csv(summary_station, "C:/12_months_of_Cyclistic_trip_data/summary_stations.csv")

