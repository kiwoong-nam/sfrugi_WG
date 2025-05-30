samples=c('FC01','FC04','FC_102','FC_105','FC33','FC52','FC71','FC77','FC81','FC_85','FC_90','FC_97','FC02','FC_100','FC_103','FC_106','FC35','FC54','FC72','FC78','FC82','FC_88','FC_92','FC_98','FC03','FC_101','FC_104','FC32','FC37','FC55','FC76','FC79','FC_84','FC_89','FC_95','FC_99')

D='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq/retro.gene/';

K=0

RN=data.frame()
for (s in samples)
{
	v=read.table(paste(D,s,sep=''),h=T)

	cr=nrow(subset(v,CNV=='yes' & retro == 'yes'))
	nr=nrow(subset(v,CNV=='no' & retro == 'yes'))
	cn=nrow(subset(v,CNV=='yes' & retro == 'no'))
	nn=nrow(subset(v,CNV=='no' & retro == 'no'))

	test=fisher.test(matrix(c(cr,nr,cn,nn),ncol=2))

	RN=rbind(RN,data.frame(s,test$estimate,test$p.value))
}

colnames(RN)=c('sample','odd.ratio','p')

RN$p.adj=p.adjust(RN$p, method = 'fdr')

write.table(RN,'/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq/retro.gene.stats',row.names=F,sep="\t",quote=F)




