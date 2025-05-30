library("ggplot2")

v=read.table("/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/busco/busco_secondallele",h=T)

p=ggplot(v,aes(x=x,y=counts/n.busc))+geom_bar(stat='identity',fill='black')+xlab("number of samples with second alleles")+theme_bw()+ylab("Proportion of BUSCO genes")+xlim(-1,37)
                
pdf('/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/busco_secondallele.pdf',height=4,width=4)
p
dev.off()

              
