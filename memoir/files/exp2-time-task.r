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
bp = boxplot(dat.time$time.completion~dat.time$task, plot=FALSE)
colnames(bp$stats) = c("\\myscenario{1a}","\\myscenario{1b}","\\myscenario{2a}","\\myscenario{2b}")
write.table(bp$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)

shapiro = shapiro.test(dat.time$time.completion)
levene = levene.test(dat.time$time.completion, dat.time$task)
kruskal = kruskal.test(dat.time$time.completion~dat.time$task)
grp1 = dat.time[dat.time$task == "1A", ]$time.completion
grp2 = dat.time[dat.time$task == "1B", ]$time.completion
grp3 = dat.time[dat.time$task == "2A", ]$time.completion
grp4 = dat.time[dat.time$task == "2B", ]$time.completion
grp = cbind(grp1, grp2, grp3, grp4)
friedman = friedman.test(grp)
out.anova = friedman2tex(friedman)
wilcox = pairwise.wilcox.test(dat.time$time.completion, dat.time$task, p.adj="holm", exact=FALSE, pair=FALSE)
out.file.anova = gsub(".csv", "-anova.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
