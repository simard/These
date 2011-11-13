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
dat.passive.trpzipper.residue = data.frame(
										mean.diff.passive = dat.exp2.trpzipper.residue$mean.diff.passive,
										group.number = dat.exp2.trpzipper.residue$group.number,
										task = rep("1A",length(dat.exp2.trpzipper.residue$group.number))
										)
dat.passive.trpcage.residue = data.frame(
										mean.diff.passive = dat.exp2.trpcage.residue$mean.diff.passive,
										group.number = dat.exp2.trpcage.residue$group.number,
										task = rep("1B",length(dat.exp2.trpcage.residue$group.number))
										)
dat.passive.trpzipper.atom = data.frame(
										mean.diff.passive = dat.exp2.trpzipper.atom$mean.diff.passive,
										group.number = dat.exp2.trpzipper.atom$group.number,
										task = rep("2A",length(dat.exp2.trpzipper.atom$group.number))
										)
dat.passive.trpcage.atom = data.frame(
										mean.diff.passive = dat.exp2.trpcage.atom$mean.diff.passive,
										group.number = dat.exp2.trpcage.atom$group.number,
										task = rep("2B",length(dat.exp2.trpcage.atom$group.number))
										)
dat.passive = rbind(dat.passive.trpzipper.residue, dat.passive.trpcage.residue, dat.passive.trpzipper.atom, dat.passive.trpcage.atom)
dat.passive.monome = dat.passive[dat.passive$group.number == 1, ]
bp.monome = boxplot(dat.passive.monome$mean.diff.passive~dat.passive.monome$task, plot=FALSE)
colnames(bp.monome$stats) = c("\\myscenario{1a}","\\myscenario{1b}","\\myscenario{2a}","\\myscenario{2b}")
write.table(bp.monome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
dat.passive.binome = dat.passive[dat.passive$group.number == 2, ]
bp.binome = boxplot(dat.passive.binome$mean.diff.passive~dat.passive.binome$task, plot=FALSE)
write.table(bp.binome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append = TRUE)

dat.passive.trpzipper = dat.exp2.trpzipper
shapiro = shapiro.test(dat.passive.trpzipper$mean.diff.passive)
levene = levene.test(dat.passive.trpzipper$mean.diff.passive, dat.passive.trpzipper$group.number)
kruskal = kruskal.test(dat.passive.trpzipper$mean.diff.passive~dat.passive.trpzipper$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-trpzipper.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat = dat.passive.trpzipper
pop.a = dat[ dat$group.number == 1, ]$mean.diff.passive
pop.b = dat[ dat$group.number == 2, ]$mean.diff.passive
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio-trpzipper.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
dat.passive.trpcage = dat.exp2.trpcage
shapiro = shapiro.test(dat.passive.trpcage$mean.diff.passive)
levene = levene.test(dat.passive.trpcage$mean.diff.passive, dat.passive.trpcage$group.number)
kruskal = kruskal.test(dat.passive.trpcage$mean.diff.passive~dat.passive.trpcage$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-trpcage.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
