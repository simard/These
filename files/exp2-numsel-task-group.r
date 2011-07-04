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
dat.selection.trpzipper.residue = data.frame(
										total.selection.number = dat.exp2.trpzipper.residue$total.selection.number,
										group.number = dat.exp2.trpzipper.residue$group.number,
										task = rep("1A",length(dat.exp2.trpzipper.residue$group.number))
										)
dat.selection.trpcage.residue = data.frame(
										total.selection.number = dat.exp2.trpcage.residue$total.selection.number,
										group.number = dat.exp2.trpcage.residue$group.number,
										task = rep("1B",length(dat.exp2.trpcage.residue$group.number))
										)
dat.selection.trpzipper.atom = data.frame(
										total.selection.number = dat.exp2.trpzipper.atom$total.selection.number,
										group.number = dat.exp2.trpzipper.atom$group.number,
										task = rep("2A",length(dat.exp2.trpzipper.atom$group.number))
										)
dat.selection.trpcage.atom = data.frame(
										total.selection.number = dat.exp2.trpcage.atom$total.selection.number,
										group.number = dat.exp2.trpcage.atom$group.number,
										task = rep("2B",length(dat.exp2.trpcage.atom$group.number))
										)
dat.selection = rbind(dat.selection.trpzipper.residue, dat.selection.trpcage.residue, dat.selection.trpzipper.atom, dat.selection.trpcage.atom)
dat.selection.monome = dat.selection[dat.selection$group.number == 1, ]
bp.monome = boxplot(dat.selection.monome$total.selection.number~dat.selection.monome$task, plot=FALSE)
colnames(bp.monome$stats) = c("\\myscenario{1a}","\\myscenario{1b}","\\myscenario{2a}","\\myscenario{2b}")
write.table(bp.monome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
dat.selection.binome = dat.selection[dat.selection$group.number == 2, ]
bp.binome = boxplot(dat.selection.binome$total.selection.number~dat.selection.binome$task, plot=FALSE)
write.table(bp.binome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append = TRUE)

dat.selection.trpzipper = dat.exp2.trpzipper
shapiro = shapiro.test(dat.selection.trpzipper$total.selection.number)
levene = levene.test(dat.selection.trpzipper$total.selection.number, dat.selection.trpzipper$group.number)
kruskal = kruskal.test(dat.selection.trpzipper$total.selection.number~dat.selection.trpzipper$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-trpzipper.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat.selection.trpcage = dat.exp2.trpcage
shapiro = shapiro.test(dat.selection.trpcage$total.selection.number)
levene = levene.test(dat.selection.trpcage$total.selection.number, dat.selection.trpcage$group.number)
kruskal = kruskal.test(dat.selection.trpcage$total.selection.number~dat.selection.trpcage$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-trpcage.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
