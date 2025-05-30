v1=read.table("/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS/orthology.FAW",h=T)
v2=read.table("/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS/orthology.exigua",h=T)
B=1000
############################################################################################################
############################################################################################################

vg1=aggregate(v1[c(2,3)],by=list(v1$CNV),sum)
vg2=aggregate(v2[c(2,3)],by=list(v2$CNV),sum)

vg1
#         Group.1      N       S
#1    CNVOrtho.CNV   1634   4102
#2 CNVOrtho.nonCNV    457   1890
#3     nonCNVOrtho 103649 544311
vg2
#  Group.1     N     S
#1     CNV   118   165
#2  NONCNV 14180 27872

############################################################################################################
############################################################################################################

# within FAW:
# 1. CNV vs nonCNV copies within CNV orthologs

fisher.test(matrix(c(vg1[1,2],vg1[1,3],vg1[2,2],vg1[2,3]),ncol=2))

#p-value < 2.2e-16
#alternative hypothesis: true odds ratio is not equal to 1
#95 percent confidence interval:
# 1.463430 1.856398
#sample estimates:
#odds ratio 
#   1.64731 


# 2 nonCNV copies within CNV orthologs vs nonCNV orthologs

fisher.test(matrix(c(vg1[2,2],vg1[2,3],vg1[3,2],vg1[3,3]),ncol=2))
#p-value < 2.2e-16
#alternative hypothesis: true odds ratio is not equal to 1
#p-value = 8.182e-06
#alternative hypothesis: true odds ratio is not equal to 1
#95 percent confidence interval:
# 1.143700 1.407431
#sample estimates:
#odds ratio 
#  1.269802 

# within exigua
# CNV vs nonCNV orthologus
fisher.test(matrix(c(vg2[1,2],vg2[1,3],vg2[2,2],vg2[2,3]),ncol=2))
#p-value = 0.005463
#alternative hypothesis: true odds ratio is not equal to 1
#95 percent confidence interval:
# 1.099294 1.792754
#sample estimates:
#odds ratio 
#  1.405731 


############################################################################################################
############################################################################################################
veg=aggregate(v2[c(2,3)],by=list(v2$CNV),sum)

veg[1,2]/veg[1,3]
#[1] 0.7151515
veg[2,2]/veg[2,3]
#[1] 0.5087543

fisher.test(matrix(c(veg[1,2],veg[1,3],veg[2,2],veg[2,3]),ncol=2))
#p-value = 0.005463
#alternative hypothesis: true odds ratio is not equal to 1
#95 percent confidence interval:
# 1.099294 1.792754
#sample estimates:
#odds ratio 
#  1.405731 




 

