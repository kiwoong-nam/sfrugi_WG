library("ggplot2")

v=read.table('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/structure/intronN.txt',h=T)

colnames(v)[2]='Type'

j_pos <- position_jitter(width = 0.25, seed = 123) # seed를 고정해야 선과 점이 따로 놀지 않음

p = ggplot(v, aes(x = Type, y = mn, group = sample)) +
  geom_line(aes(color = Type), position = j_pos, alpha = 0.3, size = 0.5, color = "grey50") +
  geom_errorbar(aes(ymin = l, ymax = u, color = Type), 
                position = j_pos, width = 0.01, alpha = 0.3) +
  geom_point(aes(color = Type), position = j_pos, size = .8) +
  scale_color_manual(values = c("iORF-CNV" = "red", "non-CNV" = "blue")) +
  ylab("The number of introns per gene") +
  xlab("") +
  scale_y_continuous(limits = c(0, NA), expand = expansion(mult = c(0, 0.1)))+
  theme_bw() +
  theme(legend.position = "none")


#p=ggplot(v,aes(x=sample,y=mn,fill=Type))+geom_bar(stat='identity',position='dodge')+coord_flip()+ylab("The number of introns per gene")+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()+ scale_fill_manual(labels=c('iORF-CNV','non-CNV'),values=c("red","blue"))


pdf('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/structure.intronN.pdf',width=4.2,height=4.2)
p
dev.off()



