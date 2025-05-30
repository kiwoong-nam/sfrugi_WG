D='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq/retro.gene/';
B=1000

samples=c('FC01','FC04','FC_102','FC_105','FC33','FC52','FC71','FC77','FC81','FC_85','FC_90','FC_97','FC02','FC_100','FC_103','FC_106','FC35','FC54','FC72','FC78','FC82','FC_88','FC_92','FC_98','FC03','FC_101','FC_104','FC32','FC37','FC55','FC76','FC79','FC_84','FC_89','FC_95','FC_99')


allF=function(vs)
{
	cr=nrow(subset(vs,CNV=='yes' & retro == 'yes'))
	nr=nrow(subset(vs,CNV=='no' & retro == 'yes'))
	cn=nrow(subset(vs,CNV=='yes' & retro == 'no'))
	nn=nrow(subset(vs,CNV=='no' & retro == 'no'))
	
	p1=cr/(cr+cn)
	p2=nr/(nr+nn)
	c(p1,p2)
}	

SF=function(vst)
{
	vs=subset(vst,intronless == 'yes')
	cr=nrow(subset(vs,CNV=='yes' & retro == 'yes'))
	nr=nrow(subset(vs,CNV=='no' & retro == 'yes'))
	cn=nrow(subset(vs,CNV=='yes' & retro == 'no'))
	nn=nrow(subset(vs,CNV=='no' & retro == 'no'))
	
	p1=cr/(cr+cn)
	p2=nr/(nr+nn)
	c(p1,p2)
}	

K=0
RN=data.frame()
for (s in samples)
{
	v=read.table(paste(D,s,sep=''),h=T)

	bga=allF(v)
	bgs=SF(v)

	B.cnv.all=rep(NA,B)
	B.noncnv.all=rep(NA,B)
	B.cnv.intronless=rep(NA,B)
	B.noncnv.intronless=rep(NA,B)

	for(b in c(1:B))
	{
		cat(K," ",b,"\n")
		vb=v[sample(1:nrow(v),replace=T),]
		Bbga=allF(vb)
		Bbgs=SF(vb)

		B.cnv.all[b]=Bbga[1]
		B.noncnv.all[b]=Bbga[2]
		B.cnv.intronless[b]=Bbgs[1]
		B.noncnv.intronless[b]=Bbgs[2]
	}

	B.cnv.all=sort(B.cnv.all)
	B.noncnv.all=sort(B.noncnv.all)
	B.cnv.intronless=sort(B.cnv.intronless)
	B.noncnv.intronless=sort(B.noncnv.intronless)

	R1=data.frame('all','iORF-CNV',bga[1],B.cnv.all[25],B.cnv.all[975])
	R2=data.frame('all','non-CNV',bga[2],B.noncnv.all[25],B.noncnv.all[975])
	R3=data.frame('intronless','iORF-CNV',bgs[1],B.cnv.intronless[25],B.cnv.intronless[975])
	R4=data.frame('intronless','non-CNV',bgs[2],B.noncnv.intronless[25],B.noncnv.intronless[975])

	colnames(R1)=c('intron','category','mn','l','u')
	colnames(R2)=c('intron','category','mn','l','u')
	colnames(R3)=c('intron','category','mn','l','u')
	colnames(R4)=c('intron','category','mn','l','u')

	R=rbind(R1,R2,R3,R4)
	R$sample=s
	RN=rbind(RN,R)
	K=K+1
}

write.table(RN,"/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq/retro.gene.mean",row.names=FALSE,quote=FALSE,sep="\t")


