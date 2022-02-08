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


classdef PreprocessorType
    % This is an interface/ abstract class for preprocessing classes
    % Any class that is implementing a preprocessor needs to inherit this
    % class and define the PreprocessData method with Dataobj object as
    % input and Dataobj object as output
    
    properties
    end
    
    
    methods (Abstract)
        Preprocessed_data = PreprocessData(obj, data);
    end
    
    
    methods (Static)
        
        function type = newType(pp_type)
            
            switch pp_type
                
                case 'NULL'
                    type = PP_DoNothing;
                    
                case 'SKIP_ALTERNATE'
                    type = PP_SkipAlternate;
                    
                    
                otherwise
                    error('Not a valid Preprocessor Type');   
            end
            
        end
        
    end

end

