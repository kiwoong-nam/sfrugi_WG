v=read.table('/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/CNV_prop.txt')

v.m=aggregate(v[3],by=list(v$V2),mean)
v.sd=aggregate(v[3],by=list(v$V2),sd)
v.l=aggregate(v[3],by=list(v$V2),length)
v.se=merge(v.sd,v.l,by='Group.1')
v.se$SE=with(v.se,V3.x/sqrt(V3.y))

vf=merge(v.m,v.se[c(1,4)],by='Group.1')
colnames(vf)=c('chro','mn','sd')

write.table(vf,'/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/CNV_mean.txt',row.names=F,quote=F,sep="\t")
 



