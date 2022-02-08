function varargout = CrossValidationGraphs(varargin)
% CROSSVALIDATIONGRAPHS MATLAB code for CrossValidationGraphs.fig
%      CROSSVALIDATIONGRAPHS, by itself, creates a new CROSSVALIDATIONGRAPHS or raises the existing
%      singleton*.
%
%      H = CROSSVALIDATIONGRAPHS returns the handle to a new CROSSVALIDATIONGRAPHS or the handle to
%      the existing singleton*.
%
%      CROSSVALIDATIONGRAPHS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CROSSVALIDATIONGRAPHS.M with the given input arguments.
%
%      CROSSVALIDATIONGRAPHS('Property','Value',...) creates a new CROSSVALIDATIONGRAPHS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CrossValidationGraphs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CrossValidationGraphs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CrossValidationGraphs

% Last Modified by GUIDE v2.5 09-Mar-2021 14:10:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CrossValidationGraphs_OpeningFcn, ...
                   'gui_OutputFcn',  @CrossValidationGraphs_OutputFcn, ...
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


% --- Executes just before CrossValidationGraphs is made visible.
function CrossValidationGraphs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CrossValidationGraphs (see VARARGIN)

% Choose default command line output for CrossValidationGraphs
handles.output = hObject;

model_name     = varargin{1};
predicted_data = varargin{2};

model_no = size(varargin{1});
model_no = model_no(2);



color = [];
fit = [];
% predicted_data(1:end,1)
% predicted_data(1:end,2)

%handles
for i = 1:model_no
    plotted = plot(handles.axes1,predicted_data(1:end,i));
    
    color = get(plotted,'Color');
    text_object = eval(strcat('handles.text',num2str(i+1)));
    if(i~=1)
        cost_func = 'NRMSE';
        fit = round(goodnessOfFit(predicted_data(1:end,i), predicted_data(1:end,1), cost_func)*100,2);
        model_name_char = char(model_name(i));
        name_size = size(model_name_char);
        if(name_size(2)<17)
            text_object.String = strcat(strcat(model_name(i),':'),num2str(fit));
        else
            
            text_object.String = strcat(strcat(model_name_char(1:17),'...:'),num2str(fit));
        end
    else
        text_object.String = model_name(i);
    end
    %fit
    %text_object.String = model_name(i);
    
    text_object.ForegroundColor = color;
    hold on
end

%color
hold off

if(model_no == 1)
    warndlg('No model loaded. Only loaded data will be plotted.')
end
%handles.text1.ForegroundColor = color(1,1:end);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CrossValidationGraphs wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CrossValidationGraphs_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%hObject.ForegroundColor = handles.color;
handles.text1 = hObject;


% --- Executes during object creation, after setting all properties.
function text3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.text2 = hObject;


% --- Executes during object creation, after setting all properties.
function text4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.text3 = hObject;


% --- Executes during object creation, after setting all properties.
function text5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.text4 = hObject;


% --- Executes during object creation, after setting all properties.
function text6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.text5 = hObject;


% --- Executes during object creation, after setting all properties.
function text7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.text6 = hObject;


% --- Executes during object creation, after setting all properties.
function text8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.text7 = hObject;


% --- Executes during object creation, after setting all properties.
function text9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.text8 = hObject;


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = 'Please enter the file name:';
fileName = input(prompt,'s');
filename1 = [fileName,'.png'];
saveas(handles.axes1,filename1)
