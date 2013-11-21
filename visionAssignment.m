% This script will run all of the code necessary for the project


aMatrix = setupAMatrix('data_points.txt','colors_for_data.txt','images/initCalibPoint.jpg'); % Read in the 6 recorded points and find A
callibM = findCallibration(aMatrix); % Find the intrinsic matrix
normCallibM = callibM/callibM(3,4);
newM = normCallibM(1:3,1:3);
%transMatrix = inv(newM)*normCallibM(:,4);
[rMatrix,qMatrix] = rq(newM);
initProbePoint = [14.25;0;9.125];
probeInCameraCoords = qMatrix*initProbePoint; 

aMatrixTestPoint = setupAMatrix('data_points.txt','colors_for_data.txt','images/testCalibPoint.jpg');
callibM = findCallibration(aMatrixTestPoint); % Find the intrinsic matrix
normCallibM = callibM/callibM(3,4);
newM = normCallibM(1:3,1:3);
%transMatrix = inv(newM)*normCallibM(:,4);
[rMatrix,qMatrix] = rq(newM);
testProbPoint = inv(qMatrix)*probeInCameraCoords;