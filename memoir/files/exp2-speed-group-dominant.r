#!/usr/bin/env Rscript
setwd("./files/")
source("Rinit")
out.file.boxplot = get.outname(commandArgs())

dat.exp2.monome = dat.exp2[dat.exp2$group.number == 1, ]
dat.exp2.monome.dominant = data.frame(
									  mean.speed=dat.exp2.monome$mean.leader.speed, 
									  group.number=dat.exp2.monome$group.number,
									  tool.number=rep(1,length(dat.exp2.monome$group.number))
									  )
dat.exp2.monome.nondominant = data.frame(
									  mean.speed=dat.exp2.monome$mean.slave.speed, 
									  group.number=dat.exp2.monome$group.number,
									  tool.number=rep(2,length(dat.exp2.monome$group.number))
									  )
dat.exp2.binome = dat.exp2[dat.exp2$group.number == 2, ]
dat.exp2.binome.dominant = data.frame(
									  mean.speed=c(dat.exp2.binome$mean.leader.speed, dat.exp2.binome$mean.slave.speed),
									  group.number=rep(dat.exp2.binome$group.number, 2),
									  tool.number=rep(1, 2*length(dat.exp2.binome$group.number))
									  )
dat.exp2.binome.nondominant = data.frame(
									  mean.speed=0,
									  group.number=2,
									  tool.number=2
									  )
dat.speed = rbind(dat.exp2.monome.dominant, dat.exp2.monome.nondominant, dat.exp2.binome.dominant, dat.exp2.binome.nondominant)
dat.speed.dominant = dat.speed[dat.speed$tool.number == 1, ]
bp.speed.dominant = boxplot(dat.speed.dominant$mean.speed ~ dat.speed.dominant$group.number, plot=FALSE)
colnames(bp.speed.dominant$stats) = c("\\myglosnl{glo-Monome}","\\myglosnl{glo-Binome}")
write.table(bp.speed.dominant$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = TRUE)
dat.speed.nondominant = dat.speed[dat.speed$tool.number == 2, ]
bp.speed.nondominant = boxplot(dat.speed.nondominant$mean.speed ~ dat.speed.nondominant$group.number, plot=FALSE)
write.table(bp.speed.nondominant$stats,
			file = out.file.boxplot,
			quote = FALSE,
			sep = ",",
			eol = "\n",
			dec = ".",
			row.names = FALSE,
			col.names = FALSE,
			append = TRUE)
dat.speed.total = rbind(dat.exp2.monome.dominant, dat.exp2.monome.nondominant, dat.exp2.binome.dominant)
shapiro = shapiro.test(dat.speed.total$mean.speed)
levene = levene.test(dat.speed.total$mean.speed, dat.speed.total$group.number)
bartlett = bartlett.test(dat.speed.total$mean.speed ~ dat.speed.total$group.number)
kruskal = kruskal.test(dat.speed.total$mean.speed ~ dat.speed.total$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat = dat.speed.total
pop.a = dat[ dat$group.number == 1, ]$mean.speed
pop.b = dat[ dat$group.number == 2, ]$mean.speed
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
dat.speed.dominant.total = rbind(dat.exp2.monome.dominant, dat.exp2.binome.dominant)
shapiro = shapiro.test(dat.speed.dominant.total$mean.speed)
levene = levene.test(dat.speed.dominant.total$mean.speed, dat.speed.dominant.total$group.number)
bartlett = bartlett.test(dat.speed.dominant.total$mean.speed ~ dat.speed.dominant.total$group.number)
kruskal = kruskal.test(dat.speed.dominant.total$mean.speed ~ dat.speed.dominant.total$group.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-dominant.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat = dat.speed.dominant.total
pop.a = dat[ dat$group.number == 1, ]$mean.speed
pop.b = dat[ dat$group.number == 2, ]$mean.speed
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio-dominant.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
dat.speed.monome = dat.speed[dat.speed$group.number == 1, ]
shapiro = shapiro.test(dat.speed.monome$mean.speed)
levene = levene.test(dat.speed.monome$mean.speed, dat.speed.monome$tool.number)
kruskal = kruskal.test(dat.speed.monome$mean.speed ~ dat.speed.monome$tool.number)
out.anova = kruskal2tex(kruskal)
out.file.anova = gsub(".csv", "-anova-monome.tex", out.file.boxplot)
write(
	  out.anova,
	  file = out.file.anova
	  )
dat = dat.speed.monome
pop.a = dat[ dat$tool.number == 1, ]$mean.speed
pop.b = dat[ dat$tool.number == 2, ]$mean.speed
out.ratio = evolution2tex(pop.a, pop.b)
out.file.ratio = gsub(".csv", "-ratio-monome.tex", out.file.boxplot)
write(
	  out.ratio,
	  file = out.file.ratio
	  )
