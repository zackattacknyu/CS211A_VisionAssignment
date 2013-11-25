% Setup the A matrix for finding the callibration matrix
% In form of Ax = 0
% The ordering of the points from first to last is
% Green, Blue, Red, Gold, Purple, Yellow

function aMatrix = setupAMatrix_general(setOfPointsSource,setOfPointsTarget)
    sourceFileID = fopen(setOfPointsSource, 'r');
    sourceDataPoints = fscanf(sourceFileID, '%f');
    
    targetFileID = fopen(setOfPointsTarget, 'r');
    targetDataPoints = fscanf(targetFileID, '%f');
    
    xVs = [];
    yVs = [];
    zVs = [];
    xVt = [];
    yVt = [];
    zVt = [];
    %imagePoints = {[81,1165],[2359,744],[2037,1855],[2293,2821],[1090,3198],[1176,1360]};
    
    for i=1:3:12
        xVs = [xVs, sourceDataPoints(i)];
        yVs = [yVs, sourceDataPoints(i+1)];
        zVs = [zVs, sourceDataPoints(i+2)];
        xVt = [xVt, targetDataPoints(i)];
        yVt = [yVt, targetDataPoints(i+1)];
        zVt = [zVt, targetDataPoints(i+2)];
    end
    xVs
    yVs
    zVs
    xVt
    yVt
    zVt
    A = [];
    for i=1:4
        A = [A; xVs(i) yVs(i) zVs(i) 1 0 0 0 0 0 0 0 0 -xVt(i);];
        A = [A; 0 0 0 0 xVs(i) yVs(i) zVs(i) 1 0 0 0 0 -yVt(i);];
        A = [A; 0 0 0 0 0 0 0 0 xVs(i) yVs(i) zVs(i) 1 -zVt(i);];
    end
    
    aMatrix = A; % The final A matrix of Ax = 0
    fclose(sourceFileID);
    fclose(targetFileID);
end
