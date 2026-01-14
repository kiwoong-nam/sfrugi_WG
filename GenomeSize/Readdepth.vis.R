library(gridExtra)
library('ggplot2')

v=read.table("/home/kiwoong/Projects/sfrugi_WG/GenomeSize/Readdepth/CI.txt",h=T)

va=subset(v,stats=='Autosome')
vz=subset(v,stats=='Z')
vz$stats='Z chromosome'
vs=rbind(va,vz)

vr=subset(v,stats=='Ratio')

vr$Sex='Female'
vr$Sex[vr$m>0.75]='Male'

OD=vr$sample[order(vr$Sex)]

vs$ID=factor(vs$sample,levels=OD)
vr$ID=factor(vr$sample,levels=OD)

p1=ggplot(vs,aes(x=ID,y=m,fill=stats))+geom_bar(stat='identity',position='dodge')+labs(tag = "A") +xlab("sample")+ geom_errorbar(aes(ymin=l,ymax=u),width=0.2,position=position_dodge(width = 0.9))+theme_bw()+ylab('RD')+coord_flip()+theme(legend.title = element_blank(), plot.tag.position = c(0.005, 0.99),plot.tag = element_text( size = 21) )

p2=ggplot(vr,aes(x=ID,y=m,fill=Sex))+geom_bar(stat='identity')+geom_errorbar(aes(ymin=l,ymax=u),width=0.2)+xlab("sample")+theme_bw()+ylab(expression(RD[Z~chromosome] / RD[Autosome]))+coord_flip()+ scale_fill_brewer(palette = "Set2")+labs(tag = "B")+theme(plot.tag.position = c(0.005, 0.99),plot.tag = element_text( size = 21) )

pdf('/home/kiwoong/Projects/sfrugi_WG/GenomeSize/Readdepth.pdf',width=12,height=7)
grid.arrange(p1, p2, ncol = 2)
dev.off()

