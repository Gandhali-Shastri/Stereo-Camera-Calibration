function [P1,P2] = get_camera_matrix(pl,pr,E,K1,K2)


[U,S,V] = svd(E);

W = [0,-1,0;1,0,0;0,0,1];        

P4 = zeros(3,4,4);
R1 = U*W*V';
R2 = U*W'*V';
T1 = U(:,3);
T2 = -U(:,3);

P4(:,:,1) = [R1, T1];
P4(:,:,2) = [R1, T2];
P4(:,:,3) = [R2, T1];
P4(:,:,4) = [R2, T2];


%Get best P matrix 
X = [pl(1,:)' pr(1,:)'];
%image 1 camera matrix
P1 = [eye(3) zeros(3,1)];

%image 2 camera matrix
x = X(:,1);
xp = X(:,2);

%P2 =
P2 = K1*P1;
xhat = inv(K1)*x;

X3D = zeros(4,4);
Depth = zeros(4,2);

for i=1:4
        
% First the point is converted
xphat = inv(K2)*xp;

% We build the matrix A
A = [P1(3,:).*xhat(1,1)-P1(1,:);
     P1(3,:).*xhat(2,1)-P1(2,:);
     P4(3,:,i).*xphat(1,1)-P4(1,:,i);
     P4(3,:,i).*xphat(2,1)-P4(2,:,i)];

% Normalize A
A1n = sqrt(sum(A(1,:).*A(1,:)));
A2n = sqrt(sum(A(2,:).*A(2,:)));
A3n = sqrt(sum(A(1,:).*A(1,:)));
A4n = sqrt(sum(A(1,:).*A(1,:))); 

Anorm = [A(1,:)/A1n;
         A(2,:)/A2n;
         A(3,:)/A3n;
         A(4,:)/A4n];

% Obtain the 3D point
[Uan,San,Van] = svd(Anorm);
X3D(:,i) = Van(:,end);

% Check depth on second camera
xi = P4(:,:,i)*X3D(:,i);
w = xi(3);
T = X3D(end,i);
m3n = sqrt(sum(P4(3,1:3,i).*P4(3,1:3,i)));
Depth(i,1) = (sign(det(P4(:,1:3,i)))*w)/(T*m3n);

% Check depth on first camera
xi = P1(:,:)*X3D(:,i);
w = xi(3);
T = X3D(end,i);
m3n = sqrt(sum(P1(3,1:3).*P1(3,1:3)));
Depth(i,2) = (sign(det(P1(:,1:3)))*w)/(T*m3n);

end

% Check which solution is the right one and return
if(Depth(1,1)>0 && Depth(1,2)>0)
    P2 = P4(:,:,1);
elseif(Depth(2,1)>0 && Depth(2,2)>0)
    P2 = P4(:,:,2);    
elseif(Depth(3,1)>0 && Depth(3,2)>0)
    P2 = P4(:,:,3);
elseif(Depth(4,1)>0 && Depth(4,2)>0)
    P2 = P4(:,:,4);
end
    
% disp('P1'); disp(P1);
% disp('P2'); disp(P2);
end