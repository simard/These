#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file = get.outname(commandArgs())

# Generate an empty file to prevent compilation from 'Makefile' file
write(
	  "",
	  file = out.file
	  )

dat.exp3.subjects = aggregate(
		  dat.exp3,
		  by = list(subject.surname = dat.exp3$subject.surname, subject.name = dat.exp3$subject.name),
		  FUN = smart.mean)
summary.subjects = summary(factor(dat.exp3.subjects$subject.sex))
out.summary.subjects = subjectssummary2tex(summary.subjects)
out.file.subjects = gsub(".csv", ".tex", out.file)
write(
	  out.summary.subjects,
	  file = out.file.subjects
	  )
