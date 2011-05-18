# Directories
IMG=images
BUILD=build
FILES=files

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
GLOSS=xindy
ACRO=xindy
DVIPS=dvips
PS2PDF=ps2pdf
R=R

# Compilators options
TEXOPT=-shell-escape -output-format=dvi -file-line-error -interaction nonstopmode -output-directory=$(BUILD)
BTEXOPT=
INDEXOPT=
GLOSSOPT=--language french --codepage utf8 --input-markup xindy
ACROOPT=--language french --codepage utf8 --input-markup xindy
DVIPSOPT=-R0
PS2PDFOPT=
ROPT=--vanilla

# About images
PNG=$(wildcard $(IMG)/*.png)
EPS=$(PNG:.png=.eps)

# Others
UNAME=$(shell uname)
AUX=$(wildcard $(BUILD)/*.aux)
BBL=$(AUX:.aux=.bbl)
GLS=$(AUX:.aux=.gls)
ACR=$(AUX:.aux=.acr)
STT=$(wildcard $(FILES)/*.r)
CSV=$(STT:.r=.csv)

.PHONY: final draft pdf ps dvi bibtex glossary acronym img stats clean proper

all: draft

# To create the final document with:
#   - the images
#   - valid table of contents
final: clean img stats
	@echo "----- FINAL -----"
	$(MAKE) $(BUILD)/$(OUT).dvi
	$(MAKE) bibtex
	$(MAKE) glossary
	$(MAKE) acronym
	$(MAKE) $(BUILD)/$(OUT).dvi
	$(MAKE) bibtex
	$(MAKE) glossary
	$(MAKE) acronym
	$(MAKE) -B $(BUILD)/$(OUT).dvi
	$(MAKE) -B pdf

# To create a draft version of the document.
# It execute a faster compilation without images.
# This is the default target, called by 'all'
draft: $(BUILD) img stats
	@sed 's/^\(\\documentclass\[\)\(.*\)/\1draft,\2/g' $(IN).tex > $(BUILD)/$(IN).tex
	IN=$(BUILD)/$(IN) $(MAKE) pdf

# To create the PDF file
pdf: $(OUT).pdf

# To create the PS file
ps: $(OUT).ps

# To create the DVI file
dvi: $(OUT).dvi

# To create BBL file for the bibliography
bibtex: $(BBL)
	@echo "----- CREATING BBL FILES -----"

# To create the the glossary
glossary: $(GLS)
	@echo "----- CREATING GLS FILES -----"

# To create the the acronym glossary
acronym: $(ACR)
	@echo "----- CREATING ACR FILES -----"

# To create all images at the desired format (i.e. EPS)
img: $(EPS)
	@echo "----- CONVERSION IMAGES PNG -> EPS -----"

# To generate results from the statistics (by R)
stats: $(CSV)
	@echo "----- GENERATE CSV files -----"

# Just take the created PDF file to copy it in the current directory
$(OUT).pdf: $(BUILD)/$(OUT).pdf
	cp $< $(OUT).pdf

# Just take the created PS file to copy it in the current directory
$(OUT).ps: $(BUILD)/$(OUT).ps
	cp $< $(OUT).ps

# Just take the created DVI file to copy it in the current directory
$(OUT).dvi: $(BUILD)/$(OUT).dvi
	cp $< $(OUT).dvi

# Create the PDF file with the PS file
$(BUILD)/$(OUT).pdf: $(BUILD)/$(OUT).ps
	@echo "----- CONVERSION PS -> PDF -----"
	$(PS2PDF) $(PS2PDFOPT) $< $@

# Create the PS file with the DVI file
$(BUILD)/$(OUT).ps: $(BUILD)/$(OUT).dvi
	@echo "----- CONVERSION DVI -> PS -----"
	# This link is needed for the 'bookmark' package which is not able to find 
	# files in subdirectories
	ln -s $(BUILD)/$(OUT).out.ps $(OUT).out.ps
	$(DVIPS) $(DVIPSOPT) -o $@ $<
	rm $(OUT).out.ps

# Create the DVI file with the TeX file
# We need the $(BUILD) directory
$(BUILD)/$(OUT).dvi: $(IN).tex $(BUILD)
	@echo "----- CONVERSION TEX -> DVI -----"
	$(TEX) $(TEXOPT) -jobname=$(OUT) $<

# Create BBL files for bibliography with AUX files
$(BUILD)/%.bbl : $(BUILD)/%.aux
	-$(BTEX) $(BTEXOPT) `echo $< | sed 's/\.aux//g'`

# Create GLS files for glossary with GLO files
$(BUILD)/%.gls : $(BUILD)/%.glo
	-$(GLOSS) $(GLOSSOPT) -M `echo $< | sed 's/\.glo//g'` -t `echo $< | sed 's/\.glo/\.glg/g'` -o $@ $<

# Create ACR files for acronym glossary with ACN files
$(BUILD)/%.acr : $(BUILD)/%.acn
	-$(ACRO) $(ACROOPT) -M `echo $< | sed 's/\.acn//g'` -t `echo $< | sed 's/\.acn/\.alg/g'` -o $@ $<

# Create the temporary directory to build the document
$(BUILD):
	mkdir -p $@

# Convert all images from PNG to EPS
$(IMG)/%.eps: $(IMG)/%.png
	convert $< eps:->$@

# Create the 'Makefile' file for the conversion of images from PNG to EPS format
$(IMG)/Makefile: $(IMG)
	echo $(MKIMG) > $@

# Generate CSV files from R files
$(FILES)/%.csv: $(FILES)/%.r
	-$(R) $(ROPT) -f $<

# To clean the 'build' directory
clean:
	rm -Rf $(BUILD)

# To clean the 'build' directory and suppress all created files
proper: clean
	rm -f $(IMG)/*.eps
	rm -f $(OUT).dvi $(OUT).ps $(OUT).pdf
