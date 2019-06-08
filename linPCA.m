function linPCA(X,y,two,optional)

    % Compute Singular Value decomposition 
    [U,~,~]=svds(X, 2);
    
    % Project data on eigenvectors for the two largest singular values
    Xproj = X'*U;
    
    % Compute
    indices = {};
    if two
        indices{1} = find(y);
        indices{2} = find(y == 0);
    else
        for i = unique(y)'
            indices{i} = find(y == i);
        end
    end
    xaxis = Xproj(:,1);
    yaxis = Xproj(:,2);
    
    
    hold on
    if two % For task E1
        title("PCA K = 2")
        plot(xaxis(indices{1}),yaxis(indices{1}),'bs')
        plot(xaxis(indices{2}),yaxis(indices{2}),'ro')
        legend('Image of 1','Image of 0')
        xlabel('Eigenvector with \lambda_1 > \lambda_2')
        ylabel('Eigenvector with \lambda_2')
    else % For task E2
        stri = {};
        marker = ['x', 'o', '.', 's', '*'];
        for i = unique(y)'
            plot(xaxis(indices{i}),yaxis(indices{i}),marker(i))
            stri{i} = strcat(['Cluster:', num2str(i), ', Label: ', num2str(optional(i)) ]);
        end
        if length(unique(y)) == 5
            legend(stri{1},stri{2},stri{3},stri{4},stri{5});
            title("PCA K = 5")
        elseif length(unique(y)) == 2
            stri{1}
            legend(stri{1},stri{2});
            title("PCA K = 2")
        end
    end
    hold off

end