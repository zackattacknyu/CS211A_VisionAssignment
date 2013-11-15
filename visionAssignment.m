% This script will run all of the code necessary for the project

aMatrix = setupAMatrix('data_points.txt'); % Read in the 6 recorded points and find A
callibM = findIntrinsic(aMatrix); % Find the intrinsic matrix
callibM