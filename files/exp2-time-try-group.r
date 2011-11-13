#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

dat.time.monome = dat.exp2[dat.exp2$group.number == 1, ]
bp.monome = boxplot(dat.time.monome$time.completion~dat.time.monome$group.try, plot=FALSE)
colnames(bp.monome$stats) = c("1","2","3")
write.table(bp.monome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
dat.time.binome = dat.exp2[dat.exp2$group.number == 2, ]
bp.binome = boxplot(dat.time.binome$time.completion~dat.time.binome$group.try, plot=FALSE)
write.table(bp.binome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append = TRUE)

dat.time.try1 = dat.exp2[dat.exp2$group.try == 1, ]
shapiro = shapiro.test(dat.time.try1$time.completion)
levene = levene.test(dat.time.try1$time.completion, dat.time.try1$group.number)
kruskal = kruskal.test(dat.time.try1$time.completion~dat.time.try1$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-try1.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat.time.try2 = dat.exp2[dat.exp2$group.try == 2, ]
shapiro = shapiro.test(dat.time.try2$time.completion)
levene = levene.test(dat.time.try2$time.completion, dat.time.try2$group.number)
kruskal = kruskal.test(dat.time.try2$time.completion~dat.time.try2$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-try2.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat.time.try3 = dat.exp2[dat.exp2$group.try == 3, ]
shapiro = shapiro.test(dat.time.try3$time.completion)
levene = levene.test(dat.time.try3$time.completion, dat.time.try3$group.number)
kruskal = kruskal.test(dat.time.try3$time.completion~dat.time.try3$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-try3.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )

shapiro = shapiro.test(dat.time.monome$time.completion)
levene = levene.test(dat.time.monome$time.completion, dat.time.monome$group.try)
grp1 = dat.time.monome[ dat.time.monome$group.try == 1, ]$time.completion
grp2 = dat.time.monome[ dat.time.monome$group.try == 2, ]$time.completion
grp3 = dat.time.monome[ dat.time.monome$group.try == 3, ]$time.completion
grp = cbind(grp1, grp2, grp3)
friedman = friedman.test(grp)
wilcox = pairwise.wilcox.test(dat.time.monome$time.completion, dat.time.monome$group.try, p.adj="holm", exact=TRUE, pair=TRUE)
out.anova = friedman2tex(friedman)
out.file.anova = gsub(".csv", "-anova-monome.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
out.ratio = evolution2tex(grp2, grp3)
out.file.ratio = gsub(".csv", "-ratio-monome.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )

shapiro = shapiro.test(dat.time.binome$time.completion)
levene = levene.test(dat.time.binome$time.completion, dat.time.binome$group.try)
grp1 = dat.time.binome[ dat.time.binome$group.try == 1, ]$time.completion
grp2 = dat.time.binome[ dat.time.binome$group.try == 2, ]$time.completion
grp3 = dat.time.binome[ dat.time.binome$group.try == 3, ]$time.completion
grp = cbind(grp1, grp2, grp3)
friedman = friedman.test(grp)
wilcox = pairwise.wilcox.test(dat.time.binome$time.completion, dat.time.binome$group.try, p.adj="holm", exact=FALSE, pair=FALSE)
out.anova = friedman2tex(friedman)
out.file.anova = gsub(".csv", "-anova-binome.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
out.ratio = evolution2tex(grp1, grp2)
out.file.ratio = gsub(".csv", "-ratio-binome.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
