library("ggplot2")

v=read.table('/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/Count/freq.txt',h=T)

v$Duplication = factor(v$type, levels=c("intra", "inter+intra", "inter"))

j_pos <- position_jitter(width = 0.25, seed = 123)

p = ggplot(v, aes(x = Duplication, y = mn, group = sample)) +
  geom_line(color = "grey50", position = j_pos, alpha = 0.2, size = 0.4) +
  geom_errorbar(aes(ymin = l, ymax = u, color = Duplication), 
                position = j_pos, width = 0.01, alpha = 0.3) +
  geom_point(aes(color = Duplication), position = j_pos, size = 1) +
  
  scale_color_manual(values = c("intra" = "orange", "inter" = "purple", "inter+intra" = "darkgreen")) +
  scale_y_continuous(limits = c(0, NA), expand = expansion(mult = c(0, 0.1))) +
  
  ylab("Total copy number") +
  xlab("") +
  theme_bw() +
  theme(legend.position = "none")

#p=ggplot(v,aes(x=sample,y=mn,fill=Duplication))+geom_bar(stat='identity',position='dodge')+coord_flip()+ylab("Total copy number")+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()

pdf('/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome.Count.Freq.pdf',width=4.2,height=4.2)
p
dev.off()

