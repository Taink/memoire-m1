#import "template.typ": project

// voir fichier `template.typ` pour modifier le template
#show: project.with(
  title: "Incorporer des outils d'intégration continue dans les processus métiers",
  subtitle: "Mémoire de fin d'année de M1 à l'EFREI",
  authors: (
    (name: "Maxime Daniel", email: "maxime.daniel@efrei.net", company: "Adagp", company_email: "maxime.daniel@adagp.fr"),
  ),
  abstract: lorem(300),
  abstract_en: lorem(300),
  // abstract: [
  //   blabla
  // ],
  date: "Version du 31 Juillet 2023",
  schoolLogo: "./assets/efrei.png",
  companyLogo: "./assets/adagp.svg",
)

= Introduction
L'évolution des projets informatiques modernes
accompagne celle de l'industrie dans son ensemble :
les projets ont hautement gagné en taille et en âge.

Pour accompagner cette nouvelle complexité,
des outils aidant au développement
et à la gestion des infrastructures
permettant de la faire fonctionner sont apparus.

Parmi ces outils, les outils d'intégration continue
sont une partie essentielle du processus de déploiement.
Il s'agit d'un ensemble de pratiques visant
à assurer la qualité du code écrit au fur du développement
de nouvelles fonctionnalités.

Ce mémoire aura donc pour but de répondre à la question suivante :
comment intégrer les pratiques d'intégration continue dans des processus métiers existants ?

Outre la réponse à cette question, ce mémoire vise également
à produire quelque éclairage sur les voies menant à un projet d'intégrations
des méthodologies d'intégration continue au sein des processus métiers
d'une entreprise.

En tout cas, pour répondre à notre problématique,
nous baserons nos conclusions sur une revue de travaux antérieurs sur ce sujet
et sur une étude de cas autour des projets réalisés pendant la rédaction du mémoire.

Nous commencerons donc par une analyse de l'état de l'art
au travers d'une revue de la littérature existante sur le sujet.
Nous continuerons en analysant le contexte de notre étude de cas,
avant de proposer une solution à notre problématique
au travers d'approches aussi bien théoriques que pratiques.
Nous mettrons en œuvre cette solution, et en critiquerons les résultats puis
finirons en déterminant le positionnement de notre étude dans l'état de l'art,
avant de tirer nos conclusions sur notre problématique.

= État de l'art
// Intro de cette partie ?
// idées ci-dessous

// Parmi ces outils, les outils d'intégration continue
// sont une partie essentielle du processus de déploiement.
// Il s'agit d'un ensemble de pratiques visant
// à assurer la qualité du code écrit au fur du développement
// de nouvelles fonctionnalités.

// Comme nous l'avons dit plus tôt, les outils d'intégration continue
// sont une composante essentielle de des processus de déploiement modernes.
// Commençons donc par en établir une définition.

== Définition de l'intégration continue

La définition exacte de l'intégration continue
(ou "CI" pour "_Continuous Integration_"),
bien qu'elle soit souvent similaire,
diffère parmi les experts du domaine
#cite(
  "booch-ood",
  "aws-ci-def",
  "ibm-ci-def",
  "atlassian-ci-def",
  "ieee-ci-review",
  "fowler-ci"
).

Le socle commun est bien retranscrit par la définition de @wikipedia-ci :
"L'intégration continue est un ensemble de pratiques utilisées
en génie logiciel consistant à
vérifier à chaque modification de code source que
le résultat des modifications ne produit pas de régression
dans l'application développée."

Il est en effet important de comprendre que l'intégration continue
désigne les pratiques à intégrer dans ses processus métiers,
et non les outils qui permettent d'en faciliter la mise en place.
@fowler-ci explique que la différence entre un projet qui utilise de
l'intégration continue et un projet qui n'en utilise pas
ne réside pas dans l'utilisation d'un outil cher et/ou complexe,
mais dans la pratique quotidienne d'une intégration par les développeurs
sur un répertoire contrôlé du code source#footnote[Un répertoire contrôlé
du code source est un répertoire de code source utilisant un système de
contrôle de version, comme Git, CVS ou Subversion par exemple.]<vcs>.

Les experts s'accordent aussi sur les objectifs de l'intégration continue :
- Accélérer la correction de bugs, au travers de tests systématiques
  sur les modifications réalisées
  #cite(
    "aws-ci-def",
    "ibm-ci-def",
    "atlassian-ci-def",
    "meyer-ci-tools",
    "fowler-ci"
  )
- Améliorer la communication des problèmes potentiels,
  au travers de notifications lorsque les tests échouent par exemple
  #cite(
    "aws-ci-def",
    "atlassian-ci-def",
    "meyer-ci-tools",
  )
- Visualiser rapidement l'évolution du développement du logiciel
  #cite(
    "aws-ci-def",
    "ibm-ci-def",
    "atlassian-ci-def"
  )

