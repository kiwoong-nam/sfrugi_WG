v=read.table("/home/knam/work/sfrugi_WG/AFS/X/group.txt")
CNV=349
nonCNV=6527

vg=aggregate(v[c(3)],by=list(v$V1,v$V4),length)

vg
#  Group.1 Group.2  V3
#1     CNV      no  99
#2  nonCNV      no 922
#3     CNV     yes 222
#4  nonCNV     yes  98

(vg$V3[3]+vg$V3[4])/CNV
#[1] 0.9169054

vg$V3[3]/CNV
#[1] 0.6361032

vg$V3[1]/nonCNV
#[1] 0.01516776


mat.shared=matrix(c(vg$V3[3],CNV-vg$V3[3],vg$V3[1],nonCNV-vg$V3[1]),ncol=2)
mat.shared
#     [,1] [,2]
#[1,]  222   99
#[2,]  127 6428

fisher.test(mat.shared)
#	Fisher's Exact Test for Count Data
#
#data:  mat.shared
#p-value < 2.2e-16
#alternative hypothesis: true odds ratio is not equal to 1
#95 percent confidence interval:
#  83.80195 154.77912
#sample estimates:
#odds ratio 
# 113.0697 


fisher.test(matrix(vg$V3[c(3,1,4,2)],ncol=2))

#	Fisher's Exact Test for Count Data
#
#data:  matrix(vg$V3[c(3, 1, 4, 2)], ncol = 2)
#p-value < 2.2e-16
#alternative hypothesis: true odds ratio is not equal to 1
#95 percent confidence interval:
# 15.20920 29.27985
#sample estimates:
#odds ratio 
#  21.01627 
