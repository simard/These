#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file = get.outname(commandArgs())

# Generate an empty file to prevent compilation from 'Makefile' file
write(
	  "",
	  file = out.file
	  )

dat.exp2.subjects = aggregate(
		  dat.exp2,
		  by = list(subject.surname = dat.exp2$subject.surname, subject.name = dat.exp2$subject.name),
		  FUN = smart.mean)
summary.subjects = summary(factor(dat.exp2.subjects$subject.sex))
	string = "\\mynum{<s>}~sujet<splural> (\\mynum{<f>}~femme<fplural> et \\mynum{<m>}~homme<mplural>)%"
	string = set.subjects(string, summary.subjects["f"][[1]]+summary.subjects["m"][[1]])
	string = set.female(string, summary.subjects["f"][[1]])
	string = set.male(string, summary.subjects["m"][[1]])
	string
out.summary.subjects = subjectssummary2tex(summary.subjects)
out.file.subjects = gsub(".csv", ".tex", out.file)
write(
	  out.summary.subjects,
	  file = out.file.subjects
	  )
