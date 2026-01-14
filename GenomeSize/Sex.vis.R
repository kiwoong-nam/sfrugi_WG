library('ggplot2')

v1=read.table("/home/kiwoong/Projects/sfrugi_WG/GenomeSize/Readdepth/CI.txt",h=T)
v2=read.table("/home/kiwoong/Projects/sfrugi_WG/Assembling/stats/summary.tbl",h=T)

colnames(v2)[2]='sample'

vr=subset(v1,stats=='Ratio')
vr$Sex='Female'
vr$Sex[vr$m>0.75]='Male'

v=merge(v2,vr,by='sample')

p=ggplot(v,aes(x=assembly.len/1e6,fill=Sex))+geom_density(alpha=0.5)+theme_bw()+xlim(370,410)+ scale_fill_brewer(palette = "Set2")+xlab('Assembly Size (Mb)')

with(v,wilcox.test(assembly.len ~ Sex))
#
#	Wilcoxon rank sum exact test
#
#data:  assembly.len by Sex
#W = 309, p-value = 1.507e-07
#alternative hypothesis: true location shift is not equal to 0


pdf("/home/kiwoong/Projects/sfrugi_WG/GenomeSize/Sex.pdf",width=6,height=5)
p
dev.off()


