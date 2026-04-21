library("ggplot2")
v=read.table('/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/TATA/calcP',h=T)

v1=subset(v,Func=="CNV")
v2=subset(v,Func=="nonCNV")

v1$Func="iORF-CNV"
v2$Func="non-CNV"

v11=v1[c(1,2,4,5,6)]
v12=v1[c(1,2,8,9,10)]
v11$Function="iORF-CNV"
v12$Function="Random"
colnames(v12)=colnames(v11)

v21=v2[c(1,2,4,5,6)]
v22=v2[c(1,2,8,9,10)]
v21$Function="non-CNV"
v22$Function="Random"
colnames(v22)=colnames(v21)

vm1=rbind(v11,v12)
vm2=rbind(v21,v22)

##################

vm1$Function = factor(vm1$Function, levels = c("iORF-CNV","Random"))
vm2$Function = factor(vm2$Function, levels = c("non-CNV","Random"))

j_pos <- position_jitter(width = 0.25, seed = 123)

p1 = ggplot(vm1, aes(x = Function, y = m, group = sample)) +
  geom_line(color = "grey60", position = j_pos, alpha = 0.2, size = 0.4) +
  geom_errorbar(aes(ymin = pmin(l, u), ymax = pmax(l, u), color = Function), 
                position = j_pos, width = 0.01, alpha = 0.3) +
  geom_point(aes(color = Function), position = j_pos, size = 0.8) +
  scale_color_manual(values = c("iORF-CNV" = "red", "Random" = "yellow")) +
  scale_y_continuous(limits = c(0, NA), expand = expansion(mult = c(0, 0.1))) +
  ylab("Proportion of TATA-box genes") +
  xlab("") +
  theme_bw() +
  theme(legend.position = "none")

p2 = ggplot(vm2, aes(x = Function, y = m, group = sample)) +
  geom_line(color = "grey60", position = j_pos, alpha = 0.2, size = 0.4) +
  geom_errorbar(aes(ymin = pmin(l, u), ymax = pmax(l, u), color = Function), 
                position = j_pos, width = 0.01, alpha = 0.3) +
  geom_point(aes(color = Function), position = j_pos, size = 0.8) +
  scale_color_manual(values = c("non-CNV" = "blue", "Random" = "yellow")) +
  scale_y_continuous(limits = c(0, NA), expand = expansion(mult = c(0, 0.1))) +
  ylab("Proportion of TATA-box genes") +
  xlab("") +
  theme_bw() +
  theme(legend.position = "none")


#p1=ggplot(vm1,aes(x=sample,y=m,fill=Function))+geom_bar(stat="identity",position="dodge")+coord_flip()+ylab("Proportion of TATA-box genes")+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()+ scale_fill_manual(labels=c('iORF-CNV','Random'),values=c("red","yellow"))
 
#p2=ggplot(vm2,aes(x=sample,y=m,fill=Function))+geom_bar(stat="identity",position="dodge")+coord_flip()+ylab("Proportion of TATA-box genes")+geom_errorbar(aes(ymin=l,ymax=u),position=position_dodge(width=0.85),width=.2)+theme_bw()+ scale_fill_manual(labels=c('nonCNV','Random'),values=c("blue","yellow"))
 
pdf('/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/TATA.CNV.pdf',width=4.2,height=4.2)
p1
dev.off()

pdf('/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/TATA.nonCNV.pdf',width=4.2,height=4.2)
p2
dev.off()

 




