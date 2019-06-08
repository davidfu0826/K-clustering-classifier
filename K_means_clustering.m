function [y,C] = K_means_clustering(X,K)

% Calculating cluster centroids and cluster assignments for:
% Input:    X   DxN matrix of input data
%           K   Number of clusters
%
% Output:   y   Nx1 vector of cluster assignments
%           C   DxK matrix of cluster centroids

[D,N] = size(X);

intermax = 25;
conv_tol = 1e-6;
% Initialize
C = repmat(mean(X,2),1,K) + repmat(std(X,[],2),1,K).*randn(D,K);
y = zeros(N,1);
Cold = C;

for kiter = 1:intermax

    % Step 1: Assign to clusters
    y = step_assign_clustering(X,C);
    
    % Step 2: Assign new clusters
    C = step_compute_mean(X,C,y);
        
    if fcdist(C,Cold) < conv_tol
        return
    end
    Cold = C;
end

end

function d = fxdist(x,C)
    % repmat - subtract all centroids by x
    % vecnorm - norm of every column
    [~, K] = size(C);
    d = vecnorm(repmat(x,1,K)-C,2);
    %d = [];
end

function d = fcdist(C1,C2)
    d = norm(C1-C2,2);
    %d = [];
end

function y = step_assign_clustering(X,C)
    [N, M] = size(X);
    y = [];
    for i = 1:M
        [~,index] = min(fxdist(X(:,i),C));
        y = [y; index];
    end
end

function [newC, d] = step_compute_mean(X,C,y)
    [~, K] = size(C);
    newC = [];
    d = [];
    for i = 1:K
        newC(:,i) = mean(X(:,find(y == i)),2);
        d = [d fcdist(newC(:,i),C(:,i))];
    end
end