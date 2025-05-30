library("ggplot2")

v=read.table('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/structure/length_singleexon.txt',h=T)

colnames(v)[2]='Type'

p=ggplot(v,aes(x=sample,y=mn,fill=Type))+geom_bar(stat='identity',position='dodge')+coord_flip()+ylab("The length of gene (bp)")+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()+ scale_fill_manual(labels=c('iORF-CNV','non-CNV'),values=c("red","blue"))

pdf('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/structure.length_singleexon.pdf',width=8,height=9)
p
dev.off()


