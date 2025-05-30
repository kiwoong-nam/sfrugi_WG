v=read.table('/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/NSSSites/sites.txt',h=T)

B=1000

bg=with(v,sum(NS)/sum(S))

BT=rep(NA,B)
for(b in c(1:B))
{
	BT[b]=with(v[sample(c(1:nrow(v)),replace=T),],sum(NS)/sum(S))
}

RES=data.frame(bg,sort(BT)[25],sort(BT)[975])

colnames(RES)=c('mn','l','u')

write.table(RES,'/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/NSSSites/mean.txt',quote=FALSE,sep="\t",row.names=F)

