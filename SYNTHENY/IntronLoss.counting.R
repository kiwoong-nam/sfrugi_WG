v=read.table('/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/IntronLoss/counting');

BN=1000

vg=aggregate(v[1],by=list(v$V1,v$V2),length)
A=subset(vg,Group.1=='intronic' & Group.2=='conserv')$V1
B=subset(vg,Group.1=='intronic' & Group.2=='nonconserv')$V1
C=subset(vg,Group.1=='intronloss' & Group.2=='conserv')$V1
D=subset(vg,Group.1=='intronloss' & Group.2=='nonconserv')$V1
E=subset(vg,Group.1=='sustaintroless' & Group.2=='conserv')$V1
F=subset(vg,Group.1=='sustaintroless' & Group.2=='nonconserv')$V1


bg1=B/(A+B)
bg2=D/(C+D)
bg3=F/(E+F)

##################
vg

#         Group.1    Group.2   V1
#1       intronic    conserv 5719
#2     intronloss    conserv  111
#3 sustaintroless    conserv  429
#4       intronic nonconserv   68
#5     intronloss nonconserv   42
#6 sustaintroless nonconserv    4

bg1
#[1] 0.01175048

bg2
#[1] 0.2745098

bg3
#[1] 0.009237875


##################

fisher.test(matrix(vg$V1[c(1,4,2,5)],ncol=2))

#	Fisher's Exact Test for Count Data
#
#data:  matrix(vg$V1[c(1, 4, 2, 5)], ncol = 2)
#p-value < 2.2e-16
#alternative hypothesis: true odds ratio is not equal to 1
#95 percent confidence interval:
# 20.14748 49.67979
#sample estimates:
#odds ratio 
#  31.75672 


##################################################

BT1=rep(NA,BN)
BT2=rep(NA,BN)
BT3=rep(NA,BN)

RS=c(1:nrow(v))

for(b in 1:BN)
{
	cat(b,"\n")
	v[sample(RS,replace=T),]
	vb=v[sample(RS,replace=T),]

	vgb=aggregate(vb[1],by=list(vb$V1,vb$V2),length)

	Ab=subset(vgb,Group.1=='intronic' & Group.2=='conserv')$V1
	Bb=subset(vgb,Group.1=='intronic' & Group.2=='nonconserv')$V1
	Cb=subset(vgb,Group.1=='intronloss' & Group.2=='conserv')$V1
	Db=subset(vgb,Group.1=='intronloss' & Group.2=='nonconserv')$V1
	Eb=subset(vgb,Group.1=='sustaintroless' & Group.2=='conserv')$V1
	Fb=subset(vgb,Group.1=='sustaintroless' & Group.2=='nonconserv')$V1

	if (length(Fb) == 0) Fb = 0

	BT1[b]=Bb/(Ab+Bb)
	BT2[b]=Db/(Cb+Db)
	BT3[b]=Fb/(Eb+Fb)
}


RES=rbind(data.frame(type='intronic',mn=bg1,u.ci=sort(BT1)[975],l.ci=sort(BT1)[25]),data.frame(type='sustaintroless',mn=bg3,u.ci=sort(BT3)[975],l.ci=sort(BT3)[25]),data.frame(type='intronloss',mn=bg2,u.ci=sort(BT2)[975],l.ci=sort(BT2)[25]))

write.table(RES,'/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/IntronLoss/mean',row.names=FALSE,sep="\t",quote=FALSE)
 
	

