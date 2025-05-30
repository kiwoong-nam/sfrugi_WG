library("ggplot2")

v=read.table('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Transducing/mean',h=T)

colnames(v)[2]='Type'

p=ggplot(v,aes(x=sample,y=m,fill=Type))+geom_bar(stat='identity',position='dodge')+coord_flip()+ylab("Proportion of LINE-transduced gene")+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()+ scale_fill_manual(labels=c('iORF-CNV','non-CNV'),values=c("red","blue"))


pdf('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Transducing.pdf',width=10,height=9.5)
p
dev.off()


