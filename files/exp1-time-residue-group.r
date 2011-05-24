#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

dat.exp1.monome = dat.exp1[dat.exp1$group.config == "monome", ]
bp.monome = boxplot(dat.exp1.monome$time.completion~dat.exp1.monome$pattern.number, range=2, plot=FALSE)
colnames(bp.monome$stats) = c("\\myresidue{1}","\\myresidue{2}","\\myresidue{3}","\\myresidue{4}","\\myresidue{5}","\\myresidue{6}","\\myresidue{7}","\\myresidue{8}","\\myresidue{9}","\\myresidue{10}")
write.table(bp.monome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
dat.exp1.binome = dat.exp1[dat.exp1$group.config == "binome", ]
bp.binome = boxplot(dat.exp1.binome$time.completion~dat.exp1.binome$pattern.number, range=2, plot=FALSE)
write.table(bp.binome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append=TRUE)
shapiro = shapiro.test(dat.exp1$time.completion)
# Levene test does not work, why? Do not know!
#levene = levene.test(dat.exp1$time.completion, dat.exp1$group.config)
bartlett = bartlett.test(dat.exp1$time.completion, dat.exp1$group.config)
grp1 = dat.exp1[dat.exp1$group.config == "monome",]$time.completion
grp2 = dat.exp1[dat.exp1$group.config == "binome",]$time.completion
grp = cbind(grp1, grp2)
friedman = friedman.test(grp)
out.anova = friedman2tex(friedman)
out.file.anova = gsub(".csv", "-anova.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat = dat.exp1[dat.exp1$pattern.number == 6 | dat.exp1$pattern.number == 9 | dat.exp1$pattern.number == 10,]
shapiro = shapiro.test(dat$time.completion)
# Levene test does not work, why? Do not know!
#levene = levene.test(dat$time.completion, dat$group.config)
bartlett = bartlett.test(dat$time.completion, dat$group.config)
grp1 = dat[dat$group.config == "monome",]$time.completion
grp2 = dat[dat$group.config == "binome",]$time.completion
grp = cbind(grp1, grp2)
friedman = friedman.test(grp)
out.anova = friedman2tex(friedman)
out.file.anova = gsub(".csv", "-anova-restricted.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat.r6 = dat.exp1[dat.exp1$pattern.number == 6,]
shapiro = shapiro.test(dat.r6$time.completion)
# Levene test does not work, why? Do not know!
#levene = levene.test(dat.r6$time.completion, dat.r6$group.config)
bartlett = bartlett.test(dat.r6$time.completion, dat.r6$group.config)
grp1 = dat.r6[dat.r6$group.config == "monome",]$time.completion
grp2 = dat.r6[dat.r6$group.config == "binome",]$time.completion
grp = cbind(grp1, grp2)
friedman = friedman.test(grp)
out.anova = friedman2tex(friedman)
out.file.anova.r6 = gsub(".csv", "-anova-r6.tex", out.file.boxplot)
#write(
#	  out.anova,
#	  file = out.file.anova.r6
#	  )
dat.r9 = dat.exp1[dat.exp1$pattern.number == 9,]
shapiro = shapiro.test(dat.r9$time.completion)
# Levene test does not work, why? Do not know!
#levene = levene.test(dat.r9$time.completion, dat.r9$group.config)
bartlett = bartlett.test(dat.r9$time.completion, dat.r9$group.config)
grp1 = dat.r9[dat.r9$group.config == "monome",]$time.completion
grp2 = dat.r9[dat.r9$group.config == "binome",]$time.completion
grp = cbind(grp1, grp2)
friedman = friedman.test(grp)
out.anova = friedman2tex(friedman)
out.file.anova.r9 = gsub(".csv", "-anova-r9.tex", out.file.boxplot)
#write(
#	  out.anova,
#	  file = out.file.anova.r9
#	  )
dat.r10 = dat.exp1[dat.exp1$pattern.number == 10,]
shapiro = shapiro.test(dat.r10$time.completion)
# Levene test does not work, why? Do not know!
#levene = levene.test(dat.r10$time.completion, dat.r10$group.config)
bartlett = bartlett.test(dat.r10$time.completion, dat.r10$group.config)
grp1 = dat.r10[dat.r10$group.config == "monome",]$time.completion
grp2 = dat.r10[dat.r10$group.config == "binome",]$time.completion
grp = cbind(grp1, grp2)
friedman = friedman.test(grp)
out.anova = friedman2tex(friedman)
out.file.anova.r10 = gsub(".csv", "-anova-r10.tex", out.file.boxplot)
#write(
#	  out.anova,
#	  file = out.file.anova.r10
#	  )
