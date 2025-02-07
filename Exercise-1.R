#### ENV 603 / 11-April-2021 / A. M. Creel
# Dataset 1: Religion by region

# If you have not yet installed these libraries, use install.packages("")

library(tidyverse)
library(socviz)
library(dplyr)
library(ggplot2)
library(RColorBrewer)

# Create a new table called rel_by_region


rel_by_region <- gss_sm %>%
  group_by(bigregion, religion) %>%
  summarize(N = n()) %>%
  mutate(freq = N / sum(N),
         pct = round((freq*100), 0))

# See how the pipeline above has taked the gss_sm dataframe and transformed it into a summary table.

View(gss_sm)
View(rel_by_region)

# Now let's make some plots!

p1 <- ggplot(rel_by_region, aes(x = bigregion, y = pct, fill = religion)) + 
  geom_col(position = "dodge2") +
  labs(x = "Region",y = "Percent", fill = "Religion") +
  theme(legend.position = "top")

p1

p2 <- ggplot(rel_by_region, aes(x = religion, y = pct, fill = religion)) +
  geom_col(position = "dodge2") +
  labs(x = NULL, y = "Percent", fill = "Religion") +
  guides(fill = FALSE) + 
  coord_flip() + 
  facet_grid(~ bigregion)

p2

# Make modifications to either plot. Google is your friend here. A few suggestions:
# (1) Add a title
# (2) Remove the gridlines
# (3) Reorder the bars
# (4) Choose a new color scheme

p3 <- p2 +
  ggtitle("Religion by Region") +
  theme_light() + 
  theme(panel.grid.major  = element_blank()) + 
  scale_fill_brewer(palette="Set1")

p3

# Once you're happy with your changes, save your plot:
ggsave("plot1.png",
  plot = last_plot(),
  dpi = 300)
