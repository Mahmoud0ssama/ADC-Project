function [x, X] = pnrz(random_bits, T, num_of_bits, ts)
%n = 50; % number of columns for each bit => bit1 : col1->col200, bit2 : col201->col400, .........
N = T/ts; % total number of columns of all bits
n = floor(N / num_of_bits);
dt = ts; % time between each 2 columns = sampling interval = (T/length(random_bits)) / n = (T) / (n*length(random_bits)) = T /N
t = 0:dt:T; % length(t) = length(N) + 1
x = zeros(1,length(t)); % output signal
X = zeros(length(random_bits), length(t));
duration_of_bit = T / length(random_bits)
j = duration_of_bit;
k = 1;

for i = 1:length(random_bits)
  if random_bits(i) == 1
    x((i-1)*n+1:(i)*n + 1) = 1;
  else
    x((i-1)*n+1:(i)*n + 1) = -1;
  end
  
  %x(1,(i)*n+1) = x(1,(i)*n);
  t(i*n +1);
  j;
  %disp(x((i-1)*n+1:(i)*n+1));
  %if (t(i*n +1) == j) 
    %disp(x((i-1)*n+1:(i)*n+1));
    X(k, 1:(n+1)) = x((i-1)*n+1:(i)*n+1);
    %X(k, (n+1):end) = X(k,(n+1));
    j = j + duration_of_bit;
    k = k + 1;
  %end
end

%{
 time shift
if (t(i*n +1) == j) 
    %disp(x((i-1)*n+1:(i)*n+1));
    X(k,(i-1)*n + 1:i*n+1) = x((i-1)*n+1:(i)*n+1);
    if j ~= T
        X(k,i*n+1) = 0;
    end
    j = j + duration_of_bit;
    k = k + 1;
  end
%}
