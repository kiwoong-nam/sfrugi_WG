library("ggplot2")

v=read.table('/home/kiwoong/Projects/sfrugi_WG/Ver7/Gene/Cov.txt',h=T)

vs=subset(v,CNV=="CNV.GENE")
vs$CNV="iORF-CNV"
vs1=subset(v,CNV!="CNV.GENE")
v=rbind(vs,vs1)

p=ggplot(v,aes(x=sample,y=m,fill=CNV))+geom_bar(stat='identity',position='dodge')+geom_errorbar(aes(ymin=l,ymax=h),position = position_dodge(width=0.9),width=0.2)+theme_bw()+ scale_fill_manual(values=c("red","blue"))+coord_flip()+ylab("Relative Read Depth to Whole Genome Sequences")+ theme(legend.title=element_blank())

pdf('/home/kiwoong/Projects/sfrugi_WG/Ver7/Cov.pdf',width=6,height=5)
p
dev.off()

