%% Initialization
clear all; clc;
addpath(genpath('src'));
addpath(genpath('data'));
fish = 0;                                                                   % Do we want to fish or not?
iteration = 0;
%% Yes! Fish!
if fish == 1
    seqImg1 = imread('seq1-image1.pgm'); seqImg2 = imread('seq1-image2.pgm');
    for lambda = 5:5:1000                                                   % First group of fish!
        % Calculation
        tic
        [flowObj] = func_hsOpticalFlow(seqImg1,seqImg2,lambda,iteration);
        time = toc;
        % Plot
        flowResult = plot(flowObj);
        % Save
        fileNmae = 'Dir_lambda_%d_Iter_%d_TM_%f.png';
        fileNmaeStr = sprintf(fileNmae,lambda,iteration,time);
        saveas(flowResult,fileNmaeStr)
        % Plot
        maxMag = max(flowObj.Magnitude(:));
        norMag = flowObj.Magnitude./maxMag;
        norImg = flipud(norMag.*255);
        flowImage = image(norImg);
        % Save
        fileNmae = 'Mag_lambda_%d_Iter_%d_TM_%f.png';
        fileNmaeStr = sprintf(fileNmae,lambda,iteration,time);
        saveas(flowImage,fileNmaeStr)
    end
    
    seqImg1 = imread('seq2-image1.pgm'); seqImg2 = imread('seq2-image2.pgm');
    for lambda = 5:5:1000                                                   % Second group of fish
        % Calculation
        tic
        [flowObj] = func_hsOpticalFlow(seqImg1,seqImg2,lambda,iteration);
        time = toc;
        % Plot
        flowResult = plot(flowObj);
        % Save
        fileNmae = 'Dir_lambda_%d_Iter_%d_TM_%f.png';
        fileNmaeStr = sprintf(fileNmae,lambda,iteration,time);
        saveas(flowResult,fileNmaeStr)
        % Plot
        maxMag = max(flowObj.Magnitude(:));
        norMag = flowObj.Magnitude./maxMag;
        norImg = flipud(norMag.*255);
        flowImage = image(norImg);
        % Save
        fileNmae = 'Mag_lambda_%d_Iter_%d_TM_%f.png';
        fileNmaeStr = sprintf(fileNmae,lambda,iteration,time);
        saveas(flowImage,fileNmaeStr)
    end
else
    %% No! No Fish!
    seqImg1 = imread('seq1-image1.pgm'); seqImg2 = imread('seq1-image2.pgm');
    % Set to iteration to 0 for adaptive iterations
    lambda = 75; iteration = 0;
    %% Calculation
    [flowObj] = func_hsOpticalFlow(seqImg1,seqImg2,lambda,iteration);
    
    %% Plot
    flowResult = plot(flowObj);
    maxMag = max(flowObj.Magnitude(:));
    norMag = flowObj.Magnitude./maxMag;
    norImg = flipud(norMag.*255);
    image(norImg);
end