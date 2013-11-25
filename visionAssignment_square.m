% This script will run all of the code necessary for the project

clear all;
pixelValues = [402 697 1649 704 445 1026 1584 1018 857 2100 1429 2071];
aMatrix = setupAMatrix('data_points_square.txt',pixelValues); % Read in the 6 recorded points and find A
callibM = findCallibration(aMatrix); % Find the intrinsic matrix
%normCallibM = callibM/callibM(3,4);
normCallibM = callibM;

newM = normCallibM(1:3,1:3);
%transColumn = inv(newM)*normCallibM(:,4);
[rMatrix,qMatrix] = rq(newM);
transColumn = inv(rMatrix)*normCallibM(:,4);
extrinsic = [qMatrix transColumn; 0 0 0 1];
initProbePoint = [8.4375;0;9.8125;1];
probeInCameraCoords = extrinsic*initProbePoint; 

imagePoints = [];
realPoints = [];
fileID = fopen('locationTextFiles/IPlanePoints_square.txt', 'r');
prodImagePoints = fscanf(fileID, '%f');
for i = 1:length(prodImagePoints)
    imagePoints = [imagePoints; prodImagePoints(i)];
    
    if(mod(i,12) == 0)
        aMatrix = setupAMatrix('data_points_redux.txt',imagePoints); % Read in the 6 recorded points and find A
        callibM = findCallibration(aMatrix); % Find the intrinsic matrix
        %normCallibM = callibM/callibM(3,4);
        normCallibM = callibM;
        newM = normCallibM(1:3,1:3);
        %transColumn = inv(newM)*normCallibM(:,4);
        [rMatrix,qMatrix] = rq(newM);
        transColumn = inv(rMatrix)*normCallibM(:,4);
        extrinsic = [qMatrix transColumn; 0 0 0 1];
        %probeInCameraCoords = [5.55139;0.3983109;3.114695;1];
        realPoints = [realPoints; (inv(extrinsic)*probeInCameraCoords)'];
        imagePoints = [];
    end
end

scatter3(realPoints(:,1), realPoints(:,3), realPoints(:,2),5);