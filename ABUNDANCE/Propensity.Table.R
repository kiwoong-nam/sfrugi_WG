v.cnvG=read.table('/home/kiwoong/Projects/sfrugi_WG/ABUNDANCE/Propensity/CNV_Gene.txt',h=T)
v.snv=read.table('/home/kiwoong/Projects/sfrugi_WG/ABUNDANCE/Propensity/SNV.windowed.pi',h=T)

o.merged='/home/kiwoong/Projects/sfrugi_WG/ABUNDANCE/Propensity/Table.100kb.txt'
o.dt='/home/kiwoong/Projects/sfrugi_WG/ABUNDANCE/Propensity/Table.mean.txt'

B=1000

############################################################################

colnames(v.cnvG)[c(1,2,3,4)]=c('CHROM','BIN_START','geneCNV.n','geneCNV.l')

v.snv$T=with(v.snv,paste(CHROM,BIN_START))
v.cnvG$T=with(v.cnvG,paste(CHROM,BIN_START))

v=merge(v.snv,v.cnvG[c(3:5)],by='T',all = TRUE)[c(2,3,5,7,8)]
v[is.na(v)] = 0

colnames(v)[c(1:3)]=c("chrom","start","SNP")

write.table(v,o.merged,sep="\t",quote=F,row.names=F)

############################################################################

GT=function(cl,t)
{
	vara=v[cl]
	mm=sum(vara)

	bT=rep(NA,B)
	for(b in 1:B)
	{
		bT[b]=sum(vara[sample(c(1:nrow(v)),replace=T),])
	}
	bT=sort(bT)
	l=bT[25]
	h=bT[975]
	data.frame(cate=t,mn=mm,l.ci=l,h.ci=h)
}

res=rbind(GT(3,"SNV"),GT(5,"CNV Gene, length"),GT(4,"CNV Gene, number"))


write.table(res,o.dt,sep="\t",quote=F,row.names=F)

############################################################################
