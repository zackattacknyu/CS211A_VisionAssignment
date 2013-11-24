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



% realPoints = [];
% images = dir('C:\Users\kevin\Documents\GitHub\prod');
% for i = 4:(length(images)-1)
%     aMatrix = setupAMatrix('data_points.txt','colors_for_data_prodPictures.txt',strcat('C:\Users\kevin\Documents\GitHub\prod\',images(i).name));
%     callibM = findCallibration(aMatrix); % Find the intrinsic matrix
%     %normCallibM = callibM/callibM(3,4);
%     normCallibM = callibM;
%     newM = normCallibM(1:3,1:3);
%     %transColumn = inv(newM)*normCallibM(:,4);
%     [rMatrix,qMatrix] = rq(newM);
%     transColumn = inv(rMatrix)*normCallibM(:,4);
%     extrinsic = [qMatrix transColumn; 0 0 0 1];
%     realPoints = [realPoints; (inv(extrinsic)*probeInCameraCoords)'];
% end

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