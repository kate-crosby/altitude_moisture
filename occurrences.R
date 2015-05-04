
# get the grin.csv from historical genomics repo
grin.all <- read.csv("GRIN.csv", header = T, stringsAsFactors = F)

# I did this by country as it seemed easiest (origcty as a field is almost always complete)
colombia <- subset(grin.all,grin.all$origcty=="COL" )
argentina <- subset(grin.all,grin.all$origcty=="ARG")
chile <- subset(grin.all, grin.all$origcty =="CHL")
bolivia <- subset(grin.all, grin.all$origcty =="BOL")
brazil <- subset(grin.all, grin.all$origcty == "BRA")
ecuador <- subset(grin.all, grin.all$origcty == "ECU")
guatemala <- subset(grin.all, grin.all$origcty =="GTM")
honduras <- subset(grin.all, grin.all$origcty == "HND")
mexico <- subset(grin.all, grin.all$origcty =="MEX")
nicaraugua <- subset(grin.all, grin.all$origcty =="NIC")
panama <- subset(grin.all, grin.all$origcty == "PAN")
peru <- subset(grin.all, grin.all$origcty =="PER")
costarica <- subset(grin.all, grin.all$origcty == "CRI")
venezuela <- subset(grin.all, grin.all$origcty == "VEN")
elsalvador <- subset(grin.all, grin.all$origcty == "SLV")
belize <-subset(grin.all, grin.all$origcty == "BLZ")

#All of mexico and everything tracking south
avail.zea <- rbind(colombia, argentina, chile, bolivia, brazil, ecuador, guatemala, honduras, mexico,
                   nicaraugua, panama, peru, costarica, venezuela, elsalvador, belize)

