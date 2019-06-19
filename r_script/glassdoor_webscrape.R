#############################################
#   Scraping glassdoor company reviews      #
#############################################

# Load necessary packages
library(rvest)
library(tidyverse)
library(xml2)

# Save the glassdoor url that contains all of the company urls
url <- "https://www.glassdoor.com/sitedirectory/company-jobs.htm"

# Scrape the urls for all of the industries
industry_url <- url %>%
  xml2::read_html() %>%
  rvest::html_nodes("div.col-12.col-sm-6 a") %>%
  rvest::html_attr("href") %>%
  paste0("https://www.glassdoor.com", .)


test <- industry_url[1] %>%
  xml2::read_html() %>%
  rvest::html_nodes("div.row a.padBot") %>%
  rvest::html_attr("href") %>%
  matrix(., ncol = 4, byrow = TRUE)

# Create a list of 96 matrices that contain the urls for each company's 
# Reviews, Salaries, Benefits, and Interviews
company_url <- purrr::map(industry_url, function(x) {
  xml2::read_html(x) %>%
    rvest::html_nodes("div.row a.padBot") %>%
    rvest::html_attr("href") %>%
    paste0("https://www.glassdoor.com", .) %>%
    matrix(., ncol = 4, byrow = TRUE)
})
