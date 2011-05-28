#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file = get.outname(commandArgs())

# Generate an empty file to prevent compilation from 'Makefile' file
write(
	  "",
	  file = out.file
	  )

summary.visual.intuitive = global.summary(dat.exp1$platform.visual.intuitive)
out.summary.visual.intuitive = summary2tex(summary.visual.intuitive)
out.file.visual.intuitive = gsub(".csv", "-visual-intuitive.tex", out.file)
write(
	  out.summary.visual.intuitive,
	  file = out.file.visual.intuitive
	  )

summary.visual.confortable = global.summary(dat.exp1$platform.visual.confortable)
out.summary.visual.confortable = summary2tex(summary.visual.confortable)
out.file.visual.confortable = gsub(".csv", "-visual-confortable.tex", out.file)
write(
	  out.summary.visual.confortable,
	  file = out.file.visual.confortable
	  )

summary.interaction.intuitive = global.summary(dat.exp1$platform.interaction.intuitive)
out.summary.interaction.intuitive = summary2tex(summary.interaction.intuitive)
out.file.interaction.intuitive = gsub(".csv", "-interaction-intuitive.tex", out.file)
write(
	  out.summary.interaction.intuitive,
	  file = out.file.interaction.intuitive
	  )

summary.interaction.confortable = global.summary(dat.exp1$platform.interaction.confortable)
out.summary.interaction.confortable = summary2tex(summary.interaction.confortable)
out.file.interaction.confortable = gsub(".csv", "-interaction-confortable.tex", out.file)
write(
	  out.summary.interaction.confortable,
	  file = out.file.interaction.confortable
	  )
