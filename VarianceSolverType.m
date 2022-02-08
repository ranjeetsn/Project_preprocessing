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


classdef VarianceSolverType < handle
    % This is an interface/ abstract class for variance solver classes
    % Any class that is implementing a variance solver needs to inherit
    % this class
    
    properties
    end
    
    
    methods (Abstract)
        [variance, ret_code] = m_solveForVariance(obj, data, variance_covariance_mapper);
    end
    
    
    methods (Static)
        
        function type = newType(v_solver_type)
            
            switch v_solver_type
                
                case 'TLS_SOLVER'
                    type = VS_TLSSolver;
                    
                case 'MLE_SOLVER'
                    type = VS_MLESolver;
                    
                otherwise
                    error('Not a valid Variance Solver Type');   
            end
            
        end
        
    end

end

