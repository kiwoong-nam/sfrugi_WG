v=read.table('/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/all/counting');

BN=1000

vg=aggregate(v[1],by=list(v$V1,v$V2),length)
A=subset(vg,Group.1=='intron' & Group.2=='conserv')$V1
B=subset(vg,Group.1=='intron' & Group.2=='nonconserv')$V1
C=subset(vg,Group.1=='intronless' & Group.2=='conserv')$V1
D=subset(vg,Group.1=='intronless' & Group.2=='nonconserv')$V1

bg1=B/(A+B)
bg2=D/(C+D)

##################

vg

#     Group.1    Group.2   V1
#1     intron    conserv 5719
#2 intronless    conserv  540
#3     intron nonconserv   68
#4 intronless nonconserv   46

fisher.test(matrix(vg$V1,ncol=2))
#
#p-value < 2.2e-16
#alternative hypothesis: true odds ratio is not equal to 1
#95 percent confidence interval:
#  4.763158 10.682683
#sample estimates:
#odds ratio 
#  7.160223 

bg1
#[1] 0.01175048
bg2
#[1] 0.07849829

##################################################

BT1=rep(NA,BN)
BT2=rep(NA,BN)
RS=c(1:nrow(v))

for(b in 1:BN)
{
	v[sample(RS,replace=T),]
	vb=v[sample(RS,replace=T),]

	vgb=aggregate(vb[1],by=list(vb$V1,vb$V2),length)

	Ab=subset(vgb,Group.1=='intron' & Group.2=='conserv')$V1
	Bb=subset(vgb,Group.1=='intron' & Group.2=='nonconserv')$V1
	Cb=subset(vgb,Group.1=='intronless' & Group.2=='conserv')$V1
	Db=subset(vgb,Group.1=='intronless' & Group.2=='nonconserv')$V1

	BT1[b]=Bb/(Ab+Bb)
	BT2[b]=Db/(Cb+Db)
}

RES=rbind(data.frame(type='intronless',mn=bg2,u.ci=sort(BT2)[975],l.ci=sort(BT2)[25]),data.frame(type='intron',mn=bg1,u.ci=sort(BT1)[975],l.ci=sort(BT1)[25]))
	
write.table(RES,'/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/all/mean',row.names=F,sep="\t",quote=F)

	
	

