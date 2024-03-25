fontpath := "fonts"
mainfile := "src/dissertation.typ"
outputfile := "dissertation.pdf"

watch:
	typst watch {{mainfile}} {{outputfile}} --font-path {{fontpath}}

build:
	typst compile {{mainfile}} {{outputfile}} --font-path {{fontpath}}
