N=1023;
u1=idinput(N,'prbs');
y1=zeros(N,1);

% Simulating the data using DGP
order=5;
for k=(order+1):N
       y1(k)=-0.2*y1(k-1)-0.6*y1(k-5)+1.2*u1(k-1)+1.6*u1(k-2);
end

ek1=0.280*wgn(N,1,1); %error in u
ek2=0.638*wgn(N,1,1); %error in y

u=u1+ek1; y=y1+ek2;
snr=[var(u1)/var(ek1) var(y1)/var(ek2)];