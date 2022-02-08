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


classdef VarianceModelType < handle
    % This is an interface/ abstract class for covariance computation classes
    % Any class that is implementing a Covariance calculation needs to inherit this
    % class and define the ComputeCovariance method with Dataobj object as
    % input and covariance matrix as output
    
    properties
    end
    
    
%     methods (Abstract)
%         %covariance = m_ComputeCovariance(obj, data, no_of_constraints);
%     end

    
    
    methods (Static)
        
        function type = newType(vr_type)
            
            switch vr_type
                
                case 'KNOWN'
                    type = VR_KnownVariance;
                    
                case 'UNKNOWN'
                    type = VR_UnknownVariance;
                    
                otherwise
                    error('Not a valid Model Type');
                    
            end
            
        end
        
    end
    
    
end

