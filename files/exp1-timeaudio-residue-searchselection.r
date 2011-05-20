#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

bp.audio.search = boxplot(dat.exp1$time.search.audio~dat.exp1$pattern.number, range=2, plot=FALSE)
colnames(bp.audio.search$stats) = c("\\myresidue{1}","\\myresidue{2}","\\myresidue{3}","\\myresidue{4}","\\myresidue{5}","\\myresidue{6}","\\myresidue{7}","\\myresidue{8}","\\myresidue{9}","\\myresidue{10}")
write.table(bp.audio.search$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
bp.audio.selection = boxplot(dat.exp1$time.selection.audio~dat.exp1$pattern.number, range=2, plot=FALSE)
write.table(bp.audio.selection$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append=TRUE)
