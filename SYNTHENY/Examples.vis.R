library(ggplot2)
library(dplyr)

v.l <- read.table("/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Examples/cobmne.Litura", header = FALSE, sep = "\t", stringsAsFactors = FALSE)
v.e <- read.table("/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Examples/cobmne.Exigua", header = FALSE, sep = "\t", stringsAsFactors = FALSE)

colnames(v.l) = c("category", "frugiperda.chro", "frugiperda.start", "frugiperda.end", "litura.chro", "litura.start", "litura.end")
colnames(v.e) = c("category", "frugiperda.chro", "frugiperda.start", "frugiperda.end", "exigua.chro", "exigua.start", "exigua.end")

get_cum_coords <- function(data, chr_col, start_col, end_col) {
  chroms <- as.character(sort(unique(as.numeric(data[[chr_col]]))))
  sizes <- data %>%
    group_by(!!sym(chr_col)) %>%
    summarize(size = max(!!sym(end_col))) %>%
    arrange(match(!!sym(chr_col), chroms))
  offsets <- setNames(c(0, cumsum(as.numeric(sizes$size))[-nrow(sizes)]), chroms)
  data$cum_pos <- data[[start_col]] + offsets[as.character(data[[chr_col]])]
  return(list(data = data, offsets = offsets, sizes = sizes$size, labels = chroms))
}

save_individual_plot <- function(df, other_species_name, output_path) {
  other_chr_col <- paste0(tolower(other_species_name), ".chro")
  other_start_col <- paste0(tolower(other_species_name), ".start")
  other_end_col <- paste0(tolower(other_species_name), ".end")
  
  fru_res <- get_cum_coords(df, "frugiperda.chro", "frugiperda.start", "frugiperda.end")
  df_res <- fru_res$data %>% rename(fru_cum = cum_pos)
  oth_res <- get_cum_coords(df_res, other_chr_col, other_start_col, other_end_col)
  df_res <- oth_res$data %>% rename(other_cum = cum_pos)
  
  p <- ggplot() +
    geom_point(data = filter(df_res, category == "BUSCO"),
               aes(x = fru_cum, y = other_cum),
               color = "#777777", size = 0.5, alpha = 0.4) +
    geom_point(data = filter(df_res, category %in% c("intronic", "intronloss")),
               aes(x = fru_cum, y = other_cum, color = category),
               size = 1, alpha = 1) +
    scale_color_manual(values = c("intronic" = "#0000FF", "intronloss" = "#FF0000")) +
    
    geom_vline(xintercept = fru_res$offsets, color = "#EEEEEE", linewidth = 0.3) +
    geom_hline(yintercept = oth_res$offsets, color = "#EEEEEE", linewidth = 0.3) +
    
    scale_x_continuous(breaks = fru_res$offsets + fru_res$sizes/2, labels = fru_res$labels, expand = c(0, 0)) +
    scale_y_continuous(breaks = oth_res$offsets + oth_res$sizes/2, labels = oth_res$labels, expand = c(0, 0)) +
    labs(x = expression(italic("Spodoptera frugiperda")), 
         y = bquote(italic(paste("Spodoptera ", .(other_species_name))))) +
    
    theme_minimal() +
    theme(
      panel.grid = element_blank(),
      panel.border = element_rect(colour = "black", fill=NA, linewidth=1), 
      axis.text.x = element_text(angle = 90, vjust = 0.5, size = 8),
      axis.text.y = element_text(size = 8),
      legend.position = "right",
      legend.title = element_blank() 
    )
  
  ggsave(output_path, p, width = 6, height = 5, bg = "white")
}

save_individual_plot(v.l, "Litura", "/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Examples.Litura.pdf")
save_individual_plot(v.e, "Exigua", "/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Examples.Exigua.pdf")
