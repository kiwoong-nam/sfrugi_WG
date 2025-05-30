library("ggplot2")
library(gridExtra)
library(grid)

vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)

v1=read.table('/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS_indi/mean',h=T)
v2=read.table('/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/NSSSites/mean.txt',h=T)
v3=read.table('/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS/orthology.mean',h=T)

################

v2$group='All Sites'
v3s=subset(v3,species=='FAW')
v3s$ortho=c('Orthogroup with CNV gene','Orthogroup with CNV gene ','Orthogroup without CNV gene')
v3s$group=c('CNV.GENE','nonCNV','nonCNV')

v3e=subset(v3,species=='exigua')
v3e$group=c('Orthogroup with FAW CNV gene','Orthogroup without FAW CNV gene')

##########################

p1=ggplot(v1,aes(x=sample,y=m,fill=CNV))+geom_bar(stat='identity',position='dodge')+coord_flip()+ylab(expression(H[nonsyn]/H[syn]))+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()+ scale_fill_manual(labels=c('iORF-CNV ','non-CNV'),values=c("red","blue"))+ylim(0,2.7)+ theme(legend.position = c(0.75, 0.87),legend.title=element_blank())

p2=ggplot(v2,aes(x=group,y=mn))+geom_bar(stat='identity',fill="grey45",col='grey45')+geom_errorbar(aes(ymin=l,ymax=u),width=0.2)+theme_bw()+ylim(0,2.7)+coord_flip()+xlab(NULL)+ylab("Nonsynonymous to Synonymous Sites")

p3=ggplot(v3s,aes(x=ortho,y=mn,fill=group))+geom_bar(stat='identity')+geom_errorbar(aes(ymin=l.ci,ymax=u.ci),width=0.2)+theme_bw()+ scale_fill_manual(labels=c('iORF-CNV ','non-CNV'),values=c("red","blue"))+ylab("Nonsynonymous to Synonymous Polymorphism Ratio")+ylim(0,2.7)+xlab(NULL)+ theme(legend.position = c(0.7, 0.87))+theme(axis.text.x = element_text(angle = 20, vjust = .75, hjust=.65))

p4=ggplot(v3e,aes(x=group,y=mn))+geom_bar(stat='identity')+geom_errorbar(aes(ymin=l.ci,ymax=u.ci),width=0.2)+theme_bw()+ylab("Nonsynonymous to Synonymous Polymorphism Ratio")+ylim(0,2.7)+xlab(NULL)+theme(axis.text.x = element_text(angle = 20, vjust = .75, hjust=.65))

pdf('/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/MALADAPTATION.pdf',width=11,height=10)
grid.newpage()
pushViewport(viewport(layout = grid.layout(100, 75)))
print(p1, vp = vplayout(c(1:90),c(1:48)))
print(p2, vp = vplayout(c(91:100),c(2:48)))
print(p3, vp = vplayout(c(1:50),c(51:75)))
print(p4, vp = vplayout(c(52:100),c(51:75)))
#dev.off()



