function rd(s)
j=1
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