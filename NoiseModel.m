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


classdef NoiseModel < handle
    %This singleton implementation for the Noise Model provides 
    %a place to store the noise model type and single point of access
    
    properties (Access = private)
        d_NoiseModelType
    end
    
    methods(Access=private)
        
        function obj = NoiseModel()
            obj.d_NoiseModelType = NoiseModelEnums.UNDEFINED;
        end
        
    end
    
    methods (Static)
        
        function obj = getInstance()
            
            persistent d_instance;
            
            if (isempty(d_instance))
                obj = NoiseModel();
                d_instance = obj;
            else
                obj = d_instance;
            end
        end
        
    end
    
    methods
         
        function obj                    = m_setNoiseModel(obj, noise_model_type)
                obj.d_NoiseModelType    = noise_model_type;
        end
        
        function noise_model            = m_getNoiseModel(obj)
            noise_model                 = obj.d_NoiseModelType;
        end
        
    end
end

