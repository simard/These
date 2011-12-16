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
dat.time.trpzipper.residue = data.frame(
										time.completion = dat.exp2.trpzipper.residue$time.completion,
										group.number = dat.exp2.trpzipper.residue$group.number,
										task = rep("1A",length(dat.exp2.trpzipper.residue$group.number))
										)
dat.time.trpcage.residue = data.frame(
										time.completion = dat.exp2.trpcage.residue$time.completion,
										group.number = dat.exp2.trpcage.residue$group.number,
										task = rep("1B",length(dat.exp2.trpcage.residue$group.number))
										)
dat.time.trpzipper.atom = data.frame(
										time.completion = dat.exp2.trpzipper.atom$time.completion,
										group.number = dat.exp2.trpzipper.atom$group.number,
										task = rep("2A",length(dat.exp2.trpzipper.atom$group.number))
										)
dat.time.trpcage.atom = data.frame(
										time.completion = dat.exp2.trpcage.atom$time.completion,
										group.number = dat.exp2.trpcage.atom$group.number,
										task = rep("2B",length(dat.exp2.trpcage.atom$group.number))
										)
dat.time = rbind(dat.time.trpzipper.residue, dat.time.trpcage.residue, dat.time.trpzipper.atom, dat.time.trpcage.atom)
dat.time.monome = dat.time[dat.time$group.number == 1, ]
bp.monome = boxplot(dat.time.monome$time.completion~dat.time.monome$task, plot=FALSE)
colnames(bp.monome$stats) = c("\\myscenario{1a}","\\myscenario{1b}","\\myscenario{2a}","\\myscenario{2b}")
write.table(bp.monome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
dat.time.binome = dat.time[dat.time$group.number == 2, ]
bp.binome = boxplot(dat.time.binome$time.completion~dat.time.binome$task, plot=FALSE)
write.table(bp.binome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append = TRUE)

dat.time.trpzipper = dat.exp2.trpzipper
shapiro = shapiro.test(dat.time.trpzipper$time.completion)
levene = levene.test(dat.time.trpzipper$time.completion, dat.time.trpzipper$group.number)
kruskal = kruskal.test(dat.time.trpzipper$time.completion~dat.time.trpzipper$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-trpzipper.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat.time.trpcage = dat.exp2.trpcage
shapiro = shapiro.test(dat.time.trpcage$time.completion)
levene = levene.test(dat.time.trpcage$time.completion, dat.time.trpcage$group.number)
kruskal = kruskal.test(dat.time.trpcage$time.completion~dat.time.trpcage$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-trpcage.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat = dat.time.trpcage
pop.a = dat[ dat$group.number == 1, ]$time.completion
pop.b = dat[ dat$group.number == 2, ]$time.completion
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio-trpcage.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
