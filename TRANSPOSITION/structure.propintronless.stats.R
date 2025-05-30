v=read.table('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/structure/propintronless_st.txt',h=T)

RES=data.frame()
for(i in c(1:nrow(v)))
{
	F1=fisher.test(matrix(c(v[i,2],v[i,3],v[i,4],v[i,5]),ncol=2))
	RES=rbind(RES,data.frame(v[i,1], F1$estimate,F1$p.value))
}


colnames(RES)=c("sample","odd.ratio","p.value")
RES$p.adj=p.adjust(RES$p.value, method = "fdr")

write.table(RES,'/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/structure/propintronless.stats',sep="\t",quote=FALSE,row.names=FALSE)



