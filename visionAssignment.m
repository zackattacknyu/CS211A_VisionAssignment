% This script will run all of the code necessary for the project


aMatrix = setupAMatrix('data_points.txt'); % Read in the 6 recorded points and find A
callibM = findIntrinsic(aMatrix); % Find the intrinsic matrix
normCallibM = callibM/callibM(3,4);
newM = normCallibM(1:3,1:3);
transMatrix = inv(newM)*normCallibM(:,4);
[rMatrix,qMatrix] = rq(newM);