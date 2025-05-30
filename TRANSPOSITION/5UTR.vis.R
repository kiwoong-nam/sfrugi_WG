library("ggplot2")

v=read.table("/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/5UTR/divergence.txt",h=T,sep="\t")

nrow(subset(v,d<0.05))/nrow(v)
#[1] 0.6032259

nrow(subset(v,d<0.1))/nrow(v)
#[1] 0.6507167



p=ggplot(v,aes(x=d))+geom_histogram(bins=50)+theme_bw()+xlab("lowest divergence among copies within samples")

pdf("/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/5UTR.pdf",width=4.7,height=3.7)
p
dev.off()