Enfin, l'intégration continue porte principalement sur
les tests d'intégration évidemment, mais aussi la
compilation#footnote[La compilation consiste à transformer
du code source en code binaire exécutable par la machine].
Il s'appuie généralement sur une automatisation de ces tâches,
et sur un système de notification en cas d'échec
#cite("aws-ci-def", "atlassian-ci-def").
Ces systèmes fonctionnent eux-même mieux lorsqu'ils sont intégrés
dans des systèmes de gestion de version, comme Git, CVS ou Subversion.
L'intégration continue est donc un ensemble de pratiques qui
redéfinissent les processus de développement de logiciels en profondeur.

== Présentation d'outils et technologies
Nous nous proposons maintenant de lister
les outils d'intégration continue les plus utilisés,
en analysant leur position dans le marché.

=== Jenkins
Jenkins est un outil d'intégration continue open-source écrit en Java.
Il est très flexible, et permet de mettre en place des pipelines
d'intégration continue très complexes.
Il est relativement facile à prendre en main,
mais la complexité des pipelines qu'il permet de mettre en œuvre
impacte sa facilité d'utilisation par rapport à des solutions plus modernes.
C'est en effet un des premiers outils de son genre et
il a défini de nombreux standards dans son marché.
Il occupe encore aujourd'hui une large part
du marché des outils d'intégration continue, même si
des solutions plus récentes l'ont fait peu à peu tomber en désuétude,
notamment en créant des alternatives plus faciles d'utilisation.
#cite("ieee-ci-review", "packt-hands-on-ci-cd")

#table(
  columns: (1fr, 1fr),
  inset: 10pt,
  align: horizon,
  [*Principaux atouts*], [*Compatible avec*],
  [
    - Écosystème robuste,
    - Communauté active,
    - Exécution sur site#footnote[L'exécution sur site est souvent
      nécessaire dans des contextes où les données utilisées
      sont sensibles@ieee-ci-review]<onsite>
  ],
  [

  ]
)

=== Travis CI
Travis CI est un service hébergé d'intégration continue.
Il est distribué sous une licence libre#footnote[Le code est certes libre,
mais son intégration sur une infrastructure n'est pas facile,
de l'aveu de l'entreprise elle-même@travis-blog-install],
et s'est surtout fait connaître pour son offre gratuite pour les
répertoires publics open-source.
Il est plutôt flexible, et permet à peu près 

#table(
  columns: (1fr, 1fr),
  inset: 10pt,
  align: horizon,
  [*Principaux atouts*], [*Compatible avec*@travis-ci-compat],
  [
    - Écosystème robuste,
    - Communauté active,
    - Exécution sur site#footnote[L'exécution sur site est souvent
      nécessaire dans des contextes où les données utilisées
      sont sensibles@ieee-ci-review]<onsite>
  ],
  [
    - Github
    - Atlassian Bitbucket
    - GitLab
    - Assembla
  ]
)

=== CircleCI
CircleCI est un autre service

=== GitLab CI
GitLab CI est un outil d'intégration continue open-source
intégré à la plateforme GitLab.
Il est lui aussi très flexible, et permet de mettre en place
des pipelines d'intégration continue tout aussi complexes.
Il s'appuie sur l'utilisation de conteneurs Docker,
qui lui permettent d'exécuter ses tâches dans un environnement
reproductible, souvent très proche de celui de production.
Son principal atout réside dans son intégration à la plateforme
GitLab, qui offre des fonctionnalités de gestion supplémentaires
à travers l'utilisation de son service GitLab CI.

== Revue de littérature
#lorem(400)

#pagebreak()

= Contextualisation de la mission en entreprise
#lorem(300)
== Contexte de l'entreprise et processus métiers existants
#lorem(400)
== Défis et lacunes
#lorem(500)
== Gains potentiels et avantages
#lorem(200)

#pagebreak()

= Proposition d'une solution
== Approche théorique
#lorem(750)
== Étapes clés et bonnes pratiques de mise en place
#lorem(350)
== Pertinence
#lorem(350)

#pagebreak()

= Mise en œuvre et responsabilités liées à la mission
== Actions entreprises
#lorem(500)
== Responsabilités assumées
#lorem(500)
== Défis rencontrés et leurs solutions
#lorem(500)

#pagebreak()

= Étude des résultats et limites du travail réalisé
== Résultats obtenus
#lorem(500)
== Analyse critique
#lorem(400)
=== Avantages
#lorem(500)
=== Limitations
#lorem(500)
== Facteurs d'influence sur les résultats
#lorem(400)
== Améliorations possibles
#lorem(400)

#pagebreak()

= Positionnement dans l'état de l'art
#lorem(150)
== Comparaison avec autres résultats prééxistants
#lorem(500)
== Contributions originales
// qu'ai-je apporté ?
#lorem(400)
== Implications et perspectives futures
#lorem(500)

#pagebreak()

= Conclusion

// - Résumé des principales conclusions du mémoire
// - Récapitulation des contributions et des recommandations
// - Possibilités d'extension et de recherche future

#lorem(500)

#pagebreak()

#bibliography("./bibliography.yml", title: "Bibliographie", style: "ieee")

#pagebreak()

= Annexes
#lorem(50)
