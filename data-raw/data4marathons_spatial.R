pacman::p_load(tidyverse, sf, rvest, lubridate, stringdist, elevatr)
pacman::p_load_current_gh("rCarto/photon")

# https://simplemaps.com/data/us-cities.
cities <- read_csv("data/uscities.csv")


dat <- read_csv("https://github.com/byuidatascience/data4marathons/raw/master/data-raw/race_info/race_info.csv") %>%
  filter(year >= 2010, country == "US") %>%
  group_by(marathon) %>%
  summarize(years = n(), finishers = sum(finishers), 
            max_mean = max(mean_time, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(marathon_clean = str_remove_all(marathon, "\n"))

urls <- c("http://www.marathonguide.com/races/races.cfm?Sort=RaceDate&Place=USA&StartDate=01/01/20",
          "http://www.marathonguide.com/races/races.cfm?Sort=RaceDate&Place=USA&StartDate=3/5/20",
          "http://www.marathonguide.com/races/races.cfm?Sort=RaceDate&Place=USA&StartDate=5/7/20",
          "http://www.marathonguide.com/races/races.cfm?Sort=RaceDate&Place=USA&StartDate=7/9/20",
          "http://www.marathonguide.com/races/races.cfm?Sort=RaceDate&Place=USA&StartDate=9/10/20",
          "http://www.marathonguide.com/races/races.cfm?Sort=RaceDate&Place=USA&StartDate=11/12/20",
          "http://www.marathonguide.com/races/races.cfm?Sort=RaceDate&Place=USA&StartDate=1/14/21")

rip_race_location <- function(x){
  print(x)
  dhtml <- read_html(x)
  dhtml %>%
    html_nodes("table") %>% 
    .[[8]] %>%
    html_table(fill = TRUE)
}

list_dat_locs <- urls %>% map(~rip_race_location(.x))


list_clean <- function(dat_locs) {
  
  cnames <- dat_locs[2,] %>% str_to_lower() %>% str_replace_all("/", "_")
  colnames(dat_locs) <- cnames
  
  str_remove_all(dat_locs$name, "- Day [:digit:]{1,2}| Day [:digit:]{1,2}")
  
  rows_remove <- which(str_count(dat_locs$state_province) != 2)
  
  dat_locs %>%
    slice(-rows_remove) %>%
    mutate(date = mdy(date), city_state = str_c(city, ", ", state_province),
           name = str_remove_all(name, "- Day [:digit:]{1,2}| Day [:digit:]{1,2}"),
           full_detail = str_c(name, ", ", city_state)) %>%
    fill(date, .direction = "down") %>%
    group_by(name) %>%
    slice(1) %>%
    ungroup()
  
  
}

# sometimes it doesn't rip clean.  Just rerun the rip.

dat_locs <- map(list_dat_locs, list_clean) %>%
  bind_rows() %>%
  group_by(full_detail) %>%
  slice(1) %>%
  ungroup()


rows_to_match <- dat_locs$city %>% map(~amatch(.x,cities$city_ascii)) %>% unlist()

dat_locs <- bind_cols(dat_locs, cities[rows_to_match, ] %>%
  select(lat, lng, city_ascii, state_id)) %>%
  filter(!is.na(lng))

rows_name_match <- dat$marathon_clean %>% map(~amatch(.x,dat_locs$name, method = "jw")) %>% unlist()



dat_locs <- bind_cols(dat, 
          dat_locs[rows_name_match, c("date", "name", "lat", "lng", "state_id", "city_ascii")]) %>%
  filter(!is.na(lat), !is.na(lng)) %>%
  mutate(month = month(date), day = mday(date)) %>%
  select(-date)


elev_function <- function(x,y) {
  print(str_c(x,"",y))
  data.frame(x = x, y = y) %>%
    get_elev_point(prj = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs", units = "meters", src = "aws", z =1)
}



elevations_df <- map2(dat_locs$lng, dat_locs$lat, ~elev_function(.x, .y)) 

dat_locs <-dat_locs %>%
  mutate(elevation_m = map(elevations_df, as_tibble) %>% map("elevation") %>% unlist())

write_csv(dat_locs, "data/marathon_locations.csv")

# 
# 
# search_gn <- function(x,y) {
#   GNsearch(name = x, admin = y, country = "US") %>%
#     filter(adminCode1 == y, fcodeName == "populated place") %>%
#     slice(1) %>%
#     select(lat, lng, toponymName, adminName1, adminCode1, fcode) %>%
#     mutate(city_x = x, state_y = y)
# }
# 
# search_gn_safe <- purrr::safely(search_gn)
# 
# lat_long <- map2(dat_locs$city, dat_locs$state_province, ~search_gn_safe(.x, .y))
# 
# results <- map(lat_long, 1)
# errors <- map(lat_long, 2) %>% map(is.null) %>% unlist() %>% !.
