function varargout = morse_code_translator(varargin)
% MORSE_CODE_TRANSLATOR MATLAB code for morse_code_translator.fig
%      MORSE_CODE_TRANSLATOR, by itself, creates a new MORSE_CODE_TRANSLATOR or raises the existing
%      singleton*.
%
%      H = MORSE_CODE_TRANSLATOR returns the handle to a new MORSE_CODE_TRANSLATOR or the handle to
%      the existing singleton*.
%
%      MORSE_CODE_TRANSLATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MORSE_CODE_TRANSLATOR.M with the given input arguments.
%
%      MORSE_CODE_TRANSLATOR('Property','Value',...) creates a new MORSE_CODE_TRANSLATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before morse_code_translator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to morse_code_translator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help morse_code_translator

% Last Modified by GUIDE v2.5 19-Apr-2021 17:57:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @morse_code_translator_OpeningFcn, ...
                   'gui_OutputFcn',  @morse_code_translator_OutputFcn, ...
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


% --- Executes just before morse_code_translator is made visible.
function morse_code_translator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to morse_code_translator (see VARARGIN)

% Choose default command line output for morse_code_translator
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes morse_code_translator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = morse_code_translator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function input_Callback(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input as text
%        str2double(get(hObject,'String')) returns contents of input as a double


% --- Executes during object creation, after setting all properties.
function input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in translate.
function translate_Callback(hObject, eventdata, handles)
% hObject    handle to translate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Warning dialogue
select= get(handles.language,'Value');
if select == 1
    warndlg('Please select a language.','Warning')
    set(handles.play,'Visible','off')
end

%Input and ouput
morse = {'.-','-...','-.-.','-..','.','..-.','--.',...
         '....','..','.---','-.-','.-..','--','-.','---',...
         '.--.','--.-','.-.','...','-','..-','...-','.--','-..-','-.--','--..',...
         '.----','..---','...--','....-','.....','-....','--...','---..',...
         '----.','-----','.-.-.-','/',''};
letter = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',...
          'Q','R','S','T','U','V','W','X','Y','Z','1','2','3','4','5','6','7','8','9','0','STOP',' ',''};
count=0;
if select==2
    set(handles.play,'Visible','off')
    eng= upper(get(handles.input,'String'));
    if isempty(eng)
        errordlg('No input!','Error!')
    end
    if strcmp(eng,'STOP')
        set(handles.text,'String', '.-.-.-')
    else
        message = '';
        for k=1:length(eng)
            character = eng(k);
            [~, idx] = ismember(character, letter);
            if idx == ~length(letter)
                errordlg('Enter letters or numbers only.','Error!')
                set(handles.input,'String', 'Enter your message here')
                set(handles.text,'String', 'Translation')
                set(handles.word_count,'String','')
                return
            else
                if ~isempty(idx)
                    message = [message morse(idx) ' '];
                end
                if character ~= ' '
                    count = count + 1;
                end
            end
        end
        o= string(message);
        i='';
        for k=1:length(message)
            i=i+o(k);
        end
        set(handles.text,'String', i);
        set(handles.word_count,'String',count)
        set(handles.play,'Visible','on')
    end
end

if select==3
    set(handles.play,'Visible','off')
    code= split(strcat(get(handles.input,'String')));
    if isempty(get(handles.input,'String'))
        errordlg('No input!','Error!')
    end
    message = '';
    for k=1:length(code)
        character = code(k);
        [~, idx] = ismember(character, morse);
         if idx == ~length(morse)
            errordlg('Enter morse code only.','Error!')
            set(handles.input,'String', 'Enter your message here')
            set(handles.text,'String', 'Translation')
            set(handles.word_count,'String','')
            return
        else
            if ~isempty(idx)
                message = [message letter(idx)];
            end
         end
    end
    o= string(message);
    i='';
    for k=1:length(message)
        i=i+o(k);
        if o(k) ~= ' ' 
            count = count + 1;
        end
    end
    count=count-1;
    set(handles.text,'String', i);
    set(handles.word_count,'String',count)
    set(handles.play,'Visible','on')
