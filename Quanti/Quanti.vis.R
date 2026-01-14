library("ggplot2")

v=read.table('/home/kiwoong/Projects/sfrugi_WG/Quanti/indicatorN.txt',h=T)

p=ggplot(v, aes(x=as.factor(indicator), y=proportion)) +  geom_boxplot(outlier.shape = NA, alpha=0.5, width=0.5, fill="white") +  geom_jitter(position=position_jitter(0.2), size=2, alpha=0.6, color="red") +  theme_bw() +  labs(x="minimum number of supported indicators",       y="proportion of iORF-CNV genes") +  theme(axis.text = element_text(size=12, color="black"), axis.title = element_text(size=12)) +  ylim(0, 1.0)
  

pdf("/home/kiwoong/Projects/sfrugi_WG/Quanti/Quanti.pdf",width=5,height=5)
p
dev.off()

