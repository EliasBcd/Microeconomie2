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
| `05-cppmono.qmd`, `06-equilibres.qmd`, `07-surplus.qmd` | Annexes A, B, C : tableau CPP/monopole, méthodes de résolution, calcul des surplus |
| `_theme.qmd` | Charge ggplot2 et le thème `theme_perso`, inclus en tête de chaque chapitre |

## Compilation

L'environnement R local est fragile :
- `renv/activate.R` (ignoré par git) contient un espace réservé `..md5..` non remplacé, qui fait échouer la compilation quand renv est actif ;
- la bibliothèque renv de R 4.6 est vide, et R 4.4.1 est une installation incomplète (pas de `Rscript`).

Pour vérifier un chapitre sans toucher à renv, on désactive renv et on fournit à R un profil vide. La bibliothèque personnelle de R 4.6.1 contient ggplot2, knitr et rmarkdown.

```bash
export RENV_ACTIVATE_PROJECT=FALSE R_PROFILE_USER=/chemin/vers/un/fichier/vide.Rprofile
quarto render 02-monopole.qmd --to html   # sortie dans _book/
```

Ne jamais lancer `quarto render` avec renv actif sans l'avoir décidé : renv peut réécrire `renv.lock` et `activate.R`.
Pour tester une figure seule : extraire le code du bloc dans un script R, avec `library(ggplot2)` et le thème de `_theme.qmd`, puis l'exécuter **hors du dossier du projet** avec `ggsave`.

**Piège d'édition :** ne pas écrire de LaTeX via des chaînes Python ou sed non brutes. `\t`, `\r` et `\f` deviennent des caractères de contrôle (`\text` → tabulation, `\right` → retour chariot). Utiliser l'outil Edit, puis vérifier avec `git diff | grep -P '^\+.*[\x00-\x08\x0b-\x1f]'`.

## Conventions

- Environnements Quarto : `def-`, `prp-`, `thm-`, `cor-`, `exm-`, `cnj-` (hypothèses), `.remark`, `.proof`. Figures `fig-`, équations `eq-`, sections `sec-`.
- Les préfixes de renvoi sont en minuscules (`_quarto.yml` : `crossref` et `language: crossref-sec-prefix: section`).
- Les identifiants doivent être uniques dans tout le livre (ceux de l'annexe C portent le suffixe `-annexe`).
- Notations : $C_m$ coût marginal, $C_M$ coût moyen, $CV_M$ coût variable moyen, $R_m$ recette marginale, $P(q)$ demande inverse, $Q(p)$ demande, $\varepsilon_{q/p}$ élasticité prix, $S$ offre agrégée (aussi $S_c$, $S_p$ pour les surplus et $S_i$ pour la part de marché : ambiguïté connue).
- Couleurs habituelles des figures : demande en bleu, coût marginal en rouge, recette marginale en vert.

## État d'avancement (au 12 octobre 2026, non commité)

**Fait :**
- 10 corrections d'erreurs de fond : prix maximal, économies d'échelle, figures de changement de demande (avec renvoi à `@sec-choix-monopole`), valeurs de la discrimination du 2ᵉ degré ($P_1=6-q$, $P_2=8-q$, $c=2$), recette notée $\pi$, annexe A, HHI, courbe d'offre CPP avec seuils de fermeture et de rentabilité, libre entrée, définition de la demande.
- 10 problèmes techniques : identifiants en double, figure de la demande perçue, $x_0$, légendes et étiquettes de figures, `ymax <-`, intégrales, préfixe des sections.

**Reste à faire, dans l'ordre convenu :**

1. **Harmoniser le vocabulaire avec le TD.** Garder les termes du cours et ajouter les synonymes du TD à leur première apparition : perte sèche / charge morte, recette / revenu marginal, pilote / leader / meneuse, satellite / follower / suiveuse, fonction de réaction / meilleure réponse, équilibre de Cournot / Cournot-Nash. Autres ambiguïtés à régler : la lettre $S$ (4 usages), $c$ (coût quadratique en Cournot, coût marginal constant en discrimination), « Demande agrégée (P) », mélange de $q_i^a$ et $q_i^*$ en Cournot.
2. **Réorganiser les chapitres** (à discuter, en commençant par le chapitre 2). Pistes : déplacer la sous-section « Variation de la demande » ; placer la remarque sur les seuils après `@eq-profitCM` dans le chapitre 1 ; déplacer « Perception par les agents isolés » après la notion de *price-taker* ; ordre de la discrimination 1ᵉʳ → 3ᵉ → 2ᵉ degré ; cartel en annexe « Pour aller plus loin » ; titres de niveau 5 dans la partie régulation.
3. **Ajouts pour l'asynchrone :**
   - objectifs et prérequis en début de chapitre, encadré « À retenir » et « Erreurs fréquentes » en fin de chapitre ;
   - transformer les « *Question :* » en auto-évaluation, avec la réponse dans un callout repliable ;
   - renvois vers les exercices du TD par numéro ;
   - commenter dans le texte les figures non citées (les trois figures du prix maximal) ;
   - page « Comment utiliser ces notes », annexe de rappels mathématiques, tableau des notations, fiche méthode étape par étape (refonte de `06-equilibres.qmd`) ;
   - `fig-alt` sur toutes les figures, palette lisible par les daltoniens ;
   - corriger `index.qmd` (il annonce des « corrigés des exercices » qui n'existent pas, et le plan est incomplet).
4. **Contenu demandé par le TD mais absent du cours :** prix imposé et taxe unitaire en CPP (fiche 1, exercice 2), Cournot avec des coûts marginaux différents, Stackelberg avec des coûts différents ou des coûts fixes et choix du rôle de meneur, calcul de l'élasticité à partir de l'indice de Lerner.

Correspondance indicative avec la brochure 2026-2027, à vérifier sur la version compilée :
- **Fiche 1 (CPP) :** 1.1 demande et surplus ; 1.2 offre, équilibre, prix imposé, taxe unitaire.
- **Fiche 2 (monopole) :** 2.1 questions de cours ; 2.2 lecture graphique ; 2.3 et 2.4 monopole simple ; 2.5 subvention et taxe forfaitaire ; 2.6 prix plafond ; 2.7 monopole naturel ; 2.8 tarification au coût marginal ; 2.9 discrimination du 2ᵉ degré (*Le Mondial*) ; 2.10 à 2.12 discrimination du 3ᵉ degré.
- **Fiche 3 (oligopole) :** 3.1 questions de cours ; 3.2 et 3.3 Cournot ; 3.4 et 3.5 Stackelberg ; 3.6 Cournot et Stackelberg ; 3.7 révision.
