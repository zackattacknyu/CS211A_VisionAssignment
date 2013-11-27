% This script will run all of the code necessary for the project

clear all;
pixelValues = [79 1397 2138 908 1848 1750 2216 2406 1510 2990 1007 1516];
aMatrix = setupAMatrix('data_points_redux.txt',pixelValues); % Read in the 6 recorded points and find A
callibM = findCallibration(aMatrix); % Find the intrinsic matrix
%normCallibM = callibM/callibM(3,4);
normCallibM = callibM;

newM = normCallibM(1:3,1:3);
%transColumn = inv(newM)*normCallibM(:,4);
[rMatrix,qMatrix] = rq(newM);
transColumn = inv(rMatrix)*normCallibM(:,4);
extrinsic = [qMatrix transColumn; 0 0 0 1];
initProbePoint = [14.25;0;9.125;1];
probeInCameraCoords = extrinsic*initProbePoint; 

callibM_probePic = callibM;

imagePoints = [];
realPoints = [];
fileID = fopen('locationTextFiles/IPlanePoints.txt', 'r');
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