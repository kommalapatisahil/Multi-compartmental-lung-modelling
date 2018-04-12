%adaptive model
%m- model 
%p - practical /actual

clc;
clear all;

T = 200; %time of run

Rin  = 10;
Rout = 25;
c0 = 2;
teta = 0.005.*[75,75,75,75];
%teta = [1,1,1,1].*0.01
Q0 = 0.05;

C = 2*eye(4,4);

Api = (-1).*C./Rin;
Bpi = (1/Rin).*ones(4,1);

Apo = (-1).*C./Rout;
Bpo = (1/Rout).*ones(4,1);

Bmi = Bpi*Q0;
Ami = Api + Bpi*teta  ;

Bmo = Bpo*Q0;
Amo = Apo + Bpo*teta  ;


r = @(t)sin(10*t*2*pi/180) + 8;
rr = r(1:T);
x = zeros(4,T);


i = 1;
x(:,1) = rand(4,1);
%x(:,1) = ones(4,1)*0.5
x(:,1);
j =1 ;
k= 1;

while i <= T
    if j == 20
        k = 0;
        %disp('shifted to exhale')
    end
    
    if j == 60
        k = 1;
        j = 0;
        %disp('shifted to inhale')
    end
    
    if k ==1
    x(:,i+1) = x(:,i) + Ami*x(:,i) + Bmi*rr(1,i); 
    end
    
    if k == 0
    x(:,i+1) = x(:,i) + Amo*x(:,i) + Bmo*rr(1,i); 
    end
    
    i = i+ 1;
    j = j+1;
end

figure(1)
subplot(2,1,1);
hold on;
for no = 1:4

    plot(1:T+1,x(no,:));

end

title('Modelled volume vs time');
xlabel('Time');
ylabel('X(t)');
legend('cell1','cell2','cell3','cell4')
hold off;

subplot(2,1,2);
plot(x(1,:),x(2,:));
title('x1(t) vs x2(t)');
xlabel('x1(t)');
ylabel('x2(t)');

