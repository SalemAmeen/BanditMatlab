function [ Weights ] = RandomPruining(Weights, SizeOfWeight)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

         RandNo=randi(SizeOfWeight);
         while (Weights(RandNo)==0)
              RandNo=randi(SizeOfWeight);
         end
         
         %fprintf('%d',RandNo)

         Weights(RandNo)=0;
      
end

