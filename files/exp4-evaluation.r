#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file = get.outname(commandArgs())

dat.sus = aggregate(
				  dat.exp4,
				  by = list(
							id = dat.exp4$id,
							subject.surname = dat.exp4$subject.surname,
							subject.name = dat.exp4$subject.name
							),
				  smart.mean
				  )
dat.q = aggregate(
				  dat.exp4,
				  by = list(
							id = dat.exp4$id,
							subject.surname = dat.exp4$subject.surname,
							subject.name = dat.exp4$subject.name,
							haptic = dat.exp4$haptic
							),
				  smart.mean
				  )

# Generate an empty file to prevent compilation from 'Makefile' file
write(
	  "",
	  file = out.file
	  )

summary.sus = global.summary(dat.sus$questionary.sus)
out.summary.sus = summary2tex(summary.sus)
out.file.sus = gsub(".csv", "-sus.tex", out.file)
write(
	  out.summary.sus,
	  file = out.file.sus
	  )

summary.sus.biologists = global.summary(dat.sus[dat.sus$id == "Maxime_DELORME.Nadege_DEVOS.Nicolas_FEREY" | dat.sus$id == "Marc_PIUZZI.Benoist_LAURENT.Alex_TEK", ]$questionary.sus)
out.summary.sus.biologists = summary2tex(summary.sus.biologists)
out.file.sus.biologists = gsub(".csv", "-sus-biologists.tex", out.file)
write(
	  out.summary.sus.biologists,
	  file = out.file.sus.biologists
	  )

summary.resume.1 = global.summary(dat.q$questionary.resume.1)
out.summary.resume.1 = summary2tex(summary.resume.1)
out.file.resume.1 = gsub(".csv", "-resume-1.tex", out.file)
write(
	  out.summary.resume.1,
	  file = out.file.resume.1
	  )
summary.resume.1.false = global.summary(dat.q[dat.q$haptic == "False", ]$questionary.resume.1)
out.summary.resume.1.false = summary2tex(summary.resume.1.false)
out.file.resume.1.false = gsub(".csv", "-resume-1-false.tex", out.file)
write(
	  out.summary.resume.1.false,
	  file = out.file.resume.1.false
	  )
summary.resume.1.true = global.summary(dat.q[dat.q$haptic == "True", ]$questionary.resume.1)
out.summary.resume.1.true = summary2tex(summary.resume.1.true)
out.file.resume.1.true = gsub(".csv", "-resume-1-true.tex", out.file)
write(
	  out.summary.resume.1.true,
	  file = out.file.resume.1.true
	  )
wilcox.resume.1 = wilcox.test(dat.q$questionary.resume.1 ~ dat.q$haptic, paired = TRUE, na.action = "na.pass")
out.anova.resume.1 = wilcox2tex(wilcox.resume.1)
out.file.wilcox.resume.1 = gsub(".csv", "-resume-1-anova.tex", out.file)
write(
	  out.anova.resume.1,
	  file = out.file.wilcox.resume.1
	  )

summary.resume.2 = global.summary(dat.q$questionary.resume.2)
out.summary.resume.2 = summary2tex(summary.resume.2)
out.file.resume.2 = gsub(".csv", "-resume-2.tex", out.file)
write(
	  out.summary.resume.2,
	  file = out.file.resume.2
	  )
wilcox.resume.2 = wilcox.test(dat.q$questionary.resume.2 ~ dat.q$haptic, paired = TRUE, na.action = "na.pass")
out.anova.resume.2 = wilcox2tex(wilcox.resume.2)
out.file.wilcox.resume.2 = gsub(".csv", "-resume-2-anova.tex", out.file)
write(
	  out.anova.resume.2,
	  file = out.file.wilcox.resume.2
	  )

summary.resume.3 = global.summary(dat.q$questionary.resume.3)
out.summary.resume.3 = summary2tex(summary.resume.3)
out.file.resume.3 = gsub(".csv", "-resume-3.tex", out.file)
write(
	  out.summary.resume.3,
	  file = out.file.resume.3
	  )
wilcox.resume.3 = wilcox.test(dat.q$questionary.resume.3 ~ dat.q$haptic, paired = TRUE, na.action = "na.pass")
out.anova.resume.3 = wilcox2tex(wilcox.resume.3)
out.file.wilcox.resume.3 = gsub(".csv", "-resume-3-anova.tex", out.file)
write(
	  out.anova.resume.3,
	  file = out.file.wilcox.resume.3
	  )

summary.resume.4 = global.summary(dat.q$questionary.resume.4)
out.summary.resume.4 = summary2tex(summary.resume.4)
out.file.resume.4 = gsub(".csv", "-resume-4.tex", out.file)
write(
	  out.summary.resume.4,
	  file = out.file.resume.4
	  )
wilcox.resume.4 = wilcox.test(dat.q$questionary.resume.4 ~ dat.q$haptic, paired = TRUE, na.action = "na.pass")
out.anova.resume.4 = wilcox2tex(wilcox.resume.4)
out.file.wilcox.resume.4 = gsub(".csv", "-resume-4-anova.tex", out.file)
write(
	  out.anova.resume.4,
	  file = out.file.wilcox.resume.4
	  )

summary.resume.5 = global.summary(dat.q$questionary.resume.5)
out.summary.resume.5 = summary2tex(summary.resume.5)
out.file.resume.5 = gsub(".csv", "-resume-5.tex", out.file)
write(
	  out.summary.resume.5,
	  file = out.file.resume.5
	  )
summary.resume.5.false = global.summary(dat.q[dat.q$haptic == "False", ]$questionary.resume.5)
out.summary.resume.5.false = summary2tex(summary.resume.5.false)
out.file.resume.5.false = gsub(".csv", "-resume-5-false.tex", out.file)
write(
	  out.summary.resume.5.false,
	  file = out.file.resume.5.false
	  )
summary.resume.5.true = global.summary(dat.q[dat.q$haptic == "True", ]$questionary.resume.5)
out.summary.resume.5.true = summary2tex(summary.resume.5.true)
out.file.resume.5.true = gsub(".csv", "-resume-5-true.tex", out.file)
write(
	  out.summary.resume.5.true,
	  file = out.file.resume.5.true
	  )
wilcox.resume.5 = wilcox.test(dat.q$questionary.resume.5 ~ dat.q$haptic, paired = TRUE, na.action = "na.pass")
out.anova.resume.5 = wilcox2tex(wilcox.resume.5)
out.file.wilcox.resume.5 = gsub(".csv", "-resume-5-anova.tex", out.file)
write(
	  out.anova.resume.5,
	  file = out.file.wilcox.resume.5
	  )
