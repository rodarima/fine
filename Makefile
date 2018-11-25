# Compile only the slides by now (faster)
#PDFS=slides.pdf
PDFS=slides.pdf handout.pdf

all: $(PDFS)

handout.pdf: slides.tex
	cp slides.tex handout.tex
	sed -i -e 's/includeNotes{.}/includeNotes{1}/g' handout.tex
	latexmk -pdf -latexoption="-shell-escape" handout.tex
	rm -f handout.tex
	@kill -HUP $$(pidof mupdf)

%.pdf: %.tex
	latexmk -pdf -latexoption="-shell-escape" $<
	@kill -HUP $$(pidof mupdf)

clean:
	rm -f ${PDFS} *.{aux,log}
