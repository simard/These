#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

dat.exp2.monome = dat.exp2[dat.exp2$group.number == 1, ]
bp.monome.passive = boxplot(dat.exp2.monome$mean.diff.passive, plot=FALSE)
bp.monome.active = boxplot(dat.exp2.monome$mean.diff.active, plot=FALSE)
bp.monome = cbind(bp.monome.passive$stats, bp.monome.active$stats)
colnames(bp.monome) = c("passive","active")
write.table(bp.monome,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
dat.exp2.binome = dat.exp2[dat.exp2$group.number == 2, ]
bp.binome.passive = boxplot(dat.exp2.binome$mean.diff.passive, plot=FALSE)
bp.binome.active = boxplot(dat.exp2.binome$mean.diff.active, plot=FALSE)
bp.binome = cbind(bp.binome.passive$stats, bp.binome.active$stats)
write.table(bp.binome,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append=TRUE)
dat.diff.passive = data.frame(mean.diff=dat.exp2$mean.diff.passive, group.number=dat.exp2$group.number, is.active=rep(FALSE,length(dat.exp2$group.number)))
shapiro = shapiro.test(dat.diff.passive$mean.diff)
dat.diff.passive.levene = na.omit(data.frame(mean.diff=dat.diff.passive$mean.diff, group.number=dat.diff.passive$group.number))
levene = levene.test(dat.diff.passive.levene$mean.diff, dat.diff.passive.levene$group.number)
grp1 = dat.diff.passive[dat.diff.passive$group.number == 1, ]$mean.diff
grp2 = dat.diff.passive[dat.diff.passive$group.number == 2, ]$mean.diff
grp = cbind(grp1, grp2)
friedman = friedman.test(grp)
out.anova.passive = friedman2tex(friedman)
out.file.anova.passive = gsub(".csv", "-anova-passive.tex", out.file.boxplot)
write(
	  out.anova.passive,
	  file = out.file.anova.passive
	  )
dat.diff.active = data.frame(mean.diff=dat.exp2$mean.diff.active, group.number=dat.exp2$group.number, is.active=rep(TRUE,length(dat.exp2$group.number)))
shapiro = shapiro.test(dat.diff.active$mean.diff)
dat.diff.active.levene = na.omit(data.frame(mean.diff=dat.diff.active$mean.diff, group.number=dat.diff.active$group.number))
levene = levene.test(dat.diff.active.levene$mean.diff, dat.diff.active.levene$group.number)
grp1 = dat.diff.active[dat.diff.active$group.number == 1, ]$mean.diff
grp2 = dat.diff.active[dat.diff.active$group.number == 2, ]$mean.diff
grp = cbind(grp1, grp2)
friedman = friedman.test(grp)
out.anova.active = friedman2tex(friedman)
out.file.anova.active = gsub(".csv", "-anova-active.tex", out.file.boxplot)
write(
	  out.anova.active,
	  file = out.file.anova.active
	  )
dat.diff = rbind(dat.diff.passive,dat.diff.active)
dat.diff.monome = dat.diff[dat.diff$group.number == 1, ]
shapiro = shapiro.test(dat.diff.monome$mean.diff)
dat.diff.monome.levene = na.omit(data.frame(mean.diff=dat.diff.monome$mean.diff, group.number=dat.diff.monome$group.number, is.active=dat.diff.monome$is.active))
levene = levene.test(dat.diff.monome.levene$mean.diff, dat.diff.monome.levene$is.active)
kruskal = kruskal.test(dat.diff.monome$mean.diff~dat.diff.monome$is.active)
out.anova.monome = kruskal2tex(kruskal)
out.file.anova.monome = gsub(".csv", "-anova-monome.tex", out.file.boxplot)
write(
	  out.anova.monome,
	  file = out.file.anova.monome
	  )
dat.diff.binome = dat.diff[dat.diff$group.number == 2, ]
shapiro = shapiro.test(dat.diff.binome$mean.diff)
dat.diff.binome.levene = na.omit(data.frame(mean.diff=dat.diff.binome$mean.diff, group.number=dat.diff.binome$group.number, is.active=dat.diff.binome$is.active))
levene = levene.test(dat.diff.binome.levene$mean.diff, dat.diff.binome.levene$is.active)
kruskal = kruskal.test(dat.diff.binome$mean.diff~dat.diff.binome$is.active)
out.anova.binome = kruskal2tex(kruskal)
out.file.anova.binome = gsub(".csv", "-anova-binome.tex", out.file.boxplot)
write(
	  out.anova.binome,
	  file = out.file.anova.binome
	  )
