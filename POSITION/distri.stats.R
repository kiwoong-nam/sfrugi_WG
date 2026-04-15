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
#S = 6236, p-value = 0.003133
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#       rho 
#-0.5359606 


with(v,cor.test(m.rho,mn.te.total,method="spearman"))
#data:  m.rho and mn.te.total
#S = 1356, p-value = 0.000118
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#      rho 
#0.6660099 

with(v,cor.test(m.rho,mn.te.line,method="spearman"))
#data:  m.rho and mn.te.line
#S = 1620, p-value = 0.0007202
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#      rho 
#0.6009852 

with(v,cor.test(m.rho,mn.cnv,method="spearman"))
#	Spearman's rank correlation rho
#
#data:  m.rho and mn.cnv
#S = 1820, p-value = 0.00225
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#      rho 
#0.5517241 


#########

test1=with(vs,lm(log(mn.cnv)/(1-mn.cnv)~log(m.rho)))
test2=with(vs,lm(log(mn.te.line/(1-mn.te.line))~log(m.rho)))

cor.test(resid(test1),resid(test2),method='spearman')

#	Spearman's rank correlation rho
#
#data:  resid(test1) and resid(test2)
#S = 1182, p-value = 0.0004474
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#      rho 
#0.6391941 

cor.test(resid(test1),resid(test2))
#data:  resid(test1) and resid(test2)
#t = 5.6811, df = 25, p-value = 6.473e-06
#alternative hypothesis: true correlation is not equal to 0
#95 percent confidence interval:
# 0.5185967 0.8797296
#sample estimates:
#      cor 
#0.7506726 

###############

with(vs,cor.test(m.cds,mn.cnv,method="spearman"))
#data:  m.cds and mn.cnv
#S = 5374, p-value = 0.0004332
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#       rho 
#-0.6404151


