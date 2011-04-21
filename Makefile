# Directories
IMG=images
TMP=temp

# In-file and out-file
ifeq ($(IN),)
	IN=main
endif
ifeq ($(OUT),)
	OUT=Thesis
endif

# Compilators
TEX=latex
BTEX=biber
INDEX=makeindex
GLOSS=makeglos
DVIPS=dvips
PS2PDF=ps2pdf

# Compilators options
TEXOPT=-shell-escape -output-format=dvi -file-line-error -interaction nonstopmode -output-directory=$(TMP)
BTEXOPT=
INDEXOPT=
GLOSSOPT=-m
DVIPSOPT=-R0
PS2PDFOPT=

# About images
PNG=$(wildcard $(IMG)/*.png)
EPS=$(PNG:.png=.eps)

# Others
UNAME=$(shell uname)
AUX=$(wildcard $(TMP)/*.aux)
BBL=$(AUX:.aux=.bbl)

.PHONY: final draft pdf ps dvi bibtex img clean proper

all: draft

# To create the final document with:
#   - the images
#   - valid table of contents
final: clean img
	@echo "----- FINAL -----"
	$(MAKE) $(TMP)/$(OUT).dvi
	$(MAKE) bibtex
	$(MAKE) -B $(TMP)/$(OUT).dvi
	$(MAKE) -B pdf

# To create a draft version of the document.
# It execute a faster compilation without images.
# This is the default target, called by 'all'
draft: $(TMP) img
	@sed 's/^\(\\documentclass\[\)\(.*\)/\1draft,\2/g' $(IN).tex > $(TMP)/$(IN).tex
	IN=$(TMP)/$(IN) $(MAKE) pdf

# To create the PDF file
pdf: $(OUT).pdf

# To create the PS file
ps: $(OUT).ps

# To create the DVI file
dvi: $(OUT).dvi

# To create BBL file for the bibliography
bibtex: $(BBL)
	@echo "----- CREATING BBL FILES -----"

# To create all images at the desired format (i.e. EPS)
img: $(EPS)
	@echo "----- CONVERSION IMAGES PNG -> EPS -----"

# Just take the created PDF file to copy it in the current directory
$(OUT).pdf: $(TMP)/$(OUT).pdf
	cp $< $(OUT).pdf

# Just take the created PS file to copy it in the current directory
$(OUT).ps: $(TMP)/$(OUT).ps
	cp $< $(OUT).ps

# Just take the created DVI file to copy it in the current directory
$(OUT).dvi: $(TMP)/$(OUT).dvi
	cp $< $(OUT).dvi

# Create the PDF file with the PS file
$(TMP)/$(OUT).pdf: $(TMP)/$(OUT).ps
	@echo "----- CONVERSION PS -> PDF -----"
	$(PS2PDF) $(PS2PDFOPT) $< $@

# Create the PS file with the DVI file
$(TMP)/$(OUT).ps: $(TMP)/$(OUT).dvi
	@echo "----- CONVERSION DVI -> PS -----"
	$(DVIPS) $(DVIPSOPT) -o $@ $<

# Create the DVI file with the TeX file
# We need the $(TMP) directory
$(TMP)/$(OUT).dvi: $(IN).tex $(TMP) img
	@echo "----- CONVERSION TEX -> DVI -----"
	$(TEX) $(TEXOPT) -jobname=$(OUT) $<

# Create BBL files for bibliography with AUX files
$(TMP)/%.bbl : $(TMP)/%.aux
	-$(BTEX) $(BTEXOPT) `echo $< | sed 's/\.aux//g'`

$(TMP):
	mkdir -p $@

# Convert all images from PNG to EPS
$(IMG)/%.eps: $(IMG)/%.png
	convert $< eps:->$@

# Create the 'Makefile' file for the conversion of images from PNG to EPS 
# format
$(IMG)/Makefile: $(IMG)
	echo $(MKIMG) > $@

# To clean the 'temp' directory
clean:
	rm -Rf $(TMP)

# To clean the 'temp' directory and suppress all created files
proper: clean
	rm -f $(IMG)/*.eps
	rm -f $(OUT).dvi $(OUT).ps $(OUT).pdf
