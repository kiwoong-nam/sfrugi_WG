library("ggplot2")

v=read.table('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/structure/propintronless.txt',h=T)

p=ggplot(v,aes(x=sample,y=m,fill=cate))+geom_bar(stat='identity',position='dodge')+coord_flip()+ylab("Proportion of intronless genes")+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()+ scale_fill_manual(labels=c('iORF-CNV','non-CNV'),values=c("red","blue"))

pdf('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/structure.propintronless.pdf',width=8,height=9)
p
dev.off()


