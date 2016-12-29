library(ggplot2)
library(gridExtra)

bbi <- element_text(face="bold.italic", color="black")

distance <- read.csv("~/Desktop/taxi_distance.csv")
distance$length <- factor(distance$length, 
                          levels = distance$length)

ggplot(data=distance, aes(x=length, y=count)) +
  geom_bar(stat="identity", fill=I("yellow"), 
           col=I("black"), width = 1) + 
  xlab("") + ylab("Count") + 
  theme(legend.position='none', title=bbi, axis.text=element_text(size=12)) +
  labs(title="NYC taxi trips in 2015 \n by distance") +
  scale_y_continuous(breaks=c(1000000,10000000, 50000000),
                     labels = c("1 million", "10 million", "50 million"))

rides <- read.csv("~/Desktop/taxi_coordinates.csv")

micro_map <- ggplot(data=subset(rides, short_count>0), aes(x = long, y = lat, 
                                        colour = short_count)) +
  geom_point(size = 0.8, shape = 16) + 
  scale_colour_gradient2(low="yellow",  
                         high = "red", 
                         mid="orange", 
                         midpoint = 6,
                         trans="log",
                         limits=c(1,40000),
                         breaks=c(1, 10, 100, 1000, 10000)) +
  labs(x="longitude", y="latitude", 
       title= "NYC taxi trips in 2015:\n500-foot rides") + 
  theme(title=bbi, panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())

comp <- subset(rides, long_count>100 & short_count>0)
comp$multiplier <- round(comp$short_count/comp$long_count,4)

micro_map_2 <- ggplot(data=comp, aes(x = long, y = lat, colour = multiplier)) +
  geom_point(size = 0.8, shape = 16) + 
  scale_colour_gradient2(low="yellow",  
                         mid="red",
                         trans="log",
                         limits=c(0.0001, 12),
                         breaks=c(0.001, 0.01, 0.1, 1, 10),
                         labels = c('1/1000', '1/100', '1/10', '1', '10x')) +
  labs(x="longitude", y="latitude", 
       title= "NYC taxi trips in 2015:\nRatio of 500-ft. cab rides to all others") + 
  theme(title=bbi, panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())

shady <- read.csv("~/Desktop/shady.csv")

shady$type <- factor(shady$type, levels = shady$type)

nada <- theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank())

cash <- ggplot(data=shady, aes(x=type, y=cash_pct, fill=type)) +
  geom_bar(stat="identity", 
           col=I("black"), width = 1) + 
  scale_y_continuous(limits=c(0,1), 
                     labels = c("0%", "25%", "50%", "75%", "100%")) +
  guides(fill=FALSE) + labs(title="paid in cash") + nada

fifty <- ggplot(data=shady, aes(x=type, y=expensive_pct, fill=type)) +
  geom_bar(stat="identity", 
           col=I("black"), width = 1) + 
  scale_y_continuous(limits=c(0,1), 
                     labels = c("0%", "25%", "50%", "75%", "100%")) +
  guides(fill=FALSE) + labs(title="fare at least 50$") + nada

nego <- ggplot(data=shady, aes(x=type, y=nego_pct, fill=type)) +
  geom_bar(stat="identity", 
           col=I("black"), width = 1) + 
  scale_y_continuous(limits=c(0,1), 
                     labels = c("0%", "25%", "50%", "75%", "100%")) +
  guides(fill=FALSE) + labs(title="fare negotiated") + nada

grid.arrange(cash, fifty, nego, ncol=3)
