%%------------------------------------------------------------------------------------
%%------------------------------------------------------------------------------------
% This code is a part of XPCA, a MATLAB toolbox project. This project is supported by the 
% Robert Bosch Center for Data Sciences and Artificial Intelligence (RBCDSAI), 
% Indian Institute of Technology Madras (IITM).
%
% Project Name  : COMPREHENSIVE ERRORS-IN-VARIABLES BASED MODEL IDENTIFICATION
% Project No    : CR1819CHE002RBEIAKTA 
% Author        : Lokesh Rajulapati
% Date          : 25th February 2020
%
% Bug Reports
% Please report your bugs to the following mail id : lkrajulapati at gmail dot com
%%------------------------------------------------------------------------------------
%%------------------------------------------------------------------------------------
% Purpose of this Class : Abstract / Concrete / Enums
% 
% Inputs for Initialization : 
%
% Outputs : 
%
% Notes on Future Extensions :
%%------------------------------------------------------------------------------------
%%------------------------------------------------------------------------------------


classdef OC_EigenPlots < OrderCalculatorType
    
    % This is a concerte class implementing a OrderCalculatorType
    % This Class takes the order from user after computing the eigen plots
    
    properties
    end
    
    methods
        
        function [order, eigen_values, ret_value] = ComputeOrder(obj)
          disp('In the OC_EigenPlots: ComputeOrder routine'); 
        end
        
    end
    
end

