function bin2dec(str)
  x = 0
  for c in str
    x *= 2
    x += Int(c)-Int('0')
  end
  return x
end

function stringbit2num(str)
  bias = 2^10 -1
  m = 1 + bin2dec(str[13:end]) / 2^52
  ex = bin2dec(str[2:12]) - bias
  s = bin2dec(str[1])
  if s==1
    s=-1
  else
    s=1
  end
  val = s * m * 2^ex
  return val
end

println(bitstring(4.0))
println(stringbit2num(bitstring(4.0)))
