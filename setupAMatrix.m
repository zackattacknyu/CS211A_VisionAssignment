% Setup the A matrix for finding the callibration matrix
% In form of Ax = 0
% The ordering of the points from first to last is
% Green, Blue, Red, Gold, Purple, Yellow

function aMatrix = setupAMatrix(realWorldVectorTextFile,imagePoints)
    fileID = fopen(realWorldVectorTextFile, 'r');
    dataPoints = fscanf(fileID, '%f');
    
    xV = [];
    yV = [];
    zV = [];
    uV = [];
    vV = [];
    
    %imagePoints = {[81,1165],[2359,744],[2037,1855],[2293,2821],[1090,3198],[1176,1360]};

   for i=1:length(imagePoints)
       if mod(i, 2) == 0
          vV = [vV; imagePoints(i)];
       else
          uV = [uV; imagePoints(i)];
       end
   end
    
    
    for i=1:3:18
        xV = [xV, dataPoints(i)];
        yV = [yV, dataPoints(i+1)];
        zV = [zV, dataPoints(i+2)];
    end
    xV
    yV
    zV
    uV
    vV
    A = [];
    for i=1:6
        A = [A; -xV(i) -yV(i) -zV(i) -1 0 0 0 0 uV(i)*xV(i) uV(i)*yV(i) uV(i)*zV(i) uV(i);];
        A = [A; 0 0 0 0 -xV(i) -yV(i) -zV(i) -1 vV(i)*xV(i) vV(i)*yV(i) vV(i)*zV(i) vV(i);];
    end
    
    aMatrix = A; % The final A matrix of Ax = 0
    fclose(fileID);
    
end
