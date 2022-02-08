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


classdef ConfidenceIntervalCalculator < handle

    
    properties
        d_Data
        d_NumberOfBootstraps
        d_SizeOfBootstraps
        d_AlphaValue
    end
    
    methods
        
        function obj                    = m_setData(obj, data)
            %data
            obj.d_Data                  = data;
        end
        
        function obj                    = m_setNumberOfBootstraps(obj, no_of_bootstraps)
            obj.d_NumberOfBootstraps    = no_of_bootstraps;
        end
        
        function obj                    = m_setSizeOfBootstraps(obj, size_of_bootstraps)
            % Check if size of bootstrap is greater than the total number
            % of rows and throw an error
            obj.d_SizeOfBootstraps      = size_of_bootstraps;
        end
        
        function obj                    = m_setAlphaValue(obj, alpha_value)
            obj.d_AlphaValue            = alpha_value;
        end
        
        function [confidence_intervals,std_model]   = m_computeConfidenceIntervals(obj, order, n_outputs, lag, variance_vec, vcv_mapper)
            
            model       = [];
            confidence_intervals = [];
            data        = obj.d_Data.m_getData();
            size(data)
            total_cols  = size(data, 2);
            nvar        = size(data,1);
            
            for i = 1:obj.d_NumberOfBootstraps
                
                col_indices     = randperm(total_cols, obj.d_SizeOfBootstraps);
                selected_rows   = data(:,col_indices);
                
                if (nargin == 6)
                     
                    temp            = SysidUtils.m_computeModelForStackedData(selected_rows, order, ...
                                                                              n_outputs, lag, ...
                                                                              variance_vec,  vcv_mapper);
                elseif (nargin == 4)
                     temp           = SysidUtils.m_computeModelForStackedData(selected_rows, order, ...
                                                                              n_outputs, lag);                                            
                end
                
                temp            = temp/temp(nvar/2 + 1 ,1);
                model           = [model temp];
                
            end
            mean_model = mean(model, 2);
            std_model  = std(model, 0, 2);
            
            for i = 1:nvar
                interval = norminv([obj.d_AlphaValue/200 1-obj.d_AlphaValue/200], mean_model(i), std_model(i));
                 confidence_intervals = [ confidence_intervals; interval];
            end
            confidence_intervals = [ confidence_intervals];
           
        end
        
       function [confidence_intervals]   = m_computeConfidenceIntervalsStatic(obj, no_of_constraints, variance_vec, vcv_mapper)
            
            model       = [];
            data        = obj.d_Data;
            data = data';
            total_cols  = size(data,2);
            nvar        = size(data,1);
            sz = nvar - no_of_constraints;
            Qe              = vcv_mapper.m_mapVarianceToCovariance(variance_vec);
            for i = 1:obj.d_NumberOfBootstraps
                
                col_indices     = randperm(total_cols, obj.d_SizeOfBootstraps);
                selected_rows   = data(:,col_indices);
                
                temp = SysidUtils.m_computeConstraints( selected_rows, no_of_constraints, Qe);
                Regression_model = rref(temp');           %for regression model
                
                Regression_model = -Regression_model(1:end,end-sz+1:end);
                model(:,:,i)           = Regression_model;
            end
            
            mean_model = mean(model, 3);
            std_model  = std(model, 0, 3);
            
             for i = 1:no_of_constraints
                 for j = 1:sz
                    interval = norminv([obj.d_AlphaValue/200 1-obj.d_AlphaValue/200], mean_model(i,j), std_model(i,j));
                    confidence_intervals_temp(i,j,1) = interval(1);
                    confidence_intervals_temp(i,j,2) = interval(2);
                 end
             end
            confidence_intervals = confidence_intervals_temp;
       end
        
    end
end

