%computing F using corr points from the images.

function F = get_fundamental_matrix(norm_pl,norm_pr,pl,pr)

norm_pl = get_normalization_matrix(pl');
norm_pr = get_normalization_matrix(pr');

% Data Centroid
pl_n = norm_pl * pl';
pr_n = norm_pr * pr';


A =[ repmat(pr_n(1,:)',1,3) .* pl_n', repmat(pr_n(2,:)',1,3) .* pl_n', pl_n(1:3,:)'];

% Get F matrix
[U,S,V] = svd(A);
F = reshape(V(:,end),3,3)';

% make rank 2 
[U,S,V] = svd(F);
F = U*diag([S(1) S(5) 0])*(V');

% Denormalize
F = norm_pr' * F* norm_pl;

% disp('F'); disp(F);
end
