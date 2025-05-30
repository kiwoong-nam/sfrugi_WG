v=read.table('/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/Selfing/Selfing')
vs=subset(v,V1!=V2 & V3 > 95 & V4 > 95)

write.table(vs,'/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/Selfing/multigene.txt',row.names=F,quote=F,sep="\t")


