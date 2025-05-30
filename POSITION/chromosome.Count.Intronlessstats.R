v=read.table('/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/Count/Intronlessfreq.txt',h=T)

RES=data.frame()
for(i in c(1:nrow(v)))
{
	F=fisher.test(matrix(c(v[i,2],v[i,3],v[i,4],v[i,5]),ncol=2))
	RES=rbind(RES,data.frame(v[i,1], F$estimate,F$p.value))
}

colnames(RES)=c("sample","odd.ratio","p.value")

RES$p.adj=p.adjust(RES$p.value, method = "fdr")

write.table(RES,"/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/Count/Intronlessstats.txt",sep="\t",quote=FALSE,row.names=FALSE)


