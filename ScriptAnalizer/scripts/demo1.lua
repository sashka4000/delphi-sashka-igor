dofile2 ("fsdfsf.lua")

twrite = topc_string_min_max ("  Комментарий",0,100)

twrite2 = topc_string_min_max ("  Комментарий222",10,1000)

-- Просто комментарий

function rd2(s)
j=1  -- Комментарий
i=0
l=string.len(s)
n,m=0
k={""}
while n do
i=i+1
m=n
n=string.find(s,":",n+1)
if n then r=n-1 m=m+1 
     else m = m+1 r = l end 
k[i]=string.sub(s,m,r)
end
return k
end