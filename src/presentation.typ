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
  les processus métiers],
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

  J'y assiste le service informatique,
  dans des projets de développement soit en collaboration
  soit en autonomie.

  Ce mémoire est le compte rendu d'un projet de recherche et
  développement.
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
  Cette solution hébergée s'est fait connaître pour son offre gratuite
  sur les projets open-source.

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
  Cette solution est comparable à Travis, mais met un accent
  sur la performance de l'exécution des tests.

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
  L'orchestrateur des tâches est forcément hébergé mais
  l'exécuteur (ou "runner") des tâches peut être sur site,
  ce qui rend la solution complètement gratuite.
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
  Équivalent de GitLab CI mais dédié à Github.

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

#new-section-slide("Contexte")

#slide(title: "Le projet ciblé")[
  Client Java d'un service de notification externe.

  Le client utilise Maven pour la compilation,
  donc le gros du travail d'intégration est déjà fait :
  les scripts sont déjà préparés et il faut juste exécuter une seule
  commande.
]

#slide(title: "Solution retenue")[
  Étant donné notre contexte, une solution idéale aurait les
  caractéristiques suivantes :
  #line-by-line[
    - Facile (voire agréable) d'utilisation
    - Gratuite
    - Compatible avec les technologies utilisées à l'ADAGP
      (Java, Maven, Git et Github)
    - Facile à mettre en place
    - Pas (ou peu) de maintenance nécessaire
  ]

  La solution qui correspond le plus :
  #uncover(6)[*Github Actions*.]
]

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

      C'est une amélioration facile à réaliser car globalement
      déjà en place dans le service informatique.
    ]
  )
]

#new-section-slide("Mise en œuvre")

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

#set text(size: 15pt)

#slide(title: [Écriture du fichier de configuration Github Actions])[
  #alternatives([
  ```yaml
  name: maven-build
  run-name: Run maven up to 'verify' phase and archive JAR

  on: [push, pull_request]

  jobs:
    maven-build:
    strategy:
      matrix:
      os: [windows-latest, ubuntu-latest]

    runs-on: ${{ matrix.os }}

    concurrency:
      group: ${{ github.workflow }}-${{ github.ref }}-${{ matrix.os }}
      cancel-in-progress: true

    ...
  ```],[
  ```yaml
    ...

    steps:
      - uses: actions/checkout@v3
      - name: Setup JDK
        uses: actions/setup-java@v3
        with:
          java-version: '17'
          distribution: 'oracle'
          cache: maven
      - name: Maven build
        run: mvn -B clean verify
      - uses: actions/upload-artifact@v3
        with:
          name: compiled-jar
          path: target/*.jar
          retention-days: 1
  ```
  ])
]

#set text(size: 20pt)

#new-section-slide("Analyse critique")

#slide(title: "Revue des résultats obtenus")[
  #align(center)[
    #image("./assets/ci-results-dashboard.png")
  ]
]
#slide[
  #align(center)[
    #image("./assets/ci-results-job.png")
  ]
]
#slide[
  #align(center)[
    #image("./assets/ci-results-job2.png")
  ]
]

#slide(title: "Avantages")[
  - Taille du projet
  - Modèle de développement en tronc commun
  - Automatisation de l'intégration (difficulté réduite)
]

#slide(title: "Limitations")[
  - Taille du projet
  - Solution Github Actions pas complètement testée
  - Le service externe n'est pas complètement testé
]

#slide(title: "Facteurs d'influence")[
  - Choix de technologies
    - Maven
    - Github Actions
  - Taille du projet
  - Temps de mise en place
  - Expérience préalable
]

#slide(title: "Utilisation de Github Actions sur le mémoire et la présentation")[
  Cette présentation et le mémoire ont étés compilés via un même
  logiciel de composition, Typst.

  La compilation de ces deux éléments est réalisée via Github Actions.

  #pause

  C'est un témoignage de la flexibilité de la solution Github Actions.
]

#new-section-slide("Conclusion")

#slide(title: "Conclusion")[
  #only(1)[
    Points d'attention :
    - La mise en place de l'intégration continue est un investissement
      complexe et progressif
    - De nombreux facteurs doivent être pris en compte pour réussir
      un projet d'intégration continue

    Critères de réussite du projet :
    - Éprouver la qualité du code et du logiciel
    - Solution facile à maintenir
  ]
  #only("2-3")[
    Ce projet a permis de :
    - vérifier la viabilité des Github Actions,
    - établir un moyen de parvenir à une solution fonctionnelle,
    - tester un prototype pour un futur projet.

    #only(3)[
      Pistes d'amélioration :
      - Projet plus gros
      - Utilisation plus avancée de Github
    ]
  ]
]

#focus-slide[
  Merci pour votre attention !
]