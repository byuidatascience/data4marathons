#'
#' @title Table of Information about Marathons
#' @description An interesting data set to see the effects of goals on what should be a unimodal distrubtion of finish times. The NYT had a good article - https://www.nytimes.com/2014/04/23/upshot/what-good-marathons-and-bad-investments-have-in-common.html?rref=upshot&_r=1
#' @format A data frame with columns:
#' \describe{
#'  \item{year}{The variable is integer. The year of the marathon}
#'  \item{marathon}{The variable is character. The name of the marathon}
#'  \item{country}{The variable is character. The country where the marathon was held}
#'  \item{finishers}{The variable is integer. The number of finishers at the marathon}
#'  \item{mean_time}{The variable is numeric. The average finish time in minutes.}
#' }
#' @source \url{https://faculty.chicagobooth.edu/george.wu/research/marathon/marathon_names.htm}
#' @examples
#' \dontrun{
#' race_info
#'}
'race_info'



#'
#' @title A resampled set of runners from all marathons with more 50 runners.
#' @description Each marathon will have 100 runners (50 male, 50 female) per year. So any marathon with less than 50 runners in the group will have multiple resampled runners. This data set has over 500k runners. The original data had close to 10 million runners and a few more columns. The NYT had a good article - https://www.nytimes.com/2014/04/23/upshot/what-good-marathons-and-bad-investments-have-in-common.html?rref=upshot&_r=1
#' @format A data frame with columns:
#' \describe{
#'  \item{age}{The variable is numeric. The age of the runner}
#'  \item{gender}{The variable is character. The gender of the runner (M/F)}
#'  \item{chiptime}{The variable is numeric. The time in minutes for the runner}
#'  \item{year}{The variable is integer. The year of the marathon}
#'  \item{marathon}{The variable is character. The name of the marathon}
#'  \item{country}{The variable is character. The country where the marathon was held}
#'  \item{finishers}{The variable is integer. The number of finishers at the marathon}
#' }
#' @source \url{http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm}
#' @examples
#' \dontrun{
#' marathon_sample
#'}
'marathon_sample'



#'
#' @title A random sample of 50% of males and females for each year of runners for all years of the New York City marathon where gender is recorded.
#' @description This data set has just over 200k runners. The NYT had a good article - https://www.nytimes.com/2014/04/23/upshot/what-good-marathons-and-bad-investments-have-in-common.html?rref=upshot&_r=1. The NYC marathon website - https://www.nyrr.org/tcsnycmarathon
#' @format A data frame with columns:
#' \describe{
#'  \item{age}{The variable is numeric. The age of the runner}
#'  \item{gender}{The variable is character. The gender of the runner (M/F)}
#'  \item{chiptime}{The variable is numeric. The time in minutes for the runner}
#'  \item{year}{The variable is numeric. The year of the marathon}
#'  \item{marathon}{The variable is character. The name of the marathon}
#'  \item{country}{The variable is character. The country where the marathon was held}
#'  \item{finishers}{The variable is numeric. The number of finishers at the marathon}
#' }
#' @source \url{http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm}
#' @examples
#' \dontrun{
#' marathon_nyc
#'}
'marathon_nyc'



#'
#' @title The full set of runners for all races during 2010.
#' @description This data set has 800k runners. The NYT had a good article - https://www.nytimes.com/2014/04/23/upshot/what-good-marathons-and-bad-investments-have-in-common.html?rref=upshot&_r=1.
#' @format A data frame with columns:
#' \describe{
#'  \item{age}{The variable is numeric. The age of the runner}
#'  \item{gender}{The variable is character. The gender of the runner (M/F)}
#'  \item{chiptime}{The variable is numeric. The time in minutes for the runner}
#'  \item{year}{The variable is numeric. The year of the marathon}
#'  \item{marathon}{The variable is character. The name of the marathon}
#'  \item{country}{The variable is character. The country where the marathon was held}
#'  \item{finishers}{The variable is numeric. The number of finishers at the marathon}
#' }
#' @source \url{http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm}
#' @examples
#' \dontrun{
#' marathon_2010
#'}
'marathon_2010'



