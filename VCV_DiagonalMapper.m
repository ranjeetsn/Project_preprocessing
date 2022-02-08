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


classdef VCV_DiagonalMapper < VarianceCovarianceMapperType
    % This is a concerte class implementing a Variance Covariance Mapper 

    properties
    end
    
    methods
        
        % Maps the variance vector to the diagonal matrix of covariance
        
        function covariance_matrix = Map(obj, variance_vector)
            
          %disp(' In the  VCV_DiagonalMapper - Map routine')
          
          covariance_matrix = diag(variance_vector);

        end
        
    end
    
end

