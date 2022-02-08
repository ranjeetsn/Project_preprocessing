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


classdef VarianceCovarianceMapperType < handle
    % This is an interface/ abstract class for mapping classes
    % Any class that is implementing a mapping from variance to covariance
    %needs to inherit this
    
    properties
    end
    
    
    methods (Abstract)
        covariance_matrix = Map(obj, variance_vector);
    end
    
    
    methods (Static)
        
        function type = newType(vcv_mapper_type)
            
            switch vcv_mapper_type
                
                case 'DIAGONAL_MAPPER'
                    type = VCV_DiagonalMapper;
                    
                case 'DIPCA_MAPPER'
                    type = VCV_DipcaMapper;
                    
                case 'GENERIC_MAPPER'
                    type = VCV_GenericMapper;
                    
                otherwise
                    error('Not a valid Preprocessor Type');   
            end
            
        end
        
    end

end

