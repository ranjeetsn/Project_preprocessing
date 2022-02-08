
function varargout = CrossValidationApp(varargin)
% CROSSVALIDATIONAPP MATLAB code for CrossValidationApp.fig
%      CROSSVALIDATIONAPP, by itself, creates a new CROSSVALIDATIONAPP or raises the existing
%      singleton*.
%
%      H = CROSSVALIDATIONAPP returns the handle to a new CROSSVALIDATIONAPP or the handle to
%      the existing singleton*.
%
%      CROSSVALIDATIONAPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CROSSVALIDATIONAPP.M with the given input arguments.
%
%      CROSSVALIDATIONAPP('Property','Value',...) creates a new CROSSVALIDATIONAPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CrossValidationApp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CrossValidationApp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CrossValidationApp

% Last Modified by GUIDE v2.5 09-Mar-2021 05:54:14

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CrossValidationApp_OpeningFcn, ...
                   'gui_OutputFcn',  @CrossValidationApp_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before CrossValidationApp is made visible.
function CrossValidationApp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CrossValidationApp (see VARARGIN)
if(isempty(handles.pushbutton19.UserData))
    handles.pushbutton21.Enable = 'off';
else
    handles.pushbutton21.Enable = 'on';
end

% Choose default command line output for CrossValidationApp
%handles.main_app_var   = varargin{1};
handles.main_app_data  = varargin{1};
%handles.main_app_model = varargin{3};

model_XPCA = varargin{2};
% n = size(model_XPCA);
% numerator = model_XPCA(1:n(1)/2);
% denominator = model_XPCA(n(1)/2+1:n(1));
% model_XPCA = idtf(numerator',denominator');


%model_XPCA.Name = 'CurrentSession Model';
% model_XPCA.UserData = 'XPCA';
handles.main_app_model = model_XPCA;

handles.output = hObject;

for i= 1:19
    button = eval(strcat('handles.pushbutton',num2str(i))); 
    button.CData = imread('Empty.png');
end

GrabPointer = load('Grabpointer.mat');
handles.GrabPointer = GrabPointer.cdata;
PickPointer = load('Pickpointer.mat');
handles.PickPointer = PickPointer.cdata;

handles.pushbutton16.UserData = model_XPCA;
handles.pushbutton16.String = model_XPCA.Name;
handles.dragStatus = 0;
%set(gcf, 'Pointer', 'custom','PointerShapeCData',GrabPointer);
%handles.pushbutton1.CData = imread('Empty.png');
% Update handles structure
% currPos = get(gcf,'CurrentPoint');
% tester = CrossValidUtils.tester
%handles.axes1
guidata(hObject, handles);

% UIWAIT makes CrossValidationApp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CrossValidationApp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if(hObject.Value == 2)
    hObject.Value = 1;
    [file,path] = uigetfile('*.mat');
    filename = fullfile(path, file);

    S = load(filename);
    handles.S = S;
    names = fieldnames(S);
    %handles.pushbutton1.String = names;
    %S.(names{1})
    
    
    for i=1:8
        button = eval(strcat('handles.pushbutton',num2str(i)));
        if(isempty(button.String) == 1)
            if(isempty(handles.pushbutton19.UserData) == 1) %isempty(handles.pushbutton17.UserData) == 1 && 
                %handles.pushbutton17.String = names;
                handles.pushbutton19.String = names;
                %handles.pushbutton17.UserData = S.(names{1});
                handles.pushbutton19.UserData = S.(names{1});
                %handles.dataWorking = button;
                handles.dataValid   = button;
                guidata(hObject, handles);
            end
            button.String = names;
            button.UserData = S.(names{1});
            if(isempty(handles.pushbutton19.UserData))
                handles.pushbutton21.Enable = 'off';
            else
                handles.pushbutton21.Enable = 'on';
            end
            return;
        end
    end
    warndlg('Cannot load more than 8 datasets. Please remove data to load new datasets.');
end


% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% set(hObject,'toolbar','figure');
% a = findall(gcf);
% b = findall(a,'ToolTipString','Save Figure');
% set(b,'Visible','Off')
% c = findall(a,'ToolTipString','Insert Legend');
% set(c,'Visible','Off')
% a


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(hObject.Value == 2)
    hObject.Value = 1;
    [file,path] = uigetfile('*.mat');
    filename = fullfile(path, file);

    S = load(filename);
    handles.S = S;
    names = fieldnames(S);
    %handles.pushbutton1.String = names;
%     S.(names{1}).UserData;
    
    for i=16:-1:9
        button = eval(strcat('handles.pushbutton',num2str(i)));
        if(isempty(button.String) == 1)
%             if(isempty(handles.pushbutton17.UserData) == 1 && isempty(handles.pushbutton19.UserData) == 1)
%                 handles.pushbutton17.String = names;
%                 handles.pushbutton19.String = names;
%                 handles.pushbutton17.UserData = S.(names{1});
%                 handles.pushbutton19.UserData = S.(names{1});
%                 handles.dataWorking = button;
%                 handles.dataValid   = button;
%                 guidata(hObject, handles);
%             end
            button.String = names;
            button.UserData = S.(names{1});
            return;
        end
    end
    warndlg('Cannot load more than 8 Models. Please remove data to load new Models.');
end
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% % --- Executes during object creation, after setting all properties.
% function axes1_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to axes1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% handles.axes1 = hObject;
% guidata(hObject,handles)
% imshow('Arrow_right.png')
% % Hint: place code in OpeningFcn to populate axes1



% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hObject.CData = imread('Trashcan empty.png');



% % --- Executes during object creation, after setting all properties.
% function axes3_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to axes3 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% imshow('Arrow_down.png');
% % Hint: place code in OpeningFcn to populate axes3


