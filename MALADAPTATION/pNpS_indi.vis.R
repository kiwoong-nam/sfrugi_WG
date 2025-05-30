library("ggplot2")

v=read.table('/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS_indi/mean',h=T)

colnames(v)[2]='Type'

p=ggplot(v,aes(x=sample,y=m,fill=Type))+geom_bar(stat='identity',position='dodge')+coord_flip()+ylab(expression(H[nonsyn]/H[syn]))+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()+ scale_fill_manual(labels=c('CNV gene','non-CNV gene'),values=c("red","blue"))

pdf('/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS_indi.pdf',width=8,height=9)
p
dev.off()


