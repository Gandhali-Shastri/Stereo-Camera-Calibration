% https://stackoverflow.com/questions/10502790/in-a-calibrated-stereo-vision-rig-how-does-one-obtain-the-camera-matrices-nee
% https://www.cs.princeton.edu/~andyz/algorithms.pdf
% http://www.cse.psu.edu/~rtc12/CSE486/lecture12.pdf
% http://www.cim.mcgill.ca/~langer/558/19-cameracalibration.pdf

function [Kl,Tl,Kr,Tr] =compute_stereo_calib(P,pl,pr)

Pw = zeros(size(P, 1), 4);
Pw(:, 1:3) = P;
Pw(:, 4) = 1;


%left img
[M_l, rho_l, r3_l, u0_l, v0_l, alpha_l, beta_l] = get_parameters(Pw,pl);

%right img
[M_r, rho_r, r3_r, u0_r, v0_r, alpha_r, beta_r] = get_parameters(Pw,pr);

[Kl,Tl] = get_int_ext(M_l, rho_l, r3_l, u0_l, v0_l, alpha_l, beta_l);

[Kr,Tr] = get_int_ext(M_r, rho_r, r3_r, u0_r, v0_r, alpha_r, beta_r);
% 
% disp('Kl');
% disp(Kl);
% disp('Kr');
% disp(Kr);
% disp('Tl');
% disp(Tl);
% disp('Tr');
% disp(Tr);

end