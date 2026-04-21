library("ggplot2")

v=read.table('/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/Count/Intronlessfreq.txt',h=T)

v1=v[c(1,6,8,9)]
v2=v[c(1,7,10,11)]

colnames(v1)=c("sample","mn","u","l")
colnames(v2)=c("sample","mn","u","l")
v1$Type="Intronless"
v2$Type="Intron"

vs=rbind(v1,v2)

vs$Type = factor(vs$Type, levels = c("Intron", "Intronless"))

j_pos <- position_jitter(width = 0.25, seed = 123)

p = ggplot(vs, aes(x = Type, y = mn, group = sample)) +
  geom_line(color = "grey60", position = j_pos, alpha = 0.3, size = 0.5) +
    geom_errorbar(aes(ymin = pmin(l, u), ymax = pmax(l, u), color = Type), 
                position = j_pos, width = 0.01, alpha = 0.4) +
   geom_point(aes(color = Type), position = j_pos, size = 1.2) +
  scale_y_continuous(limits = c(0, NA), expand = expansion(mult = c(0, 0.1))) +  
  ylab("Proportion of intra-chromosomal duplication") +
  xlab("") +
  theme_bw() +
  theme(
    legend.position = "none",
    axis.title.y = element_text(size = 10),
    panel.grid.minor = element_blank() 
  )

#p=ggplot(vs,aes(x=sample,y=mn,fill=Type))+geom_bar(stat='identity',position='dodge')+coord_flip()+ylab("Proportion of intra-chromosomal duplication")+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()

pdf('/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome.Count.Intronless.pdf',width=4.2,height=4.2)
p
dev.off()


