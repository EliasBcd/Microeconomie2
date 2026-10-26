# Après la compilation : retire les liens des renvois qui pointent vers un autre chapitre.
# Dans un livre Moodle, chaque chapitre a sa propre adresse et ces liens ne fonctionnent pas.
# Le texte du renvoi (par exemple « section 2.1.1 ») est conservé.

fichiers <- list.files("_book", pattern = "\\.html$", full.names = TRUE)
motif <- '<a href="[^"#]+\\.html#[^"]*" class="quarto-xref"[^>]*>(.*?)</a>'

for (f in fichiers) {
  html <- readLines(f, encoding = "UTF-8", warn = FALSE)
  avant <- sum(grepl(motif, html, perl = TRUE))
  html <- gsub(motif, "\\1", html, perl = TRUE)
  writeLines(html, f, useBytes = TRUE)
  if (avant > 0) message(basename(f), " : ", avant, " ligne(s) avec un renvoi vers un autre chapitre")
}
