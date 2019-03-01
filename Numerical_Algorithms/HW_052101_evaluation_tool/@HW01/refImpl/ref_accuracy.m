function [z] = ref_accuracy(X,  Y)
    z = norm(X - Y, 1) / norm(Y, 1);
end