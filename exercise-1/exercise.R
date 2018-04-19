# Exercise 1: reading and querying a web API

# Load the httr and jsonlite libraries for accessing data
# You can also load `dplyr` if you wish to use it
library(httr)
library(jsonlite)
library(dplyr)

# Create a variable for the API's base URI (https://api.github.com)
base <- "https://api.github.com"

# Under the "Repositories" category of the API, 
# find the endpoint that will list repos in an organization. Then, 
# Create a variable `resource` that stores the endpoint for the "info201"
# organization repos (this is the PATH to the resource of interest).
# (FYI: this is where we keep the book code and master exercise sets!)
resource <- "/orgs/info201/repos"

# Send a GET request to this endpoint (the `base_uri`` followed by `resource`)
info <- GET(paste0(base, resource))

# Extract the "text" of the response usin the `content` function
info_content <- content(info, "text")

# Convert the body from JSON into a data frame
parsed <- fromJSON(info_content)

# How many (public) repositories does the organization have?
nrow(parsed)

##### New query ######

# Use a "Search" endpoint to search for repositories about "graphics"
# (bonus: limit language to only "R" -- which requires a different syntax)
# (hint: https://developer.github.com/v3/search/#search-repositories)
# Reassign the `resource` variable to refer to the appropriate resource.
resource <- "/search/repositories"

# You will need to specify some query parameters. Create a `query_params` list 
# variable that specifies an appropriate key and value for the search term and
# the language
query_p <- list(q = "graphics+language:R")

# Send a GET request to this endpoint--including your params list as the `query`
new_response <- GET(paste0(base, resource), query = query_p)

# Extract the response body and convert it from JSON.
new_response_body <- content(new_response, "text")
nrb_parsed <- fromJSON(new_response_body)$items

# How many search repos did your search find? (Hint: check the list names)
nrow(nrb_parsed)

# What are the full names of the top 5 results?
nrb_parsed[1:5,"full_name"]
