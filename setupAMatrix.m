% Setup the A matrix for finding the callibration matrix
% In form of Ax = 0

function aMatrix = setupAMatrix(filename)
    fileID = fopen(filename, 'r');
    dataPoints = fscanf(fileID, '%f');
    
    xV = [];
    yV = [];
    zV = [];
    uV = [];
    vV = [];
    for i=1:5:30
        xV = [xV, dataPoints(i)];
        yV = [yV, dataPoints(i+1)];
        zV = [zV, dataPoints(i+2)];
        uV = [uV, dataPoints(i+3)];
        vV = [vV, dataPoints(i+4)];
    end
    
    A = [];
    for i=1:6
        A = [A; -xV(i) -yV(i) -zV(i) -1 0 0 0 0 uV(i)*xV(i) uV(i)*yV(i) uV(i)*zV(i) uV(i);];
        A = [A; 0 0 0 0 -xV(i) -yV(i) -zV(i) -1 vV(i)*xV(i) vV(i)*yV(i) vV(i)*zV(i) vV(i);];
    end
    
    aMatrix = A;
    
end
