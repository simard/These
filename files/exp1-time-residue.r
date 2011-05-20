#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

bp = boxplot(dat.exp1$time.completion~dat.exp1$pattern.number, range=2, plot=FALSE)
colnames(bp$stats) = c("\\myresidue{1}","\\myresidue{2}","\\myresidue{3}","\\myresidue{4}","\\myresidue{5}","\\myresidue{6}","\\myresidue{7}","\\myresidue{8}","\\myresidue{9}","\\myresidue{10}")
write.table(bp$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)

shap = shapiro.test(dat.exp1$time.completion)
print(shap$statistic)
print(shap$p.value)
lev = levene.test(dat.exp1$time.completion,dat.exp1$pattern.number)
print(lev$statistic)
print(lev$p.value)
kruskal = kruskal.test(dat.exp1$time.completion~dat.exp1$pattern.number)
out.anova = "$\\chi^2(<df>) = <chi>$, $p = <p>$"
out.anova = set.df(out.anova, kruskal$parameter)
out.anova = set.chi(out.anova, kruskal$statistic)
out.anova = set.p(out.anova, kruskal$p.value)
out.file.anova = gsub(".csv", "-anova.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
