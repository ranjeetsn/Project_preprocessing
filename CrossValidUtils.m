classdef CrossValidUtils < handle
    methods(Static)
        function object = objectInfo(cursorLocation, handles)
            object = 0;
            for i = 1:20
                handle = eval(strcat('handles.pushbutton',num2str(i)));
                if (CrossValidUtils.Object(cursorLocation, handle) == 1)
                    object = handle;
                    return;
                end
            end
        end
        
        function object = Object(cursorLocation,handles)
            a = getpixelposition(handles);
            x = cursorLocation;
            if(x(1) >= a(1) && x(1) <=  (a(1)+a(3)) && x(2) >= a(2) && x(2) <= (a(2)+a(4)))
                object = 1;
            else
                object = 0;
            end
        end
        
        function type = objectType(Object, handles)
            type = 0;
            Type_data = [1:8];
            Type_model = [9:16];
            Type_workspace = [18];
            Type_working = [17];
            Type_Valid = [19];
            Type_trash = [20];

            for i = Type_data
                if(eval(strcat('handles.pushbutton',num2str(i))) == Object)
                    type = 1;
                    return;
                end
            end

            for i = Type_model
                if(eval(strcat('handles.pushbutton',num2str(i))) == Object)
                    type = 2;
                    return;
                end
            end

            for i = Type_workspace
                if(eval(strcat('handles.pushbutton',num2str(i))) == Object)
                    type = 3;
                    return;
                end
            end

            for i = Type_working
                if(eval(strcat('handles.pushbutton',num2str(i))) == Object)
                    type = 4;
                    return;
                end
            end

            for i = Type_Valid
                if(eval(strcat('handles.pushbutton',num2str(i))) == Object)
                    type = 5;
                    return;
                end
            end

            for i = Type_trash
                if(eval(strcat('handles.pushbutton',num2str(i))) == Object)
                    type = 6;
                    return;
                end
            end

        end
        
        function [residuals,Output, Input] = m_computeResidualsCrossValid(model, data)

            Data = data;
            Model = [model.Numerator model.Denominator]';
            %Model = model
            Variance = model.NoiseVariance;
            [residuals, Output, Input] = SysidUtils.m_computeEivkfStateSpace(Data, Model, Variance);
        end
         
        %m_createXPCAmodelObject()
        function model_object = m_createXPCAObject(Numerator, Denominator, Variable, IODelay, NoiseVariance, Report, Ts, TimeUnit, UserData, Name)
            
            model_object = xpcaModel(Numerator, Denominator, Variable, IODelay, NoiseVariance, Report,  Ts, TimeUnit, UserData, Name);
        end
        
        function model_object = m_createXPCAStaticObject(RegressionModel,NoiseVariance,Report,UserData,Name)
            
            model_object = xpcaStaticModel(RegressionModel,NoiseVariance,Report,UserData,Name);
        end
        
    end
end