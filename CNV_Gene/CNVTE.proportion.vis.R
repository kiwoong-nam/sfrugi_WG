library("ggplot2")

v=read.table("/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/proportion.txt",h=T)

p=ggplot(v,aes(x=prop))+geom_histogram(bins=100)+geom_vline(xintercept=0.9,col=2,linewidth=1)+theme_bw()+xlab("Proportion of TE sequence")

pdf("/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE.proportion.pdf",width=4,height=3.5)
p
dev.off()



