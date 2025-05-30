v=read.table("/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS/counts",h=T)
vg=aggregate(v[c(2,3)],by=list(v$CNV),sum)

vg$NS=with(vg,N/S)

B=1000

as=c(1:nrow(v))

Bcnv.gene=rep(NA,B)
Bnoncnv=rep(NA,B)

for(b in 1:B)
{
        cat(b,"\n")
        vb=v[(sample(as,replace=T)),]
        vgb=aggregate(vb[c(2,3)],by=list(vb$CNV),sum)
        vgb$NS=with(vgb,N/S)

        Bcnv.gene[b]=vgb$NS[1]
        Bnoncnv[b]=vgb$NS[2]
}


RES=rbind(
data.frame(group='CNV.GENE',mn=vg$NS[1],u.ci=sort(Bcnv.gene)[975],l.ci=sort(Bcnv.gene)[25]),
data.frame(group='nonCNV',mn=vg$NS[2],u.ci=sort(Bnoncnv)[975],l.ci=sort(Bnoncnv)[25]))

write.table(RES,'/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS/mean',quote=F,row.names=F,sep="\t")

