function [ idxW ] = ThomsonSamoling( R,V )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


u = betarnd(R+1, V-R+1);
            [m, idxW] = max(u);
 
end

