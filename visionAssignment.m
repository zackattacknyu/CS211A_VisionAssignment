% This script will run all of the code necessary for the project

clear all;
% aMatrix = setupAMatrix('data_points.txt','colors_for_data_calibProb.txt','images/calibProbe1.jpg'); % Read in the 6 recorded points and find A
% callibM = findCallibration(aMatrix); % Find the intrinsic matrix
% %normCallibM = callibM/callibM(3,4);
% normCallibM = callibM;
% newM = normCallibM(1:3,1:3);
% %transColumn = inv(newM)*normCallibM(:,4);
% [rMatrix,qMatrix] = rq(newM);
% transColumn = inv(rMatrix)*normCallibM(:,4);
% extrinsic = [qMatrix transColumn; 0 0 0 1];
% initProbePoint = [11;5.25;8.1875;1]; 
% probeInCameraCoords = extrinsic*initProbePoint; 

probeInCameraCoords = [5.55139;0.3983109;3.114695;1]
aMatrixFirstPoint = setupAMatrix('data_points.txt','colors_for_data_prodPictures.txt','images/IMG_20131122_162357_original.jpg');
callibM_FirstPoint = findCallibration(aMatrixFirstPoint); % Find the intrinsic matrix
%normCallibM = callibM/callibM(3,4);
normCallibM_FirstPoint = callibM_FirstPoint;
newMFirstPoint = normCallibM_FirstPoint(1:3,1:3);
%transColumn = inv(newM)*normCallibM(:,4);
[rMatrixFirstPoint,qMatrixFirstPoint] = rq(newMFirstPoint);
transColumn_FirstPoint = inv(rMatrixFirstPoint)*normCallibM_FirstPoint(:,4);
extrinsicFirstPoint = [qMatrixFirstPoint transColumn_FirstPoint; 0 0 0 1];
testFirstPoint = inv(extrinsicFirstPoint)*probeInCameraCoords;

% aMatrixTestPoint = setupAMatrix('data_points.txt','colors_for_data_calibPoint.txt','images/calibProbe2.jpg');
% callibM_TestPoint = findCallibration(aMatrixTestPoint); % Find the intrinsic matrix
% %normCallibM = callibM/callibM(3,4);
% normCallibM_TestPoint = callibM_TestPoint;
% newMTestPoint = normCallibM_TestPoint(1:3,1:3);
% %transColumn = inv(newM)*normCallibM(:,4);
% [rMatrixTestPoint,qMatrixTestPoint] = rq(newMTestPoint);
% transColumn_TestPoint = inv(rMatrixTestPoint)*normCallibM_TestPoint(:,4);
% extrinsicTestPoint = [qMatrixTestPoint transColumn_TestPoint; 0 0 0 1];
% testProbPoint = inv(extrinsicTestPoint)*probeInCameraCoords;
% 
% aMatrixSecondPoint = setupAMatrix('data_points.txt','colors_for_data_calibPoint.txt','images/calibProbe3.jpg');
% callibM_SecondPoint = findCallibration(aMatrixSecondPoint); % Find the intrinsic matrix
% %normCallibM = callibM/callibM(3,4);
% normCallibM_SecondPoint = callibM_SecondPoint;
% newMSecondPoint = normCallibM_SecondPoint(1:3,1:3);
% %transColumn = inv(newM)*normCallibM(:,4);
% [rMatrixSecondPoint,qMatrixSecondPoint] = rq(newMSecondPoint);
% transColumn_SecondPoint = inv(rMatrixSecondPoint)*normCallibM_SecondPoint(:,4);
% extrinsicSecondPoint = [qMatrixSecondPoint transColumn_SecondPoint; 0 0 0 1];
% testSecondPoint = inv(extrinsicSecondPoint)*probeInCameraCoords;