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


classdef VCV_DipcaMapper < VarianceCovarianceMapperType
    % This is a concerte class implementing a Variance Covariance Mapper 
    % Anyone calling this class should set the d_NoOfVariables and d_Lag
    % before one can use the Mapper function

    properties (Access = private)
        d_NoOfVariables = 0
        d_Lag           = 0
    end
    
    methods
        
        % Set the number of variables
        function obj                = m_SetNoOfVariables(obj, no_of_variables)
            %disp("VCV_DipcaMapper : m_SetNoOfVariables")
            obj.d_NoOfVariables     = no_of_variables;
        end
        
        % Get the number of variables
        function no_of_variables    = m_GetNoOfVariables(obj)
            %disp("VCV_DipcaMapper : m_GetNoOfVariables")
            no_of_variables         =   obj.d_NoOfVariables;
        end
        
        % Set the lag
        function obj                = m_SetLag(obj, lag)
            %disp("VCV_DipcaMapper : m_SetLag")
            obj.d_Lag               = lag;
        end
        
        % Get the lag
        function lag                = m_GetLag(obj)
            %disp("VCV_DipcaMapper : m_GetLag")
            lag                     = obj.d_lag;
        end
        
        % Maps the variance vector to the diagonal matrix of covariance
        function covariance_matrix  = Map(obj, variance_vector)
            
          % Check to make sure that variance_vector is a column vector
          % and the size should be equal to the number of variables
          
          %disp('In the  VCV_DipcaMapper : Map')
          %obj.d_Lag
          %variance_vector
          
          y                         = repmat(variance_vector', obj.d_Lag + 1, 1);          
          y                         = y(:);          
          covariance_matrix         = diag(y);
          
        end
        
    end
    
end

