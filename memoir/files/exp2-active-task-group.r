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
dat.active.trpzipper.residue = data.frame(
										mean.diff.active = dat.exp2.trpzipper.residue$mean.diff.active,
										group.number = dat.exp2.trpzipper.residue$group.number,
										task = rep("1A",length(dat.exp2.trpzipper.residue$group.number))
										)
dat.active.trpcage.residue = data.frame(
										mean.diff.active = dat.exp2.trpcage.residue$mean.diff.active,
										group.number = dat.exp2.trpcage.residue$group.number,
										task = rep("1B",length(dat.exp2.trpcage.residue$group.number))
										)
dat.active.trpzipper.atom = data.frame(
										mean.diff.active = dat.exp2.trpzipper.atom$mean.diff.active,
										group.number = dat.exp2.trpzipper.atom$group.number,
										task = rep("2A",length(dat.exp2.trpzipper.atom$group.number))
										)
dat.active.trpcage.atom = data.frame(
										mean.diff.active = dat.exp2.trpcage.atom$mean.diff.active,
										group.number = dat.exp2.trpcage.atom$group.number,
										task = rep("2B",length(dat.exp2.trpcage.atom$group.number))
										)
dat.active = rbind(dat.active.trpzipper.residue, dat.active.trpcage.residue, dat.active.trpzipper.atom, dat.active.trpcage.atom)
dat.active.monome = dat.active[dat.active$group.number == 1, ]
bp.monome = boxplot(dat.active.monome$mean.diff.active~dat.active.monome$task, plot=FALSE)
colnames(bp.monome$stats) = c("\\myscenario{1a}","\\myscenario{1b}","\\myscenario{2a}","\\myscenario{2b}")
write.table(bp.monome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
dat.active.binome = dat.active[dat.active$group.number == 2, ]
bp.binome = boxplot(dat.active.binome$mean.diff.active~dat.active.binome$task, plot=FALSE)
write.table(bp.binome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append = TRUE)

dat.active.trpzipper = dat.exp2.trpzipper
shapiro = shapiro.test(dat.active.trpzipper$mean.diff.active)
levene = levene.test(dat.active.trpzipper$mean.diff.active, dat.active.trpzipper$group.number)
kruskal = kruskal.test(dat.active.trpzipper$mean.diff.active~dat.active.trpzipper$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-trpzipper.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat = dat.active.trpzipper
pop.a = dat[ dat$group.number == 1, ]$mean.diff.active
pop.b = dat[ dat$group.number == 2, ]$mean.diff.active
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio-trpzipper.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
dat.active.trpcage = dat.exp2.trpcage
shapiro = shapiro.test(dat.active.trpcage$mean.diff.active)
levene = levene.test(dat.active.trpcage$mean.diff.active, dat.active.trpcage$group.number)
kruskal = kruskal.test(dat.active.trpcage$mean.diff.active~dat.active.trpcage$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-trpcage.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat = dat.active.trpcage
pop.a = dat[ dat$group.number == 1, ]$mean.diff.active
pop.b = dat[ dat$group.number == 2, ]$mean.diff.active
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio-trpcage.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
