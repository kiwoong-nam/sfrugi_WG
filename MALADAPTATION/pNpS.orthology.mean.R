v1=read.table("/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS/orthology.FAW",h=T)
v2=read.table("/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS/orthology.exigua",h=T)

B=1000

#############################################

vg1=aggregate(v1[c(2,3)],by=list(v1$CNV),sum)
vg1$NS=with(vg1,N/S)
fisher.test(matrix(c(vg1[1,2],vg1[1,3],vg1[2,2],vg1[2,3]),ncol=2))
#p-value < 2.2e-16
#alternative hypothesis: true odds ratio is not equal to 1
#95 percent confidence interval:
# 2.650179 3.423776
#sample estimates:
#odds ratio 
#  3.010926
 
fisher.test(matrix(c(vg1[2,2],vg1[2,3],vg1[3,2],vg1[3,3]),ncol=2))
#p-value < 2.2e-16
#alternative hypothesis: true odds ratio is not equal to 1
#95 percent confidence interval:
# 1.294332 1.570046
#sample estimates:
#odds ratio 
#  1.426582


vg2=aggregate(v2[c(2,3)],by=list(v2$CNV),sum)
vg2$NS=with(vg2,N/S)

fisher.test(matrix(c(vg2[1,2],vg2[1,3],vg2[2,2],vg2[2,3]),ncol=2))
#p-value = 0.0002555
#alternative hypothesis: true odds ratio is not equal to 1
#95 percent confidence interval:
# 1.209248 2.007883
#sample estimates:
#odds ratio 
#  1.518484
 

#############################################

F.B.CNVOrtho.CNV=rep(NA,B)
F.B.CNVOrtho.nonCNV=rep(NA,B)
F.B.nonCNVOrtho=rep(NA,B)

for(b in 1:B)
{
        cat(b,"\n")
	vb=v1[(sample(c(1:nrow(v1)),replace=T)),]
        vgb=aggregate(vb[c(2,3)],by=list(vb$CNV),sum)
        vgb$NS=with(vgb,N/S)

        F.B.CNVOrtho.CNV[b]=vgb$NS[1]
        F.B.CNVOrtho.nonCNV[b]=vgb$NS[2]
        F.B.nonCNVOrtho[b]=vgb$NS[3]
}


FAW=rbind(data.frame(species='FAW',group='CNVOrtho.CNV',mn=vg1$NS[1],u.ci=sort(F.B.CNVOrtho.CNV)[975],l.ci=sort(F.B.CNVOrtho.CNV)[25]),
data.frame(species='FAW',group='CNVOrtho.nonCNV',mn=vg1$NS[2],u.ci=sort(F.B.CNVOrtho.nonCNV)[975],l.ci=sort(F.B.CNVOrtho.nonCNV)[25]),
data.frame(species='FAW',group='nonCNVOrtho',mn=vg1$NS[3],u.ci=sort(F.B.nonCNVOrtho)[975],l.ci=sort(F.B.nonCNVOrtho)[25])
)

#############################################

E.B.CNV=rep(NA,B)
E.B.nonCNV=rep(NA,B)

for(b in 1:B)
{
        cat(b,"\n")
	vb=v2[(sample(c(1:nrow(v2)),replace=T)),]
        vgb=aggregate(vb[c(2,3)],by=list(vb$CNV),sum)
        vgb$NS=with(vgb,N/S)

        E.B.CNV[b]=vgb$NS[1]
        E.B.nonCNV[b]=vgb$NS[2]
}


Exigua=rbind(
data.frame(species='exigua',group='CNV',mn=vg2$NS[1],u.ci=sort(E.B.CNV)[975],l.ci=sort(E.B.CNV)[25]),
data.frame(species='exigua',group='nonCNV',mn=vg2$NS[2],u.ci=sort(E.B.nonCNV)[975],l.ci=sort(E.B.nonCNV)[25])
)

RES=rbind(FAW,Exigua)

write.table(RES,'/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS/orthology.mean',quote=F,row.names=F,sep="\t")


