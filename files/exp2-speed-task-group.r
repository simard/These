#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

dat.exp2.trpzipper = dat.exp2[dat.exp2$molecule == "trp-zipper", ]
dat.exp2.trpzipper.residue = dat.exp2.trpzipper[dat.exp2.trpzipper$molecule.scale == "residue", ]
dat.exp2.trpzipper.atom = dat.exp2.trpzipper[dat.exp2.trpzipper$molecule.scale == "atom", ]
dat.exp2.trpcage = dat.exp2[dat.exp2$molecule == "trp-cage", ]
dat.exp2.trpcage.residue = dat.exp2.trpcage[dat.exp2.trpcage$molecule.scale == "residue", ]
dat.exp2.trpcage.atom = dat.exp2.trpcage[dat.exp2.trpcage$molecule.scale == "atom", ]
dat.speed.trpzipper.residue = data.frame(
										mean.speed = dat.exp2.trpzipper.residue$mean.speed,
										group.number = dat.exp2.trpzipper.residue$group.number,
										task = rep("1A",length(dat.exp2.trpzipper.residue$group.number))
										)
dat.speed.trpcage.residue = data.frame(
										mean.speed = dat.exp2.trpcage.residue$mean.speed,
										group.number = dat.exp2.trpcage.residue$group.number,
										task = rep("1B",length(dat.exp2.trpcage.residue$group.number))
										)
dat.speed.trpzipper.atom = data.frame(
										mean.speed = dat.exp2.trpzipper.atom$mean.speed,
										group.number = dat.exp2.trpzipper.atom$group.number,
										task = rep("2A",length(dat.exp2.trpzipper.atom$group.number))
										)
dat.speed.trpcage.atom = data.frame(
										mean.speed = dat.exp2.trpcage.atom$mean.speed,
										group.number = dat.exp2.trpcage.atom$group.number,
										task = rep("2B",length(dat.exp2.trpcage.atom$group.number))
										)
dat.speed = rbind(dat.speed.trpzipper.residue, dat.speed.trpcage.residue, dat.speed.trpzipper.atom, dat.speed.trpcage.atom)
dat.speed.monome = dat.speed[dat.speed$group.number == 1, ]
bp.monome = boxplot(dat.speed.monome$mean.speed~dat.speed.monome$task, plot=FALSE)
colnames(bp.monome$stats) = c("\\myscenario{1a}","\\myscenario{1b}","\\myscenario{2a}","\\myscenario{2b}")
write.table(bp.monome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
dat.speed.binome = dat.speed[dat.speed$group.number == 2, ]
bp.binome = boxplot(dat.speed.binome$mean.speed~dat.speed.binome$task, plot=FALSE)
write.table(bp.binome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append = TRUE)

dat.speed.trpzipper = dat.exp2.trpzipper
shapiro = shapiro.test(dat.speed.trpzipper$mean.speed)
levene = levene.test(dat.speed.trpzipper$mean.speed, dat.speed.trpzipper$group.number)
kruskal = kruskal.test(dat.speed.trpzipper$mean.speed~dat.speed.trpzipper$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-trpzipper.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat = dat.speed.trpzipper
pop.a = dat[ dat$group.number == 1, ]$mean.speed
pop.b = dat[ dat$group.number == 2, ]$mean.speed
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio-trpzipper.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
dat.speed.trpcage = dat.exp2.trpcage
shapiro = shapiro.test(dat.speed.trpcage$mean.speed)
levene = levene.test(dat.speed.trpcage$mean.speed, dat.speed.trpcage$group.number)
kruskal = kruskal.test(dat.speed.trpcage$mean.speed~dat.speed.trpcage$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-trpcage.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat = dat.speed.trpcage
pop.a = dat[ dat$group.number == 1, ]$mean.speed
pop.b = dat[ dat$group.number == 2, ]$mean.speed
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio-trpcage.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
