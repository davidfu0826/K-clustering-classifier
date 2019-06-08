classdef K_means_classifier

    properties
        clusterLabels
        C
    end
    methods
        % K-means classifier, classifies data using K-means clustering
        % Input:    t         Training labels
        %           X         Training data
        %           K         Amount of clusters
        %
        % Output:   obj       Classifier
        function obj = K_means_classifier(t,X,K)
            % K-means clustering for training data
            [y,obj.C] = K_means_clustering(X,K);
            % Assigning labels to clusters with most frequent label
            obj.clusterLabels = [];
            for i = 1:K
                obj.clusterLabels = [obj.clusterLabels; mode(t(find(y == i)))]; % mode returns the most frequent element
            end
        end
        
        % predict, classifies an example using previously computed clusters
        % Input:    example   Example to classify
        %
        % Output:   label     Prediction according to the model
        function [label, index] = predict(obj, example)
            [~, index] = min(obj.fxdist(example));
            label = obj.clusterLabels(index);
        end
        
        % fxdist, Computes distance from points x to all centroids C
        % and selects centroid which has shortest distance
        % Input:    example   Example to classify using the clusters
        %                     computed from training data using
        %                     K-means clustering
        %
        % Output:   label     Prediction according to the model
        function d = fxdist(obj, x)
            [~, K] = size(obj.C);
            d = vecnorm(repmat(x,1,K)-obj.C,2);
        end
    end
end


