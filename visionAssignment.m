% This script will run all of the code necessary for the project

clear all;
aMatrix = setupAMatrix('data_points.txt','colors_for_data.txt','images/calibProbe1.jpg'); % Read in the 6 recorded points and find A
callibM = findCallibration(aMatrix); % Find the intrinsic matrix
%normCallibM = callibM/callibM(3,4);
normCallibM = callibM;
newM = normCallibM(1:3,1:3);
%transColumn = inv(newM)*normCallibM(:,4);
[rMatrix,qMatrix] = rq(newM);
transColumn = inv(rMatrix)*normCallibM(:,4);
extrinsic = [qMatrix transColumn; 0 0 0 1];
initProbePoint = [11;5.25;8.1875;1]; 
probeInCameraCoords = extrinsic*initProbePoint; 

aMatrixTestPoint = setupAMatrix('data_points.txt','colors_for_data.txt','images/calibProbe2.jpg');
callibM = findCallibration(aMatrixTestPoint); % Find the intrinsic matrix
%normCallibM = callibM/callibM(3,4);
normCallibM = callibM;
newM = normCallibM(1:3,1:3);
%transColumn = inv(newM)*normCallibM(:,4);
[rMatrix,qMatrix] = rq(newM);
transColumn = inv(rMatrix)*normCallibM(:,4);
extrinsic = [qMatrix transColumn; 0 0 0 1];
testProbPoint = inv(extrinsic)*probeInCameraCoords;