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
la compilation (ou une étape équivalente), qu'on appelle généralement _build_,
et enfin les tests de conformité fonctionnelle
(souvent réalisés par un service QA dédié).

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

#figure(
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
  ```,
  caption: [
    Une pipeline Jenkins qui permet de tester une application
    Java Maven en générant un rapport (écrite en
    #link("https://www.groovy-lang.org/", "Groovy"))
  ],
  kind: "example",
  supplement: "Exemple"
) <jenkins-example>

#figure(
  table(
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
          sont sensibles@ieee-ci-review,
          ou du moins si le réseau d'entreprise
          est derrière un pare-feu peu laxiste.
        ]
    ],
    [
      N'importe quel système : Jenkins est un serveur d'automatisation.
      À partir du moment où une étape est automatisable, Jenkins peut
      l'automatiser.
    ]
  ),
  caption: [Récapitulatif Jenkins],
) <jenkins-recap>

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

#figure(
  ```yaml
  language: java
  jdk:
    - openjdk8
  script:
    - mvn clean install
    - mvn test
    - cat target/surefire-reports/*.txt
  ```,
  caption: [
    Une pipeline Travis qui permet de tester une application
    Java Maven en générant un rapport
  ],
  kind: "example",
  supplement: "Exemple"
) <travis-example>

#figure(
  table(
    columns: (1fr, 1fr),
    inset: 10pt,
    align: horizon,
    [*Principaux atouts*], [*Compatible avec*@travis-ci-compat],
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
  ),
  caption: [Récapitulatif TravisCI],
) <travis-recap>

=== CircleCI <circle>
CircleCI est un autre service alternatif à #link(label("travis"))[Travis].
Il est fonctionnellement très similaire, mais s'en distingue
par une attention plus importante à la performance et l'efficacité.
Il est un peu moins facile d'utilisation (mais toujours plus que Jenkins),
mais a mis en place beaucoup de fonctionnalités permettant d'améliorer
la rapidité des étapes de build et de test, ce qui accélère encore
davantage l'intégration continue.
@travis-vs-circleci

#figure(
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
  ```,
  caption: [
    Une pipeline CircleCI qui permet de tester une application
    Java Maven en générant un rapport
  ],
  kind: "example",
  supplement: "Exemple"
) <circle-example>

#figure(
  table(
    columns: (1fr, 1fr),
    inset: 10pt,
    align: horizon,
    [*Principaux atouts*], [*Compatible avec*@travis-vs-circleci],
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
  ),
  caption: [Récapitulatif CircleCI],
) <circle-recap>

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

#figure(
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
  ```,
  caption: [
    Une pipeline Gitlab qui permet de tester une application
    Java Maven en générant un rapport
  ],
  kind: "example",
  supplement: "Exemple"
) <gitlab-example>

#figure(
  table(
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
  ),
  caption: [Récapitulatif Gitlab CI],
) <gitlab-recap>

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

#figure(
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
  ```,
  caption: [
    Une pipeline Github Actions qui permet de tester une application
    Java Maven en générant un rapport
  ],
  kind: "example",
  supplement: "Exemple"
) <github-actions-example>

#figure(
  table(
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
  ),
  caption: [Récapitulatif Github Actions]
) <github-actions-recap>

== Revue de la littérature
La littérature sur l'intégration continue est souvent produite par
des acteurs du métier, mais sa croissance suit l'intérêt qui est porté
pour cette approche qui facilite grandement les projets informatiques.

Martin Fowler, dans son article sur l'intégration continue @fowler-ci,
présente le concept au plus grand nombre.
C'est un article fondateur, écrit en 2006, qui fournit plusieurs
informations importantes sur le concept d'intégration continue,
son utilité, et son applicabilité.
Il appuie sa présentation par des exemples pratiques tirés de
son expérience professionnelle, et y établit les critères nécessaires à
la bonne conduite de l'intégration continue :
- Maintenir une source de vérité unique pour le code source
- Automatiser le build
- Ajouter des tests à l'étape de build
- Tous les développeurs devraient pousser leurs modifications (ou _commits_
  dans le contexte de Git et Subversion) quotidiennement
- Toutes les commits devraient déclencher un build
- Un build raté devrait être corrigé aussitôt
- Garder un build rapide
- Réaliser les tests dans un clone de l'environnement de production
- Rendre l'accès à un exécutable récent très facile
- Tout le monde doit voir ce qui se passe
- Automatiser le déploiement

Mojtaba Shahin et al. @ieee-ci-review ont produit un travail remarquable
dans leur propre revue de la littérature sur le sujet, et ils y produisent
une synthèse très instructive sur les tenants et aboutissants de la CI mais
aussi d'autres étapes du cycle DevOps : la livraison et le déploiement
continus.
Dans leur sélection (qui inclut 69 ouvrages, de 2004 à juin 2016), ils
notent que la majorité sont récents, et qu'ils sont pour la plupart produit
par l'industrie du développement logiciel.
Ils constatent en outre une majorité de projets web et utilitaires,
avec comme outils principaux Git/Github et Subversion pour le contrôle de
version et Jenkins comme serveur d'intégration.
Ils établissent enfin une liste de 7 facteurs qui impactent le succès des
projets d'incorporation des outils d'intégration continue,
par ordre d'importance :
1. L'effort et le temps alloués pour tester les approches
2. La transparence et la communication au sein de l'équipe
3. De bons principes de conceptions
4. Le client
5. La présence d'éléments motivés et compétents au sein de l'équipe
6. Le domaine d'application
7. Une infrastructure appropriée

Une lacune présente dans la littérature existante est cependant qu'elle peut
être sujette, du fait de sa production par des acteurs de l'industrie,
à des conflits d'intérêts ou du moins des manques d'objectivité.
Il est donc difficile de se baser sur l'avis d'une ou deux revues.

Une autre lacune, celle-là beaucoup plus importante, est que la plupart
des ouvrages récents publiés présupposent une grande familiarité avec le
reste des pratiques DevOps, et oublient un peu comment simplement intégrer
les idées de l'intégration continue dans un contexte moins compatible.
Très peu de publications expliquent leur choix de technologie, et les défis
qui ont pu les réorienter.

Cette étude se place donc comme un témoignage de l'applicabilité des pratiques
d'intégration continue, à travers l'incorporation de leurs outils au sein de
processus métiers orthogonaux aux pratiques DevOps.

= Contextualisation de la mission en entreprise
// #lorem(300)
Notre allons réaliser une étude de cas, celui de l'Adagp.
Cette entreprise, créée en 1953, est une société à but non lucratif.

"ADAGP" est un acronyme qui signie
"Association pour la Diffusion des Arts Graphiques et Plastiques"
#footnote[
  Elle a été rebaptisée depuis la loi 3 juillet 1986 en "Société des artistes
  dans les arts graphiques et visuels"
] ;
c'est un _Organisme de Gestion Collective_,
qui représente des artistes d'horizons très différents :
plus de 40 disciplines artistiques sont représentées
parmi les arts graphiques et plastiques
(allant de la peinture à l'architecture,
la photographie à la sculpture,
en passant par la ferronerie et la bande dessinée ou le manga).

D'après le CNC @cnc-sprd,
"[l'ADAGP] intervient dans les domaines suivants :
droit de reproduction
(livres, posters, presse, merchandising...),
droit de représentation
(audiovisuel, présentation publique...),
droit de suite,
multimédia,
copie privée,
photocopie,
droit de prêt".

Elle joue en somme un rôle d'intermédiaire juridique entre les artistes
et les personnes qui, d'une façon ou d'une autre,
veulent utiliser leurs œuvres.

C'est une entreprise de taille moyenne, dont le nombre d'employés (aussi
appelés _gestionnaires_ dans ce contexte) tourne autour de 70 personnes.

Son statut juridique de SPRD
#footnote[
  Pour Société de Perception et de Répartition des Droits
]
la soumet à un contrôle annuel de la Cour des
Comptes (à l'instar d'autres sociétés d'auteur comme la SACEM ou la SACD par
exemple) et son statut de société d'auteur (et de société à but non lucratif)
l'oblige à redistribuer une partie de ses perceptions dans diverses actions,
dont l'Action Culturelle par exemple.

== Contexte de l'entreprise et processus métiers existants
// #lorem(400)
Je suis alternant au sein du service informatique de l'Adagp.
Ce service est composé de 4 personnes (3 si on omet ma présence),
et intervient dans tous les autres services de l'Adagp,
notamment à travers l'ERP développé en interne, SIGEDAV.
Ce dernier est l'outil utilisé par l'ensemble de l'entreprise
pour gérer les droits de ses adhérents.

C'est un service important, essentiel au bon fonctionnement de l'Adagp,
et qui a à ce titre une multitude de responsabilités, parmi lesquelles :
- Le développement et le support de SIGEDAV, l'ERP interne (écrit en Java),
- Le développement et le support de l'extranet,
- La gestion du parc informatique de l'Adagp,
- La gestion du réseau interne,
- Le support technique

Contrairement à la plupart des autres services de l'Adagp,
ses effectifs n'ont pas changé depuis le début de mon alternance.
Sa petite taille est à la racine de ses choix de processus métiers.

Le développement sur les applications à l'ADAGP
suit un processus d'amélioration continue.
1. En premier lieu, une demande est formulée par une personne de l'Adagp.
2. Ensuite, la demande est évaluée par le *précopil* ;
  il s'agit d'un comité décisionnel composé
  du service informatique
  et du comité utilisateur --
  ce dernier est composé d'utilisateurs représentatifs,
  qui pourront poser des questions aux utilisateurs
  à l'origine de la demande.
3. Une seconde évaluation est réalisée par le *copil* ;
  ce comité est composé
  du service informatique,
  de la direction administrative et financière,
  et du service études et prospectives.

  Ce dernier comité va en particulier établir l'importance de la demande.
  Pour ce faire, il va en évaluer les gains, et risques potentiels.
  Cette importance détermine la priorité et les échéances d'implémentation
  de la demande si cette dernière est acceptée.
  En effet, les demandes, une fois acceptées,
  sont ajoutées au planning du service informatique,
  soit avec une échéance immédiate
  (pour les demandes hautement prioritaires),
  soit avec une échéance indéfinie
  (pour les demandes jugées peu importantes).
  L'importance de la demande fera osciller son échéance dans le planning
  entre ces deux extrêmes.
  Parfois, la demande constitue une obligation réglementaire :
  dans ce cas, il est nécessaire de se mettre en conformité
  avec la nouvelle législation,
  la demande a alors une priorité absolue
  et doit être traitée dans les plus brefs délais.
4. Un cahier des charges est rédigé,
  ainsi que des spécifications techniques,
  et une étude d'impact
  (pour déterminer quels services seront impactés par la demande).
  Cette rédaction est réalisée en collaboration
  avec les personnes à l'origine de la demande.
5. Vient enfin le temps du développement de la fonctionnalité.
  C'est aussi pendant cette étape que les tests sont écrits.
6. C'est généralement à ce stade qu'une intégration est réalisée.
  Dans certains cas,
  cette étape peut constituer la mise en place
  d'un environnement de pré-production
7. Après le développement,
  une série de tests est réalisée avec les équipes des services
  à l'origine de la demande.
8. Si tout s'est bien passé,
  la demande a bien été réalisée.
  Les modifications sont mises en production
  Une rétrospective sera faite en précopil et en copil.

#figure(
  image("assets/cycle-développement-adagp.excalidraw.svg", width: 80%),
  caption: [Cycle de l'amélioration continue des applications à l'Adagp.]
) <cycle-dev-adagp>

On peut voir en @cycle-dev-adagp que certaines étapes
mènent à revenir en arrière dans le processus d'amélioration continue.
Une autre façon de schématiser le cycle de développement de l'Adagp
est comme une série de cycles en V
(dont le cas général est produit en @cycle-en-v),
pour chaque nouvelle demande d'amélioration d'une application.

Enfin, chacun des membres du service a une spécialité qui lui incombe
(Web, Applications Java, ...),
et les application tombent dans l'une de ces spécialités.
L'application tombe sous la responsabilité de la personne
qui est spécialisé dans le domaine de l'application.
Ça n'exclut évidemment pas la responsabilité de support,
et si le membre responsable d'une application particulière est absent,
il faut que les autres membres puissent au moins diagnostiquer les erreurs
qui pourraient survenir pour y remédier.
Par conséquent, chaque membre fournit aux autres une documentation relative
à la gestion des applications dont il a la responsabilité
(installation, exploitation, mise à jour...).
La rédaction de cette documentation est un processus interne au service,
qui s'ajoute au cycle d'amélioration continue.

== Défis et lacunes
// #lorem(500)
L'incorporation d'outils et méthodologies d'intégration continue
peut constituer un défi à de multiples égards.

Premièrement, l'intégration continue bénéficie grandement
de l'automatisation de certaines tâches,
travail qui n'est généralement pas déjà fait à l'Adagp.
Les tâches de test et de déploiement sont réalisées manuellement,
ce qui peut entraîner des oublis et des erreurs.
Le code d'automatisation devra donc être intégralement écrit
pendant la mise en place des outils.

De plus, l'équipe du service informatique n'est pas formée aux dernières
technologies d'intégration,
et n'a pas nécessairement le temps de se former en profondeur sur le sujet.
Il faut donc trouver un compromis entre la mise en place d'une solution
efficace et la facilité d'utilisation de cette dernière.

Enfin, l'Adagp est une entreprise à but non lucratif de taille moyenne,
qui n'a pas nécessairement les moyens de mettre en place une solution
d'intégration continue complexe et coûteuse.
Il faut donc trouver une solution qui soit à la fois efficace et si
possible gratuite, sinon très peu coûteuse.
Le plus difficile sera de trouver une solution
qui soit à la fois efficace et facile d'utilisation,
car les solutions gratuites sont souvent plus complexes à mettre en place.

En effet, @ieee-ci-review note que l'effort et le temps alloués
à l'expérimentation des approches d'intégration continue
sont les facteurs les plus importants pour le succès
des projets d'incorporation des pratiques d'intégration continue,
or les effectifs du service informatique de l'Adagp étant limités,
il est difficile de trouver du temps pour expérimenter
les différentes solutions disponibles
en plus des améliorations à apporter aux applications existantes.

Le plus gros défi sera cependant à long terme.
L'absence d'outils d'intégration continue n'a pas encouragé
le service à écrire beaucoup de tests unitaires
(en pratique, seuls des tests unitaires basiques sont écrits) ;
ils constituent une charge de développement supplémentaire,
charge qu'il peut être difficile d'assumer en plus du support.
@fowler-ci encourage d'ailleurs le test du code pendant l'intégration.
Il faudra donc aussi commencer à réintégrer l'écriture
de tests de façon plus systématique
pendant le développement.

== Gains potentiels et avantages
// #lorem(200)
Le gain potentiel principal de l'ajout de processus d'intégration continue
est le gain en facilité de collaboration entre les membres du service.

Au-delà des simples améliorations de qualité de vie
(l'intégration continue diminue l'impact des conflits
de fusion de branches sur les système de contrôle de version comme Git,
car l'intégration comprend la compilation des projets :
on est assurés que le projet fonctionne car il _build_ malgré la fusion),
l'ajout d'outils de CI à un projet permet surtout d'augmenter
la confiance dans le code écrit par les autres collaborateurs.
Les outils de CI permettant d'intégrer à chaque modification,
ils augmentent mécaniquement la transparence et la communication
(au travers des logs et des notifications d'échec ou de rétablissement)
pendant le développement.

À plus long terme, l'intégration continue est surtout un bon moyen
d'éviter les régressions issue des modifications.
Le service informatique n'y a été que très peu confronté
car les projets sont généralement très cloisonnés,
de sorte que chacun connaît très bien les projets qui lui incombent
et les problèmes de régression sont généralement facilement identifiés
et rapidement corrigés.

// retour d'expérience méthodologies agiles
// permet d'éviter les régressions
// gain en transparence et en communication ( logs )
// facilite la collaboration
// prétexte pour automatisation des processus

Un autre avantage à l'incorporation de ces outils,
c'est que beaucoup de processus internes seront automatisés.
C'est une charge supplémentaires mais un gain conséquent.

Enfin, l'intégration continue est un des chemins
que le service informatique souhaite emprunter
pour mettre en place des méthodologies agiles.
L'intégration continue est en effet une étape clé
de certaines méthodologie d'inspiration agile ;
ce projet pourra constituer un retour d'expérience supplémentaire.

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
== Responsabilités assumées
Ma mission consiste à épauler les autres membres du service informatique
sur de nouveaux projets, soit en collaboration avec eux, soit en
réalisant des projets en autonomie.
Parmi ces derniers,
on peut citer le développement du formulaire d'adhésion en ligne,
qui permet aux artistes d'adhérer à l'Adagp par internet,
ce qui permet de faciliter le traitement de ces demandes pour le service
des adhésions.
// #lorem(500)
== Actions entreprises
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
#figure(
  image("assets/wikipedia-cycle-en-v.png"),
  caption: [
    Cycle en V
    (Source: #link("https://fr.wikipedia.org/wiki/Cycle_en_V", "wikipedia"))
  ],
  kind: "appendix",
  supplement: "Annexe",
  numbering: "A"
) <cycle-en-v>
