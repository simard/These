#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

dat.exp2.monome = dat.exp2[dat.exp2$group.number == 1, ]
dat.exp2.monome.dominant = data.frame(
									  total.selection.number=dat.exp2.monome$total.leader.selection.number, 
									  group.number=dat.exp2.monome$group.number,
									  is.slave=rep(FALSE,length(dat.exp2.monome$group.number))
									  )
dat.exp2.monome.nondominant = data.frame(
									  total.selection.number=dat.exp2.monome$total.slave.selection.number, 
									  group.number=dat.exp2.monome$group.number,
									  is.slave=rep(TRUE,length(dat.exp2.monome$group.number))
									  )
dat.exp2.binome = dat.exp2[dat.exp2$group.number == 2, ]
dat.exp2.binome.dominant = data.frame(
									  total.selection.number=dat.exp2.binome$total.leader.selection.number + dat.exp2.binome$total.slave.selection.number,
									  group.number=dat.exp2.binome$group.number,
									  is.slave=rep(FALSE,length(dat.exp2.binome$group.number))
									  )
dat.exp2.binome.nondominant = data.frame(
									  total.selection.number=0,
									  group.number=2,
									  is.slave=TRUE
									  )
dat.selection.number = rbind(dat.exp2.monome.dominant, dat.exp2.monome.nondominant, dat.exp2.binome.dominant, dat.exp2.binome.nondominant)
dat.selection.number.dominant = dat.selection.number[dat.selection.number$is.slave == FALSE, ]
bp.selection.number.dominant = boxplot(dat.selection.number.dominant$total.selection.number ~ dat.selection.number.dominant$group.number, plot=FALSE)
colnames(bp.selection.number.dominant$stats) = c("\\myglosnl{glo-Monome}","\\myglosnl{glo-Binome}")
write.table(bp.selection.number.dominant$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
dat.selection.number.nondominant = dat.selection.number[dat.selection.number$is.slave == TRUE, ]
bp.selection.number.nondominant = boxplot(dat.selection.number.nondominant$total.selection.number ~ dat.selection.number.nondominant$group.number, plot=FALSE)
write.table(bp.selection.number.nondominant$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append = TRUE)

dat.exp2.monome.cumulative = data.frame(
									  total.selection.number=dat.exp2.monome$total.leader.selection.number + dat.exp2.monome$total.slave.selection.number,
									  group.number=dat.exp2.monome$group.number
									  )
dat.exp2.binome.cumulative = data.frame(
									  total.selection.number=dat.exp2.binome$total.leader.selection.number + dat.exp2.binome$total.slave.selection.number,
									  group.number=dat.exp2.binome$group.number
									  )
dat.exp2.cumulative = rbind(dat.exp2.monome.cumulative, dat.exp2.binome.cumulative)
shapiro = shapiro.test(dat.exp2.cumulative$total.selection.number)
dat.exp2.cumulative.levene = na.omit(data.frame(total.selection.number=dat.exp2.cumulative$total.selection.number, group.number=dat.exp2.cumulative$group.number))
levene = levene.test(dat.exp2.cumulative.levene$total.selection.number, dat.exp2.cumulative.levene$group.number)
kruskal = kruskal.test(dat.exp2.cumulative$total.selection.number ~ dat.exp2.cumulative$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-cumulative.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat = dat.exp2.cumulative
pop.a = dat[ dat$group.number == 1, ]$total.selection.number
pop.b = dat[ dat$group.number == 2, ]$total.selection.number
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio-cumulative.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
dat.exp2.monome.dominant = data.frame(
									  total.selection.number=dat.exp2.monome$total.leader.selection.number,
									  group.number=dat.exp2.monome$group.number
									  )
dat.exp2.binome.dominant = data.frame(
									  total.selection.number=c(dat.exp2.binome$total.leader.selection.number, dat.exp2.binome$total.slave.selection.number),
									  group.number=rep(dat.exp2.binome$group.number,2)
									  )
dat.exp2.dominant = rbind(dat.exp2.monome.dominant, dat.exp2.binome.dominant)
shapiro = shapiro.test(dat.exp2.dominant$total.selection.number)
dat.exp2.dominant.levene = na.omit(data.frame(total.selection.number=dat.exp2.dominant$total.selection.number, group.number=dat.exp2.dominant$group.number))
levene = levene.test(dat.exp2.dominant.levene$total.selection.number, dat.exp2.dominant.levene$group.number)
kruskal = kruskal.test(dat.exp2.dominant$total.selection.number ~ dat.exp2.dominant$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-dominant.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
out.mean = mean2tex(mean(dat.exp2.monome.cumulative$total.selection.number))
out.file.mean = gsub(".csv", "-mean-monome.tex", out.file.boxplot)
write(
	  out.mean,
	  file = out.file.mean
	  )
out.mean = mean2tex(mean(dat.exp2.binome.cumulative$total.selection.number))
out.file.mean = gsub(".csv", "-mean-binome.tex", out.file.boxplot)
write(
	  out.mean,
	  file = out.file.mean
	  )
