function varargout = A_123190046_ResponsiSCPK(varargin)
% A_123190046_RESPONSISCPK MATLAB code for A_123190046_ResponsiSCPK.fig
%      A_123190046_RESPONSISCPK, by itself, creates a new A_123190046_RESPONSISCPK or raises the existing
%      singleton*.
%
%      H = A_123190046_RESPONSISCPK returns the handle to a new A_123190046_RESPONSISCPK or the handle to
%      the existing singleton*.
%
%      A_123190046_RESPONSISCPK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in A_123190046_RESPONSISCPK.M with the given input arguments.
%
%      A_123190046_RESPONSISCPK('Property','Value',...) creates a new A_123190046_RESPONSISCPK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before A_123190046_ResponsiSCPK_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to A_123190046_ResponsiSCPK_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help A_123190046_ResponsiSCPK

% Last Modified by GUIDE v2.5 25-Jun-2021 14:56:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @A_123190046_ResponsiSCPK_OpeningFcn, ...
                   'gui_OutputFcn',  @A_123190046_ResponsiSCPK_OutputFcn, ...
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


% --- Executes just before A_123190046_ResponsiSCPK is made visible.
function A_123190046_ResponsiSCPK_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user tabel (see GUIDATA)
% varargin   command line arguments to A_123190046_ResponsiSCPK (see VARARGIN)

% Choose default command line output for A_123190046_ResponsiSCPK
handles.output = hObject;
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = [1,3,4,5,6,7,8];
data = readmatrix('DATA RUMAH.xlsx', opts); %membaca file DATA RUMAH.xlsx kolom 1,3,4,5,6,7,8
set(handles.tabel, 'Data', data);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes A_123190046_ResponsiSCPK wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = A_123190046_ResponsiSCPK_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user tabel (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in proses.
function proses_Callback(hObject, eventdata, handles)
% hObject    handle to proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user tabel (see GUIDATA)
w = [0.3,0.2,0.23,0.1,0.07,0.1]; %bobot kriteria
k = [0, 1, 1, 1, 1, 1]; %jenis kriteria (1 untuk keuntungan, 0 untuk kerugian)
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = [3,4,5,6,7,8];
data = readmatrix('DATA RUMAH.xlsx', opts); %membaca file DATA RUMAH.xlsx

%tahapan 1. normalisasi matriks
%matriks m x n dengan ukuran sebanyak variabel data (input)
[m,n]=size(data); %matriks m x n dengan ukuran sebanyak variabel x(input)
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
Y=zeros (m,n); %membuat matriks Y, yang merupakan titik kosong

for j=1:n
    if (k(j)==1) %statement untuk kriteria dengan atribut keuntungan
        R(:,j)=data(:,j)./max(data(:,j)); %menghitung normalisasi kriteria jenis keuntungan
    else
        R(:,j)=min(data(:,j))./data(:,j); %menghitung normalisasi kriteria jenis biaya
    end
end

%tahapan kedua, proses perangkingan
for i=1:m
    V(i)= sum(w.*R(i,:));
end

B = sort(V, 'descend'); %sorting dari terbesar

opts2 = detectImportOptions('DATA RUMAH.xlsx');
opts2.SelectedVariableNames = (2);
rekomendasi = readmatrix('DATA RUMAH.xlsx', opts2); %membaca file DATA RUMAH.xlsx

for i=1:20 %mengambil data peringkat 1 sampai 20
    for j=1:m
        if(B(i) == V(j))
            rekomendasii(i) = rekomendasi(j);
            break;
        end
    end
end

set(handles.hasil, 'data', rekomendasii'); %mengatur value dari tabel hasil


% --- Executes during object creation, after setting all properties.
function tabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
