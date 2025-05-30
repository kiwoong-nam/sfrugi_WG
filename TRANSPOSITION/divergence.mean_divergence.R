B=1000
v=read.table('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/divergence/divergence.txt',h=T)

FK=function(va,codon)
{
	m=mean(va)

	A=rep(NA,B)
	for(b in 1:B)
	{
		A[b]=mean(va[sample(c(1:length(va)),replace=T)])
	}

	data.frame(codon=codon,m=m,l=sort(A)[25],u=sort(A)[975])
}

RES=rbind(
FK(v$div1,'first'),
FK(v$div2,'second'),
FK(v$div3,'thrid')
)

write.table(RES,'/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/divergence/mean_divergence.txt',sep="\t",quote=F,row.names=F)



