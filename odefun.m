function [dpq_dt] = odefun(t,pq)
    %pq är en vektor med p och q, alltså [p1 p2 q1 q2]
    dpq_dt=zeros(1,4);
    dpq_dt(1) = -pq(3)/((pq(3)^2 + pq(4)^2)^(3/2));
    dpq_dt(2) = -pq(4)/((pq(3)^2 + pq(4)^2)^(3/2)); %Gradienten av H med avseende på q
    dpq_dt(3) = pq(1);
    dpq_dt(4) = pq(2); %Gradienten av H med avseende på p
    dpq_dt = transpose(dpq_dt);
end