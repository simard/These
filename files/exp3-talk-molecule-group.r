#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

dat.binome = dat.exp3[ dat.exp3$group.number == 2, ]
bp.binome = boxplot(dat.binome$verbal.total~dat.binome$molecule, plot=FALSE)
colnames(bp.binome$stats) = c("Prion","Ubiquitin")
write.table(bp.binome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
dat.quadrinome = dat.exp3[dat.exp3$group.number == 4, ]
bp.quadrinome = boxplot(dat.quadrinome$verbal.total~dat.quadrinome$molecule, plot=FALSE)
write.table(bp.quadrinome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append = TRUE)

dat.prion = dat.exp3[ dat.exp3$molecule == "prion", ]
shapiro = shapiro.test(dat.prion$verbal.total)
#levene = levene.test(dat.prion$verbal.total, dat.prion$group.number)
bartlett = bartlett.test(dat.prion$verbal.total, dat.prion$group.number)
grp1 = dat.prion[ dat.prion$group.number == 2, ]$verbal.total
grp2 = dat.prion[ dat.prion$group.number == 4, ]$verbal.total
grp = cbind(grp1, grp2)
friedman = friedman.test(grp)
out.anova = friedman2tex(friedman)
out.file.anova = gsub(".csv", "-anova-prion-group.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )

dat.ubiquitin = dat.exp3[ dat.exp3$molecule == "ubiquitin", ]
shapiro = shapiro.test(dat.ubiquitin$verbal.total)
#levene = levene.test(dat.ubiquitin$verbal.total, dat.ubiquitin$group.number)
bartlett = bartlett.test(dat.ubiquitin$verbal.total, dat.ubiquitin$group.number)
grp1 = dat.ubiquitin[ dat.ubiquitin$group.number == 2, ]$verbal.total
grp2 = dat.ubiquitin[ dat.ubiquitin$group.number == 4, ]$verbal.total
grp = cbind(grp1, grp2)
friedman = friedman.test(grp)
out.anova = friedman2tex(friedman)
out.file.anova = gsub(".csv", "-anova-ubiquitin-group.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
