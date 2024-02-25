%Uppgift 1d
clear

%Konstanter
t_tot = 100;
h = 0.0005;
n_tot = t_tot/h;
k = 20;
euler_typ = "framåt"; %"symplektisk", "framåt", "bakåt", "mittpunkt" 

%Begynnelsedata
a = 0.5;
p = zeros(n_tot+1,2);
q = zeros(n_tot+1,2);
q(1,:) = [1-a 0];
p(1,:) = [0 sqrt((1+a)/(1-a))];

if euler_typ == "symplektisk"
    %Approximerar med symplektisk euler
    for n = 1:n_tot
        p(n+1,:) = p(n,:) - h*gradient_q(q(n,:));
        q(n+1,:) = q(n,:) + h*gradient_p(p(n+1,:));
    end
elseif euler_typ == "framåt"
    %Approximerar med framåt euler
    for n = 1:n_tot
        p(n+1,:) = p(n,:) - h*gradient_q(q(n,:));
        q(n+1,:) = q(n,:) + h*gradient_p(p(n,:));
    end
elseif euler_typ == "bakåt"
    %Approximerar med bakåt euler
    for n = 1:n_tot
        [pnplus1,qnplus1] = fixpunkt(p(n,:), q(n,:), k, h);
        p(n+1,:) = p(n,:) - h*gradient_q(qnplus1);
        q(n+1,:) = q(n,:) + h*gradient_p(pnplus1);
    end
elseif euler_typ == "mittpunkt"
    %Approximerar med mittpunkt euler
    for n = 1:n_tot
        [pnplus1,qnplus1] = fixpunkt(p(n,:), q(n,:), k, h);
        p(n+1,:) = p(n,:) - h*gradient_q((q(n,:)+qnplus1)/2);
        q(n+1,:) = q(n,:) + h*gradient_p((p(n,:)+pnplus1)/2);
    
    end
end

tspan=(0:n_tot)*h;

%Plottar vägen i ett diagram
hold on
% plot3(p(:,1),p(:,2),tspan)
plot3(q(:,1),q(:,2),tspan)
plot3(0,0,[0 10 20 30 40 50 60 70 80 90 100],'o')
axis([-2,2,-2,2])

%{
%Animerar vägen i ett diagram
for n=1:height(p)
    % clf
    hold on
    plot3(q(n,1),q(n,2),tspan, 'hexagram')
    % plot3(p(n,1),p(n,2),tspan, 'o')
    axis([-2 2 -2 2])
    drawnow
    pause(0.001)
end
%}

%Uppgift 1e
%Visar H som funktion av tiden
tspan = (0:n_tot)*h;
H = zeros(length(p),1);
for i = 1:height(p)
    H(i,1) = ((p(i,1)^2 + p(i,2)^2)/2) - 1/sqrt(q(i,1)^2 + q(i,2)^2);
end
figure
plot(tspan,H)