function PCA(X,y,two,optional)

    % Compute Singular Value decomposition 
    [U,~,~]=svds(X, 2);
    
    % Project data on eigenvectors for the two largest singular values
    Xproj = X'*U;
    
    % Compute element indices for different classes
    indices = {};
    for i = unique(y)'
        indices{i} = find(y == i);
    end
    
    % Extract data for plotting
    xaxis = Xproj(:,1);
    yaxis = Xproj(:,2);
    
    % Plotting data  
    hold on

    for i = unique(y)'
        plot(xaxis(indices{i}),yaxis(indices{i}),marker(i))
    end

    hold off

end