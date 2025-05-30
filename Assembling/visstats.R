library("ggplot2")
library(gridExtra)
library(grid)

vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)

vc1=read.table("/home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00165452/result.txt",header=T)
vc2=read.table("/home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00167884/result.txt",header=T)
vc3=read.table("/home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/result.txt",header=T)
vc4=read.table("/home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586.2/result.txt",header=T)
vc4$batch=unique(vc3$batch)

vc=rbind(vc1,vc2,vc3,vc4)
vc$BUSCO.complete=with(vc,busco.S+busco.D)

write.table(vc,"/home/kiwoong/Projects/sfrugi_WG/Assembling/stats/summary.tbl",row.names=F,quote=F,sep="\t")

p1=ggplot(vc,aes(x=ID,y=read.len/1e9))+geom_bar(stat='identity')+xlab(NULL)+ylab('Throughput (Gb)')+theme_bw()+ coord_flip()

p2=ggplot(vc,aes(x=ID,y=assembly.len/1e6))+geom_bar(stat='identity')+xlab(NULL)+ylab('Size (Mb)')+theme_bw()+ coord_flip()

p3=ggplot(vc,aes(x=ID,y=assembly.N50/1e6))+geom_bar(stat='identity')+xlab(NULL)+ylab('N50 (Mb)')+theme_bw()+ coord_flip()

p4=ggplot(vc,aes(x=ID,y=BUSCO.complete))+geom_bar(stat='identity')+xlab(NULL)+ylab('% complete BUSCO')+theme_bw()+geom_hline(yintercept=95,color='blue',linetype='dashed')+ coord_flip()

pdf('/home/kiwoong/Projects/sfrugi_WG/Assembling/stats/corn.pdf',width=10,height=10)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2)))
print(p1, vp = vplayout(1,1))
print(p2, vp = vplayout(1,2))
print(p3, vp = vplayout(2,1))
print(p4, vp = vplayout(2,2))
dev.off()


