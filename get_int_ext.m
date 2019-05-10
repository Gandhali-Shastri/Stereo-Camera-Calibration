
function [K,T] = get_int_ext(M, rho, r3, u0, v0, alpha, beta);

r3 = r3';
A = M(:,1:3);
b = M(:,4);
a1 = A(1,:)';
a2 = A(2,:)';
a3 = A(3,:)';

cosTheta = -dot(cross(a1,a3),cross(a2,a3))/(norm(cross(a1,a3),2)*norm(cross(a2,a3),2));
sinTheta = sqrt(1-cosTheta^2);
r1 = cross(a2,a3)/norm(cross(a2,a3),2);
r2 = cross(r3,r1);

K = [alpha    0     u0; % Intrinsic Matrix
     0       beta   v0;
     0        0     1];
 
t = rho * (b\inv(K)); % Translation Matrix
R = [r1' ;r2' ;r3'];    % Rotation Matrix

T = [R; t];
% 
% disp('t'); disp(t);
% disp('R'); disp(R);
% disp('TR'); disp(T);
end