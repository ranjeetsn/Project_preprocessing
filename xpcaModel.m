classdef xpcaModel<handle
    properties
        Numerator
        Denominator
        Variable = 'q^-1';
        IODelay = 0;
        NoiseVariance = [];
        Report
        Ts
        TimeUnit = 'seconds';
        UserData = [];
        Name
    end
    
    methods
        
    function obj = xpcaModel(varargin)
        
         try   
            if (~isempty(varargin{1}) && ~isempty(varargin{2}) && ~isempty(varargin{5}) && ~isempty(varargin{10}))

                obj.Numerator   = varargin{1};
                obj.Denominator = varargin{2};
                obj.NoiseVariance = varargin{5};
                obj.Name       = varargin{10};
                
%                 if(~isempty(varargin{4}))
%                     obj.IODelay = varargin{4};
%                 end
                
                 if(~isempty(varargin{4}))
                    obj.IODelay = varargin{4};
                 end
                
                 
                
                 if(~isempty(varargin{6}))
                    obj.Report = varargin{6};
                 end
                
                
                
                if(~isempty(varargin{7}))
                    obj.Ts = varargin{7};
                end
                
                if(~isempty(varargin{8}))
                    obj.TimeUnit = varargin{8};
                end
                
                if(~isempty(varargin{9}))
                    obj.UserData = varargin{9};
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