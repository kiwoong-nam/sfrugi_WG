v=read.table("/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS/counts",h=T)

vg=aggregate(v[c(2,3)],by=list(v$CNV),sum)

fisher.test(matrix(c(vg[1,2],vg[1,3],vg[2,2],vg[2,3]),ncol=2))


#	Fisher's Exact Test for Count Data
#data:  matrix(c(vg[1, 2], vg[1, 3], vg[2, 2], vg[2, 3]), ncol = 2)
#p-value < 2.2e-16
#alternative hypothesis: true odds ratio is not equal to 1
#95 percent confidence interval:
# 3.977789 4.183750
#sample estimates:
#odds ratio 
#  4.079622 


