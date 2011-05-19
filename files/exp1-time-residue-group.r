#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out_file = get_outname(commandArgs())

exp1_dat_mon = exp1_dat[exp1_dat$group.config == "monome", ]
bp_mon = boxplot(exp1_dat_mon$time.completion~exp1_dat_mon$pattern.number, range=2, plot=FALSE)
titles = c("\\myresidue{1}","\\myresidue{2}","\\myresidue{3}","\\myresidue{4}","\\myresidue{5}","\\myresidue{6}","\\myresidue{7}","\\myresidue{8}","\\myresidue{9}","\\myresidue{10}")
names(bp_mon$stats) = titles
write.table(bp_mon$stats,
			file = out_file,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = titles)
exp1_dat_bin = exp1_dat[exp1_dat$group.config == "binome", ]
bp_bin = boxplot(exp1_dat_bin$time.completion~exp1_dat_bin$pattern.number, range=2, plot=FALSE)
titles = c("\\myresidue{1}","\\myresidue{2}","\\myresidue{3}","\\myresidue{4}","\\myresidue{5}","\\myresidue{6}","\\myresidue{7}","\\myresidue{8}","\\myresidue{9}","\\myresidue{10}")
names(bp_bin$stats) = titles
write.table(bp_bin$stats,
			file = out_file,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append=TRUE)
