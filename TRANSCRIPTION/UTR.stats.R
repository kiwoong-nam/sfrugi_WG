v=subset(read.table('/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/global.txt',h=T),func != 'Intergenic'  & func != 'Intron' & func != 'TE')

v$odd=with(v,(m.func/m.nfunc)/(nm.func/nm.nfunc))

P=rep(NA,nrow(v))
for(i in c(1:nrow(v)))
{
	test=fisher.test(matrix(c(v[i,3],v[i,4],v[i,5],v[i,6]),ncol=2))
	P[i]=test$p.value
}
	
v$p.value=P
v$p.adj=p.adjust(P, method = "fdr")

write.table(v,'/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/stats.txt',sep="\t",quote=F,row.names=F)

