#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file = get.outname(commandArgs())

# Generate an empty file to prevent compilation from 'Makefile' file
write(
	  "",
	  file = out.file
	  )

dat.exp4.age = aggregate(
		  dat.exp4,
		  by = list(subject.surname = dat.exp4$subject.surname, subject.name = dat.exp4$subject.name),
		  FUN = smart.mean)
summary.age = global.summary(dat.exp4.age$subject.age)
out.summary.age = summary2tex(summary.age)
out.file.age = gsub(".csv", ".tex", out.file)
write(
	  out.summary.age,
	  file = out.file.age
	  )
