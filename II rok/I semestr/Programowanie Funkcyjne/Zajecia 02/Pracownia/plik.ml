let rec merge (xs : 'a list) (ys : 'a list) (rel : 'a -> 'a -> bool) =
  match (xs, ys) with
    | ([], []) -> []
    | ([],_) -> ys
    | (_,[]) -> xs
    | (hx::tx, hy::ty) ->
      if (rel hx hy)
        then hx :: (merge tx ys rel)
        else hy :: (merge xs ty rel);;

merge [3;4] [1;2] (<=);;



let rec merge (xs : 'a list) (ys : 'a list) (rel : 'a -> 'a -> bool) (result : 'a list) =
  match (xs, ys) with
    | ([], []) -> result
    | ([],_) -> (append ys result)
    | (_,[]) -> (append xs result)
    | (hx::tx, hy::ty) ->
      if (rel hx hy)
        then merge tx ys rel (hx::result)
        else merge xs ty rel (hy::result);;



        let rec merge (xs : 'a list) (ys : 'a list) (rel : 'a -> 'a -> bool) =
          match (xs, ys) with
            | ([], []) -> []
            | ([],_) -> ys
            | (_,[]) -> xs
            | (hx::tx, hy::ty) ->
              if (rel hx hy)
                then hx :: (merge tx ys rel)
                else hy :: (merge xs ty rel);;
