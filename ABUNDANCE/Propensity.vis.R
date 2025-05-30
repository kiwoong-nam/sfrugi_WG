library("ggplot2")

v=read.table('/home/kiwoong/Projects/sfrugi_WG/ABUNDANCE/Propensity/Table.mean.txt',h=T,sep="\t")

vs=v[c(1,2),]
vs$cate=c('SNV','iORF-CNV')

p=ggplot(vs,aes(x=cate,y=mn/1e6))+geom_bar(stat='identity')+geom_errorbar(aes(ymin=l.ci/1e6,ymax=h.ci/1e6),width=0.2)+theme_bw()+ylab('Total Size (Mb)')+xlab(NULL)

pdf('/home/kiwoong/Projects/sfrugi_WG/ABUNDANCE/Propensity.pdf',height=4.2,width=2.4)
p
dev.off()

