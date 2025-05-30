v=read.table('/home/kiwoong/Projects/sfrugi_WG/Ver7/Gene/CNV.txt',h=T)

B=1000

samples=unique(v$sample)

RES=data.frame()
for(s in samples)
{
	cat(s,"\n")
	vs=subset(v,sample==s)
	vsg=subset(vs,CNV!='total')

	vg=aggregate(vsg[c(3,4)],by=list(vsg$sample,vsg$CNV),sum)
	vg$cov=with(vg,Cov/nPos)
	diff=vg$cov[1]-vg$cov[2]

	bd=rep(NA,B)
	for(b in 1:B)
	{
		vb=vsg
		vb$CNV=sample(vb$CNV)
		vgb=aggregate(vb[c(3,4)],by=list(vb$sample,vb$CNV),sum)
		vgb$cov=with(vgb,Cov/nPos)
		bd[b]=vgb$cov[1]-vgb$cov[2]
	}

	p=length(bd[bd>diff])/length(bd)
	RES=rbind(RES,data.frame(sample=s,CNV=vg$cov[1],nonCNV=vg$cov[2],p=p))
}

RES$p.adj=p.adjust(RES$p, method = "fdr")

write.table(RES,'/home/kiwoong/Projects/sfrugi_WG/Ver7/Gene/Stats.txt',row.names=FALSE,sep="\t",quote=FALSE)

