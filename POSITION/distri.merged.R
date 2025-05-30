v1=read.table('/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/SNV_mean.txt',h=T)
v2=read.table('/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/CNV_mean.txt',h=T)
v3=read.table('/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/TE_mean.total.txt',h=T)
v4=read.table('/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/TE_mean.LINE.txt',h=T)
v5=read.table('/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/r2_mean',h=T)
v6=read.table('/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/CDS_mean.txt',h=T)

v12=merge(v1,v2,by='chro')
colnames(v12)=c('chro','mn.snv','se.snv','mn.cnv','se.cnv')
v123=merge(v12,v3,by='chro')
colnames(v123)=c('chro','mn.snv','se.snv','mn.cnv','se.cnv','mn.te.total','se.te.total')
v1234=merge(v123,v4,by='chro')
colnames(v1234)=c('chro','mn.snv','se.snv','mn.cnv','se.cnv','mn.te.total','se.te.total','mn.te.line','se.te.line')

colnames(v5)=c('chro','chr.size','m.rho','l.rho','u.rho')

v12345=merge(v1234,v5,by='chro')
colnames(v6)=c('chro','m.cds','l.cds','u.cds')
v=merge(v12345,v6,by='chro')

write.table(v,'/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/merged.txt',sep="\t",row.names=F,quote=F)


