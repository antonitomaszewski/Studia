let rec sumprod = function
  | hd::tl -> let (s,p) = sumprod tl
              in (hd+s, hd*p)
  | [] -> (0,1);;
let rec _sumprod acc = function
  | [] -> acc
  | hd::tl -> let (s,p) = acc
              in _sumprod (hd+s,hd*p) tl;;
