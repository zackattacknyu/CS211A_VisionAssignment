% This script will run all of the code necessary for the project

clear all;
pixelValues = [1946 749 1137 1035 1174 1545 1097 2865 660 1993 367 1410];
aMatrix = setupAMatrix('data_points_block_book.txt',pixelValues); % Read in the 6 recorded points and find A
callibM = findCallibration(aMatrix); % Find the intrinsic matrix
%normCallibM = callibM/callibM(3,4);
normCallibM = callibM;

newM = normCallibM(1:3,1:3);
%transColumn = inv(newM)*normCallibM(:,4);
[rMatrix,qMatrix] = rq(newM);
transColumn = inv(rMatrix)*normCallibM(:,4);
extrinsic = [qMatrix transColumn; 0 0 0 1];
initProbePoint = [10.0625;0.0625;5.6875;1];
probeInCameraCoords = extrinsic*initProbePoint; 

callibM_probePic = normCallibM

imagePoints = [];
realPoints = [];
fileID = fopen('locationTextFiles/IPlanePoints_book.txt', 'r');
prodImagePoints = fscanf(fileID, '%f');
for i = 1:length(prodImagePoints)
    imagePoints = [imagePoints; prodImagePoints(i)];
    
    if(mod(i,12) == 0)
        aMatrix = setupAMatrix('data_points_block_book.txt',imagePoints); % Read in the 6 recorded points and find A
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

scatter3(realPoints(:,1), realPoints(:,3), realPoints(:,2),12);