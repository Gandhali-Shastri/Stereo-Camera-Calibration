function [A] = get_normalization_matrix(pts)
%Normalized data

centroid = mean(pts,2);
dist = sqrt(sum((pts - repmat(centroid,1,size(pts,2))).^2,1));
mean_dist = mean(dist);

A = [sqrt(2)/mean_dist, 0,                  -sqrt(2)/mean_dist*centroid(1);...
     0,                 sqrt(2)/mean_dist,  -sqrt(2)/mean_dist*centroid(2);...
     0,                 0,                  1];

end