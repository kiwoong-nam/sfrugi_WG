library("ggplot2")

v=read.table('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq/retro.gene.mean',h=T)

p=ggplot(subset(v,intron=="all"),aes(x=sample,y=mn,fill=category))+geom_bar(stat='identity',position='dodge')+ylab("The proportion of genes with retro-structure")+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()+ scale_fill_manual(values=c("red","blue"))+xlab(NULL)+coord_flip()

pdf('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq.retro.pdf',width=10,height=9.5)
p
dev.off()



