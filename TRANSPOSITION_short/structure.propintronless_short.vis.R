library("ggplot2")

vt=read.table('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION_short/structure/propintronless.txt',h=T)

vt$Len=with(vt,paste(Lmn," bp - ",Lmx," bp",sep=""))

colnames(vt)[4] = 'Type'
colnames(vt)[5] = 'mn'

v1=subset(vt,Type=="non.CNV")
v2=subset(vt,Type=="iORF-CNV")

v1$Type="non-CNV"

v=rbind(v1,v2)

v$Type = factor(v$Type, levels = c('iORF-CNV', 'non-CNV'))

v$Len = factor(v$Len, levels = c("0 bp - 1000 bp", "1000 bp - 2000 bp")) # 실제 데이터에 맞춰 추가

j_pos <- position_jitter(width = 0.25, seed = 123)

p = ggplot(v, aes(x = Type, y = mn, group = sample)) +
  geom_line(aes(color = Type), position = j_pos, alpha = 0.2, size = 0.4, color = "grey50") +
  geom_errorbar(aes(ymin = l, ymax = u, color = Type), 
                position = j_pos, width = 0.01, alpha = 0.3) +
  geom_point(aes(color = Type), position = j_pos, size = 0.6) +
  
  facet_grid(. ~ Len) + 
  
  scale_color_manual(values = c("iORF-CNV" = "red", "non-CNV" = "blue")) +
  scale_y_continuous(limits = c(0, NA), expand = expansion(mult = c(0, 0.1))) +
  
  ylab("Proportion of intronless genes") + 
  xlab("") +
  theme_bw() +
  theme(
    legend.position = "none",
    strip.background = element_blank(), 
  )


#p=ggplot(v,aes(x=sample,y=m,fill=cate))+geom_bar(stat='identity',position='dodge')+coord_flip()+ylab("Proportion of intronless genes")+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()+ scale_fill_manual(labels=c('iORF-CNV','non-CNV'),values=c("red","blue"))+facet_grid(.~Len)+theme(legend.title=element_blank())

pdf('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION_short/structure.propintronless.pdf',width=7.5,height=4.2)
p
dev.off()


