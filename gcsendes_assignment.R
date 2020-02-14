library(gganimate) # load library needed for animation
library(tidyverse)
data_racing <- readRDS('racing.rds')

p <- data_racing %>%
  ggplot(aes(x=-rank, y=album_cumsum, fill = playlist_genre)) + # fill=as.factor(playlist_subgenre)
  geom_tile(aes(y = album_cumsum/2, height=album_cumsum),width=0.9)+
  geom_text(aes(label=playlist_subgenre),
            hjust="right",
            colour="black",
            fontface="bold",
            nudge_y=-100,
            size = 5)+
  geom_text(aes(label=scales::comma(album_cumsum)),
            hjust="left",
            nudge_y=50,
            colour="grey30", 
            size = 5)+
  theme_minimal() +
  coord_flip(clip="off") +
  scale_x_discrete("") +
  scale_y_continuous(name = "", 
                     breaks = c(-1200, 0, 500, 1000, 1500),
                     labels = c("", "0", "500", "1000", "1500"))+
  scale_fill_brewer(palette = 'RdYlBu') +
  theme(panel.grid.major.y=element_blank(),
        panel.grid.minor.x=element_blank(),
        plot.title= element_text(size=24,colour="grey50",face="bold"),
        plot.caption = element_text(size = 15, colour="grey50"),
        plot.subtitle = element_text(size=20,colour="grey50",face="bold"),
        plot.margin = margin(1,1,1,2,"cm"),
        axis.text.x=element_blank(),
        axis.text.y=element_text(size = 20),
        legend.title = element_text(size = 14),
        legend.text = element_text(size = 12)) +
  transition_time(Y) +
  labs(title='Number of tracks released by {round(frame_time,0)}',
       #subtitle='{round(frame_time,0)}',
       caption='made by Gerold')

#print(p)
#anim_save(p, 'my.gif')

#animate(p, duration = 30, fps = 25, end_pause = 20) 
options(gganimate.dev_args = list(width = 700, height = 700))
animate(p, duration = 10, fps = 10, renderer = gifski_renderer(loop = F))

anim_save("racing-bars_noloop_v1.gif", )

#write_rds(data_racing, 'racing.rds')