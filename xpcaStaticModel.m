classdef xpcaStaticModel<handle
    properties
        RegressionModel
        NoiseVariance = [];
        Report
        UserData = [];
        Name
    end
    
    methods
        
    function obj = xpcaStaticModel(varargin)
        
         try   
            if (~isempty(varargin{1}) && ~isempty(varargin{2}) &&  ~isempty(varargin{5}))

                obj.RegressionModel = varargin{1};
                obj.NoiseVariance = varargin{2};
                obj.Name          = varargin{5};
                
                if(~isempty(varargin{3}))
                    obj.Report = varargin{3};
                end
                
                if(~isempty(varargin{4}))
                    obj.UserData = varargin{4};
                end
                                     
            end
            
            
        catch
            ME = MException('MyComponent:InsufficientArguments',...
                'Please Enter Numerator and Denominator of Transfer function');
            throw(ME)
        end

    end
        
    end
end