library(circlize)

v.l.f=read.table('/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/OrthoChr/BUSCO.genes.litura')[c(1,2,3)]
v.l.l=read.table('/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/OrthoChr/BUSCO.genes.litura')[c(4,5,6)]

v.e.f=read.table('/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/OrthoChr/BUSCO.genes.exigua')[c(1,2,3)]
v.e.e=read.table('/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/OrthoChr/BUSCO.genes.exigua')[c(4,5,6)]

colnames(v.l.f) <- c("chr", "start", "end")
colnames(v.l.l) <- c("chr", "start", "end")
colnames(v.e.f) <- c("chr", "start", "end")
colnames(v.e.e) <- c("chr", "start", "end")

v.l.f$chr <- paste0("Sf", v.l.f$chr,sep='')
v.l.l$chr <- paste0("Sl", v.l.l$chr,sep='')
v.e.f$chr <- paste0("Sf", v.e.f$chr,sep='')
v.e.e$chr <- paste0("Se", v.e.e$chr,sep='')

v.l=rbind(v.l.f,v.l.l)
v.e=rbind(v.e.f,v.e.e)

pdf("/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping.pdf", width = 14*1.3, height = 7*1.3)
par(mfrow = c(1, 2))
circos.genomicInitialize(rbind(v.l.f, v.l.l), plotType = c("labels"))
circos.genomicLink(v.l.f, v.l.l, 
                   col = rand_color(max(nrow(v.l.f),nrow(v.l.l)), transparency = 0.5),
                   border = NA, 
                   lty = 1, 
                   lwd = 0.5)
mtext("A", side = 3, line = -1, adj = 0, cex = 2.5, font = 1)
circos.clear()
circos.genomicInitialize(rbind(v.e.f, v.e.e), plotType = c("labels"))
circos.genomicLink(v.e.f, v.e.e, 
                   col = rand_color(max(nrow(v.e.f),nrow(v.e.e)), transparency = 0.5),
                   border = NA, 
                   lty = 1, 
                   lwd = 0.5)
mtext("B", side = 3, line = -1, adj = 0, cex = 2.5, font = 1)
dev.off()


