% This script will run all of the code necessary for the project

clear all;
aMatrix = setupAMatrix('data_points.txt','colors_for_data.txt','images/initCalibPoint.jpg'); % Read in the 6 recorded points and find A
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

aMatrixTestPoint = setupAMatrix('data_points.txt','colors_for_data.txt','images/testCalibPoint.jpg');
callibM = findCallibration(aMatrixTestPoint); % Find the intrinsic matrix
%normCallibM = callibM/callibM(3,4);
normCallibM = callibM;
newM = normCallibM(1:3,1:3);
%transColumn = inv(newM)*normCallibM(:,4);
[rMatrix,qMatrix] = rq(newM);
transColumn = inv(rMatrix)*normCallibM(:,4);
extrinsic = [qMatrix transColumn; 0 0 0 1];
testProbPoint = inv(extrinsic)*probeInCameraCoords;