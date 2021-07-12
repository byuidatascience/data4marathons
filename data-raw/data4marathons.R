pacman::p_load(tidyverse, downloader, fs, glue, rvest)
pacman::p_load_current_gh("byuidss/DataPushR")

set.seed(150)

# Good article about the data
# https://www.nytimes.com/2014/04/23/upshot/what-good-marathons-and-bad-investments-have-in-common.html?rref=upshot&_r=1

# Original data source
# http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm
# 
# Marathon details
# https://faculty.chicagobooth.edu/george.wu/research/marathon/marathon_names.htm
# 
# My links
# dat <- read_csv("https://www.dropbox.com/s/wq9e3wqzow500uo/master_marathon.csv?dl=1")
# dat <- read_csv("https://www.dropbox.com/s/dp80lkd1n89gzma/master_marathon_1m.csv?dl=1")
# dat <- read_csv("https://byuistats.github.io/M335/data/runners_100k.csv")

race_locations <- read_csv("data/marathon_locations.csv")

race_info <- read_html("https://faculty.chicagobooth.edu/george.wu/research/marathon/marathon_names.htm") %>%
  html_nodes("table") %>% 
  html_table() %>%
  .[[1]] 

colnames(race_info) <- race_info[1,]

race_info <- race_info[-1,] %>% 
  as_tibble() %>%
  rename_all("str_to_lower") %>%
  mutate(year = as.integer(year), finishers = as.integer(finishers), 
         `mean time` = as.numeric(`mean time`)) %>%
  rename(mean_time = `mean time`)

race_location <- select(race_locations,-finishers, -max_mean, -years) %>%
  left_join(race_info) %>%
  mutate(day = ifelse(month == 2 & day == 29, 28, day),
         date = mdy(str_c(month, "/", day, "/", year))) %>%
  select(marathon, marathon_name = name, state_id, city = city_ascii, finishers, mean_time, lat, lng, elevation_m, date, month, day, year, -marathon_clean )

dat <- read_csv("/Users/hathawayj/odrive/Dropbox/data/master_marathon.csv")

marathon_location <- filter(dat, marathon %in% race_location$marathon) %>%
  group_by(marathon) %>%
  filter(year == max(year)) %>%
  ungroup() %>%
  select(age, gender, chiptime, year, marathon, country, finishers)

dat <- dat %>%
  select(age, gender, chiptime, year, marathon, country, finishers)

marathon_berlin <- dat %>%
  filter(marathon == "Berlin Marathon", !is.na(gender)) %>%
  group_by(year, gender) %>%
  sample_frac(size = .5) %>%
  ungroup()

marathon_jerusalem <- dat %>%
  filter(marathon == "Jerusalem Marathon")

marathon_big_sur <- dat %>%
  filter(marathon == "Big Sur Marathon")

marathon_nyc <- dat %>%
  filter(marathon == "New York City Marathon", !is.na(gender)) %>%
  group_by(year, gender) %>%
  sample_frac(size = .5) %>%
  ungroup()

marathon_sample <- dat %>%
  filter(finishers > 50) %>%
  group_by(marathon, year, gender) %>%
  sample_n(50, replace = TRUE) %>%
  ungroup() %>%
  mutate(finishers = as.integer(finishers), year = as.integer(year))

marathon_2010 <- dat %>%
  filter(year == 2010)


# Need to split the file into small enough files to store on GitHub
#   - Don't store all of these as each file type.
# 
# Create a 
# 
# Create a marathon table
# 

package_name_text <- "data4marathons"
base_folder <- "../../byuidatascience/"
user <- "byuidatascience"
package_path <- str_c(base_folder, package_name_text)

####  Run to create repo locally and on GitHub.  ######
# 
# github_info <- dpr_create_github(user, package_name_text)
# 
#  package_path <- dpr_create_package(list_data = NULL,
#                                     package_name = package_name_text,
#                                     export_folder = base_folder,
#                                     git_remote = github_info$clone_url)

 ##### dpr_delete_github(user, package_name_text) ####
