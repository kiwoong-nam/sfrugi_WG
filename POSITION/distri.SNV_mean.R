#head -n 1015 ../distri/SNV_prop.txt > ../distri/SNV_prop_uptochr29.txt

v1=read.table('/home/knam/work/sfrugi_WG/POSITION/distri/SNV_prop_uptochr29.txt')
v2=read.table('/home/knam/work/sfrugi_WG/POSITION/distri/chrsize.txt')
colnames(v2)=c('V2','V1')
v=merge(v1,v2,by='V2')
v$density=with(v,V3/V1.y)

v.m=aggregate(v[5],by=list(v$V2),mean)
v.sd=aggregate(v[5],by=list(v$V2),sd)
v.l=aggregate(v[5],by=list(v$V2),length)
v.se=merge(v.sd,v.l,by='Group.1')
v.se$SE=with(v.se,density.x/sqrt(density.y))

vf=merge(v.m,v.se[c(1,4)],by='Group.1')
colnames(vf)=c('chro','mn','sd')

write.table(vf,'/home/knam/work/sfrugi_WG/POSITION/distri/SNV_mean.txt',row.names=F,quote=F,sep="\t")
 


