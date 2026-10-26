# Microéconomie 2 — notes de cours

Livre Quarto (R + ggplot2) des notes de cours de Microéconomie 2, L2 économie-gestion, Université Paris 8.
Auteurs : Elias Bouacida, Hela Maafi, Antoine Terracol. Langue : français.

## Contexte d'usage

- Les notes servent de support à un **cours asynchrone** : l'étudiant travaille seul, sans enseignant pour lever ses doutes.
- Le cours est compilé et déposé sur **Moodle**, ouvert au fur et à mesure. Rien n'est publié en ligne pour les étudiants : **pas de liens web** vers le TD ni vers un site.
- Chaque document doit être **autoportant**.
- Le TD se fait en parallèle. Il est dans `../ExercicesMicro2` (brochure LaTeX dans `Brochure/2026-2027/`, corrigés Quarto). La **numérotation des exercices est figée**, car la fiche papier est déjà distribuée. Les renvois au TD se font par numéro (« fiche 2, exercice 2.5 »). Dans ce dépôt, `03-monopole-naturel.qmd` et `04-monopole-discriminant.qmd` sont volontairement inclus dans `02-monopole.qmd` et absents de son `_quarto.yml`.

## Règles de travail

- **Corrections une par une** : présenter chaque modification (texte actuel → texte proposé, avec la justification) et n'éditer qu'après **approbation explicite**. Pas de corrections groupées non validées.
- Pour une figure : faire valider le principe, modifier, générer la figure, la vérifier visuellement (chevauchement d'étiquettes, cohérence avec le texte), puis la montrer.
- Vérifier les calculs avant de proposer des valeurs numériques : les exemples doivent satisfaire les équations du texte.
- Ne pas commiter sans demande.

## Structure

| Fichier | Contenu |
|---|---|
| `index.qmd` | Présentation, bibliographie, plan |
| `01-cpp.qmd` | Concurrence pure et parfaite (rappels L1) |
| `02-monopole.qmd` | Monopole : recette marginale, optimum, Lerner, monopole naturel, régulation, discrimination (1ᵉʳ, 2ᵉ, 3ᵉ degrés) |
| `03-oligopoles.qmd` | Cournot (duopole, N firmes, Lerner, HHI), Stackelberg, cartel (**hors programme**) |
| `05-cppmono.qmd`, `06-equilibres.qmd`, `07-surplus.qmd` | Annexes A, B, C : tableau CPP/monopole, fiche méthode (étapes de calcul), calcul des surplus |
| `08-rappels.qmd`, `09-notations.qmd` | Annexes D, E : rappels mathématiques, tableau des notations (avec les termes du TD) |
| `moodle.lua`, `moodle-liens.R` | Adaptations du HTML pour le livre Moodle (voir plus bas) |
| `_theme.qmd` | Charge ggplot2 et le thème `theme_perso`, inclus en tête de chaque chapitre |

## Diffusion dans un livre Moodle

Le HTML compilé est importé dans un livre Moodle (outil « Importer un chapitre », zip du dossier `_book`). Tests faits le 13 octobre 2026 :
- les encadrés Quarto (`callout-*`) gardent leurs couleurs et leur titre ;
- les encadrés **repliables** de Quarto (`collapse="true"`) ne fonctionnent pas : utiliser `<details><summary>Réponse</summary> … </details>` (lignes vides autour du contenu Markdown) ;
- les figures et les renvois **à l'intérieur d'un chapitre** fonctionnent ;
- les renvois **entre chapitres** ne fonctionnent pas : `moodle-liens.R` (lancé en `post-render`) retire leur lien et garde leur texte ;
- Moodle affichait les formules centrées dans le fil du texte et perdait l'ancre des équations numérotées : `moodle.lua` (filtre limité au HTML) corrige les deux ;
- Moodle classe les chapitres par nom de fichier : `index.html` arrive en dernier et doit être déplacé à la main.

## Piège d'édition

Ne pas écrire de LaTeX via des chaînes Python ou sed non brutes. `\t`, `\r` et `\f` deviennent des caractères de contrôle (`\text` → tabulation, `\right` → retour chariot). Utiliser l'outil Edit, puis vérifier avec `git diff | grep -P '^\+.*[\x00-\x08\x0b-\x1f]'`.

## Conventions

- Environnements Quarto : `def-`, `prp-`, `thm-`, `cor-`, `exm-`, `cnj-` (hypothèses), `.remark`, `.proof`. Figures `fig-`, équations `eq-`, sections `sec-`.
- Les préfixes de renvoi sont en minuscules (`_quarto.yml` : `crossref` et `language: crossref-sec-prefix: section`).
- Les identifiants doivent être uniques dans tout le livre (ceux de l'annexe C portent le suffixe `-annexe`).
- Blocs R : un bloc qui porte `#| label: fig-…` a un en-tête sans nom (```` ```{r} ````), sinon knitr signale un « duplicated chunk option 'label' ».
- Notations : $C_m$ coût marginal, $C_M$ coût moyen, $CV_M$ coût variable moyen, $R_m$ recette marginale, $P(q)$ demande (agrégée) inverse, $Q(p)$ demande, $S(q)$ offre agrégée inverse, $\varepsilon_{q/p}$ élasticité prix, $S_c$ et $S_p$ surplus, $S_i$ part de marché.
  - Régulation : $s$ subvention unitaire, $S_{\text{tot}}=s^*q^*_{CPP}$ montant total versé (ni $D$, réservé à la demande, ni $S_F$, qui suggérerait une subvention forfaitaire).
  - Cournot : le coût quadratique est $C_i(q_i)=kq_i^2$ ; $c$ est réservé à un coût marginal constant, comme dans le TD.
  - L'étoile signale un **choix optimal** : $q_1^*=f_1(q_2^a)$ est la meilleure réponse à l'anticipation $q_2^a$ ; à l'équilibre, les anticipations sont justes et $(q_1^*, q_2^*)$ désigne l'équilibre. Même convention pour $q_F^*$ en Stackelberg.
- Vocabulaire : on garde les termes du cours et on signale ceux du TD à leur première apparition (perte sèche / charge morte, recette / revenu marginal, pilote / meneuse / leader, satellite / suiveuse / follower, équilibre de Cournot / Cournot-Nash, fonction de réaction / meilleure réponse). « Revenu marginal » n'est employé qu'une fois, dans la définition.
- Couleurs des figures : palette **viridis** (lisible par les daltoniens), définie une seule fois dans `_theme.qmd` ; ne jamais écrire une couleur en dur. `col_demande` (bleu) : demande, surplus des consommateurs ; `col_cout` (violet) : coût marginal, offre, entreprise 1 ou pilote ; `col_recette` (vert) : recette marginale (recette totale en tirets), entreprise 2 ou satellite ; `col_producteur` (jaune, aires seulement) : surplus du producteur, profit ; `col_perte` (gris) : perte sèche, pertes, éléments secondaires. Une seconde courbe du même type est en pointillés ou en tirets, pas d'une autre couleur. Étiquettes des aires en noir. Toute mention d'une couleur dans une légende, le texte ou un `fig-alt` doit correspondre à ces couleurs.

## État d'avancement (au 13 octobre 2026)

**Fait :**
- 10 corrections d'erreurs de fond : prix maximal, économies d'échelle, figures de changement de demande (avec renvoi à `@sec-choix-monopole`), valeurs de la discrimination du 2ᵉ degré ($P_1=6-q$, $P_2=8-q$, $c=2$), recette notée $\pi$, annexe A, HHI, courbe d'offre CPP avec seuils de fermeture et de rentabilité, libre entrée, définition de la demande.
- 10 problèmes techniques : identifiants en double, figure de la demande perçue, $x_0$, légendes et étiquettes de figures, `ymax <-`, intégrales, préfixe des sections.

Le 13 octobre : vocabulaire harmonisé avec le TD et notations clarifiées (voir Conventions).

**Reste à faire, dans l'ordre convenu :**

1. ~~Harmoniser le vocabulaire avec le TD~~ (fait).
2. **Réorganiser les chapitres.** Chapitre 2 fait le 13 octobre : 2.1.1 renommée « Le monopole choisit son prix ou sa quantité » ; « Le monopole n'a pas de courbe d'offre » (ex-« Variation de la demande ») en 2.2.2, juste après la maximisation ; régulation sur trois niveaux (subvention unitaire, taxe forfaitaire, impôt sur les bénéfices en sous-sections 2.4.3 à 2.4.5) ; discrimination dans l'ordre 1ᵉʳ → 3ᵉ → 2ᵉ degré. Attention : les blocs R de ce chapitre redéfinissent `P`, `Rm`, `Cm`, `qm`, et l'ordre d'exécution compte lors d'un déplacement. Chapitre 1 restructuré le 13 octobre pour suivre l'ordre du cours : hypothèses → consommateur (demande, demande agrégée, surplus des consommateurs **à un prix $p$ quelconque**) → producteur (coûts, offre, profit, seuils, puis sous-section « Surplus des producteurs » : surplus d'un producteur à un prix $p$, offre agrégée = somme des courbes de coût marginal, surplus des producteurs) → équilibre (les surplus à l'équilibre sont une application des définitions avec $p=p^*$). Raison : raisonner ensuite sur des prix imposés ou maximaux. Ne jamais écrire l'offre agrégée *égale à* un coût marginal $C_m(q)$ (vrai seulement avec un seul producteur) : c'est la *somme* des coûts marginaux. Le 13 octobre : la remarque sur les seuils suit la figure du profit ; « Perception par les agents isolés » a été déplacée en ouverture de 2.1.1 (elle sert de charnière CPP → monopole : en CPP, le producteur ne peut ni fixer son prix ni l'influencer par sa quantité ; le monopole fixe l'un et observe l'autre). Chapitre 3 fait le 13 octobre : le cartel reste dans le chapitre (choix de l'auteur, pour pouvoir le réintégrer au programme), signalé par un encadré « Hors programme », par l'introduction du chapitre et par le titre de sa méthode dans l'annexe B.
3. **Ajouts pour l'asynchrone.** Format validé le 13 octobre : encadrés « Objectifs du chapitre » (`callout-note`, avec les prérequis), « Testez-vous » (`callout-tip`, réponse dans `<details>`), « Pour vous entraîner » (`callout-note`, numéros du TD), « À retenir » (`callout-important`) et « Erreurs fréquentes » (`callout-warning`) en fin de chapitre. Contenus : coller aux exercices réellement demandés (on ne demande jamais d'agréger des demandes ni de vérifier le seuil de fermeture ; l'erreur typique est de croire que l'offre ou le coût marginal part de zéro dans le calcul d'un surplus) ; ne pas présenter l'offre agrégée comme un coût marginal (notion non expliquée aux étudiants) ; ne pas reprendre les valeurs des exercices du TD. Chapitre 1 fait le 13 octobre (8 encadrés : objectifs, 3 « Testez-vous », 2 « Pour vous entraîner » — ex. 1.1 après le consommateur, ex. 1.2 questions 1 à 4 en fin de chapitre —, « À retenir », « Erreurs fréquentes ») : il sert de modèle pour les chapitres 2 et 3. Ajouté le 13 octobre : encadrés **« Méthode : tracer le graphique »** (`callout-caution`, construction pas à pas après chaque figure clé : équilibre et surplus au ch. 1 ; optimum, perte sèche, régulation au ch. 2 ; fonctions de réaction au ch. 3) et **« Testez-vous » graphiques** (figure sans étiquettes, en noir, avec quadrillage et graduations ; identifier courbes, points et aires ; la réponse commence par la même figure avec ses légendes, ses pointillés de lecture et ses aires colorées), car les étudiants savent mal tracer et lire les graphiques. Les « *Question :* » du chapitre 2 restent telles quelles (questions de cours auxquelles le texte répond). Chapitre 2 fait le 13 octobre (16 encadrés : objectifs ; 7 « Testez-vous » dont un graphique ; 2 « Méthode » — optimum et surplus du monopole, prix maximal, qui commente aussi ses trois figures — ; 4 « Pour vous entraîner » — 2.1 à 2.4, 2.5 à 2.8, 2.10 à 2.12, 2.9 — ; « À retenir » ; « Erreurs fréquentes »). Dans « À retenir », la recette marginale est présentée comme la dérivée de $R(q)=P(q)\times q$, pas par la formule avec l'élasticité (choix de l'auteur). Chapitre 1 complété le 13 octobre : « Méthode : tracer l'équilibre et les surplus » et « Testez-vous : lire un graphique » ($P=10-q$, $S=2+q$) après la figure des surplus à l'équilibre. Chapitre 3, corrections faites le 13 octobre : coûts « propres » à chaque entreprise ; accents des figures ; intuition « la fonction de réaction passe par le sommet des isoprofits » ; commentaire de la figure des isoprofits à l'équilibre ; HHI = inverse du nombre d'entreprises identiques donnant le même Lerner ; Stackelberg en $q_L$/$q_F$ partout (y compris $q_{LC}$, $q_{FC}$, $q_{Fm}$ sur la figure, dont la légende identifie les courbes) ; avantage du pilote = jouer en premier ; tableau de synthèse `@tbl-comparaison` (monopole, Cournot, Stackelberg, CPP). Structure tranchée le 13 octobre : les isoprofits restent après l'exemple de Cournot (l'auteur ne les traite pas toujours, notion difficile) ; elles sont introduites par l'analogie avec les courbes d'indifférence et un exemple construit à la main ($P=12-q$, coût nul, isoprofits 9, 16, 25, figure `fig-isoprofit-exemple`) ; la stabilité est expliquée par l'ajustement tour à tour (stable si chaque entreprise réagit peu, pente de $f_i$ inférieure à 1 en valeur absolue) ; l'oligopole à $N$ entreprises et le HHI sont au programme (seul exercice : 3.3). Encadrés du chapitre 3 faits le 13 octobre (10 : objectifs ; « Méthode : tracer les fonctions de réaction » ; « Testez-vous » graphique Cournot, HHI, Stackelberg — Cournot et Stackelberg avec les mêmes données $P=30-q$, $c=6$ — ; « Pour vous entraîner » 3.2-3.3 puis 3.4-3.7 et 3.1 ; « À retenir » et « Erreurs fréquentes » **avant** la section hors programme sur les cartels). Les trois chapitres ont maintenant leurs encadrés. Erreurs fréquentes du ch. 2 : prix lu sur la recette marginale ; $R_m=p$ ; surplus du producteur en monopole = trapèze, pas triangle ; taxe unitaire / forfaitaire ; $C_m(q_A)$ au lieu de $C_m(q_A+q_B)$ ; $s$ / $S_{\text{tot}}$. À faire aussi :
   - objectifs et prérequis en début de chapitre, encadré « À retenir » et « Erreurs fréquentes » en fin de chapitre ;
   - transformer les « *Question :* » en auto-évaluation, avec la réponse dans un callout repliable ;
   - renvois vers les exercices du TD par numéro ;
   - commenter dans le texte les figures non citées (les trois figures du prix maximal) ;
   - ~~annexe de rappels mathématiques, tableau des notations~~ (faits le 13 octobre : annexes D et E ; la page « Comment utiliser ces notes » est dans `index.qmd`). $t$ désigne une taxe unitaire **ou** le taux de l'impôt sur les bénéfices selon le contexte : ne jamais employer les deux dans le même passage ; annexe A corrigée et annexe B refondue en fiche méthode à étapes numérotées le 13 octobre (équilibre de CPP écrit $P(q^*)=S(q^*)$, jamais $P=C_m$) ; annexe C : surplus des producteurs défini avec l'offre agrégée $S$ ($C_m$ pour un seul producteur ou un monopole), figures avec « Offre ($S$) » ;
   - ~~`fig-alt` sur toutes les figures~~ (fait le 13 octobre : les 46 figures ont un texte alternatif ; toute nouvelle figure doit en avoir un, en mots simples, sans LaTeX ; pour un « Testez-vous » graphique, l'alt de la question décrit les droites sans les nommer)  ; palette viridis appliquée le 13 octobre à toutes les figures ; passe sur les étiquettes faite le 13 octobre (plus de chevauchement ni d'étiquette coupée ; étiquettes courtes `R[m]`, `P[1]`, `P[2]`, `S[c]`, `S[p]` ou flèches là où la place manque, légendes adaptées) ;
   - ~~corriger `index.qmd`~~ (fait le 13 octobre : présentation sans « dépôt » ni corrigés, section « Comment utiliser ces notes » avec la démarche, les types d'encadrés et les moyens de poser ses questions — séances de questions-réponses en visio, forum Moodle, message à l'enseignant, Discord de la licence —, plan mis à jour).
4. **Contenu demandé par le TD mais absent du cours.** Tranché le 13 octobre : la taxe unitaire en CPP (exercice 1.2, question 5) n'est pas traitée et ne sera pas demandée ; le prix imposé est couvert par les surplus à un prix quelconque (chapitre 1) ; l'élasticité à partir de l'indice de Lerner est couverte par un « Testez-vous » du chapitre 2. Cournot avec des coûts marginaux différents et Stackelberg avec des coûts différents ou des coûts fixes (choix du rôle de meneur) ne sont **pas** ajoutés au cours : l'auteur préfère que le corrigé du TD (`../ExercicesMicro2`) soit détaillé sur ces points. Chantier clos.

Correspondance indicative avec la brochure 2026-2027, à vérifier sur la version compilée :
- **Fiche 1 (CPP) :** 1.1 demande et surplus ; 1.2 offre, équilibre, prix imposé, taxe unitaire.
- **Fiche 2 (monopole) :** 2.1 questions de cours ; 2.2 lecture graphique ; 2.3 et 2.4 monopole simple ; 2.5 subvention et taxe forfaitaire ; 2.6 prix plafond ; 2.7 monopole naturel ; 2.8 tarification au coût marginal ; 2.9 discrimination du 2ᵉ degré (*Le Mondial*) ; 2.10 à 2.12 discrimination du 3ᵉ degré.
- **Fiche 3 (oligopole) :** 3.1 questions de cours ; 3.2 et 3.3 Cournot ; 3.4 et 3.5 Stackelberg ; 3.6 Cournot et Stackelberg ; 3.7 révision.
