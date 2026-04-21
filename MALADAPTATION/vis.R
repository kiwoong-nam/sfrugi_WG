library("ggplot2")
library("gridExtra")
library("cowplot")

v1t=read.table('/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS_indi/mean', h=T)
v2=read.table('/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/NSSSites/mean.txt', h=T)
v3=read.table('/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS/orthology.mean', h=T)

vs1=subset(v1t,CNV=="CNV")
vs1$CNV="iORF-CNV"
vs2=subset(v1t,CNV!="CNV")
vs2$CNV="non-CNV"

v1=rbind(vs1,vs2)

v1$CNV = factor(v1$CNV, levels = c("iORF-CNV", "non-CNV"))
j_pos <- position_jitter(width = 0.25, seed = 123)

v3s=subset(v3, species=='FAW')
v3s$ortho=c('Orthogroup with CNV gene', 'Orthogroup with CNV gene ', 'Orthogroup without CNV gene')
v3s$group=factor(c('CNV.GENE', 'nonCNV', 'nonCNV'), levels=c('CNV.GENE', 'nonCNV'))

v3e=subset(v3, species=='exigua')
v3e$group=c('Orthogroup with FAW CNV gene', 'Orthogroup without FAW CNV gene')

p1 = ggplot(v1, aes(x = CNV, y = m, group = sample)) +
  geom_line(color = "grey70", position = j_pos, alpha = 0.3, size = 0.4) +
  geom_errorbar(aes(ymin = pmin(l, u), ymax = pmax(l, u), color = CNV), 
                position = j_pos, width = 0.05, alpha = 0.3) +
  geom_point(aes(color = CNV), position = j_pos, size = 1) +
  
  geom_hline(yintercept = v2$mn, color = "grey30", size = 0.8) +
  geom_hline(yintercept = c(v2$l, v2$u), color = "grey30", linetype = "dashed", size = 0.5) + 
  
  scale_color_manual(values = c("iORF-CNV" = "red", "non-CNV" = "blue")) +

  scale_y_continuous(limits = c(0, 2.7), expand = c(0, 0)) +
  ylab(expression(H[nonsyn]/H[syn])) + xlab("") +
  theme_bw() +
  theme(legend.position = "none", panel.grid.minor = element_blank()) +
  annotate("text", x = 1.5, y = v2$mn - 0.1, label = "Nonsynonymous to Synonymous Sites", 
           size = 2.6, color = "grey30", fontface = "italic", hjust = 0.5)

p2 = ggplot(v3s, aes(x = ortho, y = mn, fill = group)) +
  geom_bar(stat = 'identity', alpha = 0.8) +
  geom_errorbar(aes(ymin = l.ci, ymax = u.ci), width = 0.2) +
  scale_fill_manual(values = c("CNV.GENE" = "red", "nonCNV" = "blue")) +
  scale_y_continuous(limits = c(0, 2.7), expand = c(0, 0)) + 
  ylab("pN/pS Ratio") + xlab("") +
  theme_bw() +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 30, hjust = 1, size = 8)) 
        
p3 = ggplot(v3e, aes(x = group, y = mn)) +
  geom_bar(stat = 'identity', fill = "grey60") +
  geom_errorbar(aes(ymin = l.ci, ymax = u.ci), width = 0.2) +
  scale_y_continuous(limits = c(0, 2.7), expand = c(0, 0)) + 
  ylab("pN/pS Ratio") + xlab("") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 30, hjust = 1, size = 8))

cp =  plot_grid(
  p1, p2, p3, 
  ncol = 3, 
  rel_widths = c(1, 1, 1),
  align = 'h',
  axis = 'bt' 
)

pdf('/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/MALADAPTATION.pdf', width = 10/1.3, height = 6/1.5)
cp
dev.off()

