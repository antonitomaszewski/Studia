let rec pack_duplicates = function
  | [] -> [[]]
  | hd::tl -> let check::packed = pack_duplicates tl
              in match check with
                | [] -> [hd] :: packed
                | x::tl when x=hd -> (hd::check)::packed
                | _ -> [hd]::check::packed;;
pack_duplicates [1;2;2;3;2];;
pack_duplicates [1; 2; 2; 5; 6; 6; 6; 2; 2];;
