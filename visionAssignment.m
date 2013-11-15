% This script will run all of the code necessary for the project

aMatrix = setupAMatrix('data_points.txt');
callibM = findIntrinsic(aMatrix);
callibM