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

== Définitions
=== Intégration
Avant de parler d'intégration continue, définir la notion d'intégration
dans notre contexte devrait permettre de faire comprendre exactement
ce que l'intégration _continue_ vise à faire.

Dans notre contexte, l'intégration désigne l'étape durant laquelle
on rassemble les modifications réalisées par les équipes de développement.
Cette étape précède généralement l'envoi d'un livrable au client,
et comprend donc la mise en commun des modifications,
la compilation (ou une étape équivalente), et enfin
les tests de conformité fonctionnelle (souvent par un service QA dédié).

C'est une étape longue et compliquée, car elle peut révèler des bugs
qui nécessiteront un travail conséquent pour être corrigés.
C'est également souvent une source de conflits entre les équipes de
développement, l'une introduisant des changements qui impactent les autres,
sans qu'aucune équipe ne soit au courant avant l'intégration.
De plus, sur les projets à plus long terme,
c'est une étape qui peut révèler des bugs de _régression_#footnote[La
régression correspond à une diminution de la qualité ou de la complétude
du logiciel développé. Autrement dit, un changement introduit dans
une nouvelle version qui vient perturber un mécanisme d'une version
plus ancienne.], qui sont autrement plus difficile à déceler pendant
le développement.
#cite(
  "fowler-ci",
  "packt-hands-on-ci-cd",
)

=== Intégration continue
Introduite dans les pratiques d'_Extreme Programming_#footnote[Il s'agit
d'une méthodologie similaire à la méthode Agile. Nous n'entrerons pas
dans les détails de son fonctionnement ici puisque la CI est devenue
indépendante de sa création et s'est standardisée dans l'industrie.]
la définition exacte de l'intégration continue
(ou "CI" pour "_Continuous Integration_"),
bien qu'elle soit souvent similaire,
diffère parmi les experts du domaine
#cite(
  "fowler-ci",
  "booch-ood",
  "aws-ci-def",
  "ibm-ci-def",
  "atlassian-ci-def",
  "ieee-ci-review",
).

Le socle commun est bien retranscrit par la définition de Wikipedia
@wikipedia-ci :
"L'intégration continue est un ensemble de pratiques utilisées
en génie logiciel consistant à
vérifier à chaque modification de code source que
le résultat des modifications ne produit pas de régression
dans l'application développée."

Il est en effet important de comprendre que l'intégration continue
désigne les pratiques à intégrer dans ses processus métiers,
et non les outils qui permettent d'en faciliter la mise en place.
Martin Fowler @fowler-ci explique d'ailleurs, dans son article sur le sujet,
que la différence entre un projet qui pratique de la CI
et un projet qui n'en pratique pas ne réside pas dans l'utilisation
d'un outil cher et/ou complexe,
mais dans la pratique quotidienne d'une intégration par les développeurs
sur un répertoire contrôlé du code source#footnote[Un répertoire contrôlé
du code source est un répertoire de code source utilisant un système de
contrôle de version, comme Git, CVS ou Subversion par exemple.]<vcs>.

Par ailleurs, les experts s'accordent aussi sur les objectifs de
l'intégration continue :
- Accélérer la correction de bugs, au travers de tests systématiques
  sur les modifications réalisées
  #cite(
    "fowler-ci",
    "aws-ci-def",
    "ibm-ci-def",
    "atlassian-ci-def",
    "meyer-ci-tools",
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

En somme, l'intégration continue vise à réduire les problèmes
introduits par la collaboration sur les projets informatiques,
en particulier en ciblant le moment du partage des modifications
du code source.
#cite(
  "fowler-ci",
  "packt-hands-on-ci-cd",
  "aws-ci-def",
  "ieee-ci-review",
  "meyer-ci-tools",
)

La CI s'appuie généralement sur une automatisation de ses pratiques,
et sur un système de notification en cas d'échec.
#cite("aws-ci-def", "atlassian-ci-def")

L'automatisation ne devient possible que lorsque le code source est
géré sur le répertoire d'un système de contrôle de version,
comme Git, CVS ou Subversion.
L'intégration continue peut donc nécessiter une redéfinition
en profondeur des processus de développement de logiciels.

// === DevOps
// Le DevOps est un ensemble de méthodologies qui consistent à accélerer
// les cycles de vie des projets de développement d'applications.


== Présentation d'outils et technologies
Nous nous proposons maintenant de lister
les outils d'intégration continue les plus utilisés.

=== Jenkins <jenkins>
Jenkins est un outil d'intégration continue open-source écrit en Java.
Il est très flexible, et permet de mettre en place des pipelines
d'intégration continue très complexes.
Il est relativement facile à prendre en main,
mais la complexité des pipelines qu'il permet de mettre en œuvre
impacte sa facilité d'utilisation par rapport à des solutions plus modernes.
C'est en effet un des premiers outils répandu de son genre et
il a défini de nombreux standards dans son marché.
Il occupe encore aujourd'hui une large part
du marché des outils d'intégration continue, même si
des solutions plus récentes l'ont fait peu à peu tomber en désuétude,
notamment en créant des alternatives plus faciles d'utilisation.
#cite("ieee-ci-review", "packt-hands-on-ci-cd")

