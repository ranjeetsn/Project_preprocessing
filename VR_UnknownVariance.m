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


classdef VR_UnknownVariance < VarianceModelType
    
    % This is a concerte class implementing a Model when error variances
    % are unknown
    
    properties
        d_NoOfConstraints = 0  % Applicable for dynamic models. Need for computing the constraint matrix 
        d_errorVariances
        d_defaultErrorVariances
        d_varianceCovarianceMapper
        d_VarianceComputationStatus = VarianceComputationStatusEnums.VARIANCE_TO_BE_COMPUTED;
        d_varianceSolver
    end
    
    methods
        
        function obj                = m_setErrorVariances(obj, errorVariances)
            obj.d_errorVariances    = errorVariances;
            obj.d_defaultErrorVariances = errorVariances;
        end
        
        function obj                = m_resetVariancestoDefault(obj)
            obj.d_errorVariances    = obj.d_defaultErrorVariances;
        end
        
        function errorVariances     = m_getErrorVariances(obj)
            errorVariances          = obj.d_errorVariances;
            %obj.d_errorVariances
        end
        
        function d_varianceCovarianceMapper  = m_setMapper(obj, mapper_type)            
            obj.d_varianceCovarianceMapper = VarianceCovarianceMapper(mapper_type);  
            d_varianceCovarianceMapper     = obj.d_varianceCovarianceMapper;
        end
        
        function obj = m_setNoOfVariablesAndLagInMapper(obj, no_of_variables, lag)
                obj.d_varianceCovarianceMapper.m_setNoOfVariablesAndLag(no_of_variables, lag);
        end
        
         function obj                = m_setNoOfConstraints(obj, no_of_constraints)
            obj.d_NoOfConstraints   = no_of_constraints;
         end
        
         function obj = m_setRowIndicesAndColumnIndices(obj, row_ind, col_ind)
            obj.d_varianceCovarianceMapper.m_setRowIndicesAndColumnIndices(row_ind, col_ind);
         end
       
        function covariance     = m_getCovarianceFromVariance(obj)
            covariance          = obj.d_varianceCovarianceMapper.m_mapVarianceToCovariance(obj.d_errorVariances);
        end
        
        function obj                = m_setVarianceSolver(obj, v_solver_type)
            obj.d_varianceSolver = VarianceSolver(v_solver_type);
        end
        
        function [d_errorVariances, d_VarianceComputationStatus]= m_solveForVariance(obj, data, no_of_constraints)
            %disp("VarianceModel : m_solveForVariance ")
            %obj.d_errorVariances
            [d_errorVariances, d_VarianceComputationStatus] = obj.d_varianceSolver.m_solveForVariance(data, obj.d_varianceCovarianceMapper, obj.d_errorVariances, no_of_constraints);
            obj.d_errorVariances = d_errorVariances;
            obj.d_VarianceComputationStatus = d_VarianceComputationStatus;
        end
        
        function [covariance, ret_code] = m_ComputeCovariance(obj, dataobj, no_of_constraints)
            
          %disp("VarianceModel :  m_ComputeCovariance")
            obj.m_resetVariancestoDefault();
            %no_of_constraints is correct
            obj.m_solveForVariance(dataobj, no_of_constraints);
            variance_vec        = obj.d_errorVariances;
            covariance          = obj.d_varianceCovarianceMapper.m_mapVarianceToCovariance(variance_vec);
            ret_code            = obj.d_VarianceComputationStatus;
        end     
      
      
    end
end
