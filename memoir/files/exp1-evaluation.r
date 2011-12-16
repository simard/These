#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file = get.outname(commandArgs())

# Generate an empty file to prevent compilation from 'Makefile' file
write(
	  "",
	  file = out.file
	  )

summary.efficiency = global.summary(dat.exp1$evaluation.efficiency)
out.summary.efficiency = summary2tex(summary.efficiency)
out.file.efficiency = gsub(".csv", "-efficiency.tex", out.file)
write(
	  out.summary.efficiency,
	  file = out.file.efficiency
	  )

summary.group = global.summary(dat.exp1$evaluation.group)
out.summary.group = summary2tex(summary.group)
out.file.group = gsub(".csv", "-group.tex", out.file)
write(
	  out.summary.group,
	  file = out.file.group
	  )

summary.help = global.summary(dat.exp1$evaluation.help)
out.summary.help = summary2tex(summary.help)
out.file.help = gsub(".csv", "-help.tex", out.file)
write(
	  out.summary.help,
	  file = out.file.help
	  )

summary.leader = global.summary(dat.exp1$evaluation.leader)
out.summary.leader = summary2tex(summary.leader)
out.file.leader = gsub(".csv", "-leader.tex", out.file)
write(
	  out.summary.leader,
	  file = out.file.leader
	  )

summary.verbal = global.summary(dat.exp1$evaluation.verbal)
out.summary.verbal = summary2tex(summary.verbal)
out.file.verbal = gsub(".csv", "-verbal.tex", out.file)
write(
	  out.summary.verbal,
	  file = out.file.verbal
	  )

summary.gestural = global.summary(dat.exp1$evaluation.gestural)
out.summary.gestural = summary2tex(summary.gestural)
out.file.gestural = gsub(".csv", "-gestural.tex", out.file)
write(
	  out.summary.gestural,
	  file = out.file.gestural
	  )

summary.virtual = global.summary(dat.exp1$evaluation.virtual)
out.summary.virtual = summary2tex(summary.virtual)
out.file.virtual = gsub(".csv", "-virtual.tex", out.file)
write(
	  out.summary.virtual,
	  file = out.file.virtual
	  )
