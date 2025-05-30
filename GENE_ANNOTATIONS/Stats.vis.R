library("ggplot2")
library(gridExtra)
library(grid)

vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)

Output='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Stats.pdf'

v=read.table('/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Stats/collect.txt',h=T)

p1=ggplot(v,aes(x=sample,y=Identity,fill=category))+geom_violin()+coord_flip()+ylim(0.95,1)+theme_bw()
p2=ggplot(v,aes(x=sample,y=Coverage,fill=category))+geom_violin()+coord_flip()+ylim(0.95,1)+theme_bw()

pdf(Output,width=11,height=8)
grid.newpage()
pushViewport(viewport(layout = grid.layout(1, 2)))
print(p1, vp = vplayout(1,1))
print(p2, vp = vplayout(1,2))
dev.off()



