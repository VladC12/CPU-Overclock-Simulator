function varargout = Baza(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Baza_OpeningFcn, ...
                   'gui_OutputFcn',  @Baza_OutputFcn, ...
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


% --- Executes just before Baza is made visible.
function Baza_OpeningFcn(hObject, eventdata, handles, varargin)


% Choose default command line output for Baza
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

axes(handles.axes1)
matlabImage = imread('image.png');
image(matlabImage)
axis off
axis image

% UIWAIT makes Baza wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Baza_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton1_Callback(hObject, eventdata, handles)

open('Documentatie.pdf');

% --- Executes on button press in pushbutton3.
function pushbutton2_Callback(hObject, eventdata, handles)

close;
run('Secund.m');


% --- Executes on button press in pushbutton4.
function pushbutton3_Callback(hObject, eventdata, handles)

close;
