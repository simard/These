#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

dat.active.monome = dat.exp2[dat.exp2$group.number == 1, ]
bp.monome = boxplot(dat.active.monome$mean.diff.active~dat.active.monome$group.try, plot=FALSE)
colnames(bp.monome$stats) = c("1","2","3")
write.table(bp.monome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
dat.active.binome = dat.exp2[dat.exp2$group.number == 2, ]
bp.binome = boxplot(dat.active.binome$mean.diff.active~dat.active.binome$group.try, plot=FALSE)
write.table(bp.binome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append = TRUE)

dat.active.try1 = dat.exp2[dat.exp2$group.try == 1, ]
shapiro = shapiro.test(dat.active.try1$mean.diff.active)
levene = levene.test(dat.active.try1$mean.diff.active, dat.active.try1$group.number)
kruskal = kruskal.test(dat.active.try1$mean.diff.active~dat.active.try1$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-try1.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat = dat.active.try1
pop.a = dat[ dat$group.number == 1, ]$mean.diff.active
pop.b = dat[ dat$group.number == 2, ]$mean.diff.active
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio-try1.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
dat.active.try2 = dat.exp2[dat.exp2$group.try == 2, ]
shapiro = shapiro.test(dat.active.try2$mean.diff.active)
levene = levene.test(dat.active.try2$mean.diff.active, dat.active.try2$group.number)
kruskal = kruskal.test(dat.active.try2$mean.diff.active~dat.active.try2$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-try2.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat = dat.active.try2
pop.a = dat[ dat$group.number == 1, ]$mean.diff.active
pop.b = dat[ dat$group.number == 2, ]$mean.diff.active
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio-try2.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
dat.active.try3 = dat.exp2[dat.exp2$group.try == 3, ]
shapiro = shapiro.test(dat.active.try3$mean.diff.active)
levene = levene.test(dat.active.try3$mean.diff.active, dat.active.try3$group.number)
kruskal = kruskal.test(dat.active.try3$mean.diff.active~dat.active.try3$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-try3.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )

shapiro = shapiro.test(dat.active.monome$mean.diff.active)
levene = levene.test(dat.active.monome$mean.diff.active, dat.active.monome$group.try)
grp1 = dat.active.monome[ dat.active.monome$group.try == 1, ]$mean.diff.active
grp2 = dat.active.monome[ dat.active.monome$group.try == 2, ]$mean.diff.active
grp3 = dat.active.monome[ dat.active.monome$group.try == 3, ]$mean.diff.active
grp = cbind(grp1, grp2, grp3)
friedman = friedman.test(grp)
wilcox = pairwise.wilcox.test( dat.active.monome$mean.diff.active, dat.active.monome$group.try, p.adj="holm", exact=FALSE, pair=FALSE)
out.anova = friedman2tex(friedman)
out.file.anova = gsub(".csv", "-anova-monome.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
out.ratio = evolution2tex(grp1, grp3)
out.file.ratio = gsub(".csv", "-ratio-monome.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )

shapiro = shapiro.test(dat.active.binome$mean.diff.active)
levene = levene.test(dat.active.binome$mean.diff.active, dat.active.binome$group.try)
grp1 = dat.active.binome[ dat.active.binome$group.try == 1, ]$mean.diff.active
grp2 = dat.active.binome[ dat.active.binome$group.try == 2, ]$mean.diff.active
grp3 = dat.active.binome[ dat.active.binome$group.try == 3, ]$mean.diff.active
grp = cbind(grp1, grp2, grp3)
friedman = friedman.test(grp)
out.anova = friedman2tex(friedman)
out.file.anova = gsub(".csv", "-anova-binome.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
