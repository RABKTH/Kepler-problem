function grad = gradient_q(q)
    grad = [q(1)/((q(1)^2 + q(2)^2)^(3/2)) q(2)/((q(1)^2 + q(2)^2)^(3/2))]; %Gradienten av H med avseende på q
end