#'
#' @title The 50% sample of male/female runners for all years of the Berlin marathon that recorded gender.
#' @description This data set has ~200k observations.  Marathon website - https://www.bmw-berlin-marathon.com/en/
#' @format A data frame with columns:
#' \describe{
#'  \item{age}{The variable is numeric. The age of the runner}
#'  \item{gender}{The variable is character. The gender of the runner (M/F)}
#'  \item{chiptime}{The variable is numeric. The time in minutes for the runner}
#'  \item{year}{The variable is numeric. The year of the marathon}
#'  \item{marathon}{The variable is character. The name of the marathon}
#'  \item{country}{The variable is character. The country where the marathon was held}
#'  \item{finishers}{The variable is numeric. The number of finishers at the marathon}
#' }
#' @source \url{http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm}
#' @examples
#' \dontrun{
#' marathon_berlin
#'}
'marathon_berlin'



#'
#' @title The full set of runners for the Big Sur marathon.
#' @description This data set has ~40k observations.  Marathon website - https://www.bigsurmarathon.org/
#' @format A data frame with columns:
#' \describe{
#'  \item{age}{The variable is numeric. The age of the runner}
#'  \item{gender}{The variable is character. The gender of the runner (M/F)}
#'  \item{chiptime}{The variable is numeric. The time in minutes for the runner}
#'  \item{year}{The variable is numeric. The year of the marathon}
#'  \item{marathon}{The variable is character. The name of the marathon}
#'  \item{country}{The variable is character. The country where the marathon was held}
#'  \item{finishers}{The variable is numeric. The number of finishers at the marathon}
#' }
#' @source \url{http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm}
#' @examples
#' \dontrun{
#' marathon_big_sur
#'}
'marathon_big_sur'



#'
#' @title The full set of runners for the Jerusalem marathon.
#' @description This data set has ~2.5k observations.  Marathon website - https://jerusalem-marathon.com/en/home-page/
#' @format A data frame with columns:
#' \describe{
#'  \item{age}{The variable is numeric. The age of the runner}
#'  \item{gender}{The variable is character. The gender of the runner (M/F)}
#'  \item{chiptime}{The variable is numeric. The time in minutes for the runner}
#'  \item{year}{The variable is numeric. The year of the marathon}
#'  \item{marathon}{The variable is character. The name of the marathon}
#'  \item{country}{The variable is character. The country where the marathon was held}
#'  \item{finishers}{The variable is numeric. The number of finishers at the marathon}
#' }
#' @source \url{http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm}
#' @examples
#' \dontrun{
#' marathon_jerusalem
#'}
'marathon_jerusalem'



#'
#' @title All of the runners for marathons with lat and long locations
#' @description This data set has ~150k observations.
#' @format A data frame with columns:
#' \describe{
#'  \item{age}{The variable is numeric. The age of the runner}
#'  \item{gender}{The variable is character. The gender of the runner (M/F)}
#'  \item{chiptime}{The variable is numeric. The time in minutes for the runner}
#'  \item{year}{The variable is numeric. The year of the marathon}
#'  \item{marathon}{The variable is character. The name of the marathon}
#'  \item{country}{The variable is character. The country where the marathon was held}
#'  \item{finishers}{The variable is numeric. The number of finishers at the marathon}
#' }
#' @source \url{http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm}
#' @examples
#' \dontrun{
#' marathon_location
#'}
'marathon_location'



#'
#' @title 
#' @description This data set has ~2k observations.
#' @format A data frame with columns:
#' \describe{
#'  \item{marathon}{The variable is character. The name of the marathon that matches all other files}
#'  \item{marathon_name}{The variable is character. A cleaned name of the marathon}
#'  \item{state_id}{The variable is character. The two letter ID for each US state}
#'  \item{city}{The variable is character. The name of the city where the race is held}
#'  \item{finishers}{The variable is integer. The number of finishers at the marathon}
#'  \item{mean_time}{The variable is numeric. The average finish time in minutes.}
#'  \item{lat}{The variable is numeric. The lattitude of the city as listed at https://simplemaps.com/data/us-cities}
#'  \item{lng}{The variable is numeric. The longitude of the city as listed at https://simplemaps.com/data/us-cities}
#'  \item{elevation_m}{The variable is numeric. The elevation in meters above sea level as estimated from the elevatr R package.}
#'  \item{date}{The variable is Date. The approximate date of the marathon.  The year is correct but the month and day changes every year and we have marked it the same.}
#'  \item{month}{The variable is numeric. Approximate month of the marathon}
#'  \item{day}{The variable is numeric. Approximate day of the month of the marathon.}
#'  \item{year}{The variable is integer. The year of the marathon}
#' }
#' @source \url{http://faculty.chicagobooth.edu/george.wu/research/marathon/data.htm and https://simplemaps.com/data/us-cities}
#' @examples
#' \dontrun{
#' race_location
#'}
'race_location'



