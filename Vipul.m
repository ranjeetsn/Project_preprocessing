clc
clear all
close all
rng(1)

%% Estimated model and error-variances obtained using DIPCA in state-space form
[A,B,C,D]=tf2ss([-0.0186 1.1490 1.6676 0.0927 -0.0639 -0.0378],[1 0.1965 0.0294 -0.0304 0.0188 0.5744]) %correct order=5
D=0;
sigma=[0.4351 0.1214] %correct order=5


%% Simulating the same data used to obtain the above model from DIPCA - can also do this by loading .mat file into the workspace
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


%% EIV-KF implementation
z=y-D*u;
x0=ones(size(C,2),1);
P0=eye(size(x0,1));
eps=[];
X=[];

Q=B*sigma(2)*B';
R=sigma(1)+(D*sigma(2)*D');
S=B*sigma(2)*D';

xt=x0;
Pt=P0;

for t=1:size(y,1)
    eps(t)=z(t)-C*xt;
    Sigeps=C*Pt*C'+R;
    Kt=[A*Pt*C'+S]*inv(Sigeps);
    
    xtemp=A*xt+B*u(t)+Kt*eps(t);
    xt=xtemp;
    X=[X xtemp];
    
    Ptemp=A*Pt*A'+Q-[A*Pt*C'+S]*inv(Sigeps)*[A*Pt*C'+S]';
    Pt=Ptemp;
end

ybar=sigma(1)*inv(Sigeps)*eps;
ystr=y-ybar';

ubar=-sigma(2)*D'*inv(Sigeps)*eps;
ustr=u-ubar';

% Autocorrelation plot of the innovation sequence

figure 
autocorr(eps)