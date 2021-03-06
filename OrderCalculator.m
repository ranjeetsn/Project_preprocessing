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


classdef OrderCalculator < handle
    % This class handles the Order Calculations 
    % Internally, it does so by computing the number of constraints
    % using the eigen values. 
    
    
    properties (Access = private)
        
        d_OrderCalculatorType
        d_Order
        d_EigenValues
        d_retCode
    end
    
    methods 
        
        function obj                    = OrderCalculator(order_calculator_type)
            obj.m_setOrderCalculator(order_calculator_type);
        end
        
        function obj                    = m_setOrderCalculator(obj, order_calculator_type)
            obj.d_OrderCalculatorType   = OrderCalculatorType.newType(order_calculator_type);
        end
        
        function order_calculator_type = m_getOrderCalculator(obj)
            order_calculator_type = obj.d_OrderCalculatorType;
        end

        function obj                    = m_setData(obj, data)
            obj.d_OrderCalculatorType.m_setData(data);
        end
        
        function obj                    = m_setModel(obj, model)
            obj.d_OrderCalculatorType.m_setModel(model);
        end
        
        function obj                    = m_setVarianceModel(obj, variance_model)
            obj.d_OrderCalculatorType.m_setVarianceModel(variance_model);
        end
   
        function obj                    = m_configureOrderCalculator(obj, data, model, variance_model)
            obj.m_setData(data);
            obj.m_setModel(model);
            obj.m_setVarianceModel(variance_model);
        end
                
        function obj                    = m_setOrder(obj, order)
            %order till here ok
            obj.d_Order                 = order;
        end
        
        function [order, eigen_values,ret_code]          = m_computeOrder(obj)
            [obj.d_Order,obj.d_EigenValues,obj.d_retCode]     = obj.d_OrderCalculatorType.ComputeOrder();
            order                               = obj.d_Order;
            eigen_values                        = obj.d_EigenValues;
            ret_code                            = obj.d_retCode;
        end
        
        function order  = m_getOrder(obj)
                %order
                 order  = obj.d_Order;
        end
        
    end
    
end