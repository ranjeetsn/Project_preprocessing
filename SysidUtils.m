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


classdef SysidUtils
    % This class defined with methods as "Static" contains helper functions for DIPCA
    % Could be useful for other applications as well
    
    properties
    end
    
    methods(Static)
        
        function alpha      = ALPHA_HYPOTHESIS_TESTING()
            alpha           = 0.05;
        end
        
        function tolerance  = TOLERANCE_FOR_CONVERGENCE()
            tolerance       = 0.00001;
        end
        
        
        function zmat       = GenerateStackedMatrix(Z , lag)
            
            if ~exist('is_mimo', 'var')
                is_mimo = 0;
            end
            
            h               = [];
            zmat            = [];
            Num_of_Var      = size(Z,2);
            Num_of_Obs      = size(Z,1);
            
            for ind         = 1:Num_of_Var
                c           = Z(1:lag+1, ind);
                r           = Z(lag+1:Num_of_Obs, ind)';
                h(:,:, ind) = hankel(c, r);
            end
            
            h = flip(h,1);
            
            for ind         = 1:Num_of_Var
                zmat        = cat (1, zmat, h(:,:,ind));
            end
            
        end
        
        function Zs         = ConstructScaledZ( Z, SigE )
            num_of_samples  = size( Z, 2 );
            L               = chol(SigE, 'lower');
            Linv            = inv(L);
            Zs              = L \ Z;
            
        end
        
        function Zs         = ConstructScaledZ1( Z, SigE )
            %Z
            L               = chol(SigE, 'lower');
            Linv            = inv(L);
            Zs              = Linv * Z ;
            
        end
        
        function eig_vals       = m_computeEigenValues(Z)
                dim             = size(Z,2);
                eig_vals        = eig(Z*Z'/ dim);
        end
        
        function eig_vals  = m_ComputeEigenValuesforGivenDataAndCovariance(Z, Qe)
            
                Zs             = SysidUtils.ConstructScaledZ1(Z, Qe);
                eig_vals       = SysidUtils.m_computeEigenValues(Zs);
                
        end
        
        function [ut, st, vt]       = GetSVD(zs)
            [ut, st, vt]            = svd(zs,'econ');
        end
        
        function Constrnt_Mat_A     = GetConstraintMatrix(ut, Num_of_Constraints)
            num_cols                = size(ut,2);
            
            Constrnt_Mat_A          = ut(:, num_cols - Num_of_Constraints + 1 : num_cols);
        end
        
        function constraints        = m_computeConstraints( Z, no_of_constraints, Qe)
            
            noise_model         = NoiseModel.getInstance();
            
            if (noise_model.m_getNoiseModel() == NoiseModelEnums.NOISY)
                
                Zs                      = SysidUtils.ConstructScaledZ1( Z, Qe );
                [u s v]                 = SysidUtils.GetSVD(Zs);
               
                temp_constraints        = SysidUtils.GetConstraintMatrix(u, no_of_constraints);
                
                
                
                L                       = chol( Qe, 'lower' );
                Linv                    = inv(L);
                constraints             = L \ temp_constraints;
            else
                [u, s, v]               = SysidUtils.GetSVD(Z);
                constraints             = SysidUtils.GetConstraintMatrix(u, no_of_constraints);
            end
        end
        
        function flag  = CheckConvergenceBySingularValues(sum_sing_new, sum_sing_old)
            
            if ( abs(sum_sing_new - sum_sing_old) < SysidUtils.TOLERANCE_FOR_CONVERGENCE())   %Tolerance to be declared in the beginning ..remove hardcoded value
                %disp('Converged')
                flag = 0;
            else
                flag = 1;
            end
            
        end
        
        % This function uses Hypothesis Testing to calculate the
        % number of equal eigen values
        % Author : Ranjeet Nagarkar
        
        function [d] = HypothesisTest(X, n, alpha) % CoVar_M = 1/(n-1) * X'*X
            
            X = sort(X);
            X   = fliplr(X');
            X   = X';
            d   = -1;
            
            dim = size(X);
            l   = X;
            p   = dim(1);
            n2  = n - ( 2*p + 11 )/6;
            
            for q = p-2:-1:1
                
                l_avg   = sum( l(q+1:p) ) / (p-q);
                
                stat    = n2 * ( (p-q) * log(l_avg) - sum( log(l(q+1:p)) ) ); % test statistic from Jolliffe
                nu      = 0.5 * (p-q+2) * (p-q-1);                          % degrees of freedom of Chi-square distribution
                chi_val = chi2inv( (1-alpha) , nu);                         % alpha assumed to be 5% needs to be changed
                
                if( stat > chi_val )
                    d = p - q - 1;
                    return
                end
            end
        end
        
          function [d] = HypothesisTest1(X, n, alpha) % CoVar_M = 1/(n-1) * X'*X
            
            X   = sort(X);
            X   = fliplr(X');
            X   = X';
            d   = -1;
            
            dim = size(X);
            l   = X;
            p   = dim(1);
            n2  = n - ( 2*p + 11 )/6;
            %final_chi_val
            
            for q = 1:1:p-2
                
                l_avg   = sum( l(q+1:p) ) / (p-q);
                
                stat    = n2 * ( (p-q) * log(l_avg) - sum( log(l(q+1:p)) ) ); % test statistic from Jolliffe
                nu      = 0.5 * (p-q+2) * (p-q-1);                          % degrees of freedom of Chi-square distribution
                chi_val = chi2inv( (1-alpha) , nu);                         % alpha assumed to be 5% needs to be changed
                
                stat_out(q) = stat;
                
                if( stat < chi_val )
                    d = p - q ;
                    return
                end
            end
          end
        
          function [output] = HypothesisTestForaGivenD(X, n, alpha, d) % CoVar_M = 1/(n-1) * X'*X
            
            X   = sort(X);
            X   = fliplr(X');
            X   = X';
            
            dim = size(X);
            l   = X;
            p   = dim(1);
            n2  = n - ( 2 * p + 11 )/6;
            
            q       = p - d;
            l_avg   = sum( l(q+1:p) ) / (p-q);
            
            stat    = n2 * ( (p-q) * log(l_avg) - sum( log(l(q+1:p)) ) ); % test statistic from Jolliffe
            nu      = 0.5 * (p-q+2) * (p-q-1);                          % degrees of freedom of Chi-square distribution
            chi_val = chi2inv( (1-alpha) , nu);                        % alpha assumed to be 5% needs to be changed
            
            if( stat < chi_val )
                output = true;
            else
                output = false;
            end
            
          end
          
          % Modified version of Prof. Shankar Narasimhan's code
          function fres = obj_val1(evar,A,Sr, mapper)
              
              [ncon, nvar] = size(A);
              
              %  Calculate objective function value for every guess of the diagonal elements of
              %  square root of covariance matrix contained in vector evar
              
              fres = 0;
              
              L = mapper.m_mapVarianceToCovariance(evar);
              
              % Compute objective function value (based on joint pdf of constraint
              % residuals
              Vmat = A*L*L'*A';
              Vinv = inv(Vmat);
              fres = trace(Vinv*Sr) + log(det(Vmat));
          end
          
            
                      
        function cnc    = m_ConfigureConstraintNumberCalculatorForStatic(data, variance_model)
            
            nvar        = size(data.m_getData(), 1);
            cnc         = ConstraintNumberCalculator();
            
            cnc.m_setData(data');
            cnc.m_setVarianceModel(variance_model);
            cnc.m_setDMin(2);
            cnc.m_setDMax(nvar);
        end
        
        function cic    = m_ConfigureConfidenceIntervalCalculator(data, number_of_bootstraps, ...
                                                                  size_of_bootstraps, alpha)
            cic         = ConfidenceIntervalCalculator();
            cic.m_setData(data);
            cic.m_setNumberOfBootstraps(number_of_bootstraps);
            cic.m_setSizeOfBootstraps(size_of_bootstraps);
            cic.m_setAlphaValue(alpha);
        end
        
        function [covariance, ret_code] = m_ComputeNoiseCovarianceForGivenD(d_Data, d_val, d_VarianceModel)
            d_VarianceModel.m_setNoOfConstraints(d_val);
            [covariance, ret_code]      = d_VarianceModel.m_ComputeCovariance(d_Data, d_val);
        end
        
        function eig_vals   = m_ComputeEigenValuesGivenDataAndCovariance(d_Data, co_variance)
            eig_vals        = SysidUtils.m_ComputeEigenValuesforGivenDataAndCovariance(d_Data.m_getData(), co_variance);
        end
        
        function [eig_vals, ret_code]   = m_ComputeEigenvaluesForGivenD( d_Data, d_val, d_VarianceModel)
            
            %disp("OC_HypothesisTesting: m_ComputeEigenvaluesForGivenD")
            
            [co_variance, ret_code]     = SysidUtils.m_ComputeNoiseCovarianceForGivenD(d_Data, d_val, d_VarianceModel);
            
            if (ret_code == VarianceComputationStatusEnums.VARIANCE_COMPUTATION_FAILED_DUE_TO_UNKNOWN_REASON || ...
                ret_code == VarianceComputationStatusEnums.VARIANCE_COMPUTATION_FAILED_DUE_TO_NON_IDENTIFIABILITY)    
                eig_vals = [];
            else
                eig_vals                    = SysidUtils.m_ComputeEigenValuesGivenDataAndCovariance(d_Data, co_variance);
            end
            
        end
        
        function number_of_constraints = GetNumberofZerosInNoiselessCase(eig_values)
            %eig_values
            number_of_constraints = sum ( eig_values < XpcaConstants.NOISELESS_EIGENVALUE_TOLERANCE);
            
        end
        
        function model              = m_computeModelForStackedData(stacked_data, order, ...
                                                                   no_of_outputs, lag, ...
                                                                   variance_vec, vcv_mapper)
                                                               
            no_of_constraints       = no_of_outputs * ( lag  + 1 ) - order;
            
            if ( nargin == 6)                                                               
                vcv_mapper.m_setLag(lag);
                Qe                      = vcv_mapper.m_mapVarianceToCovariance(variance_vec);
                model                   = SysidUtils.m_computeConstraints(stacked_data, no_of_constraints, Qe);
            else
                model                   = SysidUtils.m_computeConstraints(stacked_data, no_of_constraints);
            end
            
        end
        
%         function model               = m_computeModelForStaticCaseConfInt(data, 
%         end
        
        
        function [number_of_constraints, eig_values] = m_computeNumberofConstraintsforNoiselessCase(d_Data)
            
            %Z = d_Data;
            Z              = d_Data.m_getData();
            dim            = size(Z,2);
            eig_values     = eig( Z*Z'/ dim);
            eig_values     = round(eig_values*(10^10))/(10^10);
            eig_values     = sort(eig_values, 'desc');
            number_of_constraints = nnz(~eig_values);
        end
        
%         function regression_model = m_ConvertConstraintModelToRegressionModel(model,order,OutputCols)
%             
%             num_of_var         = 1:size(model,2);
%             InputCols = num_of_var;
%             [X,Y] = ismember(output,num_var);
%             InputCols(Y(X)) = [];
%             model_trans = model';
%             modeloutput = model_trans(:,OutputCols);
%             modelinput  = model_trans(:,InputCols);
%             modeltransnew = [modeloutput,modelinput];
%             rref(modeltransnew)
%         end
                        %% EIV-KF implementation
        function [eps, ystr, ustr] = m_computeEivkfStateSpace(Data,Model,Variance)

        dim=size(Model);
        num = Model(1:dim/2);
        dem = Model(dim/2+1:end);
        sigma = Variance;
        u = Data(:,1);
        y = Data(:,2);
        %constraint_Mat = [];
        %iter=1;
        %for i=1:p
        %    if(ismember(i,constraint_instant(2,:)))                              %Taking the second row which has significant coefficients indexes
        %       constraint_Mat(i) = constraint_instant(1,iter);
        %       iter = iter+1;
        %    else
        %       constraint_Mat(i) = 0;
        %    end
        %end
        %dim=size(constraint_Mat); %dim size 1xN
        %dim=dim(2); %decide if 1 or 2
        %den=fliplr(constraint_Mat(1:dim/2)); %denominator for tf (y-coefficients)
        %num=fliplr(constraint_Mat(dim/2+1:end)); %numerator for tf (u-coefficients)
        %num=[];
        %den=[];



        %den=constraint_Mat(1:dim/2);      %denominator for tf (y-coefficients)
        %num=-constraint_Mat(dim/2+1:end); %numerator for tf (u-coefficients)

        [A,B,C,D]=tf2ss(num',dem');
        D=0;
        z=y-D*u;
        x0=ones(size(C,2),1);
        P0=eye(size(x0,1));
        eps=[];
        X=[];

        Q=B*sigma(2)*B';
        R=sigma(1)+(D*sigma(2)*D');
        S=B*sigma(2)*D';

        xt=x0;
        Pt=P0;

        for t=1:size(y,1)
            eps(t)=z(t)-C*xt;
            Sigeps=C*Pt*C'+R;
            Kt=[A*Pt*C'+S]/(Sigeps);

            xtemp=A*xt+B*u(t)+Kt*eps(t);
            xt=xtemp;
            X=[X xtemp];

            Ptemp=A*Pt*A'+Q-[A*Pt*C'+S]/(Sigeps)*[A*Pt*C'+S]';
            Pt=Ptemp;
        end

         ybar=sigma(1)/(Sigeps)*eps;
         ystr=y-ybar';

         ubar=-sigma(2)*D'/(Sigeps)*eps;
         ustr=u-ubar';

        % % Autocorrelation plot of the innovation sequence
        % 

        % acf=var(eps)*corr
        %Sigeps
        end
        
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
                        %% Preprocessing related Functions
        
    end
   
end

