####################################################################################################
# csv file
######################################################################################################
data1 <- read.csv("data1.csv", header = TRUE)
head(data1)
View(data1)
write.csv(data1, file = "redata1.csv", quote = FALSE, row.names = FALSE)


data2 <- read.table("data1.csv", header = TRUE, sep = ",")
head(data2)
write.table(data2, file = "redata2.csv", quote = FALSE, row.names = FALSE, sep = ",")

#######################################################################################################
# JSON file
#######################################################################################################
##install.packages("jsonlite")
library(jsonlite)

example.json <- ' 
                 {
                   "thebeatles": { 
                       "formed": 1960,    
                       "members": [
                          {"firstname": "George", 
                            "lastname": "Harrison"
                          },      
                          {
                            "firstname": "Ringo",  
                            "lastname": "Starr"   
                          },      
                          {
                            "firstname": "Paul",   
                            "lastname": "McCartney"
                          },
                          {
                            "firstname": "John",   
                            "lastname": "Lennon"
                          }
                        ]
                      }
                   }'

the_beatles <- fromJSON(example.json)  # read in the string
the_beatles
names(the_beatles)
names(the_beatles$thebeatles)
the_beatles$thebeatles$formed
the_beatles$thebeatles$members

jsonIris <- toJSON(iris[1:3,], pretty = TRUE)
jsonIris
fromJSON(jsonIris)

write(jsonIris, file = "iris.json")  # write json data to a file
fromJSON("iris.json")                # read json data from a file

###########################################################################################################
## XML file
###########################################################################################################
example_xml1 <- ' <the_beatles>  
                     <formed>1960</formed>  
                       <members>    
                        <member>
                          <first_name>George</first_name>
                          <last_name>Harrison</last_name>
                         </member>
                        <member>
                          <first_name>Ringo</first_name>
                          <last_name>Starr</last_name>
                         </member>                        
                        <member>
                          <first_name>Paul</first_name>
                          <last_name>McCartney</last_name>
                         </member> 
                        <member>
                          <first_name>John</first_name>
                          <last_name>Lennon</last_name>
                         </member>  
                         </members> 
                      </the_beatles>' 

library(XML) 
the_beatles <- xmlTreeParse(example_xml1)
print(names(the_beatles))

print(the_beatles$doc)
print(xmlValue(the_beatles$doc$children$the_beatles[["formed"]]))
root <- xmlRoot(the_beatles) 
sapply(xmlChildren(root[["members"]]), function(x){    
                                        xmlValue(x[["first_name"]]) 
  })


all_first_names <- "//member/first_name" 
the_beatles <- xmlParse(example_xml1) 
getNodeSet(the_beatles, all_first_names)


getNodeSet(the_beatles, "//first_name")
getNodeSet(the_beatles, "/the_beatles/members/member/first_name") 
sapply(getNodeSet(the_beatles, all_first_names), xmlValue)


## another example of xml
example_xml2 <- '<the_beatles formed="1990">  
                          <members>    
                            <member first_name="George" last_name="Harrison"/>    
                            <member first_name="Richard" last_name="Starkey"/>    
                            <member first_name="Paul" last_name="McCartney"/>    
                            <member first_name="John" last_name="Lennon"/>  
                          </members> 
                      </the_beatles>' 

sapply(getNodeSet(the_beatles, "//member[@first_name]"),  
       function(x){ xmlAttrs(x)[["first_name"]] })


#########################################################################################################
# Reading data from web
#########################################################################################################
browseURL("http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data")
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data"
read.table(url, nrows=5, header = FALSE, sep = ",")


###########################################################################################################
# Reading data using API
###########################################################################################################


URLencode("The Beatles")

create_artist_query_url_lfm <- function(artist_name){ 
  prefix <- "http://ws.audioscrobbler.com/2.0/?method=artist.gettoptags&artist="  
  postfix <- "&api_key=c2e57923a25c03f3d8b317b3c8622b43&format=json"  
  encoded_artist <- URLencode(artist_name)  
  return(paste0(prefix, encoded_artist, postfix)) 
}

create_artist_query_url_lfm("Depeche Mode") 
fromJSON(create_artist_query_url_lfm("Depeche Mode"))

get_tag_vector_lfm <- function(an_artist){  
  artist_url <- create_artist_query_url_lfm(an_artist)  
  json <- fromJSON(artist_url)  
  return(json$toptags$tag$name) 
}

get_tag_vector_lfm("Depeche Mode")

our_artists <- list("Kate Bush", "Peter Tosh", "Radiohead", 
                    "The Smiths", "The Cure", "Black Uhuru") 

our_artists_tags <- lapply(our_artists, get_tag_vector_lfm) 
names(our_artists_tags) <- our_artists
print(our_artists_tags)


