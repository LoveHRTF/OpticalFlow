% File Name     : func_flowJecobiSolver.m
% Author        : Ziwei Chen
% Date          : Dec-9-2018
% Modified      : Ziwei Chen
% Date          : Dec-11-2018
% Version       : 1.1
% Description   : This function is the Jecobi Solver for optical flow.
function [imgMapU, imgMapV] = func_flowJecobiSolver(Ix,Iy,It,lambda,iter)
waitBarX = waitbar(0,'Solving Optical Flow Using Jecobi Solver');
%% Initialization
matSize = size(Ix);
imgMapU = zeros(matSize); imgMapV = zeros(matSize);
lambdaMat = ones(matSize) * lambda;                                         % Create lambda matrix for each element
avgMask = [0, 1/4, 0; 1/4, 0, 1/4; 0, 1/4, 0];                              % Averate Mask for u-bar and v-bar
targetFitRate = 0.90;                                                       % Set target fit rate
solverEqu = 1;                                                              % Set solver; 0 for original solver from paper, 1 for drived equations

if iter > 0                                                                 % Select iterator mode, > 0 for constant iteration, = 0 for constant fit rate
    for iteration = 1: iter
        %% Get Average of 4 Pixel Connectivity
        uBar = conv2(imgMapU,avgMask,'same');
        vBar = conv2(imgMapV,avgMask,'same');
        
        %% Solve for u and v
        if solverEqu == 0
            imgMapU_tmp = uBar - (Ix .* (Ix .* uBar + Iy .* vBar + It)) ./ (lambdaMat.^2 + Ix .^2 + Iy .^2);
            imgMapV_tmp = vBar - (Iy .* (Ix .* uBar + Iy .* vBar + It)) ./ (lambdaMat.^2 + Ix .^2 + Iy .^2);
        elseif solverEqu == 1
            imgMapU_tmp = (4 * lambdaMat .* uBar - Ix .* Iy .* imgMapV - Ix .* It) ./ (Ix .^ 2 + 4 * lambdaMat);
            imgMapV_tmp = (4 * lambdaMat .* vBar - Ix .* Iy .* imgMapU - Iy .* It) ./ (Iy .^ 2 + 4 * lambdaMat);
        end
        %% Update previous map
        imgMapU = imgMapU_tmp; imgMapV = imgMapV_tmp;
        
        waitbar((iteration/iter), waitBarX,'Solving Optical Flow Using Jecobi Solver');
    end
else
    while(1)
        %% Get Average of 4 Pixel Connectivity
        uBar = conv2(imgMapU,avgMask,'same');
        vBar = conv2(imgMapV,avgMask,'same');
        
        %% Solve for u and v
        imgMapU_tmp = uBar - (Ix .* (Ix .* uBar + Iy .* vBar + It)) ./ (lambdaMat.^2 + Ix .^2 + Iy .^2);
        imgMapV_tmp = vBar - (Iy .* (Ix .* uBar + Iy .* vBar + It)) ./ (lambdaMat.^2 + Ix .^2 + Iy .^2);
        fitRate = sum(sum((imgMapU == imgMapU_tmp) + (imgMapV == imgMapV_tmp) == (ones(matSize) * 2)))/(matSize(1)*matSize(2));
        if fitRate >= targetFitRate                                         % Terminate when fit rate larger than 98%
            break;                                                          % Fit: Value does not change between two iterations
        else
            %% Update previous map
            imgMapU = imgMapU_tmp; imgMapV = imgMapV_tmp;
        end
        waitbar((fitRate/targetFitRate), waitBarX,'Solving Optical Flow Using Jecobi Solver');
    end
end
close(waitBarX);
end