Voici un exemple d'une pipeline Jenkins qui permet de tester une application
Java Maven en générant un rapport (sa syntaxe est celle de Groovy) :

#align(center)[
  #box(fill: luma(230), inset: 8pt, radius: 5pt, [
    ```groovy
    node {
      stage('SCM') {
        git 'https://github.com/user/repo.git'
      }
      
      stage('Build') {
        sh 'mvn clean install'
      }
      
      stage('Test') {
        sh 'mvn test'
        junit 'target/surefire-reports/*.xml'
      }
    }
    ```
  ])
]

#table(
  columns: (1fr, 1fr),
  inset: 10pt,
  align: horizon,
  [*Principaux atouts*], [*Compatible avec*],
  [
    - Écosystème robuste,
    - Communauté active,
    - Exécution sur site gratuite#footnote[L'exécution sur site est souvent
      nécessaire dans des contextes où les données utilisées
      sont sensibles@ieee-ci-review, ou du moins si le réseau d'entreprise
      est derrière un pare-feu peu laxiste.]
  ],
  [
    N'importe quel système : Jenkins est un serveur d'automatisation.
    À partir du moment où une étape est automatisable, Jenkins peut
    l'automatiser.
  ]
)

=== Travis CI <travis>
Travis CI est un service hébergé d'intégration continue.
Il est distribué sous une licence libre#footnote[Le code est certes libre,
mais l'intégration de son offre "entreprise", qui permet d'héberger sur 
site sur une infrastructure n'est pas facile,
de l'aveu de Travis eux-même@travis-blog-install],
et s'est surtout fait connaître pour son offre gratuite pour les
répertoires publics open-source.
Il est plutôt flexible, et permet de faire à peu près la même chose
que #link(label("jenkins"))[Jenkins].
La seule différence avec ce dernier c'est qu'il doit suivre les changements
réalisés sur une plateforme en ligne, ce qui limite logiquement
sa compatibilité à une poignée de sites.
Il est cependant très facile d'utilisation, et utilise un fichier de
configuration écrit en YAML (son format est donc répandu).
C'est une idée qui est reprise dans beaucoup d'autres systèmes
similaires (et le reste des outils présentés dans cette section sont
configurés en YAML également).

Voici une pipeline équivalente à celle décrite plus haut, qui permet elle
aussi de tester une application Java Maven en générant un rapport :
#align(center)[
  #box(fill: luma(230), inset: 8pt, radius: 5pt, [
    ```yaml
    language: java
    jdk:
      - openjdk8
    script:
      - mvn clean install
      - mvn test
      - cat target/surefire-reports/*.txt
    ```
  ])
]

#table(
  columns: (1fr, 1fr),
  inset: 10pt,
  align: horizon,
  [*Principaux atouts*], [*Compatible avec*@travis-ci-compat],
  [
    - Facile d'utilisation,
    - Communauté active,
    - Mise en place très rapide,
    - Gratuit sur les projets open-source
  ],
  [
    - Github
    - Atlassian Bitbucket
    - GitLab
    - Assembla
  ]
)

=== CircleCI <circle>
CircleCI est un autre service alternatif à #link(label("travis"))[Travis].
Il est fonctionnellement très similaire, mais s'en distingue
par une attention plus importante à la performance et l'efficacité.
Il est un peu moins facile d'utilisation (mais toujours plus que Jenkins),
mais a mis en place beaucoup de fonctionnalités permettant d'améliorer
la rapidité des étapes de build et de test, ce qui accélère encore
davantage l'intégration continue.
@travis-vs-circleci

Voici une pipeline équivalente à celle décrite plus haut, qui permet elle
aussi de tester une application Java Maven en générant un rapport :
#align(center)[
  #box(fill: luma(230), inset: 8pt, radius: 5pt, [
    ```yaml
    version: 2.1
    jobs:
      build:
        docker:
          - image: circleci/openjdk:8-jdk
        steps:
          - checkout
          - run: mvn clean install
          - run: mvn test
          - store_test_results:
              path: target/surefire-reports
    ```
  ])
]
#pagebreak() // necessary for styling
#table(
  columns: (1fr, 1fr),
  inset: 10pt,
  align: horizon,
  [*Principaux atouts*], [*Compatible avec*@travis-vs-circleci],
  [
    - Assez facile d'utilisation,
    - Mise en place et exécution très rapides,
    - Gratuit sur les projets open-source
  ],
  [
    - Github
    - Atlassian Bitbucket
    - Github Enterprise
  ]
)

