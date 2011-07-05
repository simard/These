#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

dat.passive.monome = dat.exp2[dat.exp2$group.number == 1, ]
bp.monome = boxplot(dat.passive.monome$mean.diff.passive~dat.passive.monome$group.try, plot=FALSE)
colnames(bp.monome$stats) = c("1","2","3")
write.table(bp.monome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
dat.passive.binome = dat.exp2[dat.exp2$group.number == 2, ]
bp.binome = boxplot(dat.passive.binome$mean.diff.passive~dat.passive.binome$group.try, plot=FALSE)
write.table(bp.binome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append = TRUE)

dat.passive.try1 = dat.exp2[dat.exp2$group.try == 1, ]
shapiro = shapiro.test(dat.passive.try1$mean.diff.passive)
levene = levene.test(dat.passive.try1$mean.diff.passive, dat.passive.try1$group.number)
kruskal = kruskal.test(dat.passive.try1$mean.diff.passive~dat.passive.try1$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-try1.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat.passive.try2 = dat.exp2[dat.exp2$group.try == 2, ]
shapiro = shapiro.test(dat.passive.try2$mean.diff.passive)
levene = levene.test(dat.passive.try2$mean.diff.passive, dat.passive.try2$group.number)
kruskal = kruskal.test(dat.passive.try2$mean.diff.passive~dat.passive.try2$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-try2.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat.passive.try3 = dat.exp2[dat.exp2$group.try == 3, ]
shapiro = shapiro.test(dat.passive.try3$mean.diff.passive)
levene = levene.test(dat.passive.try3$mean.diff.passive, dat.passive.try3$group.number)
kruskal = kruskal.test(dat.passive.try3$mean.diff.passive~dat.passive.try3$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-try3.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
