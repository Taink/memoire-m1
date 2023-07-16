// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(
  title: "",
  subtitle: "",
  abstract: [],
  abstract_en: [],
  authors: (),
  date: none,
  logo: none,
  body,
) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  set page(numbering: "1", number-align: center)

  let body-font = "New Computer Modern Sans"
  let heading-font = "Linux Libertine"
  
  set text(font: body-font, lang: "fr")
  show heading: set text(font: heading-font)
  show math.equation: set text(weight: 400)
  set heading(numbering: "I.1")

  // Set run-in subheadings, starting at level 3.
  show heading: it => {
    if it.level > 2 {
      parbreak()
      text(11pt, style: "italic", weight: "regular", it.body + ".")
    } else {
      it
    }
  }


  // Title page.
  // The page can contain a logo if you pass one with `logo: "logo.png"`.
  v(0.6fr)
  if logo != none {
    align(right, image(logo, width: 26%))
  }
  v(9.6fr)

  text(1.1em, date)
  v(1.2em, weak: true)
  text(font: heading-font, 2em, weight: 700, title)
  v(1.2em, weak: true)
  text(1.25em, weight: 300, subtitle)

  // Author information.
  pad(
    top: 0.7em,
    right: 20%,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(start)[
        *#author.name* \
        #author.company \
        #author.email \
        #author.company_mail
      ]),
    ),
  )

  v(2.4fr)
  pagebreak()

  // Abstract page.
  // Abstract (fr)
  align(horizon+center)[
    #heading(outlined: false, numbering: none, text(0.85em)[Résumé])
    #abstract
  ]
  
  pagebreak()
  // Abstract (en)
  align(horizon+center)[
    #heading(outlined: false, numbering: none, text(0.85em)[Abstract])
    #abstract_en
  ]
  pagebreak()

  // Table of contents.
  outline(depth: 3, indent: true)
  pagebreak()


  // Main body.
  set par(justify: true)

  body
}