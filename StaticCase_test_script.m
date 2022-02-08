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


%% This file is the script to set up and test the Static case
%
% Input     - data file
% Output    - covariance & model
%
%% Loading the data and Initializing the XPCA object 

load InputdataIPCA2.mat

data = Z;

g = xpca(data);

%% This part handles the configuration of Model, Variance Model, Variance Solver

g.m_setModel("STATIC_MODEL")

g.m_setPreprocessor("NULL")

g.m_preprocessData()

g.m_setVarianceModel("UNKNOWN")

g.m_configureVarianceModelForDiagonalMapper()

g.m_setVarianceSolver("MLE_SOLVER")

g.m_configureOrderCalculatorForHypothesisTesting()

% Initial guess of variance to start with
g.m_initializeErrorVariances();

%% The actual computation of the variances and model

covariance  = g.m_computeCovariancesForStaticCase()

model       = g.m_computeModel()
rref(model')