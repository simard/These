#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out_file = get_outname(commandArgs())

bp_sch = boxplot(exp1_dat$time.search.audio~exp1_dat$pattern.number, range=2, plot=FALSE)
titles = c("\\myresidue{1}","\\myresidue{2}","\\myresidue{3}","\\myresidue{4}","\\myresidue{5}","\\myresidue{6}","\\myresidue{7}","\\myresidue{8}","\\myresidue{9}","\\myresidue{10}")
names(bp_sch$stats) = titles
write.table(bp_sch$stats,
			file = out_file,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = titles)
bp_sel = boxplot(exp1_dat$time.selection.audio~exp1_dat$pattern.number, range=2, plot=FALSE)
names(bp_sel$stats) = titles
write.table(bp_sel$stats,
			file = out_file,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append=TRUE)
