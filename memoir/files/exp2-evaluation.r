#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file = get.outname(commandArgs())

# Generate an empty file to prevent compilation from 'Makefile' file
write(
	  "",
	  file = out.file
	  )

summary.help = global.summary(dat.exp2$evaluation.help)
out.summary.help = summary2tex(summary.help)
out.file.help = gsub(".csv", "-help.tex", out.file)
write(
	  out.summary.help,
	  file = out.file.help
	  )

summary.leader = global.summary(dat.exp2$evaluation.leader)
out.summary.leader = summary2tex(summary.leader)
out.file.leader = gsub(".csv", "-leader.tex", out.file)
write(
	  out.summary.leader,
	  file = out.file.leader
	  )

summary.verbal = global.summary(dat.exp2$evaluation.verbal)
out.summary.verbal = summary2tex(summary.verbal)
out.file.verbal = gsub(".csv", "-verbal.tex", out.file)
write(
	  out.summary.verbal,
	  file = out.file.verbal
	  )

summary.gestural = global.summary(dat.exp2$evaluation.gestural)
out.summary.gestural = summary2tex(summary.gestural)
out.file.gestural = gsub(".csv", "-gestural.tex", out.file)
write(
	  out.summary.gestural,
	  file = out.file.gestural
	  )

summary.virtual = global.summary(dat.exp2$evaluation.virtual)
out.summary.virtual = summary2tex(summary.virtual)
out.file.virtual = gsub(".csv", "-virtual.tex", out.file)
write(
	  out.summary.virtual,
	  file = out.file.virtual
	  )

summary.monome.monomanual = global.summary(dat.exp2$evaluation.preference.monome.monomanual)
out.summary.monome.monomanual = summary2tex(summary.monome.monomanual)
out.file.monome.monomanual = gsub(".csv", "-monome-monomanual.tex", out.file)
write(
	  out.summary.monome.monomanual,
	  file = out.file.monome.monomanual
	  )

summary.monome.bimanual = global.summary(dat.exp2$evaluation.preference.monome.bimanual)
out.summary.monome.bimanual = summary2tex(summary.monome.bimanual)
out.file.monome.bimanual = gsub(".csv", "-monome-bimanual.tex", out.file)
write(
	  out.summary.monome.bimanual,
	  file = out.file.monome.bimanual
	  )

summary.binome.monomanual = global.summary(dat.exp2$evaluation.preference.binome.monomanual)
out.summary.binome.monomanual = summary2tex(summary.binome.monomanual)
out.file.binome.monomanual = gsub(".csv", "-binome-monomanual.tex", out.file)
write(
	  out.summary.binome.monomanual,
	  file = out.file.binome.monomanual
	  )

dat.exp2.factorize = aggregate(
							   dat.exp2,
							   by = list(
										 dat.exp2$subject.surname,
										 dat.exp2$subject.name
										 ),
							   FUN = smart.mean
							   )
summary.preference = summary(dat.exp2.factorize$evaluation.preference)
summary.preference.total = summary.preference[[1]] + summary.preference[[2]]
summary.preference.binome.monomanual = summary.preference[[1]] / summary.preference.total
summary.preference.monome.bimanual = summary.preference[[2]] / summary.preference.total
out.summary.preference.monome.bimanual = ratio2tex(summary.preference.monome.bimanual)
out.file.preference.monome.bimanual = gsub(".csv", "-preference-monome-bimanual.tex", out.file)
write(
	  out.summary.preference.monome.bimanual,
	  file = out.file.preference.monome.bimanual
	  )
out.summary.preference.binome.monomanual = ratio2tex(summary.preference.binome.monomanual)
out.file.preference.binome.monomanual = gsub(".csv", "-preference-binome-monomanual.tex", out.file)
write(
	  out.summary.preference.binome.monomanual,
	  file = out.file.preference.binome.monomanual
	  )
