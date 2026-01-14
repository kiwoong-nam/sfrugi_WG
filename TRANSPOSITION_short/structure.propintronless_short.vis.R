library("ggplot2")

v=read.table('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION_short/structure/propintronless.txt',h=T)
v$Len=with(v,paste(Lmn," bp - ",Lmx," bp",sep=""))

p=ggplot(v,aes(x=sample,y=m,fill=cate))+geom_bar(stat='identity',position='dodge')+coord_flip()+ylab("Proportion of intronless genes")+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()+ scale_fill_manual(labels=c('iORF-CNV','non-CNV'),values=c("red","blue"))+facet_grid(.~Len)+theme(legend.title=element_blank())

pdf('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION_short/structure.propintronless.pdf',width=15,height=9)
p
dev.off()

