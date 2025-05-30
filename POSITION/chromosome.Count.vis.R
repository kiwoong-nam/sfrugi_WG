library("ggplot2")

v=read.table('/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/Count/freq.txt',h=T)

v$Duplication=factor(v$type,levels=unique(v$type)[c(2,3,1)])

p=ggplot(v,aes(x=sample,y=mn,fill=Duplication))+geom_bar(stat='identity',position='dodge')+coord_flip()+ylab("Total copy number")+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()

pdf('/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome.Count.Freq.pdf',width=8,height=8)
p
dev.off()

