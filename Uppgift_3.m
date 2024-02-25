%Uppgift 3
clear
%Begynnelsedata
a = 0.5;
%Startvärden för ode45
q0 = [1-a 0]; 
p0 = [0 sqrt((1+a)/(1-a))];
%Startvärden för euler
q = [1-a 0];
p = [0 sqrt((1+a)/(1-a))];

%Konstanter
t_tot = 500;
h = 0.05;
n_tot = t_tot/h;
k = 20;
euler_typ = "symplektisk"; %"symplektisk", "framåt", "bakåt", "mittpunkt"

%Skapar tidsspannet
tspan = (0:n_tot)*h;

%Löser med ode45
options = odeset('RelTol',1e-8,'AbsTol',1e-9);
ode = @(t,pq) odefun(t,pq);
[t,pq] = ode45(ode, tspan, [p0 q0], options);

if euler_typ == "symplektisk"
    %Approximerar med symplektisk euler
    for n = 1:n_tot
        p(n+1,:) = p(n,:) - h*gradient_q(q(n,:));
        q(n+1,:) = q(n,:) + h*gradient_p(p(n+1,:));
    end
elseif euler_typ == "mittpunkt"
    %Approximerar med mittpunkt euler
    for n = 1:n_tot
        [pnplus1,qnplus1] = fixpunkt(p(n,:), q(n,:), k, h);
        p(n+1,:) = p(n,:) - h*gradient_q((q(n,:)+qnplus1)/2);
        q(n+1,:) = q(n,:) + h*gradient_p((p(n,:)+pnplus1)/2);
    end
end

%Plottar vägen i ett diagram
hold on
plot(pq(:,3),pq(:,4))
axis([-2,2,-2,2])
% plot(pq(:,1),pq(:,2))

%Visar H som funktion av tiden för ode45
tspan = (0:n_tot)*h;
H = zeros(length(p),1);
for i = 1:height(p)
    H(i,1) = ((pq(i,1)^2 + pq(i,2)^2)/2) - 1/sqrt(pq(i,3)^2 + pq(i,4)^2);
end
figure
plot(tspan,H)