v=read.table('/home/kiwoong/Projects/sfrugi_WG/Ver7/Gene/CNV.txt',h=T)
B=1000
samples=unique(v$sample)

cac=function(vk)
{
	vg=aggregate(vk[c(3,4)],by=list(vk$sample,vk$CNV),sum)
	vg$cov=with(vg,Cov/nPos)
	c(vg[1,5],vg[2,5])
}

RES=data.frame()
for(s in samples)
{
	cat(s,"\n")
	vs=subset(v,sample==s)

	t=with(subset(vs,CNV=='total'),Cov/nPos)
	vsg=subset(vs,CNV!='total')

	bg=cac(vsg)/t
	cnv=rep(NA,B)
	noncnv=rep(NA,B)	
	for(b in 1:B)
	{
		bt=cac(vsg[sample(c(1:nrow(vsg)),replace=T),])/t
		cnv[b]=bt[1]
		noncnv[b]=bt[2]
	}
	
	RES=rbind(RES,data.frame(sample=s,CNV='CNV.GENE',m=bg[1],l=sort(cnv)[25],h=sort(cnv)[975]))
	RES=rbind(RES,data.frame(sample=s,CNV='nonCNV',m=bg[2],l=sort(noncnv)[25],h=sort(noncnv)[975]))
}

write.table(RES,'/home/kiwoong/Projects/sfrugi_WG/Ver7/Gene/Cov.txt',row.names=FALSE,sep="\t",quote=FALSE)

