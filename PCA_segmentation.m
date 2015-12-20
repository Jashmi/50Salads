clear
%close all
video = VideoReader('/home/jashmi/Downloads/Downloads/Salad_dataset/rgb/rgb-02-1.avi');

Smin = 2000;
Smax = 5000;
k = 4;
Ch = 0.5;
Cl = 0.15;

frame = read(video,[Smin,Smax]);

for i = 1 : Smax-Smin-1
    image = frame(:,:,:,i);
    image2 = frame(:,:,:,i+1);
    image = rgb2gray(image);
    image2 = rgb2gray(image2);
    diff = image2 - image;
    %img = imresize(double(image),0.1);
    img = imresize(double(diff),0.1);
    I = img(:);
    C(:,i) = I;
end
mu = mean(C,2);
Var = var(C,0,1);
Std = std2(C);
for i = 1:Smax-Smin-1
    CC(:,i) = (C(:,i)-mu)/(Std);
end
A = CC'*CC;
% [V,D] = eig(A);
% Vbar = V(:,1:k);
% Dbar = diag(D);
% Dbar = Dbar(1:k);
% Dbar = 1./sqrt(Dbar);
% Dbar = diag(Dbar);
% Ubar = CC*Vbar*Dbar;
% M = Ubar'*CC;
[U,D,V] = svd(A);
Ub = U(:,1:k);
Db = diag(D);
Db = Db(1:k);
Db = 1./sqrt(Db);
Db = diag(Db);
Ubb = CC*Ub*Db;
M = Ubb'*CC;
f = zeros(1,Smax-Smin-1);
for i = 1: Smax-Smin-2
    for j = 1:k
        temp = abs(M(j,i+1)-M(j,i));
        f(i) = f(i) + temp;
    end
end
Th = Ch*max(f)
Tl = Cl*max(f)
figure(1);plot(f);