=== GitLab CI <gitlab-ci>
GitLab CI est un outil d'intégration continue open-source
intégré à la plateforme GitLab.
Il est moins flexible que #link(label("travis"))[TravisCI] ou
#link(label("circle"))[CircleCI] mais compense son exclusivité avec
Gitlab par une intégration inatteignable pour un service externe.
Il s'appuie sur l'utilisation de conteneurs Docker,
qui lui permettent d'exécuter ses tâches dans un environnement
reproductible, souvent très proche de celui de production.
Son principal atout réside dans son intégration à la plateforme GitLab ;
il est possible depuis une pipeline Gitlab d'interagir en profondeur
avec le reste de plateforme, qui peut alors réagir directement aux
changements introduits dans les dernières versions.
@gitlab-about-ci

Il faut par ailleurs noter que l'exécuteur des tâches est un
"runner" qu'il est possible d'héberger sur site gratuitement. Des runners
hébergés par l'instance du site sont cependant mis à disposition des
utilisateurs, qui disposent de crédits d'utilisation à la minute
-- ce fonctionnement est alors le même que #link(label("travis"))[TravisCI]
et #link(label("circle"))[CircleCI].
Héberger le runner permet de l'utiliser dans un réseau d'entreprise sans
permettre à Gitlab d'y accéder, mais l'orchestration des pipelines entre
les runners est laissée à l'instance Gitlab#footnote[L'instance peut aussi
être hébergée sur site, mais c'est un projet à part entière.]

Le service CI fonctionne main dans la main avec le reste de l'offre de 
GitLab, qui se vend d'ailleurs comme une "plateforme DevOps", et qui offre
ainsi la possibilité d'unifier toutes les informations nécessaires à la
gestion du projet, fournissant des services de gestion de projet approchant
à certains égards des plateformes dédiées (comme Jira par exemple).

Voici une pipeline équivalente à celle décrite plus haut, qui permet elle
aussi de tester une application Java Maven en générant un rapport :
#align(center)[
  #box(fill: luma(230), inset: 8pt, radius: 5pt, [
    ```yaml
    image: maven:3.6.1-jdk-8
    stages:
      - build
      - test
    build:
      stage: build
      script: mvn clean install
    test:
      stage: test
      script: mvn test
      artifacts:
        when: always
        paths:
          - target/surefire-reports
    ```
  ])
]
#pagebreak() // necessary for styling
#table(
  columns: (1fr, 1fr),
  inset: 10pt,
  align: horizon,
  [*Principaux atouts*], [*Compatible avec*],
  [
    - Intégration privilégiée avec Gitlab
    - Gratuit si runner auto-hébergé + crédits gratuits sur runners partagés
  ],
  [
    Gitlab seulement, possibilité d'importer des projets depuis
    Bitbucket et Github cependant.
  ]
)

=== Github Actions <github-actions>
Github Actions est un service très similaire à
#link(label("gitlab-ci"))[Gitlab CI],
mais pour Github au lieu de Gitlab.

Il en diffère cependant sur certains points @github-about-ci :
- Il se base non seulement sur Docker, mais aussi sur des étapes
  partagées par la communauté
- Il peut interagir avec des évènements plus variés que des modifications
  de code ; des pull requests, des issues, des commentaires, des reviews...
  C'est un outil donc beaucoup plus flexible sur la communication que
  son concurrent, qui lui est davantage pensé pour fonctionner
  avec des systèmes de déploiement complexes.
- Son runner n'est pas lui-même dans un conteneur Docker : c'est simplement
  un script shell. Cela signifie que l'environnement d'exécution du runner
  n'est pas isolé du serveur sur lequel il est exécuté.

Voici une pipeline équivalente à celle décrite plus haut :
#align(center)[
  #box(fill: luma(230), inset: 8pt, radius: 5pt, [
    ```yaml
    name: Java CI
    on: [push, pull_request]
    jobs:
      build:
        runs-on: ubuntu-latest
        steps:
        - uses: actions/checkout@v2
        - name: Set up JDK 1.8
          uses: actions/setup-java@v1
          with:
            java-version: 1.8
        - name: Build with Maven
          run: mvn clean install
        - name: Test with Maven
          run: mvn test
        - name: Archive test results
          uses: actions/upload-artifact@v2
          with:
            name: surefire-reports
            path: target/surefire-reports
    ```
  ])
]

#table(
  columns: (1fr, 1fr),
  inset: 10pt,
  align: horizon,
  [*Principaux atouts*], [*Compatible avec*],
  [
    - Intégration privilégiée avec Github
    - Gratuit si runner auto-hébergé + crédits gratuits sur runners partagés
  ],
  [
    Github seulement.
  ]
)

== Revue de la littérature
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
