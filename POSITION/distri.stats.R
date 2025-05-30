v=read.table('/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/merged.txt',header=T)

with(subset(v,chro!=29),cor.test(log(mn.cnv)/(1-mn.cnv),log(m.rho),method="spearman"))

#data:  log(mn.cnv)/(1 - mn.cnv) and log(m.rho)
#S = 1466, p-value = 0.001191
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#      rho 
#0.589491


with(subset(v,chro!=29),cor.test(log(mn.cnv)/(1-mn.cnv),log(mn.te.line),method="spearman"))
#data:  log(mn.cnv)/(1 - mn.cnv) and log(mn.te.line)
#S = 982, p-value = 1.724e-05
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#      rho 
#0.7312534

with(v,cor.test(mn.snv,mn.cnv,method="spearman"))

#	Spearman's rank correlation rho
#
#data:  mn.snv and mn.cnv
#S = 5998, p-value = 0.003165
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#       rho 
#-0.535468 

with(v,cor.test(mn.cnv,mn.te.total,method="spearman"))

#	Spearman's rank correlation rho
#
#data:  mn.cnv and mn.te.total
#S = 1260, p-value = 5.473e-05
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#     rho 
#0.6896552

with(v,cor.test(mn.cnv,mn.te.line,method="spearman"))
#	Spearman's rank correlation rho
#
#data:  mn.cnv and mn.te.line
#S = 1170, p-value = 1.176e-05
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#      rho 
#0.7320197

###############################################################################################
###############################################################################################
###############################################################################################

vs=subset(v,chro!=29 & chro !=12)

with(v,cor.test(m.rho,mn.snv,method="spearman"))

#data:  m.rho and mn.snv
#S = 7752, p-value = 3.531e-07
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#       rho 
#-0.9093596 


with(v,cor.test(m.rho,mn.te.total,method="spearman"))

#data:  m.rho and mn.te.total
#S = 530, p-value = 7.67e-07
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#      rho 
#0.8694581 

with(v,cor.test(m.rho,mn.te.line,method="spearman"))
#data:  m.rho and mn.te.line
#S = 712, p-value = 1.203e-06
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#      rho 
#0.8246305 

with(v,cor.test(m.rho,mn.cnv,method="spearman"))
#data:  m.rho and mn.cnv
#S = 1868, p-value = 0.001815
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#      rho 
#0.5615764


#########

test1=with(vs,lm(log(mn.cnv)/(1-mn.cnv)~log(m.rho)))
test2=with(vs,lm(log(mn.te.line/(1-mn.te.line))~log(m.rho)))

cor.test(resid(test1),resid(test2),method='spearman')

#data:  resid(test1) and resid(test2)
#S = 1644,, p-value = 0.008921
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#      rho 
#0.4981685

cor.test(resid(test1),resid(test2))
#data:  resid(test1) and resid(test2)
#t = 3.3266, df = 25, p-value = 0.00272
#alternative hypothesis: true correlation is not equal to 0
#95 percent confidence interval:
# 0.2202805 0.7715324
#sample estimates:
#      cor 
#0.5539255 

###############

with(vs,cor.test(m.cds,mn.cnv,method="spearman"))
#data:  m.cds and mn.cnv
#S = 5374, p-value = 0.0004332
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#       rho 
#-0.6404151


