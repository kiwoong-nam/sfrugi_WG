v1=read.table('/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/TE_leng.txt',h=T)
v2=read.table('/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/chrsize.txt')

v.total=v1[c(1,2,3)]
v.line=v1[c(1,2,4)]

colnames(v2)[1]='chrN'
v.total=merge(v.total,v2,by='chrN')
v.line=merge(v.line,v2,by='chrN')

v.total$TE.density=with(v.total,total.TE/V2)
v.line$TE.density=with(v.line,LINE/V2)

v.total=v.total[c(1,2,5)]
v.line=v.line[c(1,2,5)]

G=function(v)
{
	v.m=aggregate(v[3],by=list(v$chrN),mean)
	v.sd=aggregate(v[3],by=list(v$chrN),sd)
	v.l=aggregate(v[3],by=list(v$chrN),length)
	v.se=merge(v.sd,v.l,by='Group.1')
	v.se$SE=with(v.se,TE.density.x/sqrt(TE.density.y))
	vf=merge(v.m,v.se,by='Group.1')[c(1,2,5)]
	vf
}

vf.total=G(v.total)
vf.line=G(v.line)

colnames(vf.total)=c('chro','mn','sd')
colnames(vf.line)=c('chro','mn','sd')

write.table(vf.total,'/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/TE_mean.total.txt',row.names=F,quote=F,sep="\t")
 
write.table(vf.line,'/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/TE_mean.LINE.txt',row.names=F,quote=F,sep="\t")
 



