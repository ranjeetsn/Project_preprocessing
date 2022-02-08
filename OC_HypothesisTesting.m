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


classdef OC_HypothesisTesting < OrderCalculatorType
    %----------------------------------------------------------------------
    % This is a concerte class implementing a OrderCalculatorType
    % This Class computes the Order using Hypothesis Testing
    % INPUT         - data object (variables along rows)
    %                 variance model
    %                 lag
    % OUTPUT        - order, eigen values
    % ERROR CODES   - an error code of 99999 implies number of constraints
    %                 calculation failed
    %----------------------------------------------------------------------
    
    properties (Access = private)
        d_Dvalue
        d_ConstraintNumberCalculator
    end
    
    methods (Static)
               
        function d      = DEFAULT_ORDER(obj)
            d           = 8888;
        end
        
    end
    
    methods
%% These function initialize and set up the object        
        function obj    = OC_HypothesisTesting()
            obj.d_ConstraintNumberCalculator = ConstraintNumberCalculator();
        end

        function obj    = m_setVarianceModel(obj, variance_model)
            obj.d_ConstraintNumberCalculator.m_setVarianceModel(variance_model);
        end
        
        %function obj    = m_setData(obj, data)
        %    obj.d_ConstraintNumberCalculator.m_setData(data);
        %end   
        
        function obj    = m_setDminAndDmax(obj, d_min, d_max)
            
            obj.d_ConstraintNumberCalculator.m_setDMin(d_min);
            obj.d_ConstraintNumberCalculator.m_setDMax(d_max);
        end
        
        function obj                                                = m_setOrder(obj, order)
            %disp('In Hypothesis Testing: Cannot set Order. Order to be computed');
        end
        
%% Function to compute the order of the system using the ConstraintNumberCalculator

        function [d_order, eig_values, ret_code] = ComputeOrder(obj)
            
            %disp('In the OC_HypothesisTesting: ComputeOrder routine');
           
            formatted_data  = obj.d_Model.m_getFormattedData(obj.d_Data, StackingTypeEnums.STACK_BY_LAG);
            obj.d_ConstraintNumberCalculator.m_setData(Dataobj(formatted_data));
            
            [d_min, d_max] = obj.d_Model.m_getMinAndMaxConstraints();
            obj.m_setDminAndDmax( d_min, d_max);
            
            [obj.d_Dvalue, eig_values, rcode] = obj.d_ConstraintNumberCalculator.m_ComputeNumberOfConstraints();
            %obj.d_Dvalue
            if (rcode == ReturnCodeEnums.FAILED)
                d_order  = OrderCalculatorEnums.DEFAULT_ORDER();
                ret_code = rcode;
                return;
            end
            
            
            if (obj.d_Dvalue == ConstraintNumberCalculator.DEFAULT_NUMBER_OF_CONSTRAINTS())
                % Should not come into this block. Should abort above. 
                % This if block can be removed later.
                %disp(' put out an error and discard eigen values')
                d_order = OrderCalculatorEnums.DEFAULT_ORDER();
                ret_code = ReturnCodeEnums.FAILED;
                
            else
                d_order = obj.d_Model.m_ComputeOrderGivenNumOfConstraints(obj.d_Dvalue);
                ret_code = ReturnCodeEnums.SUCCESS;
            end
        end
        
        
    end
    
end

