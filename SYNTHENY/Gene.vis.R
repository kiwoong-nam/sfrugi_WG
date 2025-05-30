library("ggplot2")
library(gridExtra)
library(grid)

vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)

v1=read.table('/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/all/mean',h=T,sep="\t")
v2=read.table('/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/all/mean.intronloss',h=T,sep="\t")
v1$type=factor(v1$type,levels=v1$type)

p1=ggplot(v1,aes(x=type,y=mn,fill=type))+geom_bar(stat='identity')+geom_errorbar(aes(ymin=l.ci,ymax=u.ci),width=0.2)+theme_bw()+ylab('Proportion of deviation from chromosomal synteny')+xlab(NULL)+theme(legend.position="none")

p2=ggplot(v2,aes(x=type,y=mn,fill=type))+geom_bar(stat='identity')+geom_errorbar(aes(ymin=l.ci,ymax=u.ci),width=0.2)+theme_bw()+ylab('Proportion of intronless homolog')+xlab(NULL)+ theme(axis.text.x = element_text(angle = 15, vjust = 1.1, hjust=1),legend.position="none")+scale_fill_manual(values=c('red','blue','yellow'))

pdf('/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene1.pdf',width=3.5,height=3.5)
p2
dev.off()

pdf('/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene2.pdf',width=3.5,height=3.5)
p1
dev.off()


