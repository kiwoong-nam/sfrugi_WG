v=read.table('/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt')
vg=aggregate(v[1],by=list(v$V2),length)
colnames(vg)=c('Category','count')

write.table(vg,'/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/counts.txt',row.names=F,sep="\t",quote=F)



