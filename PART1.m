%% format console
format_console();
%clear all

%% time domian
T = input('Enter the duration: '); % total time
ts = 0.001; % step period
t = 0:ts:T; % time vector 
t_length = length(t); % length of time vector

%% Prompt the user
si = input('Enter the row vector, enclosed in square brackets, e.g., [S1; S2; S3]: ');
[row_si, col_si] = size(si); % row_si ====== number of symbols & col_si ====== t_length
M = row_si; % number of symbols

%% define matrix to save g & phi(basis function) & coefficients sij & energies of g
%%%%%%%%% g
gi = zeros(M,t_length);

%%%%%%%%% phi_j
phi_j = zeros(M,t_length); % worest case N = M = row_si = row_phi_j & col_si ====== t_length

%%%%%%%%% sij
sij = zeros(M,M); % worest case N = M = row_si = row_phi_j & col_si ====== t_length
%%%%%%%%% Egi
Egi = zeros(M,1); % worest case N = M = row_si = row_phi_j & col_si ====== t_length

%% get the basis functions
N = M;
for i = 1:M
    gi(i,:) = si(i,:);
    for j = 1:i
        if j < i
            sij(i,j) = round(trapz(t, si(i,:).*phi_j(j,:)));
            if abs(sij(i,j)) <= 0.009
                sij(i,j) = 0;
            end
            gi(i,:) = gi(i,:) - sij(i,j).*phi_j(j,:);
        end
    end
    if (max(abs(gi(i,:)), [], 1)) <= 1e-3
       gi(i,:) = gi(i,:) * 0;
       Egi(i,1) = 0;
       sij(i,i) = 0;
       phi_j(i,:) = 0;
    else       
       Egi(i,1) = round(trapz(t, gi(i,:).^ 2));
       sij(i,i) = round(sqrt(Egi(i,1)));
       phi_j(i,:) = round(gi(i,:) / sij(i,i));
    end
    
    
end

%% Plot the M input signals, and the N basis functions & gi
plotting(M, si, 'S', t);
plotting(M, phi_j, 'PHI', t);
plotting(M, gi, 'gi', t);

%% constellation diagram

% how many basis functions 
for i = 1:M
       if sij(i,i) ~=0
           N=i;
       end
end
figure 
if N == 1
   for i = 1:M
           hold on
           scatter(sij(i,1), 0, 'o', 'filled');
           xlabel('PHI_1');
           title('Phi 1 constellation diagram');
           grid on;
       
   end
elseif N == 2
    for i = 1:M
           hold on
           scatter(sij(i,1), sij(i,2), 'o', 'filled');
           xlabel('PHI_1');
           ylabel('PHI_2');
           title('Phi 1&2 constellation diagram');
           grid on;
    end
else
    for i = 1:M
           hold on
           scatter3(sij(i,1), sij(i,2), sij(i,3), 40, 'filled');
           view(-45,10)
           xlabel('PHI_1');
           ylabel('PHI_2');
           zlabel('PHI_3');
           title('Phi 1&2&3 constellation diagram');
           grid on;
    end
end

hold off

%% Calculate the energy of each symbols using the constellation diagram
Esi_by_norm_squared = zeros(M,1);
for i = 1:M
    Esi_by_norm_squared(i,1) = sum((sij(i,:).^2),'all');     
end
sij
Esi_by_norm_squared






