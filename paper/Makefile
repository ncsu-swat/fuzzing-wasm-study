NAME := main
TEXS := $(wildcard *.tex)
TABLES := $(wildcard tables/*.tex)
FIGS := $(wildcard figures/*.tex) $(wildcard figures/*.png)
PLOTS := $(wildcard plots/*.eps)
BIBS := $(wildcard *.bib)
LETTER := response_letter

LATEX = pdflatex -synctex=1 -interaction=nonstopmode --shell-escape 
BIBTEX = bibtex

SUP := appendix

all: ${NAME}.pdf

${NAME}.pdf: ${TEXS} ${TABLES} ${BIBS} ${FIGS} ${PLOTS}
	-rm -f ${NAME}.aux
	-rm -f ${NAME}.bbl
	-$(LATEX) $(NAME)
	-$(BIBTEX) $(NAME)
	-$(LATEX) $(NAME)
	-$(LATEX) $(NAME)
	@echo '****************************************************************'
# vvvvvv For `latex` ONLY. Comment out for `pdflatex`
#	@dvips -j0 -t letter -o $(NAME).ps $(NAME).dvi
#	@ps2pdf -dPDFSETTINGS=/prepress $(NAME).ps $(NAME).pdf
# ^^^^^^^^^^^^^^^^^^^^^^^^
	@echo '******** Did you spell-check the paper? ********'

sup: ${SUP}.pdf

response_letter: 
	-rm -f ${LETTER}.aux
	-rm -f ${LETTER}.bbl
	-$(LATEX) $(LETTER)
	-$(BIBTEX) $(LETTER)
	-$(LATEX) $(LETTER)
	-$(LATEX) $(LETTER)
	@echo '****************************************************************'
# vvvvvv For `latex` ONLY. Comment out for `pdflatex`
#	@dvips -j0 -t letter -o $(LETTER).ps $(LETTER).dvi
#	@ps2pdf -dPDFSETTINGS=/prepress $(LETTER).ps $(LETTER).pdf
# ^^^^^^^^^^^^^^^^^^^^^^^^
	@echo '******** Did you spell-check the paper? ********'


clean:
	ls $(NAME)* | grep -v ".tex" | grep -v ".bib" | xargs rm -f
	ls $(LETTER)* | grep -v ".tex" | grep -v ".bib" | xargs rm -f
	rm -rf main.synctex.gz
	rm -f *.bak *~
