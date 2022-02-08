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


classdef VarianceComputationStatusEnums < uint32
    
   enumeration
      VARIANCE_KNOWN                                            (1)
      VARIANCE_TO_BE_COMPUTED                                   (2)
      VARIANCE_COMPUTED_SUCCESSFUL                              (3)
      VARIANCE_COMPUTATION_MAX_ITERATIONS_HIT                   (777)
      VARIANCE_COMPUTATION_FAILED_DUE_TO_NON_IDENTIFIABILITY    (888)
      VARIANCE_COMPUTATION_FAILED_DUE_TO_UNKNOWN_REASON         (9999)
   end
   
end