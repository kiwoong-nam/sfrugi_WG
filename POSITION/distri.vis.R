library("ggplot2")
library(gridExtra)
library(grid)

vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)

v=read.table('/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/merged.txt',h=T)
v1=read.table('/home/kiwoong/Projects/sfrugi_WG/POSITION/Intronless/prop.txt',h=T)

#########################################################################################

v$XA='Autosome'
v$XA[v$chro==29]='Z chromosome'

p1=ggplot(v,aes(x=mn.snv,y=mn.cnv,colour=XA))+geom_point(size=1)+ylab("Proportion of CNV genes")+xlab("SNV density")+theme_bw()+geom_errorbar(aes(xmin=mn.snv-se.snv,xmax=mn.snv+se.snv))+geom_errorbar(aes(ymin=mn.cnv-se.cnv,ymax=mn.cnv+se.cnv))+ expand_limits(x = 0, y = 0)+ theme(legend.position="none")
p2=ggplot(v,aes(x=mn.te.total,y=mn.cnv,colour=XA))+geom_point(size=1)+ylab("Proportion of CNV genes")+xlab("TE density")+theme_bw()+geom_errorbar(aes(xmin=mn.te.total-se.te.total,xmax=mn.te.total+se.te.total))+geom_errorbar(aes(ymin=mn.cnv-se.cnv,ymax=mn.cnv+se.cnv))+ expand_limits(x = 0, y = 0)+theme(legend.title=element_blank())+ theme(legend.position="none")

p3=ggplot(v,aes(x=mn.te.line,y=mn.cnv,colour=XA))+geom_point(size=1)+ylab("Proportion of CNV genes")+xlab("LINE density")+theme_bw()+ expand_limits(x = 0, y = 0)+geom_errorbar(aes(ymin=mn.cnv-se.cnv,ymax=mn.cnv+se.cnv))+geom_errorbar(aes(xmin=mn.te.line-se.te.line,xmax=mn.te.line+se.te.line))+theme(legend.title=element_blank())

##########################################################################
vs=subset(v,chro!=29 & chro !=12)
vs$C.m=with(vs,log(mn.cnv/(1-mn.cnv)))
vs$C.u=with(vs,log((mn.cnv+se.cnv)/(1-mn.cnv-se.cnv)))
vs$C.l=with(vs,log((mn.cnv-se.cnv)/(1-mn.cnv+se.cnv)))

vs$l.m=with(vs,log(mn.te.line/(1-mn.te.line)))
vs$l.u=with(vs,log((mn.te.line+se.te.line)/(1-mn.te.line-se.te.line)))
vs$l.l=with(vs,log((mn.te.line-se.te.line)/(1-mn.te.line+se.te.line)))

R1=as.vector(with(vs,lm(C.m~log(m.rho))$resid))
R2=as.vector(with(vs,lm(l.m~log(m.rho))$resid))
R=data.frame(R1=R1,R2=R2)

p4=ggplot(vs,aes(x=log(m.rho),y=mn.snv))+geom_point(size=1,col='#F8766D')+ylab('SNV density')+xlab(expression(paste('log(',r^2,')')))+theme_bw()+geom_errorbar(aes(xmin=log(l.rho),xmax=log(u.rho)),col='#F8766D')+geom_errorbar(aes(ymin=mn.snv-se.snv,ymax=mn.snv+se.snv),col='#F8766D')+ expand_limits(y = 0)

p5=ggplot(R,aes(x=R2,y=R1))+geom_point(size=1,col='#F8766D')+ylab(expression(paste('resid[ Logit(CNV density) ~ log(',r^2,') ]')))+xlab(expression(paste('resid[ Logit(LINE density) ~ log(',r^2,') ]')))+ theme_bw()

p6=ggplot(vs,aes(x=m.cds,y=mn.cnv))+geom_point(size=1,col='#F8766D')+ylab("Proportion of CNV genes")+xlab("CDS density")+theme_bw()+ expand_limits(x = 0, y = 0)+geom_errorbar(aes(ymin=mn.cnv-se.cnv,ymax=mn.cnv+se.cnv),col='#F8766D')+geom_errorbar(aes(xmin=l.cds,xmax=u.cds),col='#F8766D')+theme(legend.title=element_blank())

px=ggplot(vs,aes(x=log(m.rho),y=C.m))+geom_point(size=1,col='#F8766D')+ylab('Logit(CNV density)')+xlab(expression(paste('log(',r^2,')')))+theme_bw()+geom_errorbar(aes(xmin=log(l.rho),xmax=log(u.rho)),col='#F8766D')+geom_errorbar(aes(ymin=C.l,ymax=C.u),col='#F8766D')


####################################################################
colnames(v1)[1]='chro'

vi.S=merge(vs[c(1,8,9)],v1,by='chro')

with(vi.S,cor.test(mn.te.line,m,method="spearman"))
#S = 1162, p-value = 0.0003805
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#      rho 
#0.6452991

p7=ggplot(vi.S,aes(x=mn.te.line,y=m))+geom_point(size=1,col='#F8766D')+ylab("Proportion of intronless genes")+xlab("LINE density")+theme_bw()+ expand_limits(x = 0, y = 0)+geom_errorbar(aes(ymin=l,ymax=u),col='#F8766D')+geom_errorbar(aes(xmin=mn.te.line-se.te.line,xmax=mn.te.line+se.te.line),col='#F8766D')+theme(legend.title=element_blank())

###################################################################

pdf('/home/kiwoong/Projects/sfrugi_WG/POSITION/distri.pdf',width=12,height=7)
grid.newpage()
pushViewport(viewport(layout = grid.layout(100, 365)))
print(p1, vp = vplayout(c(1:51),c(1:100)))
print(p2, vp = vplayout(c(1:51),c(110:210)))
print(p3, vp = vplayout(c(1:51),c(220:365)))
print(p5, vp = vplayout(c(53:100),c(1:100)))
print(p7, vp = vplayout(c(53:100),c(108:210)))
print(p6, vp = vplayout(c(53:100),c(213:318)))
dev.off()

###################

pdf('/home/kiwoong/Projects/sfrugi_WG/POSITION/distri_r2_SNP.pdf',width=5,height=5)
p4
dev.off()

pdf('/home/kiwoong/Projects/sfrugi_WG/POSITION/distri_particalC.pdf',width=5,height=5)
px
dev.off()

