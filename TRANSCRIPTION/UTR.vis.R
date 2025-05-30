library("ggplot2")

v=read.table("/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/mean.txt",h=T,sep="\t")

v$fc[v$function.=='Upstream.CNV']='Upstream of iORF-CNV'
v$fc[v$function.=='Upstream.nonCNV']='Upstream of nonCNV'
v$fc[v$function.=='Intergenic']='Intergenic'
v$fc[v$function.=='Intron']='Intronic'
v$fc[v$function.=='TE']='TE'
v$fc[v$function.=='CDS_CNV']='CDS of iORF-CNV'
v$fc[v$function.=='CDS_nonCNV']='CDS of non-CNV'

v$func=factor(v$fc,levels=unique(v$fc)[c(1,6,2,7,4,3)])

############################

p=ggplot(subset(v,function.!="TE"),aes(x=sample,y=m,fill=func))+geom_bar(stat='identity',position='dodge')+geom_errorbar(aes(min=l,max=u),position = position_dodge(width = 0.9),width=0.2)+theme_bw()+ylab("Proportion of mapped sequence")+theme(legend.title=element_blank())

############################

pdf("/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR.pdf",width=11/1.2/1.3,height=5/1.2/1.2)
p
dev.off()


