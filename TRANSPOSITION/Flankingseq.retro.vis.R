library("ggplot2")

v=read.table('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq/retro.gene.mean',h=T)

j_pos <- position_jitter(width = 0.25, seed = 123)

p = ggplot(v, aes(x =category, y = mn, group = sample)) +
  geom_line(aes(color = category), position = j_pos, alpha = 0.3, size = 0.5, color = "grey50") +
  geom_errorbar(aes(ymin = l, ymax = u, color = category), 
                position = j_pos, width = 0.01, alpha = 0.3) +
  geom_point(aes(color = category), position = j_pos, size = .8) +
  scale_color_manual(values = c("iORF-CNV" = "red", "non-CNV" = "blue")) +
  ylab("The proportion of genes with retro-structure") +
  xlab("") +
  theme_bw() +
  scale_y_continuous(limits = c(0, NA), expand = expansion(mult = c(0, 0.1)))+
  theme(legend.position = "none")

#p=ggplot(subset(v,intron=="all"),aes(x=sample,y=mn,fill=category))+geom_bar(stat='identity',position='dodge')+ylab("The proportion of genes with retro-structure")+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()+ scale_fill_manual(values=c("red","blue"))+xlab(NULL)+coord_flip()

pdf('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq.retro.pdf',width=4.2,height=4.2)
p
dev.off()



