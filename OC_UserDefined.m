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


classdef OC_UserDefined < OrderCalculatorType
    % This is a concerte class implementing a OrderCalculatorType
    % This Class just takes the order information from the user
    
    properties (Access = private)
        d_Order
    end
    
    methods
        
        function obj    = m_setLag(obj, lag)
            obj.d_Lag   = lag;
        end
        
        function obj    = m_setVarianceModel(obj, variance_model)
            obj.d_VarianceModel = variance_model;
        end
        
        function obj    = m_setStackedData(obj, stacked_data)
            obj.d_Data  = stacked_data;
        end
        
        function obj    = m_setOrder(obj, order)
            obj.d_Order = order;
        end
        
        function [order, eigen_values, ret_code] = ComputeOrder(obj)
          %disp('In the OC_UserDefined: ComputeOrder routine');
          order         = obj.d_Order;
          %%disp('Compute and return Eigen Values');
          eigen_values  = [];
          d_val         = obj.d_Lag - obj.d_Order + 1;
          [eigen_values, ret_code]  = SysidUtils.m_ComputeEigenvaluesForGivenD(obj.d_Data, d_val, obj.d_VarianceModel);
        end
        
       
    end
    
end

