%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear all; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_of_bits = 100e3;
random_bits = rand(1, num_of_bits) > 0.5;

% encode them using polar NRZ
T = 10;
ts = 0.001; % step period
t = 0:ts:T; % time vector 

Tb = T / num_of_bits;

[x, X] = pnrz(random_bits, T, num_of_bits, ts);
[r c] = size(X)

figure(1)
% Plot the binary signal
plot(t, x, 'Marker', 'none');
xlabel('Time (s)');
ylabel('Signal Value');
ylim([-6 6])
title('Polar NRZ Binary Signal');
grid on;


%[sij_signal, Esi_signal] = part_1(X(:, 1:find(t==Tb)), ts, Tb, 1, 0);
%[sij, Esi_by_norm_squared] = part_1(X(:, 1:find(t==Tb)), ts, Tb, 1, 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


number_of_bits = 10e3;
random_bits = rand(1, number_of_bits) > 0.5; % rand generate values between 1 and 0 with flat distribution thats why we made > 0.5 to be equal probable of appearance of 1 and 0 
random_PNRZ_bits = 2*random_bits - 1;
signal_inphase_stream = random_PNRZ_bits;
signal_quadrature_stream = zeros(1, number_of_bits);
signal_complex = complex(signal_inphase_stream, signal_quadrature_stream);

figure

scatter(signal_inphase_stream, signal_quadrature_stream, 'filled');
xlabel('Inphase')
ylabel('Quadrature')
title('BEFORE ADDING NOISE')
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Eb_div_by_No_dB = -10:2:6;
SNR = 3 + Eb_div_by_No_dB;

Eb_div_by_No_in_linear = 10.^(Eb_div_by_No_dB/10);
SNR_in_linear = 10.^(SNR/10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

j = 2;

for SNR = SNR % db
    
    signal_after_noise = awgn(signal_complex,SNR,'measured');  
   
    %figure(3);
    figure
    scatter(real(signal_after_noise), imag(signal_after_noise), 'r', 'filled')
    xlim([-3 3])
    ylim([-3 3])
    xlabel('Inphase')
    ylabel('Quadrature')
    title([' SNR = ',  num2str(SNR)])
    grid on
    j = j + 1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

j = 1;
BER = [];
for SNR = -7:2:9 % db
    
    signal_after_noise = awgn(real(signal_complex),SNR,'measured');  
    
    A = real(signal_after_noise);
    A(A >= 0) = 1;
    A(A < 0) = -1;
    
    number_of_error_bits = sum(A ~= random_PNRZ_bits);
    
    BER(1,j) = number_of_error_bits/(number_of_bits);
    j = j + 1;
end



figure
hold on
semilogy(Eb_div_by_No_dB,BER,'b+-','linewidth',01);

theo=qfunc(sqrt(SNR_in_linear));
semilogy(Eb_div_by_No_dB,theo,'r+-','linewidth',01);

title('BER OF Signal vs Eg/No for signal ');
xlabel("Eb/No in dB");
ylabel("BER OF Signal");
set(gca,'YScale','log')
grid on;
legend('PRACTRICAL', 'THEORITICAL');



% generate and add noise
% signal has I and Q components so does the noise so it is a vector
% randn generate stream of zero mean and unit variance
% So if i have unit vector so its inphase is 1/sqrt(2) and quadrature is
% also 1/sqrt(2), so we will scale by 1/sqrt(2)
% after that it is unity of power so scale it with the power you need by
% multiplying by variance


%{
for variance = (1/50):(1/10):(0.5)
    noise = (1/sqrt(2))*(randn(1, number_of_bits)+1i*randn(1, number_of_bits))*variance;


    signal_after_noise = signal_complex + noise; 

    figure(2);
    scatter(real(signal_after_noise), imag(signal_after_noise), 'r')
    xlim([-3 3])
    ylim([-1.5 1.5])
    
    %drawnow expose;
    

end
%}





%{
energy_of_bits_in_signal = abs(signal_complex).^2; % energy of each bit
signal_power = mean(energy_of_bits_in_signal); % avarage across all elements
%}

%y = awgn(x,10,'measured');
%}


%{
    SNR_in_linear = 10^(SNR/10);
    variance = signal_power / SNR_in_linear; % noise power is variance
    
    noise = (1/sqrt(2))*variance* (randn(1, number_of_bits)+1i*randn(1, number_of_bits));
    signal_after_noise = signal_complex + noise;
    %}
    

