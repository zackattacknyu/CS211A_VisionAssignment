function callibMatrix = findTransform(aMatrix)

    [u, sigma, v] = svd(aMatrix); % use SVD to get matrices with calibration data
    callibrationM = v(:, end); % calibration data is in last column of v
    callibrationM = callibrationM/callibrationM(13)
    callibrationM = reshape(callibrationM(1:12), 4, 3)'; % Reshape the matrix into 3x4
    
    callibMatrix = callibrationM; % This isn't the actual intrinsic matrix, just for testing
end