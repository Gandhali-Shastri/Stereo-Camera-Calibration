function P_hat = get_world_points(pl,pr)
load('pts_viewL.mat');
load('pts_viewR.mat'); 
load('pts_world.mat'); 
load('left.mat');
load('right.mat');

%normalize data points
norm_pl = get_normalization_matrix(pl');
norm_pr = get_normalization_matrix(pr');

%get fund matrix
F= get_fundamental_matrix(norm_pl,norm_pr,pl,pr);

%calc extrisic and intrinsic param
[Kl,Tl,Kr,Tr] =compute_stereo_calib(P,pl,pr);


%essential matrix
E = Kr' * F * Kl;
% disp('E'); disp(E);

[P1,P2] = get_camera_matrix(pl,pr,E,Kl,Kr);

[P_hat,err] = triangulate11(P1,plCopy,P2,prCopy);

end