% % --- Executes during object creation, after setting all properties.
% function axes4_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to axes4 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% imshow('Arrow_down.png');
% % Hint: place code in OpeningFcn to populate axes4


% % --- Executes during object creation, after setting all properties.
% function axes2_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to axes2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% imshow('Arrow_down.png');
% % Hint: place code in OpeningFcn to populate axes2


% % --- Executes during object creation, after setting all properties.
% function axes5_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to axes5 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% imshow('Arrow_up.png');
% % Hint: place code in OpeningFcn to populate axes5


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
currPos = get(gcf,'CurrentPoint');
handles.Initial_Object = CrossValidUtils.objectInfo(currPos,handles);
%test = CrossValidUtils.CrossValidUtils.objectInfo(currPos,handles)
%handles.dragStatus
handles.dragStatus = 1;
guidata(hObject,handles)

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles.pushbutton20.CData = imread('Trashcan empty.png');
% getpixelposition(handles.pushbutton1)
currPos = get(gcf,'CurrentPoint');
handles.dragStatus = 0;
Final_Object = CrossValidUtils.objectInfo(currPos,handles);
Initial_Object = handles.Initial_Object;

a = CrossValidUtils.objectType(Initial_Object,handles);
%CrossValidUtils.CrossValidUtils.objectType(Initial_Object,handles)
b = CrossValidUtils.objectType(Final_Object,handles);


guidata(hObject,handles)

if(a == 1 && b == 1)    
    final_string    = Final_Object.String;
    final_userdata  = Final_Object.UserData;
    Final_Object.String = Initial_Object.String;
    Final_Object.UserData = Initial_Object.UserData;
    Initial_Object.String = final_string;
    Initial_Object.UserData = final_userdata;
    
%     if(Initial_Object == handles.dataWorking)
%         handles.dataWorking = Final_Object;   
%         guidata(hObject,handles)
%     end
    
    if(Initial_Object == handles.dataValid)
        handles.dataValid   = Final_Object;
        guidata(hObject,handles)
    end
elseif(a == 2 && b == 2)
    final_string    = Final_Object.String;
    final_userdata  = Final_Object.UserData;
    Final_Object.String = Initial_Object.String;
    Final_Object.UserData = Initial_Object.UserData;
    Initial_Object.String = final_string;
    Initial_Object.UserData = final_userdata;
elseif(a == 1 && b == 3)
    
    
% elseif(a == 1 && b == 4)
%     Final_Object.String = Initial_Object.String;
%     Final_Object.UserData = Initial_Object.UserData;
%     handles.dataWorking = Initial_Object;   
%     guidata(hObject,handles)
elseif(a == 1 && ismember(b,5))
    Final_Object.String = Initial_Object.String;
    Final_Object.UserData = Initial_Object.UserData;
    handles.dataValid   = Initial_Object;
    guidata(hObject,handles)
elseif(ismember(a,[1,2]) && ismember(b,6))
%     handles.dataWorking
%     Initial_Object
%     handles.dataValid
    if( Initial_Object ~= handles.dataValid) %Initial_Object ~= handles.dataWorking &&
        Initial_Object.String = '';
        Initial_Object.UserData = [];
        handles.pushbutton20.CData = imread('Trashcan full.png');
    elseif(Initial_Object == handles.dataValid) %Initial_Object == handles.dataWorking || 
        warndlg('The data you are throwing away is Validation data. Please replace these before you delete it.')
    end
end




% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function pushbutton2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
currPos = get(gcf,'CurrentPoint');
GrabPointer = handles.GrabPointer;
PickPointer = handles.PickPointer;
%handles.dragStatus
% if()
%     
% elseif(handles.dragStatus == 0)
%     set(gcf,'pointer','arrow');
% end

object = CrossValidUtils.objectInfo(currPos,handles);
object_type = CrossValidUtils.objectType(object,handles);

if((object_type == 1 || object_type == 2) && handles.dragStatus == 0 && ~isempty(object.UserData))
    set(gcf, 'Pointer', 'custom','PointerShapeCData',PickPointer);
elseif(handles.dragStatus == 1)
    set(gcf, 'Pointer', 'custom','PointerShapeCData',GrabPointer);
elseif(handles.dragStatus == 0)
    set(gcf,'pointer','arrow');
end


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(~isempty(handles.pushbutton19.UserData))
    data           = handles.pushbutton19.UserData;
    %handles.pushbutton16.UserData.UserData
    model_name     = handles.pushbutton19.String;
    predicted_data = data(:,2);
    
    for i = 16:-1:9
        model = strcat(strcat('handles.pushbutton',num2str(i)),'.UserData');
        model = eval(model);
        
     if(~isempty(model))
         
        %if(~isempty(model.UserData))
            if(strcmp(model.UserData,'XPCA'))

                [~,predictdata,~] = CrossValidUtils.m_computeResidualsCrossValid(model,data);
                 model_name{end+1} = model.Name;
                 predicted_data = [predicted_data predictdata];
            else
                %model
                %modelField = fieldnames(model.UserData)  
                data_invert(:,1)=data(:,2);
                data_invert(:,2)=data(:,1);
                predictdata = predict(model,data_invert);
                model_name{end+1} = model.Name;
                predicted_data = [predicted_data predictdata];
                 
            end
        %end
     end
    end
    
    CrossValidationGraphs(model_name, predicted_data)
     
else
    handles.pushbutton21.Enable = 'off';
end
%predictdata


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hObject.CData = imread('Arrow_down.png');


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hObject.CData = imread('Arrow_right.png');


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hObject.CData = imread('Arrow_right.png');


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hObject.CData = imread('Arrow_down.png');


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hObject.CData = imread('Arrow_down.png');


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hObject.CData = imread('Arrow_down.png');


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
