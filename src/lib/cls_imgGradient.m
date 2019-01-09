% File Name     : cls_imgGradient.m
% Author        : Ziwei Chen
% Date          : Dec-9-2018
% Modified      : N/A
% Date          : N/A
% Version       : 1.0
% Description: This class was to calculate special and time gradient of the
%              motion image set
classdef cls_imgGradient
    methods(Static)
        %% Special x-Dir
        function [imgIx_1,imgIx_2] = imgIx(seqImg1,seqImg2)
            mask_x = [-1, 1; -1, 1];
            imgIx_1 = conv2(seqImg1,mask_x,'same');
            imgIx_2 = conv2(seqImg2,mask_x,'same');
        end
        
        %% Special y-Dir
        function [imgIy_1,imgIy_2] = imgIy(seqImg1,seqImg2)
            mask_y = [-1, -1; 1, 1];
            imgIy_1 = conv2(seqImg1,mask_y,'same');
            imgIy_2 = conv2(seqImg2,mask_y,'same');
        end
        
        %% Time Dir
        function [imgIt_1,imgIt_2] = imgIt(seqImg1,seqImg2)
            mask_t1 = [1, 1; 1, 1]; mask_t2 = [-1, -1; -1, -1];
            imgIt_1 = conv2(seqImg1,mask_t1,'same');
            imgIt_2 = conv2(seqImg2,mask_t2,'same');
        end
    end
end

