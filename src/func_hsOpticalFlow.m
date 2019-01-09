% File Name     : func_hsOpticalFlow.m
% Author        : Ziwei Chen
% Date          : Dec-9-2018
% Modified      : N/A
% Date          : N/A
% Version       : 1.0
% Description   : This function is the main function for solving optical
%                 flow for two motion image using Horn and Schunck Method.
%%
function [flowObj] = func_hsOpticalFlow(seqImg1,seqImg2,lambda,iteration)
%% Gaussian Bulr for original image
seqImg1 = imgaussfilt(double(seqImg1),1);
seqImg2 = imgaussfilt(double(seqImg2),1);
%% Calculate Gradient in X and Y
[imgIx_1,imgIx_2] = cls_imgGradient.imgIx(seqImg1,seqImg2);
[imgIy_1,imgIy_2] = cls_imgGradient.imgIy(seqImg1,seqImg2);
[imgIt_1,imgIt_2] = cls_imgGradient.imgIt(seqImg1,seqImg2);
%% Calculate u and v
Ix = imgIx_1 + imgIx_2; Iy = imgIy_1 + imgIy_2; It = imgIt_1 + imgIt_2;
[flowU, flowV] = func_flowJecobiSolver(Ix,Iy,It,lambda,iteration);          % Solve for optical flow
flowU = flipud(flowU); flowV = flipud(flowV);                               % Filp image to origianl
%% Visilize
flowObj = opticalFlow(flowU,flowV);                                         % Construct Optical Flow object

end

