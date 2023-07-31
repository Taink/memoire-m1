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
  schoolLogo: none,
  companyLogo: none,
  body,
) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)

  // Keep in mind this is also used in the SVGs.
  let body-font = "New Computer Modern Sans"
  let heading-font = "Linux Libertine"
  
  set text(12pt, font: body-font, lang: "fr")
  show heading: set text(font: heading-font)
  show math.equation: set text(weight: 400)
  set heading(numbering: "I.1.A -", supplement: "Section")

  // Set run-in subheadings, starting at level 4.
  show heading: it => {
    if it.level > 3 {
      parbreak()
      text(12pt, style: "italic", weight: "regular", it.body + ".")
    } else {
      it
    }
  }

  // code blocks
  show raw.where(block: true): box.with(
    fill: luma(240),
    radius: 3pt,
    inset: 10pt,
    stroke: gray,
  )

  // inline code
  show raw.where(block: false): box.with(
    fill: luma(240),
    radius: 3pt,
    inset: (x: 2pt, y: 0pt),
    outset: (y: 3pt),
    stroke: gray,
  )

  // Title page.
  v(0.6fr)
  if schoolLogo != none {
    align(right, image(schoolLogo, width: 33%))
  }
  if companyLogo != none {
    align(right, image(companyLogo, width: 33%))
  }
  v(7fr)

  text(1.1em, date)
  v(1.2em, weak: true)
  text(font: heading-font, 2em, weight: 700, title)
  v(1.2em, weak: true)
  text(1.25em, weight: 300, subtitle)

  // Author information.
  pad(
    top: 5em,
    right: 20%,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(start)[
        *#author.name* \
        #author.company \
        #author.email \
        #author.company_email
      ]),
    ),
  )

  v(2.4fr)
  pagebreak()
  set page(numbering: "1", number-align: center)
  // Abstract page.
  align(horizon+center)[
    #heading(outlined: false, numbering: none, text(0.85em)[Abstract])
    #abstract_en

    #v(8em, weak: true)

    #heading(outlined: false, numbering: none, text(0.85em)[Résumé])
    #abstract
  ]

  pagebreak()

  // Table of contents.
  outline(depth: 3, indent: true)
  pagebreak()


  // Main body.
  set par(justify: true)

  body
}