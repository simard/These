#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

dat.speed.monome = dat.exp2[dat.exp2$group.number == 1, ]
bp.monome = boxplot(dat.speed.monome$mean.speed~dat.speed.monome$group.try, plot=FALSE)
colnames(bp.monome$stats) = c("1","2","3")
write.table(bp.monome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
dat.speed.binome = dat.exp2[dat.exp2$group.number == 2, ]
bp.binome = boxplot(dat.speed.binome$mean.speed~dat.speed.binome$group.try, plot=FALSE)
write.table(bp.binome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append = TRUE)

dat.speed.try1 = dat.exp2[dat.exp2$group.try == 1, ]
shapiro = shapiro.test(dat.speed.try1$mean.speed)
levene = levene.test(dat.speed.try1$mean.speed, dat.speed.try1$group.number)
kruskal = kruskal.test(dat.speed.try1$mean.speed~dat.speed.try1$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-try1.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat = dat.speed.try1
pop.a = dat[ dat$group.number == 1, ]$mean.speed
pop.b = dat[ dat$group.number == 2, ]$mean.speed
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio-try1.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
dat.speed.try2 = dat.exp2[dat.exp2$group.try == 2, ]
shapiro = shapiro.test(dat.speed.try2$mean.speed)
levene = levene.test(dat.speed.try2$mean.speed, dat.speed.try2$group.number)
kruskal = kruskal.test(dat.speed.try2$mean.speed~dat.speed.try2$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-try2.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat = dat.speed.try2
pop.a = dat[ dat$group.number == 1, ]$mean.speed
pop.b = dat[ dat$group.number == 2, ]$mean.speed
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio-try2.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
dat.speed.try3 = dat.exp2[dat.exp2$group.try == 3, ]
shapiro = shapiro.test(dat.speed.try3$mean.speed)
levene = levene.test(dat.speed.try3$mean.speed, dat.speed.try3$group.number)
kruskal = kruskal.test(dat.speed.try3$mean.speed~dat.speed.try3$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-try3.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat = dat.speed.try3
pop.a = dat[ dat$group.number == 1, ]$mean.speed
pop.b = dat[ dat$group.number == 2, ]$mean.speed
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio-try3.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )

shapiro = shapiro.test(dat.speed.monome$mean.speed)
levene = levene.test(dat.speed.monome$mean.speed, dat.speed.monome$group.try)
grp1 = dat.speed.monome[ dat.speed.monome$group.try == 1, ]$mean.speed
grp2 = dat.speed.monome[ dat.speed.monome$group.try == 2, ]$mean.speed
grp3 = dat.speed.monome[ dat.speed.monome$group.try == 3, ]$mean.speed
grp = cbind(grp1, grp2, grp3)
friedman = friedman.test(grp)
wilcox = pairwise.wilcox.test( dat.speed.monome$mean.speed, dat.speed.monome$group.try, p.adj="holm", exact=FALSE, pair=FALSE)
out.anova = friedman2tex(friedman)
out.file.anova = gsub(".csv", "-anova-monome.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
out.ratio = evolution2tex(grp1, grp2)
out.file.ratio = gsub(".csv", "-ratio-monome.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )

shapiro = shapiro.test(dat.speed.binome$mean.speed)
levene = levene.test(dat.speed.binome$mean.speed, dat.speed.binome$group.try)
grp1 = dat.speed.binome[ dat.speed.binome$group.try == 1, ]$mean.speed
grp2 = dat.speed.binome[ dat.speed.binome$group.try == 2, ]$mean.speed
grp3 = dat.speed.binome[ dat.speed.binome$group.try == 3, ]$mean.speed
grp = cbind(grp1, grp2, grp3)
friedman = friedman.test(grp)
wilcox = pairwise.wilcox.test( dat.speed.binome$mean.speed, dat.speed.binome$group.try, p.adj="holm", exact=FALSE, pair=FALSE)
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
