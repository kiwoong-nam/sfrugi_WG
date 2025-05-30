ID='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/structure/count';

filenames <- list.files(ID, full.names=FALSE)

RES1=data.frame()
RES2=data.frame()

for(f in filenames)
{
	v=read.table(paste(ID,f,sep="/"))

	V1=v$V5[v$V4=="CNV"]
	V2=v$V5[v$V4=="CNV.single"]
	V3=v$V5[v$V4=="nonCNV"]
	
	pv1=wilcox.test(V1,V2)$p.value
	pv2=wilcox.test(V1,V3)$p.value
	
	m1=mean(V1)
	m2=mean(V2)
	m3=mean(V3)

	R1=data.frame(f,comp="CNV_CNV.single",m1=m1,m2=m2,p=pv1)
	R2=data.frame(f,comp="CNV_nonCNV",m1=m1,m2=m3,p=pv2)
	
	RES1=rbind(RES1,R1)
	RES2=rbind(RES2,R2)
}


RES1$p.adj=p.adjust(RES1$p, method = "fdr")
RES2$p.adj=p.adjust(RES2$p, method = "fdr")
RES=rbind(RES1,RES2)

write.table(RES,"/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/structure/length.stats",sep="\t",quote=FALSE,row.names=FALSE)

