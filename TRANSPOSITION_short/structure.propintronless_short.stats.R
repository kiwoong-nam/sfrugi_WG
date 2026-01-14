v=read.table('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION_short/structure/propintronless_st.txt',h=T)

v$prop.intronless.CNV=with(v,intronless.CNV/(intronless.CNV+intron.CNV))
v$prop.intronless.nonCNV=with(v,intronless.nonCNV/(intronless.CNV+intron.nonCNV))

RES=data.frame()
for(i in c(1:nrow(v)))
{
	F1=fisher.test(matrix(c(v[i,4],v[i,5],v[i,6],v[i,7]),ncol=2))
	RES=rbind(RES,data.frame(v[i,1],v[i,2],v[i,3], F1$estimate,F1$p.value))
}


colnames(RES)=c("mn","mx","sample","odd.ratio","p.value")
RES$p.adj=p.adjust(RES$p.value, method = "fdr")

write.table(RES,'/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION_short/structure/propintronless.stats',sep="\t",quote=FALSE,row.names=FALSE)

with(subset(v,Lmn==0),quantile(prop.intronless.CNV))
#      0%       25%       50%       75%      100% 
#0.8198020 0.8470085 0.8550507 0.8695058 0.8912037 
 
with(subset(v,Lmn==1000),quantile(prop.intronless.CNV))
#      0%       25%       50%       75%      100% 
#0.4965753 0.5611711 0.5715995 0.5850676 0.6531987 

with(subset(v,Lmn==0),quantile(prop.intronless.nonCNV))
#       0%       25%       50%       75%      100% 
#0.5213777 0.5617573 0.5843277 0.6008264 0.6287671 

with(subset(v,Lmn==1000),quantile(prop.intronless.nonCNV))
#      0%       25%       50%       75%      100% 
#0.2669421 0.2834917 0.2912723 0.3032079 0.3149225 

 
with(subset(RES,mn==0),max(p.adj))
#[1] 2.283518e-22
with(subset(RES,mn==1000),max(p.adj))
#[1] 1.98908e-13

