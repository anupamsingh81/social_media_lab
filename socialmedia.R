library(SocialMediaLab)
library(dplyr)
library(igraph)
api_key = 'qjrxTtjGWzf2WewvRgrBmRqcC'
api_secret = 'EyHZAcmFUNwBVHMgpkfTQ18W0npSqjNPj8qU1uZ7MH4Ar5E7xb'
access_token = "56173323-ViSSDypCPtlnKgzZUqLQuVOv1al8zBkD46teok9w8"
access_token_secret = "XRFDZzA4jpUXHaRiyDFxtA0utP1LBmKvpalFxNKKD2QiS"


myTwitterData <-
  Authenticate("twitter", apiKey=api_key,
  apiSecret=api_secret,
  accessToken=access_token,
  accessTokenSecret=access_token_secret) %>%
  Collect(searchTerm="#ECNeph", numTweets=250,writeToFile=TRUE,verbose=TRUE)

g_twitter_actor <- myTwitterData %>%
  Create("Actor",writeToFile=TRUE)
g_twitter_actor

pageRank_ecneph <- sort(page.rank(g_twitter_actor)$vector,decreasing=TRUE)
head(pageRank_ecneph,n=20)

g_twitter_semantic <- myTwitterData %>%
  Create
("Semantic")

pageRank_auspol_semantic <-
  sort(page.rank(g_twitter_semantic)$vector,decreasing=TRUE)
head(pageRank_auspol_semantic,n=10)



g<-read.graph("ac.gml", format="graphml")
V(g)$degree <- degree(g, mode="all")
cut.off <- mean(V(g)$degree)
sub <- induced_subgraph(g, which(V(g)$degree>cut.off))