# tools
LATEXMK = latexmk
RM = rm -f
BIBTOOL = bibtool

# options
LATEXOPT = -pdf		# pdflatex
DEPOPT = -M -MP -MF		# auto generate dependencies files
CONTINUOUS = -pvc		# real-time preview

# project-specific settings
DOCNAME = deployment
BIBFILES = $(shell find bib -type f -name *.bib)

# targets
all: doc
doc: $(DOCNAME).pdf
bib: $(DOCNAME).bib
edit: $(DOCNAME).tex
	$(LATEXMK) $(LATEXOPT) $(CONTINUOUS) $(DEPOPT) $*.d $(DOCNAME)


# rules
%.pdf: %.tex $(DOCNAME).bib
	$(LATEXMK) $(LATEXOPT) $(DEPOPT) $*.d $*
	# $(LATEXMK) $(LATEXOPT) $*

$(DOCNAME).bib:
	$(BIBTOOL) --preserve.key.case=on --print.deleted.entries=off -q -s -d $(BIBFILES) -o $(DOCNAME).bib

# cleaning up

clean: squeeze bibclean
	$(LATEXMK) -silent -C

squeeze:
	$(LATEXMK) -silent -c
	$(RM) *.run.xml *.synctex.gz *.nav *.snm
	$(RM) *.d

bibclean:
	$(RM) *.bbl *.bib *.blg

.PHONY: all doc clean bibclean squeeze

# include auto-generated dependencies
-include *.d
