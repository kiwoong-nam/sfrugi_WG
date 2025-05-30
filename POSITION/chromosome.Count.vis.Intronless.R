library("ggplot2")

v=read.table('/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/Count/Intronlessfreq.txt',h=T)

v1=v[c(1,6,8,9)]
v2=v[c(1,7,10,11)]

colnames(v1)=c("sample","mn","u","l")
colnames(v2)=c("sample","mn","u","l")
v1$Type="Intronless"
v2$Type="Intron"

vs=rbind(v1,v2)

p=ggplot(vs,aes(x=sample,y=mn,fill=Type))+geom_bar(stat='identity',position='dodge')+coord_flip()+ylab("Proportion of intra-chromosomal duplication")+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()

pdf('/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome.Count.Intronless.pdf',width=8,height=8)
p
dev.off()


