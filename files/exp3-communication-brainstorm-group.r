#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

dat.binome = dat.exp3[ dat.exp3$group.number == 2, ]
bp.binome = boxplot(dat.binome$verbal.task~dat.binome$brainstorm, plot=FALSE)
colnames(bp.binome$stats) = c("sans","avec")
write.table(bp.binome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
dat.quadrinome = dat.exp3[dat.exp3$group.number == 4, ]
bp.quadrinome = boxplot(dat.quadrinome$verbal.task~dat.quadrinome$brainstorm, plot=FALSE)
write.table(bp.quadrinome$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append = TRUE)

dat.binome = dat.exp3[ dat.exp3$group.number == 2, ]
shapiro = shapiro.test(dat.binome$verbal.task)
#levene = levene.test(dat.binome$verbal.task, dat.binome$brainstorm)
bartlett = bartlett.test(dat.binome$verbal.task~dat.binome$brainstorm)
kruskal = kruskal.test(dat.binome$verbal.task~dat.binome$brainstorm)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-binome.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )

dat.quadrinome = dat.exp3[ dat.exp3$group.number == 4, ]
shapiro = shapiro.test(dat.quadrinome$verbal.task)
#levene = levene.test(dat.quadrinome$verbal.task, dat.quadrinome$brainstorm)
bartlett = bartlett.test(dat.quadrinome$verbal.task~dat.quadrinome$brainstorm)
kruskal = kruskal.test(dat.quadrinome$verbal.task~dat.quadrinome$brainstorm)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-quadrinome.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
