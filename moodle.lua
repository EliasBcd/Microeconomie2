-- Adaptations du HTML pour l'import dans un livre Moodle (sans effet sur le PDF).

if not FORMAT:match("html") then
  return {}
end

-- 1. Moodle affiche les formules centrées ($$...$$) dans le fil du texte.
--    On entoure chaque formule centrée d'un bloc dont le style est écrit dans la balise,
--    pour qu'il survive au filtrage de Moodle.
function Math(el)
  if el.mathtype == "DisplayMath" then
    return pandoc.Span({el}, pandoc.Attr("", {}, {style = "display:block; text-align:center; margin:0.8em 0;"}))
  end
end

-- 2. Moodle perd l'ancre des équations numérotées, placée par Quarto sur un élément en ligne.
--    On la déplace sur un bloc qui entoure le paragraphe de l'équation, comme pour les figures.
--    Un paragraphe peut contenir plusieurs équations : un bloc est emboîté par équation.
function Para(el)
  local ids = {}
  local inlines = el.content:walk({
    Span = function(s)
      if s.identifier:match("^eq%-") then
        table.insert(ids, s.identifier)
        s.identifier = ""
        return s
      end
    end
  })
  if #ids == 0 then
    return nil
  end
  local bloc = pandoc.Para(inlines)
  for i = #ids, 1, -1 do
    bloc = pandoc.Div({bloc}, pandoc.Attr(ids[i]))
  end
  return bloc
end
