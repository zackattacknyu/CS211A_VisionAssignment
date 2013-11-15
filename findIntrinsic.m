function intrinsicMatrix = findIntrinsic(aMatrix)
    % svd of aMatrix
    [u, sigma, v] = svd(aMatrix)
    callibrationM = v(end, 1:end)
    
    intrinsicMatrix = callibrationM % This isn't real, just for testing
end