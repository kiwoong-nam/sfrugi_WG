library("ggplot2")

v=read.table('/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/divergence/divergence.txt',h=T)

v1=data.frame(codon="first",v$div1)
v2=data.frame(codon="second",v$div2)
v3=data.frame(codon="third",v$div3)

colnames(v1)[2]='divergence'
colnames(v2)[2]='divergence'
colnames(v3)[2]='divergence'
vm=rbind(v1,v2,v3)

p=ggplot(vm,aes(x=divergence,fill=codon))+geom_density(adjust=2,alpha=0.3)+xlim(0,0.15)+theme_bw()+xlab("pairwise divergence within sample")

#+geom_vline(xintercept=vr[3,2])+geom_vline(xintercept=vr[3,3],linetype='dashed')+geom_vline(xintercept=vr[3,4],linetype='dashed')  

pdf("/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/divergence.pdf",width=5.5,height=4)
p
dev.off()

