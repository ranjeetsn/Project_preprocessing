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


classdef PP_DoNothing < PreprocessorType
    % This is a concerte class implementing a preprocessor 
    % This preprocessor just returns the input w/o any changes
    properties
    end
    
    methods
        
        function Preprocessed_data = PreprocessData(obj, data)
            
          %disp(' In the DoNothing Preprocessor routine')
          Preprocessed_data = data;
        end
        
    end
    
end