end

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

button=questdlg('Are you sure you want to reset the messages?','Reset?','Yes','No','Yes');
 
    if strcmp(button,'No')
            
    else
        set(handles.language,'Value',1)
        set(handles.language_title,'String','')
        set(handles.input,'String','Enter your message here')
        set(handles.text,'String','Translation')
        set(handles.word_count,'String','')
        set(handles.text,'FontSize',16)
        set(handles.input,'FontSize',14)
        set(handles.play,'Visible','off')

     end

% --- Executes on selection change in language.
function language_Callback(hObject, eventdata, handles)
% hObject    handle to language (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns language contents as cell array
%        contents{get(hObject,'Value')} returns selected item from language

select= get(handles.language,'Value');
guidata(hObject,handles)
if select==1
    set(handles.language_title,'String','')
end

if select==2
    set(handles.language_title,'String','Morse Code')
end

if select==3
   set(handles.language_title,'String','English')
end


% --- Executes during object creation, after setting all properties.
function language_CreateFcn(hObject, eventdata, handles)
% hObject    handle to language (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function background_color_Callback(hObject, eventdata, handles)
% hObject    handle to background_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function none_Callback(hObject, eventdata, handles)
% hObject    handle to none (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.figure1,'Color','[0.94 0.94 0.94]')
set(handles.title,'BackgroundColor','[0.94 0.94 0.94]')
set(handles.word_count_title,'BackgroundColor','[0.94 0.94 0.94]')
set(handles.word_count,'BackgroundColor','[0.94 0.94 0.94]')
set(handles.title,'ForegroundColor','k')
set(handles.word_count_title,'ForegroundColor','k')
set(handles.word_count,'ForegroundColor','k')

% --------------------------------------------------------------------
function red_Callback(hObject, eventdata, handles)
% hObject    handle to red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.figure1,'Color','#ff6961')
set(handles.title,'BackgroundColor','#ff6961')
set(handles.word_count_title,'BackgroundColor','#ff6961')
set(handles.word_count,'BackgroundColor','#ff6961')
set(handles.title,'ForegroundColor','k')
set(handles.word_count_title,'ForegroundColor','k')
set(handles.word_count,'ForegroundColor','k')

% --------------------------------------------------------------------
function yellow_Callback(hObject, eventdata, handles)
% hObject    handle to yellow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.figure1,'Color','#fdfd96')
set(handles.title,'BackgroundColor','#fdfd96')
set(handles.word_count_title,'BackgroundColor','#fdfd96')
set(handles.word_count,'BackgroundColor','#fdfd96')
set(handles.title,'ForegroundColor','k')
set(handles.word_count_title,'ForegroundColor','k')
set(handles.word_count,'ForegroundColor','k')

% --------------------------------------------------------------------
function new_Callback(hObject, eventdata, handles)
% hObject    handle to new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.language,'Value',1)
set(handles.language_title,'String','')
set(handles.word_count,'String','')
set(handles.input,'String','Enter your message here')
set(handles.text,'String','Translation')
set(handles.figure1,'Color','[0.94 0.94 0.94]')
set(handles.title,'BackgroundColor','[0.94 0.94 0.94]')
set(handles.word_count_title,'BackgroundColor','[0.94 0.94 0.94]')
set(handles.word_count,'BackgroundColor','[0.94 0.94 0.94]')
set(handles.title,'ForegroundColor','k')
set(handles.word_count_title,'ForegroundColor','k')
set(handles.word_count,'ForegroundColor','k')
set(handles.text,'FontSize',16)
set(handles.input,'FontSize',14)
set(handles.play,'Visible','off')


% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq();

% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function print_Callback(hObject, eventdata, handles)
% hObject    handle to print (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

f = getframe(gcf); 
toShow = figure('Visible','off'); 
warning('off','images:initSize:adjustingMag') 
imshow(f.cdata); 
warning('on','images:initSize:adjustingMag') 
set(toShow,'PaperOrientation','landscape',...
           'PaperUnits','normalized','PaperPosition',[0,0,1,1]); 
printdlg(toShow); 
close(toShow) 

% --------------------------------------------------------------------
function png_Callback(hObject, eventdata, handles)
% hObject    handle to png (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

orient landscape
file = uiputfile('*.png');
print(file, '-dpng');

% --------------------------------------------------------------------
function jpg_Callback(hObject, eventdata, handles)
% hObject    handle to jpg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

orient landscape
file = uiputfile('*.jpeg');
print(file, '-djpeg');

% --------------------------------------------------------------------
function pdf_Callback(hObject, eventdata, handles)
% hObject    handle to pdf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

orient landscape
file = uiputfile('*.pdf');
print(file, '-dpdf');


% --------------------------------------------------------------------
function blue_Callback(hObject, eventdata, handles)
% hObject    handle to blue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.figure1,'Color','#aec6cf')
set(handles.title,'BackgroundColor','#aec6cf')
set(handles.word_count_title,'BackgroundColor','#aec6cf')
set(handles.word_count,'BackgroundColor','#aec6cf')
set(handles.title,'ForegroundColor','k')
set(handles.word_count_title,'ForegroundColor','k')
set(handles.word_count,'ForegroundColor','k')

% --------------------------------------------------------------------
function green_Callback(hObject, eventdata, handles)
% hObject    handle to green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.figure1,'Color','#77dd77')
set(handles.title,'BackgroundColor','#77dd77')
set(handles.word_count_title,'BackgroundColor','#77dd77')
set(handles.word_count,'BackgroundColor','#77dd77')
set(handles.title,'ForegroundColor','k')
set(handles.word_count_title,'ForegroundColor','k')
set(handles.word_count,'ForegroundColor','k')

% --------------------------------------------------------------------
function black_Callback(hObject, eventdata, handles)
% hObject    handle to black (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.figure1,'Color','k')
set(handles.title,'BackgroundColor','k')
set(handles.word_count_title,'BackgroundColor','k')
set(handles.word_count,'BackgroundColor','k')
set(handles.title,'ForegroundColor','w')
set(handles.word_count_title,'ForegroundColor','w')
set(handles.word_count,'ForegroundColor','w')

% --------------------------------------------------------------------
function other_color_Callback(hObject, eventdata, handles)
% hObject    handle to other_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
color= uisetcolor([0.94 0.94 0.94],'Select a color');
set(handles.title,'ForegroundColor','k')
set(handles.figure1,'Color',color)
set(handles.title,'BackgroundColor',color)
set(handles.word_count_title,'BackgroundColor',color)
set(handles.word_count,'BackgroundColor',color)
guidata(hObject, handles);


% --------------------------------------------------------------------
function faq_Callback(hObject, eventdata, handles)
% hObject    handle to faq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
international={'International Morse Code',['A .-','        ','N -.','        ','1 .----'],...
         ['B -...','      ','O ---','       ','2 ..---'],['C -.-.','      ','P .--.','      ','3 ...--'],...
         ['D -..','       ','Q --.-','      ','4 ....-'],['E .','         ','R .-.','        ','5 .....'],...
         ['F ..-.','      ','S ...','        ','6 -....'],['G --.','      ','T -','          ','7 --...'],...
         ['H ....','     ',' U ..-','       ','8 ---..'],['I ..','         ',' V ...-','      ','9 ----.'],...
         ['J .--- ','    ',' W .--','       ','0 -----'],['K -.- ','     ',' X -..-','       ','  /'],...
         ['L .-.. ','    ',' Y -.--'],['M -- ','     ',' Z --..'],};
helpdlg(international,'FAQ');
     


% --------------------------------------------------------------------
function copynpaste1_Callback(hObject, eventdata, handles)
% hObject    handle to copynpaste1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function paste1_Callback(hObject, eventdata, handles)
% hObject    handle to paste1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents= clipboard('paste');
old_contents= get(handles.input,'string');
total= string(old_contents) + ' ' + string(contents);
set(handles.input,'string',total)

