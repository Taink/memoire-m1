#import "@preview/polylux:0.3.1": *
#import themes.clean: *

#show link: set text(blue)
// #show heading: set text(font: "Vollkorn")
// #show raw: set text(font: "JuliaMono")

// code blocks
#show raw.where(block: true): box.with(
    fill: luma(240),
    radius: 3pt,
    inset: 10pt,
    stroke: gray,
)

// inline code
#show raw.where(block: false): box.with(
    fill: luma(240),
    radius: 3pt,
    inset: (x: 2pt, y: 0pt),
    outset: (y: 3pt),
    stroke: gray,
)

#show: clean-theme.with(
    footer: [Maxime Daniel, 4 septembre 2023],
    short-title: [Soutenance du mémoire de M1],
    logo: [
        #grid(
            columns: 2,
            column-gutter: 1em,
            image("./assets/adagp.svg"),
            image("./assets/efrei.png")
        )
    ],
)

#set text(size: 20pt)

#title-slide(
    title: [Soutenance du mémoire de M1],
    subtitle: [Incorporer des outils d'intégration continue dans
    les processus métiers"],
    authors: "Maxime Daniel",
    date: "4 septembre 2023",
)

#new-section-slide("Introduction")

#slide[
    Depuis le 1er septembre 2021, je suis en alternance à l'ADAGP.

    Durant ces deux années d'alternance,
    j'ai eu l'occasion travailler sur de multiples projets :

    #line-by-line[
        - Le formulaire d'adhésion en ligne,
        - La maintenance du wiki de l'ADAGP,
        - Une API de notification,
        - ...et ce mémoire.
    ]
]

#slide(title: "À propos de l'ADAGP")[
    C'est une société de gestion des droits d'auteur.

    Elle défend les intérêts de ses adhérents,
    des auteurs et ayants-droit d'art visuel
    (peinture, sculpture, photographie, architecture, etc.)
    et les aide à gérer leurs droits.
]

#slide(title: "À propos du mémoire")[
    Ce mémoire s'inscrit dans un effort de modernisation de l'ADAGP.

    L'intérêt de ce mémoire est de proposer une solution
    pour automatiser certains processus métiers de l'ADAGP,
    en utilisant des outils d'intégration continue.

    Le but est de rendre ces processus systématiques, reproductibles,
    et de les rendre plus efficaces.
]

#slide(title: "Dans cette présentation")[
    #polylux-outline(padding: 1em, enum-args: (tight: false))
]

#new-section-slide("Choix de l'outil")


#slide(title: "Quels sont les principaux outils ?")[
    Durant la phase de recherche du mémoire,
    j'ai noté que ces outils revenaient souvent :

    - Jenkins
    - Travis CI
    - Circle CI
    - GitLab CI
    - Github Actions
]

#slide(title: "Jenkins")[
    Jenkins est la solution "historique", c'est une des premières
    solutions d'intégration continue comparables aux plus modernes.

    #table(
        columns: (1fr, 1fr),
        inset: 10pt,
        align: horizon,
        [*Principaux atouts*], [*Compatible avec*],
        align(left)[
        - Écosystème robuste,
        - Communauté active,
        - Exécution sur site gratuite
            #footnote[
            L'exécution sur site est souvent
            nécessaire dans des contextes où les données utilisées
            sont sensibles,
            ou du moins si le réseau d'entreprise
            est derrière un pare-feu peu laxiste.
            ]
        ],
        [
        N'importe quel système : Jenkins est un serveur d'automatisation.
        À partir du moment où une étape est automatisable, Jenkins peut
        l'automatiser.
        ]
    )
]

#slide(title: "Travis CI")[

    #table(
        columns: (1fr, 1fr),
        inset: 10pt,
        align: horizon,
        [*Principaux atouts*], [*Compatible avec*],
        align(left)[
        - Facile d'utilisation,
        - Communauté active,
        - Mise en place très rapide,
        - Gratuit sur les projets open-source
        ],
        align(left)[
        - Github
        - Atlassian Bitbucket
        - GitLab
        - Assembla
        ]
    )
]

