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


classdef OrderCalculatorType < handle
    % This is an interface/ abstract class for Order determination classes
    % Any class that is implementing a OrderCalculator needs to inherit this
    % class and define the ComputeOrder method
    
    properties (Access = protected)
        d_Data
        d_Model
        d_VarianceModel
    end
    
    methods (Abstract)
        [order, eig_vals, ret_code] = ComputeOrder(obj);
        m_setOrder(order);
    end
    
    methods (Static)
        
        function type  = newType(order_calculator_type)
            
            switch order_calculator_type
                
                case 'USER_DEFINED'
                    type = OC_UserDefined;
                    
                case 'HYPOTHESIS_TESTING'
                    type = OC_HypothesisTesting;
                    
                case 'EIGEN_PLOTS'
                    type = OC_EigenPlots;
                  
                otherwise
                    error('Not a valid OrderCalculator Type');   
                    
            end 
        end
        
    end
    
    methods
        
        function obj                    = m_setData(obj, data)
            obj.d_Data                  = data;
        end
        
        function obj                    = m_setModel(obj, model)
            obj.d_Model                 = model;
        end
        
        function obj                    = m_setVarianceModel(obj, variance_model)
            obj.d_VarianceModel         = variance_model;
        end
       
    end
end

