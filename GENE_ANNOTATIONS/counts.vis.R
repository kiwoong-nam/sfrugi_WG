library("ggplot2")
library(gridExtra)
library(grid)

vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)

Output='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/counts.pdf'

v=read.table('/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/counts/refseq.txt',h=T)

v1=data.frame(sample=v[1],val=v[2],category='RefSeq')
v2=data.frame(sample=v[1],val=v[4],category='Filtered gene')
v3=data.frame(sample=v[1],val=v[5],category='Intact CDS')

colnames(v1)[2]='Counts'
colnames(v2)[2]='Counts'
colnames(v3)[2]='Counts'

vg=rbind(v1,v2,v3)

vg$category=factor(vg$category,levels=c('Intact CDS','Filtered gene','RefSeq'))

p=ggplot(vg,aes(x=sample,y=Counts,fill=category))+geom_bar(stat='identity',position='dodge')+coord_flip()+theme_bw()

pdf(Output,width=6,height=6)
p
dev.off()

summary(v)
#    sample              refseq           all         mapped.gene   
# Length:36          Min.   :14678   Min.   :14267   Min.   :12279  
# Class :character   1st Qu.:14678   1st Qu.:14561   1st Qu.:12640  
# Mode  :character   Median :14678   Median :14594   Median :12748  
#                    Mean   :14678   Mean   :14572   Mean   :12711  
#                    3rd Qu.:14678   3rd Qu.:14610   3rd Qu.:12823  
#                    Max.   :14678   Max.   :14632   Max.   :12913  
#  intact.gene     prop.mapping      prop.final    
# Min.   : 7943   Min.   :0.9720   Min.   :0.5412  
# 1st Qu.: 8850   1st Qu.:0.9920   1st Qu.:0.6030  
# Median : 9134   Median :0.9942   Median :0.6223  
# Mean   : 9052   Mean   :0.9928   Mean   :0.6167  
# 3rd Qu.: 9272   3rd Qu.:0.9954   3rd Qu.:0.6317  
# Max.   :10227   Max.   :0.9969   Max.   :0.6968  


