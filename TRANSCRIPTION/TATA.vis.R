library("ggplot2")
v=read.table('/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/TATA/calcP',h=T)

v1=subset(v,Func=="CNV")
v2=subset(v,Func=="nonCNV")

v11=v1[c(1,2,4,5,6)]
v12=v1[c(1,2,8,9,10)]
v11$Function="CNV"
v12$Function="Random"
colnames(v12)=colnames(v11)

v21=v2[c(1,2,4,5,6)]
v22=v2[c(1,2,8,9,10)]
v21$Function="nonCNV"
v22$Function="Random"
colnames(v22)=colnames(v21)

vm1=rbind(v11,v12)
vm2=rbind(v21,v22)

##################""
p1=ggplot(vm1,aes(x=sample,y=m,fill=Function))+geom_bar(stat="identity",position="dodge")+coord_flip()+ylab("Proportion of TATA-box genes")+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()+ scale_fill_manual(labels=c('iORF-CNV','Random'),values=c("red","yellow"))
 
p2=ggplot(vm2,aes(x=sample,y=m,fill=Function))+geom_bar(stat="identity",position="dodge")+coord_flip()+ylab("Proportion of TATA-box genes")+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()+ scale_fill_manual(labels=c('nonCNV','Random'),values=c("blue","yellow"))
 
pdf('/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/TATA.CNV.pdf',width=7.5,height=11)
p1
dev.off()

pdf('/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/TATA.nonCNV.pdf',width=7.5,height=11)
p2
dev.off()

 




