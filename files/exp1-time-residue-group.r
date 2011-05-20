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
