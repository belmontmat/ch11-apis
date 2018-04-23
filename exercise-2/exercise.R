# Exercise 2: working with data APIs

# load relevant libraries
library(httr)
library(jsonlite)

# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
source("nty_api.R")

# Create a variable `movie.name` that is the name of a movie of your choice.
movie_name <- "Coco"

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie.name` variable as the search query!
base <- "https://api.nytimes.com/svc/movies/v2/"
resource <- "reviews/search.json"
query_p <- list(query = movie_name, api_key = nty_api_key)

# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
response <- GET(paste0(base, resource), query = query_p)
response_body <- content(response, "text")
parsed_body <- fromJSON(response_body)$results
# What kind of data structure did this produce? A data frame? A list?
# data frame

# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.


# Flatten the movie reviews content into a data structure called `reviews`
reviews <- flatten(parsed_body)

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
link <- reviews[1, "link.url"]
headline <- reviews[1,"headline"]
summary <- reviews[1, "summary_short"]

# Create a list of the three pieces of information from above. 
# Print out the list.
list(headline,summary,link)
