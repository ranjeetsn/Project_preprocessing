classdef XpcaApi
    % This class provides the API for other functions to access the XPCA
    % code to compute static and dynamic models
    properties
    end

    methods (Static)
        
        % This function calculates the order, error variances and model for
        % the static case
        function [order, error_variances, model, ret_code] = m_ComputeStaticModel(data_obj, noise_model_type, ...
                                                                                  variances, variance_solver_type, ...
                                                                                  order, order_calculator_type)
            disp ("m_ComputeStaticModel ");
        end
        
        % This function calculates the order, error variances and model for
        % the dynamic case
        function [order, error_variances, model, ret_code] = m_ComputeDynamicModel(data_obj, noise_model_type, ...
                                                                                   lag, no_inputs, no_outputs, ...
                                                                                   variances, variance_solver_type, ...
                                                                                   order, order_calculator_type)
            disp ("m_ComputeDynamicModel");
        end
        
    end
end

