v=read.table('/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/all/intronloss',h=T)

BB=5000

vg=aggregate(v[1],by=list(v$CNV.Ortho,v$CNV.copy,v$intronless),length)
colnames(vg)=c('CNV.ortho','CNV.copy','intronless','geneN')

A=subset(vg,CNV.ortho=='CNV' & CNV.copy=='yes' & intronless=='yes')$geneN
B=subset(vg,CNV.ortho=='CNV' & CNV.copy=='yes' & intronless=='no')$geneN
C=subset(vg,CNV.ortho=='CNV' & CNV.copy=='no' & intronless=='yes')$geneN
D=subset(vg,CNV.ortho=='CNV' & CNV.copy=='no' & intronless=='no')$geneN
E=subset(vg,CNV.ortho=='nonCNV' & CNV.copy=='no' & intronless=='yes')$geneN
F=subset(vg,CNV.ortho=='nonCNV' & CNV.copy=='no' & intronless=='no')$geneN

CNV.p=A/(A+B)
nonCNV.p=C/(C+D)
nonCNVo=E/(E+F)

CNV.p
#[1] 0.4148936
nonCNV.p
#[1] 0.1
nonCNVo
#[1] 0.1165893


fisher.test(matrix(c(A,B,C,D),ncol=2))

#data:  matrix(c(A, B, C, D), ncol = 2)
#p-value = 0.08441
#alternative hypothesis: true odds ratio is not equal to 1
#95 percent confidence interval:
#   0.8145158 286.3822630
#sample estimates:
#odds ratio 
#  6.298009 

fisher.test(matrix(c(A,B,E,F),ncol=2))

#data:  matrix(c(A, B, E, F), ncol = 2)
#p-value = 4.686e-13
#alternative hypothesis: true odds ratio is not equal to 1
#95 percent confidence interval:
# 3.437095 8.321846
#sample estimates:
#odds ratio 
#  5.370004 


fisher.test(matrix(c(C,D,E,F),ncol=2))
#data:  matrix(c(C, D, E, F), ncol = 2)
#p-value = 1
#alternative hypothesis: true odds ratio is not equal to 1
#95 percent confidence interval:
# 0.01917646 6.09436351
#sample estimates:
#odds ratio 
# 0.8418973 


##################################################

BT1=rep(NA,BB)
BT2=rep(NA,BB)
BT3=rep(NA,BB)

RS=c(1:nrow(v))

for(b in 1:BB)
{
	cat(b,"\n")
	vb=v[sample(RS,replace=T),]
	vgb=aggregate(vb[1],by=list(vb$CNV.Ortho,vb$CNV.copy,vb$intronless),length)
	colnames(vgb)=c('CNV.ortho','CNV.copy','intronless','geneN')

	Ab=subset(vgb,CNV.ortho=='CNV' & CNV.copy=='yes' & intronless=='yes')$geneN
	Bb=subset(vgb,CNV.ortho=='CNV' & CNV.copy=='yes' & intronless=='no')$geneN

	vk=subset(vgb,CNV.ortho=='CNV' & CNV.copy=='no' & intronless=='yes')
	Cb=vk$geneN

	Db=subset(vgb,CNV.ortho=='CNV' & CNV.copy=='no' & intronless=='no')$geneN
	Eb=subset(vgb,CNV.ortho=='nonCNV' & CNV.copy=='no' & intronless=='yes')$geneN
	Fb=subset(vgb,CNV.ortho=='nonCNV' & CNV.copy=='no' & intronless=='no')$geneN

	bCNV.p=Ab/(Ab+Bb)
	bnonCNV.p=Cb/(Cb+Db)
	bnonCNVo=Eb/(Eb+Fb)

	Db=vk$V1

	if(nrow(vk)>0)
	{
		BT1[b]=bCNV.p
		BT2[b]=bnonCNV.p
		BT3[b]=bnonCNVo
	}
	else
	{
		b=b-1
	}
}

BT1= BT1[!is.na(BT1)][c(1:1000)]
BT2= BT2[!is.na(BT2)][c(1:1000)]
BT3= BT3[!is.na(BT3)][c(1:1000)]


RES=rbind(
data.frame(type='CNV ortholog',mn=CNV.p,u.ci=sort(BT1)[975],l.ci=sort(BT1)[25]),
data.frame(type='non-CNV ortholog',mn=nonCNV.p,u.ci=sort(BT2)[975],l.ci=sort(BT2)[25]),
data.frame(type='orthogroup without CNV orthologs',mn=nonCNVo,u.ci=sort(BT3)[975],l.ci=sort(BT3)[25])
)
		
write.table(RES,'/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/all/mean.intronloss',row.names=FALSE,sep="\t",quot=FALSE)


	
	



