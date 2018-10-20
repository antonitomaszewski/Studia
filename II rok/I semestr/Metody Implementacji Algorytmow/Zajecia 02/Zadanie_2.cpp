sortuję AB, C1/C2 -> tworzę dwie listy
lista rozmiaru[n] -> na wynik
lista2 rozmiaru[niewiem] -> wykluczone ale nie będące w wyniku, czyli AB C C1 i AB C C2

idę po kolei
* wyszukuję wśród AB C1 i sprawdzam czy istnieje o tym samym C2
  -> jeśli tak return false
  -> jeśli nie, wyszukuję wśród AB C2
      -> nie ma , wynik AB C2, oraz wszystkie AB C1 C2.2 i AB C3.1 C2 do zajętych wrzucam ABC1
      -> jest, to mam AB C1 C2 oraz AB C3 C2, na pewno któryś z nich musi być AB C2
