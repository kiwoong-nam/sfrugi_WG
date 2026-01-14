library("ggplot2")
library(gridExtra)
library(grid)

vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)

v=read.table('/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/IntronLoss/mean',h=T,sep="\t")

v$type=factor(v$type,levels=v$type)

p=ggplot(v,aes(x=type,y=mn,fill=type))+geom_bar(stat='identity')+geom_errorbar(aes(ymin=l.ci,ymax=u.ci),width=0.2)+theme_bw()+ylab('Proportion of deviation from chromosomal synteny')+xlab(NULL)+theme(legend.position="none")

pdf('/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/IntronLoss.pdf',width=3.5,height=4)
p
dev.off()