#
####### End create section
####### 

## Base data creation

github_info <- dpr_info_github(user, package_name_text)
usethis::proj_set(package_path)

dpr_export(race_info, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".xlsx", ".json"))

dpr_export(marathon_sample, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv"))

dpr_export(marathon_2010, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

dpr_export(marathon_nyc, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv"))

dpr_export(marathon_berlin, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

dpr_export(marathon_big_sur, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

dpr_export(marathon_jerusalem, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

usethis::use_data(race_info, marathon_sample, marathon_2010,
                  marathon_nyc, marathon_berlin, marathon_big_sur, marathon_jerusalem, overwrite = TRUE)

dpr_push(folder_dir = usethis::proj_get(), message = "'First Push'", repo_url = NULL)

#### Base Data Create at this point  ####

# spatial runs after push above and running 'marathon_spatial.R' script

dpr_export(marathon_location, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

dpr_export(race_location, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

usethis::use_data(marathon_location, race_location)

### Data documentation

runner_details <- list(age = "The age of the runner", 
                       gender = "The gender of the runner (M/F)",
                       chiptime = "The time in minutes for the runner",
                       year = "The year of the marathon",
                       marathon = "The name of the marathon",
                       country = "The country where the marathon was held",
                       finishers = "The number of finishers at the marathon")

dpr_document(race_info, extension = ".R.md", export_folder = usethis::proj_get(),
             object_name = "race_info", title = "Table of Information about Marathons",
             description = "An interesting data set to see the effects of goals on what should be a unimodal distrubtion of finish times. The NYT had a good article - https://www.nytimes.com/2014/04/23/upshot/what-good-marathons-and-bad-investments-have-in-common.html?rref=upshot&_r=1",
             source = "https://faculty.chicagobooth.edu/george.wu/research/marathon/marathon_names.htm",
             var_details = list(year = "The year of the marathon", 
                                marathon = "The name of the marathon",
                                country = "The country where the marathon was held",
                                finishers = "The number of finishers at the marathon",
                                mean_time = "The average finish time in minutes."))


dpr_document(marathon_sample, extension = ".R.md", export_folder = usethis::proj_get(),
             object_name = "marathon_sample", title = "A resampled set of runners from all marathons with more 50 runners.",
             description = "Each marathon will have 100 runners (50 male, 50 female) per year. So any marathon with less than 50 runners in the group will have multiple resampled runners. This data set has over 500k runners. The original data had close to 10 million runners and a few more columns. The NYT had a good article - https://www.nytimes.com/2014/04/23/upshot/what-good-marathons-and-bad-investments-have-in-common.html?rref=upshot&_r=1",
             source = "http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm",
             var_details = runner_details)


dpr_document(marathon_nyc, extension = ".R.md", export_folder = usethis::proj_get(),
             object_name = "marathon_nyc", title = "A random sample of 50% of males and females for each year of runners for all years of the New York City marathon where gender is recorded.",
             description = "This data set has just over 200k runners. The NYT had a good article - https://www.nytimes.com/2014/04/23/upshot/what-good-marathons-and-bad-investments-have-in-common.html?rref=upshot&_r=1. The NYC marathon website - https://www.nyrr.org/tcsnycmarathon",
             source = "http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm",
             var_details = runner_details )

dpr_document(marathon_2010, extension = ".R.md", export_folder = usethis::proj_get(),
             object_name = "marathon_2010", title = "The full set of runners for all races during 2010.",
             description = "This data set has 800k runners. The NYT had a good article - https://www.nytimes.com/2014/04/23/upshot/what-good-marathons-and-bad-investments-have-in-common.html?rref=upshot&_r=1.",
             source = "http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm",
             var_details = runner_details )

dpr_document(marathon_berlin, extension = ".R.md", export_folder = usethis::proj_get(),
             object_name = "marathon_berlin", 
             title = "The 50% sample of male/female runners for all years of the Berlin marathon that recorded gender.",
             description = "This data set has ~200k observations.  Marathon website - https://www.bmw-berlin-marathon.com/en/",
             source = "http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm",
             var_details = runner_details )

dpr_document(marathon_big_sur, extension = ".R.md", export_folder = usethis::proj_get(),
             object_name = "marathon_big_sur", 
             title = "The full set of runners for the Big Sur marathon.",
             description = "This data set has ~40k observations.  Marathon website - https://www.bigsurmarathon.org/",
             source = "http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm",
             var_details = runner_details )

dpr_document(marathon_jerusalem, extension = ".R.md", export_folder = usethis::proj_get(),
             object_name = "marathon_jerusalem", 
             title = "The full set of runners for the Jerusalem marathon.",
             description = "This data set has ~2.5k observations.  Marathon website - https://jerusalem-marathon.com/en/home-page/",
             source = "http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm",
             var_details = runner_details )

## Spatial Documentation

dpr_document(marathon_location, extension = ".R.md", export_folder = usethis::proj_get(),
             object_name = "marathon_location", 
             title = "All of the runners for marathons with lat and long locations",
             description = "This data set has ~150k observations.",
             source = "http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm",
             var_details = runner_details)

dpr_document(race_location, extension = ".R.md", export_folder = usethis::proj_get(),
             object_name = "race_location", 
             title = "",
             description = "This data set has ~2k observations.",
             source = "http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm and https://simplemaps.com/data/us-cities",
             var_details = list(marathon = "The name of the marathon that matches all other files",
                                marathon_name = "A cleaned name of the marathon",
                                state_id = "The two letter ID for each US state",
                                city = "The name of the city where the race is held",
                                finishers = "The number of finishers at the marathon",
                                mean_time = "The average finish time in minutes.",
                                lat = "The lattitude of the city as listed at https://simplemaps.com/data/us-cities",
                                lng = "The longitude of the city as listed at https://simplemaps.com/data/us-cities",
                                elevation_m = "The elevation in meters above sea level as estimated from the elevatr R package.",
                                date = "The approximate date of the marathon.  The year is correct but the month and day changes every year and we have marked it the same.",
                                month = "Approximate month of the marathon", 
                                day = "Approximate day of the month of the marathon.",
                                year = "The year of the marathon"))

##### Finalize and push all work to GitHub

dpr_readme(usethis::proj_get(), package_name_text, user)

dpr_write_script(folder_dir = usethis::proj_get(), r_read = "scripts/marathon_spatial.R", 
                 r_folder_write = "data-raw", r_write = "data4marathons_spatial.R")

dpr_write_script(folder_dir = package_path, r_read = "scripts/marathon_package.R", 
                 r_folder_write = "data-raw", r_write = str_c(package_name_text, ".R"))

devtools::document(package_path)

dpr_push(folder_dir = usethis::proj_get(), message = "'Final Push'", repo_url = NULL)

##############################
#### Now only add data to the raw-data folder that isn't added to the package.

dat_group <- dat %>%
  group_by(marathon)

dat_marathon <- dat_group %>%
  group_split(keep = FALSE)

dat_m_names <- dat_group %>%
  group_keys() %>%
  mutate(file_name = str_c("race_", 1:n(), ".csv"))

fs::dir_create(str_c(package_path, "/data-raw/marathon"))

write_csv(dat_m_names, path = str_c(package_path, "/data-raw/marathon/_key.csv"))

out <- map2(dat_marathon, 1:length(dat_marathon), ~write_csv(.x, path = str_c(package_path, "/data-raw/marathon/race_", .y, ".csv"))) 

dpr_push(folder_dir = package_path, message = "'by_race_year_files_not documented'", repo_url = NULL)


# dat_sample %>%
#   ggplot(aes(x = chiptime)) +
#   geom_histogram(binwidth = 1) +
#   coord_cartesian(xlim = c(120, 450)) +
#   geom_vline(xintercept = c(120, 150, 180, 210, 240, 270, 300, 330))



