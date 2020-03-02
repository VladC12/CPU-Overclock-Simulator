function varargout = Second(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Second_OpeningFcn, ...
                   'gui_OutputFcn',  @Second_OutputFcn, ...
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


% --- Executes just before Second is made visible.
function Second_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for Second
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

fontSize=8;
% First for the first axes:
axes(handles.AxesTemps);
xlabel('Time in Minutes', 'FontSize', fontSize);
ylabel('Temperature', 'FontSize', fontSize);

% Now for the second axes:
axes(handles.AxesFreq);
xlabel('Time in Minutes', 'FontSize', fontSize);
ylabel('Frequency', 'FontSize', fontSize);


% UIWAIT makes Second wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Second_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in StartButon.
function StartButon_Callback(hObject, eventdata, handles)
axes(handles.AxesFreq);
time=str2double(get(handles.mintime,'String')):1:str2double(get(handles.maxtime,'String'));
 assignin('base','time',time);
for i=1:str2double(get(handles.maxtime,'String'))-str2double(get(handles.mintime,'String'))+1
    if str2double(get(handles.VoltageEditText,'String')) > 0.9 && str2double(get(handles.VoltageEditText,'String')) <4.0
    Freq(i)=str2double(get(handles.MultiplierTextEdit,'String'))*(str2double(get(handles.BusEditText,'String'))/1000)+rand(1);
    elseif str2double(get(handles.VoltageEditText,'String')) < 0.9
        Freq(i)=(str2double(get(handles.BusEditText,'String'))/1000)-rand(1);
    else
         Freq(i)=str2double(get(handles.MultiplierTextEdit,'String'))*(str2double(get(handles.BusEditText,'String'))/1000)+1 + (3-1).*rand(1);
    end
end
 assignin('base','Freq',Freq);
plot(time,Freq,'.-');
fontSize=8;
xlabel('Time in Minutes', 'FontSize', fontSize);
xlim([str2double(get(handles.mintime,'String')) str2double(get(handles.maxtime,'String'))]);
ylabel('Frequency GHz', 'FontSize', fontSize);
ylim([0 7]);

popup_sel_index = get(handles.CoolingPop, 'Value');
switch popup_sel_index
    case 1
        err = errordlg('Choose a cooler. You cannot run with no cooling!','No cooler selected!');
        uiwait(err);
    return
    case 2
        cool=0.8;
        assignin('base','cool',cool);
    case 3
        cool=0.5;    
        assignin('base','cool',cool);
    case 4
        cool=0.3;
        assignin('base','cool',cool);
    case 5
        cool=0.1;
        assignin('base','cool',cool); 
end

axes(handles.AxesTemps);
den = 2.^([str2double(get(handles.mintime,'String')):str2double(get(handles.maxtime,'String'))]-1);
 if str2double(get(handles.VoltageEditText,'String')) > 0.9 && str2double(get(handles.VoltageEditText,'String')) <4.0
    Temp =1./den+rand(1)*cool;
    elseif str2double(get(handles.VoltageEditText,'String')) < 0.9
       Temp =1./den+rand(1)*cool*0.1;
    else
         Temp =1+1./den+rand(1)*cool;
 end
Temp(1)=20;

assignin('base','Temp',Temp);
plot(cumsum(Temp),'.-');
fontSize=8;
xlim([str2double(get(handles.mintime,'String')) str2double(get(handles.maxtime,'String'))]);
xlabel('Time in Minutes', 'FontSize', fontSize);
ylim([20 inf]);
ylabel('Temperature', 'FontSize', fontSize);

if str2double(get(handles.MultiplierTextEdit,'String')) < 1
    err = errordlg('Multiplier must be bigger than 0!','Wrong Parameters');
    uiwait(err);
    return
end
if str2double(get(handles.BusEditText,'String')) < 1
    err = errordlg('Bus Frequency must be bigger than 0!','Wrong Parameters');
    uiwait(err);
    return
end
if (str2double(get(handles.BusEditText,'String'))/1000)*str2double(get(handles.MultiplierTextEdit,'String')) > 6
    err = errordlg('Incorrect Values. Use lower frequency or multiplier!','Wrong Parameters');
    uiwait(err);
    return
end
if str2double(get(handles.VoltageEditText,'String')) > 5
    err = errordlg('Input Voltage is too high!','Wrong Parameters');
    uiwait(err);
    return
end



% --- Executes on selection change in CoolingPop.
function CoolingPop_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function CoolingPop_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MultiplierTextEdit_Callback(hObject, eventdata, handles)
userMultiplier = str2double(get(handles.MultiplierTextEdit,'String'));
assignin('base','userMultiplier',userMultiplier);
% --- Executes during object creation, after setting all properties.
function MultiplierTextEdit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function BusEditText_Callback(hObject, eventdata, handles)
userBus = str2double(get(handles.BusEditText,'String'));
assignin('base','userBus',userBus);

% --- Executes during object creation, after setting all properties.
function BusEditText_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function VoltageEditText_Callback(hObject, eventdata, handles)
userVoltage = str2double(get(handles.VoltageEditText,'String'));
assignin('base','userVoltage',userVoltage);
% --- Executes during object creation, after setting all properties.
function VoltageEditText_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BackButon.
function BackButon_Callback(hObject, eventdata, handles)
% hObject    handle to BackButon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;
run('Baza.m');



function mintime_Callback(hObject, eventdata, handles)

min = str2double(get(handles.mintime,'String'));

% --- Executes during object creation, after setting all properties.
function mintime_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxtime_Callback(hObject, eventdata, handles)

 max = str2double(get(handles.maxtime,'String'));

% --- Executes during object creation, after setting all properties.
function maxtime_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Questoin.
function Questoin_Callback(hObject, eventdata, handles)

run('questions.m');
