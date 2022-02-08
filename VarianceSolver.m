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


classdef VarianceSolver < handle
    % This class Solves for the variance given data and the solver type
    
    properties (Access = private)
        d_VarianceSolverType
    end
    
    methods
        
        function obj                = VarianceSolver(v_solver_type)
            obj.m_setVarianceSolver(v_solver_type);
        end
        
        function obj                =  m_setVarianceSolver(obj, v_solver_type)
           obj.d_VarianceSolverType =  VarianceSolverType.newType(v_solver_type);
        end
        
        function [variance, ret_code] = m_solveForVariance(obj, data, variance_covariance_mapper, initial_variance_vec, no_of_constraints)
            
            %disp("In VarianceSolver : m_solveForVariance");
            %no_of_constraints
            [variance, ret_code]      = obj.d_VarianceSolverType.m_solveForVariance(data, variance_covariance_mapper, initial_variance_vec, no_of_constraints);
        end
        
    end
end