% --------------------------------------------------------------------
function copy1_Callback(hObject, eventdata, handles)
% hObject    handle to paste1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

c= get(handles.input,'String');
clipboard('copy',c);

% --------------------------------------------------------------------
function bg_color_Callback(hObject, eventdata, handles)
% hObject    handle to bg_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
color= uisetcolor([0.94 0.94 0.94],'Select a color');
set(handles.title,'ForegroundColor','k')
set(handles.figure1,'Color',color)
set(handles.title,'BackgroundColor',color)
set(handles.word_count_title,'BackgroundColor',color)
set(handles.word_count,'BackgroundColor',color)
guidata(hObject, handles);

% --------------------------------------------------------------------
function set_color_Callback(hObject, eventdata, handles)
% hObject    handle to set_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function clear1_Callback(hObject, eventdata, handles)
% hObject    handle to clear1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.input,'String','')

% --------------------------------------------------------------------
function copy2_Callback(hObject, eventdata, handles)
% hObject    handle to copy2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c= get(handles.text,'String');
clipboard('copy',c);

% --------------------------------------------------------------------
function paste2_Callback(hObject, eventdata, handles)
% hObject    handle to paste2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents= clipboard('paste');
old_contents= get(handles.text,'string');
total= string(old_contents) + ' ' + string(contents);
set(handles.text,'string',total)

% --------------------------------------------------------------------
function clear2_Callback(hObject, eventdata, handles)
% hObject    handle to clear2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text,'String','')

% --------------------------------------------------------------------
function copynpaste2_Callback(hObject, eventdata, handles)
% hObject    handle to copynpaste2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function font_size1_Callback(hObject, eventdata, handles)
% hObject    handle to font_size1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function small1_Callback(hObject, eventdata, handles)
% hObject    handle to small1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.input,'FontSize',11)

% --------------------------------------------------------------------
function medium1_Callback(hObject, eventdata, handles)
% hObject    handle to medium1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.input,'FontSize',14)

% --------------------------------------------------------------------
function large1_Callback(hObject, eventdata, handles)
% hObject    handle to large1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.input,'FontSize',20)


% --------------------------------------------------------------------
function font_size2_Callback(hObject, eventdata, handles)
% hObject    handle to font_size2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function small2_Callback(hObject, eventdata, handles)
% hObject    handle to small2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text,'FontSize',12)

% --------------------------------------------------------------------
function medium2_Callback(hObject, eventdata, handles)
% hObject    handle to medium2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text,'FontSize',16)

% --------------------------------------------------------------------
function large2_Callback(hObject, eventdata, handles)
% hObject    handle to large2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text,'FontSize',20)


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

select= get(handles.language,'Value');
if select==2
    code= get(handles.text,'String');
    
    for k=1:length(code)
        character = string(code(k));
            if character == '.'
            pause_time = 0.1;
            elseif character == '-'
                pause_time = 0.3;
            elseif character == ' '
                pause_time = 0.2;
            elseif character == '/'
                pause_time = 0.4;
            else
                pause_time = 0;
            end
            
            if character == '.' || character == '-'
             set(handles.title,'String','')
             pause(pause_time);
            end

             set(handles.title,'String','Morse Code Translator')
             pause(pause_time);
     end
end

if select==3
    code= get(handles.input,'String');
    
    for k=1:length(code)
        character = string(code(k));
            if character == '.'
                pause_time = 0.1;
            elseif character == '-'
                pause_time = 0.3;
            elseif character == ' '
                pause_time = 0.2;
            elseif character == '/'
                pause_time = 0.4;
            else
                pause_time = 0;
            end
            
            if character == '.' || character == '-'
             set(handles.title,'String','')
             pause(pause_time);
            end
             
             set(handles.title,'String','Morse Code Translator')
             pause(pause_time);
     end
end
