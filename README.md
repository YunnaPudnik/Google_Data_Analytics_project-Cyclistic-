# Google_Data_Analytics_project-Cyclistic
## Data analysis of "Cyclistic bike-share", Capstone study 

This document is created as a part of the capstone project of the Google Data Analytics Professional Certificate.

**Scenario**

Scenario You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.

**About the company**

In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime.

Further analysis is based on six steps of the data analysis process: ask, prepare, process, analyze, share, and act.

# STEP 1: Ask

Three questions will guide the future analizing program: 
1. How do annual members and casual riders use Cyclistic bikes differently? 
2. Why would casual riders buy Cyclistic annual memberships? 
3. How can Cyclistic use digital media to influence casual riders to become members?

Director of marketing has assigned the first question to answer: How do annual members and casual riders use Cyclistic bikes differently?

**Business task:**

To understand the difference of using Cyclistic bikes between annual members and casual riders. The result of the analysis will be used in the marketing department to aim and convert casual riders into members.

**Stakeholders:**

Primary: The director of marketing and Cyclistic executive team

Secondary: Cyclistic marketing analytics team

# STEP 2: Prepare

The data that we will be using is Cyclistic’s historical trip data from the last 12 months (June-2021 to May-2022). The data has been made available by Motivate International Inc.
The dataset includes 12 CSV files (each for a month), each one has 13 columns and about 5M of rows.

**ROCCC method:**
- **R**eliable - the data is complete and accurate, it contains data about all bike rides in Chicago for the recent 12 months.
- **O**riginal - the data has been made available by Motivate International Inc.
- **C**omprehensive - the data contains wide information about rides, including starting and ending time, station ID, membership type, etc.
- **C**urrent - data is up to date.
- **C**ited - the data is cited and is available under Data License Agreement.

**Data Limitations.**
Some data for “start station name and id” and “end station name and id” are missing. Most of the empty cells belong to “electric bike type”, which can slightly influence the outcome of analysis.

# STEP 3: Process

During the process step, I clean data, check on errors and format.

**Tool**: As the dataset is big, R programming is a better choice, then Excel or Google Sheet.

Click [here](https://github.com/YunnaPudnik/Google_Data_Analytics_project-Cyclistic-/blob/main/2.%20Analysis/Analysis_script.R) to view R script.

# STEP 4: Analyze

Some data aggregations are performed in R, and further analysis is done in Google Sheets ([link](https://github.com/YunnaPudnik/Google_Data_Analytics_project-Cyclistic-/tree/main/2.%20Analysis)).

# STEP 5: Share

Google Slides is used to perform the presenattion, which contains main data insights, summary and recommendations for further actions([link](https://github.com/YunnaPudnik/Google_Data_Analytics_project-Cyclistic-/tree/main/03.%20Presentation)).

# STEP 6: Act

Through analysis we concluded:
- Casual riders take less rides, but average ride has longer duration compare to Member riders.
- Casual riders are more active on Weekends.
- The longest rides are taken in March, June and July.
- Casual riders mostly use bikes for entertaining purposes.

**Top 3 recommendations:**

**1.** Set promotion in busiest stations by targeting casual riders.

**Days:** weekends; **Month:** March, June, July; **Stations:** Streeter Dr & Grand Ave, Millennium Park, Michigan Ave & Oak St

**2.** Keep annual membership promotion linked to entertaining activities, weekends content and summer events.

**3.** Design special seasonal packages for Casual riders, which will encourage them to take longer rides and increase revenue.

***Appreciate your time!***
