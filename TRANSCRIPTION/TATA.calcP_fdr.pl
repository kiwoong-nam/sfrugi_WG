v=read.table('/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/TATA/calcP',h=T)

v1=subset(v,Func=="CNV")
v2=subset(v,Func=="nonCNV")

v1$p.adj=with(v1,p.adjust(p, method = 'fdr'))
v2$p.adj=with(v2,p.adjust(p, method = 'fdr'))

nrow(subset(v1,p.adj<0.1))
#35
nrow(subset(v1,p.adj<0.05))
#32

v12=rbind(v1,v2)[c(1,2,4,8,7,11)]

write.table(v12,'/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/TATA/calcP_fdr',sep="\t",quote=F,row.names=F)


