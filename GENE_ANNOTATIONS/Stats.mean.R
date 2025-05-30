v=read.table('/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Stats/collect.txt',h=T)

vg=aggregate(v[c(4,5)],by=list(v$sample,v$category),mean)
colnames(vg)[1]='sample'
colnames(vg)[2]='category'

write.table(vg,'/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Stats/mean.txt',quote=F,sep="\t",row.names=F)

with(subset(vg,category=='intact'),min(Identity))
#[1] 0.9910394
with(subset(vg,category=='intact'),max(Identity))
#[1] 0.9922193

with(subset(vg,category=='stopcodons'),min(Identity))
#[1] 0.9826505
with(subset(vg,category=='stopcodons'),max(Identity))
#[1] 0.9851983

t.test(subset(vg,category=='intact')$Identity,subset(vg,category=='stopcodons')$Identity)
#data:  subset(vg, category == "intact")$Identity and subset(vg, category == "stopcodons")$Identity
#t = 66.308, df = 44.427, p-value < 2.2e-16
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
# 0.007388251 0.007851319
#sample estimates:
#mean of x mean of y 
#0.9919427 0.9843230 

wilcox.test(subset(vg,category=='intact')$Identity,subset(vg,category=='stopcodons')$Identity)
#	Wilcoxon rank sum exact test
#
#data:  subset(vg, category == "intact")$Identity and subset(vg, category == "stopcodons")$Identity
#W = 1296, p-value < 2.2e-16
#alternative hypothesis: true location shift is not equal to 0
 

##############
with(subset(vg,category=='intact'),min(Coverage))
#[1] 0.9948738
with(subset(vg,category=='intact'),max(Coverage))
#[1] 0.9955373

with(subset(vg,category=='stopcodons'),min(Coverage))
#[1] 0.9869415
with(subset(vg,category=='stopcodons'),max(Coverage))
#[1] 0.9893978

t.test(subset(vg,category=='intact')$Coverage,subset(vg,category=='stopcodons')$Coverage)

#data:  subset(vg, category == "intact")$Coverage and subset(vg, category == "stopcodons")$Coverage
#t = 62.199, df = 37.639, p-value < 2.2e-16
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
# 0.006557515 0.006998875
#sample estimates:
#mean of x mean of y 
#0.9953441 0.9885659 

wilcox.test(subset(vg,category=='intact')$Coverage,subset(vg,category=='stopcodons')$Coverage)
#data:  subset(vg, category == "intact")$Coverage and subset(vg, category == "stopcodons")$Coverage
#W = 1296, p-value < 2.2e-16
#alternative hypothesis: true location shift is not equal to 0


nrow(subset(v,Coverage==1 & category== "stopcodons"))
#[1] 0
nrow(subset(v,Identity==1 & category== "stopcodons"))
#[1] 0
 




