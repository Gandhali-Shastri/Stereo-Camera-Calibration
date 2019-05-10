load('pts_viewL.mat');
load('pts_viewR.mat'); 
load('pts_world.mat'); 
load('left.mat');
load('right.mat');

main(P,pl,pr);

function main(P,pl,pr)

%calc extrisic and intrinsic param
[Kl,Tl,Kr,Tr] =compute_stereo_calib(P,pl,pr);
 
disp('Kl');
disp(Kl);
disp('Kr');
disp(Kr);
disp('Tl');
disp(Tl);
disp('Tr');
disp(Tr);

[P_hat] = get_world_points(pl,pr);
disp('P_hat');
disp(P_hat);

P_hat(:,4) = []; 
R = Tl;
t = Tl(4,:);
R(4,:) = [];
 
% P1 = K1 * [I3 | 0]
% P2 = K2 * [R12 | t12]

Translated_pnts = zeros(size(P_hat));
Translated_pnts(:,1) = P_hat(:,1) - t(1);
Translated_pnts(:,2) = P_hat(:,2) - t(2);
Translated_pnts(:,3) = P_hat(:,3) - t(3);
Rotated_pnts = Translated_pnts * (R');

Transformed_points = Rotated_pnts;
% disp(Transformed_points);
euclideanDistances = pl -(sum((Transformed_points) .^2));

mean_error = mean(euclideanDistances);
max_error = max(euclideanDistances);
min_error = min(euclideanDistances);
std_error = std(euclideanDistances);

disp('mean_error');
disp(mean_error);
disp('max_error');
disp(max_error);
disp('min_error');
disp(min_error);
disp('std_error');
disp(std_error);

end