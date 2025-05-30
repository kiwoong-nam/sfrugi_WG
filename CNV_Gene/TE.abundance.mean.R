v=read.table('/home/knam/work/sfrugi_WG/POSITION/TE/abundance/count',h=T)

vg=aggregate(v[c(4:8)],by=list(v$sample,v$chrN),sum)

vg$Retro.d=with(vg,Retro/contigL)
vg$DNA.d=with(vg,DNA/contigL)
vg$RC.d=with(vg,RC/contigL)
vg$total.d=with(vg,total/contigL)

vgg1=aggregate(vg[c(8:11)],by=list(vg$Group.2),mean)

vgg2=aggregate(vg[c(8:11)],by=list(vg$Group.2),sd)
vgg3=aggregate(vg[c(8:11)],by=list(vg$Group.2),length)
vgg.se=merge(vgg2,vgg3,by='Group.1')

vgg.se$Retro.se=with(vgg.se,Retro.d.x/sqrt(Retro.d.y))
vgg.se$DNA.se=with(vgg.se,DNA.d.x/sqrt(DNA.d.y))
vgg.se$RC.se=with(vgg.se,RC.d.x/sqrt(RC.d.y))
vgg.se$total.se=with(vgg.se,total.d.x/sqrt(total.d.y))

vf=merge(vgg1,vgg.se[c(1,10:13)],by='Group.1')
colnames(vf)[c(1:5)]=c('chro','Retro.m','DNA.m','RC.m','Total.m')

write.table(vf,'/home/knam/work/sfrugi_WG/POSITION/TE/abundance/mean',row.names=F,quote=F,sep="\t")
 