#slide(title: "Circle CI")[

    #table(
        columns: (1fr, 1fr),
        inset: 10pt,
        align: horizon,
        [*Principaux atouts*], [*Compatible avec*],
        align(left)[
        - Assez facile d'utilisation,
        - Mise en place et exécution très rapides,
        - Gratuit sur les projets open-source
        ],
        align(left)[
        - Github
        - Atlassian Bitbucket
        - Github Enterprise
        ]
    )
]

#slide(title: "GitLab CI")[
    #table(
        columns: (1fr, 1fr),
        inset: 10pt,
        align: horizon,
        [*Principaux atouts*], [*Compatible avec*],
        align(left)[
        - Intégration privilégiée avec Gitlab
        - Gratuit si runner auto-hébergé +
            crédits gratuits sur runners partagés
        ],
        [
        Gitlab seulement, possibilité d'importer des projets depuis
        Bitbucket et Github cependant.
        ]
    )
]

#slide(title: "Github Actions")[
    #table(
        columns: (1fr, 1fr),
        inset: 10pt,
        align: horizon,
        [*Principaux atouts*], [*Compatible avec*],
        align(left)[
        - Intégration privilégiée avec Github,
        - Gratuit si runner auto-hébergé +
            crédits gratuits sur runners partagés
        ],
        [
        Github seulement.
        ]
    )
]

#let example(body) = block(
    width: 100%,
    inset: .5em,
    fill: aqua.lighten(80%),
    radius: .5em,
    text(size: .8em, body)
)

#new-section-slide("Mise en place")

#slide[
    #align(center)[
        #image("./assets/cycle-développement-adagp.excalidraw.svg")
    ]
]

#slide(title: "Deux pistes d'amélioration")[
    #side-by-side(
        [
            Il faut automatiser les processus en utilisant des outils
            d'intégration continue.

            Il faut donc prévoir une infrastructure pour les exécuter,
            ainsi que des scripts exécutant ces processus.
        ],
        [
            #pause
            Les méthodologies de développement doivent aussi changer
            pour s'adapter à l'automatisation.

            Il faut instaurer l'écriture de tests, et l'utilisation
            du développement sur tronc commun (qui est plus adapté
            à l'automatisation et la collaboration).
        ]
    )
]

#new-section-slide("Étapes du projet")

#slide(title: [L'écriture des tests])[
    - Amélioration de la couverture des tests,
    - Écriture des tests...
    - ...et améliorations fonctionnelles (mocking...)
]

#slide(title: [`SssWebClient` avant les tests mockés])[
    #align(center)[
        #image("./assets/couverture-tests-before.png")
    ]
]
#slide(title: [`SssWebClient` après les tests mockés])[
    #align(center)[
        #image("./assets/couverture-tests-after.png")
    ]
]

/* #slide(title: [Fit to height])[
    You can scale content such that it has a certain height using
    `#fit-to-height(height, content)`:

    #fit-to-height(2.5cm)[Height is `2.5cm`]
]

#slide(title: "Fill remaining space")[
    This function also allows you to fill the remaining space by using fractions
    as heights, i.e. `fit-to-height(1fr)[...]`:

    #fit-to-height(1fr)[Wow!]
]

#slide(title: "Side by side content")[
    Often you want to put different content next to each other.
    We have the function `#side-by-side` for that:

    #side-by-side(lorem(10), lorem(20), lorem(15))
] */

#new-section-slide("Conclusion")

#slide(title: "That's it!")[
    Hopefully you now have some kind of idea what you can do with this template.

    Consider giving it
    #link("https://github.com/andreasKroepelin/polylux")[a GitHub star #text(font: "OpenMoji")[#emoji.star]]
    or open an issue if you run into bugs or have feature requests.
]
