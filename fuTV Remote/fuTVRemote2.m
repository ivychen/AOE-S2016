% fuTV (ex-Wildcats) |  AOE Spring 2106
% Ivy Chen
% Shannon Diesch
% Sameer Jain
% Bryan Lei
%
% This is the mid-fidelity prototype of the fuTV Remote.
% This prototype presents the general user interface, with button layouts
% and a scaled verion of the remote face itself.
% The UI was designed with the user, an elderly media consumer who
% occasionally has difficulty with controlling the television/dvd/vcr
% player. These are the key features of the UI:
%   - Buttons - there are bold, rectangular buttons that are fairly raised,
%   with sufficient spacing between buttons to distinguish each button
%   apart without glancing. The tactile keys firmly yield upon pressing to
%   give the user feedback and satisfaction that their action has been
%   recorded.
%   - Colors - the remote itself is a svelte, matte black design, resistant
%   to dust, and ergonomic in the hand. The buttons are color-coded as per
%   Gestalt's laws of grouping to make button navigation more intuitive.
%   (Note, the final product, after iterations may have the colors changed
%   once user research is conducted.)
%
% The UX, user experience, was designed to give enough feedback to the user
% to indicate what action is being performed, without cluttering up the
% screen. We opt for a simple approach to the mapping. The mappings
% correspond to different states (see variables below) that act as
% switches.
%
% Looking Forward:
% This prototype is still rudimentary, especially in terms of functionality.
% There are several improvements to make over our current
% version.
%   - Visual mappings - figure out new ways to display icons on the screen,
%   what icons are necessary, etc.
%   - Functional mappings - map the button states to the TV's functions
%   (cc, etc.)
%   - Implement navigation panel - currently, the navigation arrows only
%   map to numbers 1-4 (N,E,S,W). The navigation panel may be integrated
%   with the DVD and VCR on-screen controls to navigate scene selection,
%   etc. It may also be integrated with the native TV state.
%   - Refine media (rewind, play, forward, etc.) buttons. The icons
%   (unicode doesn't display in matlab) are crude, so we can refine them.
%   Otherwise, figure out what icons need to be on screen and for how long.
%   (eg. we display the stop icon until another state is activated.
%   Alternatively, we erase the play icon a couple seconds after we display
%   it.)
%   - Channel cycling. When we reach the "negative" channel region, we
%   should actually wrap around to the highest channels. Same for the
%   postiive channels: once we exhaust the channels, go back to the
%   beginning.
%   - Import channel directory. Find a listing of actual channels and their
%   names, and construct a channel guide/directory.
%   - Channel browsing. Currently, the numberpad only maps the channel to a
%   single digit channel. We want to improve this to account for higher
%   order channels. This would require a timer to wait for the user to
%   finish pressing all intended buttons, then making a check in the
%   channel directory, and then switching the channel. If the channel is
%   invalid, we return to the last channel we were viewing.
%
% Running Details:
%   - Button presses are right-mouse clicks for some reason.
%   - Be aware that there are timers in place that set the visibility of
%   items off. These are mostly 2sec long, so just wait.
%
% See mapping details in the functions below. Beware the amount of
% auto-generated overhead below.
%
% (c) fuTV 2016 | The future of television.
%
%


function varargout = fuTVRemote2(varargin)
% FUTVREMOTE2 MATLAB code for fuTVRemote2.fig
%      FUTVREMOTE2, by itself, creates a new FUTVREMOTE2 or raises the existing
%      singleton*.
%
%      H = FUTVREMOTE2 returns the handle to a new FUTVREMOTE2 or the handle to
%      the existing singleton*.
%
%      FUTVREMOTE2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FUTVREMOTE2.M with the given input arguments.
%
%      FUTVREMOTE2('Property','Value',...) creates a new FUTVREMOTE2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fuTVRemote2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fuTVRemote2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fuTVRemote2

% Last Modified by GUIDE v2.5 29-Apr-2016 09:40:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fuTVRemote2_OpeningFcn, ...
                   'gui_OutputFcn',  @fuTVRemote2_OutputFcn, ...
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


% --- Executes just before fuTVRemote2 is made visible.
function fuTVRemote2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fuTVRemote2 (see VARARGIN)

% Choose default command line output for fuTVRemote2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fuTVRemote2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fuTVRemote2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% TV Variables/States
% We just set the defaults here
setCurrChannel(7); %set current channel to 7 (ABCHD)
setLastChannel(7); %set previous channel to 7 by default
setCurrVolume(12); %set current volume to 12 by default

global tv; %global tv variable
tv.on = false;

% Correspond to three power buttons
tv.tv = false;
tv.dvd = false;
tv.vcr = false;

% Channel States/Global States
tv.channel = false;
tv.volume = false;
tv.input = false;
tv.ok = false;
tv.mute = false;
tv.cc = false;
tv.dir = 0;

% DVD/VCR States
tv.forward = false;
tv.rewind = false;
tv.play = false;
tv.pause = false;
tv.stop = false;
tv.forwardstop = false;
tv.rewindstop = false;
tv.input = 0;

% Turns on the general cable TV (denoted by the TV static textfield)
% We make checks to see if the other DVD/VCR are turned on. We switch from
% them to TV. If we are on TV, then turn TV off.
%
function powertv_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to powertv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
tv.on = true;
tv.tv = true;
if (strcmp(get(handles.dvdscreen, 'visible'), 'on'))
    set(handles.dvdscreen,'visible','off');
    set(handles.tvscreen,'visible','on');
    tv.dvd = false;
elseif (strcmp(get(handles.vcrscreen, 'visible'), 'on'))
    set(handles.vcrscreen,'visible','off');
    set(handles.tvscreen,'visible','on');
    tv.vcr = false;
elseif (strcmp(get(handles.tvscreen,'visible'),'on'))
    tv.on = false;
    tv.tv = false;
    set(handles.tvscreen,'visible','off');
else
    set(handles.tvscreen,'visible','on');
end

% Creation of VISIO TV screen
%
function tv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% --- Executes during object creation, after setting all properties.
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2

% Turns on DVD player (denoted by the DVD static textfield)
% We make checks to see if the other TV/VCR are turned on. We switch from
% them to DVD. If we are on DVD, then turn DVD off.
%
function powerdvd_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to powerdvd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
tv.on = true;
tv.dvd = true;
if (strcmp(get(handles.tvscreen, 'visible'), 'on'))
    set(handles.tvscreen,'visible','off');
    set(handles.dvdscreen,'visible','on');
    tv.tv = false;
elseif (strcmp(get(handles.vcrscreen, 'visible'), 'on'))
    set(handles.vcrscreen,'visible','off');
    set(handles.dvdscreen,'visible','on');
    tv.vcr = false;
elseif (strcmp(get(handles.dvdscreen,'visible'),'on'))
    set(handles.dvdscreen,'visible','off');
    tv.dvd = false;
    tv.on = false;
else
    set(handles.dvdscreen,'visible','on');
end

% Turns on VCR player (denoted by the VCR static textfield)
% We make checks to see if the other DVD/TV are turned on. We switch from
% them to VCR. If we are on VCR, then turn VCR off.
%
function powervcr_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to powervcr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
tv.on = true;
tv.vcr = true;
if (strcmp(get(handles.tvscreen, 'visible'), 'on'))
    set(handles.tvscreen,'visible','off');
    set(handles.vcrscreen,'visible','on');
    tv.tv = false;
elseif (strcmp(get(handles.dvdscreen, 'visible'), 'on'))
    set(handles.dvdscreen,'visible','off');
    set(handles.vcrscreen,'visible','on');
    tv.dvd = false;
elseif (strcmp(get(handles.vcrscreen,'visible'),'on'))
    set(handles.vcrscreen,'visible','off');
    tv.on = false;
    tv.vcr = false;
else
    set(handles.vcrscreen,'visible','on');
    tv.on = true;
end

% Mutes volume, indicated by the mute icon which appears for 2 sec
%
function mute_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to mute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true)
    set(handles.volumeinfo,'visible','on');
    if (tv.mute == true)
        tv.mute = false;
        set(handles.volumeinfo,'String',strcat('VOL ', num2str(getCurrVolume())));
    else
        tv.mute = true;
        set(handles.volumeinfo,'String','MUTE');
    end
end
t = timer;
t.StartDelay = 2;
t.TimerFcn = @(myTimerObj, thisEvent)set(handles.volumeinfo,'visible','off');
start(t)
drawnow 

% Increments channel by 1 (note no limit established because we don't have
% a channel directory)
%
function up_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && tv.tv == true)
    c = getCurrChannel();
    setCurrChannel(c + 1);

    set(handles.channelinfo,'visible','on');

    if(tv.channel == false)
        tv.channel = true;
        set(handles.channelinfo,'String',strcat('CH ', num2str(getCurrChannel())));
    else
        tv.channel = false;
        set(handles.channelinfo,'String',strcat('CH ', num2str(getCurrChannel())));
    end
    drawnow
end

t = timer;
t.StartDelay = 2;
t.TimerFcn = @(myTimerObj, thisEvent)set(handles.channelinfo,'visible','off');
start(t)


% Decrements channel by 1 (note lower limit is 0)
%
function down_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && tv.tv == true)
    c = getCurrChannel();
    if (c <= 1)
        setCurrChannel(0);
    else
        setCurrChannel(c-1);
    end

    set(handles.channelinfo,'visible','on');

    if(tv.channel == false)
        tv.channel = true;
        set(handles.channelinfo,'String',strcat('CH ', num2str(getCurrChannel())));
    else
        tv.channel = false;
        set(handles.channelinfo,'String',strcat('CH ', num2str(getCurrChannel())));
    end
    drawnow
end

t = timer;
t.StartDelay = 2;
t.TimerFcn = @(myTimerObj, thisEvent)set(handles.channelinfo,'visible','off');
start(t)

% Turns on cc capabilities
%
function cc_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to cc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true)
    if (tv.cc == false)
        tv.cc = true;
    else
        tv.cc = false;
    end

    if ((strcmp(get(handles.ccinfo, 'Visible'),'on')))
        set(handles.ccinfo, 'Visible', 'off');
    else
        set(handles.ccinfo, 'Visible', 'on');
    end
    drawnow
end


% Increments volume by 1
%
function plus_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;

if(tv.on == true)
    v = getCurrVolume();
    if (v <= 99)
        setCurrVolume(v + 1);
    end

    set(handles.volumeinfo,'visible','on');

    if(tv.volume == false)
        tv.volume = true;
        set(handles.volumeinfo,'String',strcat('VOL ', num2str(getCurrVolume())));
    else
        tv.volume = false;
        set(handles.volumeinfo,'String',strcat('VOL ', num2str(getCurrVolume())));
    end
        drawnow
end
t = timer;
t.StartDelay = 2;
t.TimerFcn = @(myTimerObj, thisEvent)set(handles.volumeinfo,'visible','off');
start(t)

% Decrements volume by 1
%
function minus_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;

if(tv.on == true)
    v = getCurrVolume();
    if (v <= 1)
        setCurrVolume(0);
    else
        setCurrVolume(v - 1);
    end

    set(handles.volumeinfo,'visible','on');

    if(tv.volume == false)
        tv.volume = true;
        set(handles.volumeinfo,'String',strcat('VOL ', num2str(getCurrVolume())));
    else
        tv.volume = false;
        set(handles.volumeinfo,'String',strcat('VOL ', num2str(getCurrVolume())));
    end
        drawnow
end
t = timer;
t.StartDelay = 2;
t.TimerFcn = @(myTimerObj, thisEvent)set(handles.volumeinfo,'visible','off');
start(t)

% Sets navigation state to up
%
function navup_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to navup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true)
    tv.dir = 1;
end


% Sets nav state to right
%
function navright_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to navright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true)
    tv.dir = 2;
end


% Sets nav state to down
%
function navdown_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to navdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true)
    tv.dir = 3;
end

% Sets nav state to left
%
function navleft_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to navleft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true)
    tv.dir = 4;
end


% Sets ok state, note we need to implement a timer to reset the ok state to
% false after its action.
%
function ok_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true)
    tv.ok = true;
end


% Sets forward state
%
function forward_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to forward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && (tv.vcr == true || tv.dvd == true))
    tv.forward = true;
    tv.rewind = false;
    tv.play = false;
    tv.pause = false;
    tv.stop = false;
    tv.forwardstop = false;
    tv.rewindstop = false;
    set(handles.state,'String','>>');
    set(handles.state,'visible','on');
end


% Sets play/pause state
%
function playpause_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to playpause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && (tv.vcr == true || tv.dvd == true))
    tv.forward = false;
    tv.rewind = false;
    tv.stop = false;
    tv.forwardstop = false;
    tv.rewindstop = false;
    
    if (tv.pause == false)
        tv.play = false;
        tv.pause = true;
        set(handles.state,'String','||');
        set(handles.state,'visible','on');
    elseif (tv.play == false)
        tv.play = true;
        tv.pause = false;
        set(handles.state,'String','PLAY');
        set(handles.state,'visible','on');
        t = timer;
        t.StartDelay = 2;
        t.TimerFcn = @(myTimerObj, thisEvent)set(handles.state,'visible','off');
        start(t)
    end
end

% Sets rewind state
%
function rewind_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to rewind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && (tv.vcr == true || tv.dvd == true))
    tv.forward = false;
    tv.rewind = true;
    tv.play = false;
    tv.pause = false;
    tv.stop = false;
    tv.forwardstop = false;
    tv.rewindstop = false;
    set(handles.state,'String','<<');
    set(handles.state,'visible','on');
end

% Sets forward stop state
%
function forwardstop_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to forwardstop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && (tv.vcr == true || tv.dvd == true))
    tv.forward = false;
    tv.rewind = false;
    tv.play = false;
    tv.pause = false;
    tv.stop = false;
    tv.forwardstop = true;
    tv.rewindstop = false;
    set(handles.state,'String','>|');
    set(handles.state,'visible','on');
end
t = timer;
t.StartDelay = 2;
t.TimerFcn = @(myTimerObj, thisEvent)set(handles.state,'visible','off');
start(t)


% Sets stop state
%
function stop_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && (tv.vcr == true || tv.dvd == true))
    tv.forward = false;
    tv.rewind = false;
    tv.play = false;
    tv.pause = false;
    tv.stop = true;
    tv.forwardstop = false;
    tv.rewindstop = false;
    set(handles.state,'String','[]');
    set(handles.state,'visible','on');
end

% Sets rewind stop state
%
function rewindstop_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to rewindstop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && (tv.vcr == true || tv.dvd == true))
    tv.forward = false;
    tv.rewind = false;
    tv.play = false;
    tv.pause = false;
    tv.stop = false;
    tv.forwardstop = false;
    tv.rewindstop = true;
    set(handles.state,'String','|<');
    set(handles.state,'visible','on');
end
t = timer;
t.StartDelay = 2;
t.TimerFcn = @(myTimerObj, thisEvent)set(handles.state,'visible','off');
start(t)


% Channel 1
%
function one_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && tv.tv == true)
    tv.channel = true;

    setCurrChannel(1);
    
    set(handles.channelinfo,'String',strcat('CH ', num2str(getCurrChannel())));
    set(handles.channelinfo,'visible','on');

    t = timer;
    t.StartDelay = 2;
    t.TimerFcn = @(myTimerObj, thisEvent)set(handles.channelinfo,'visible','off');
    start(t)
    
end


% Channel 2
%
function two_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && tv.tv == true)
    tv.channel = true;

    setCurrChannel(2);
    
    set(handles.channelinfo,'String',strcat('CH ', num2str(getCurrChannel())));
    set(handles.channelinfo,'visible','on');

    t = timer;
    t.StartDelay = 2;
    t.TimerFcn = @(myTimerObj, thisEvent)set(handles.channelinfo,'visible','off');
    start(t)
    
end


% Channel 3
%
function three_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to three (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && tv.tv == true)
    tv.channel = true;

    setCurrChannel(3);
    
    set(handles.channelinfo,'String',strcat('CH ', num2str(getCurrChannel())));
    set(handles.channelinfo,'visible','on');

    t = timer;
    t.StartDelay = 2;
    t.TimerFcn = @(myTimerObj, thisEvent)set(handles.channelinfo,'visible','off');
    start(t)
    
end


% Channel 4
%
function four_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to four (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && tv.tv == true)
    tv.channel = true;

    setCurrChannel(4);
    
    set(handles.channelinfo,'String',strcat('CH ', num2str(getCurrChannel())));
    set(handles.channelinfo,'visible','on');

    t = timer;
    t.StartDelay = 2;
    t.TimerFcn = @(myTimerObj, thisEvent)set(handles.channelinfo,'visible','off');
    start(t)
    
end


% Channel 5
%
function five_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to five (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && tv.tv == true)
    tv.channel = true;

    setCurrChannel(5);
    
    set(handles.channelinfo,'String',strcat('CH ', num2str(getCurrChannel())));
    set(handles.channelinfo,'visible','on');

    t = timer;
    t.StartDelay = 2;
    t.TimerFcn = @(myTimerObj, thisEvent)set(handles.channelinfo,'visible','off');
    start(t)
    
end


% Channel 6
%
function six_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to six (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && tv.tv == true)
    tv.channel = true;

    setCurrChannel(6);
    
    set(handles.channelinfo,'String',strcat('CH ', num2str(getCurrChannel())));
    set(handles.channelinfo,'visible','on');

    t = timer;
    t.StartDelay = 2;
    t.TimerFcn = @(myTimerObj, thisEvent)set(handles.channelinfo,'visible','off');
    start(t)
    
end


% Channel 7
%
function seven_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to seven (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && tv.tv == true)
    tv.channel = true;

    setCurrChannel(7);
    
    set(handles.channelinfo,'String',strcat('CH ', num2str(getCurrChannel())));
    set(handles.channelinfo,'visible','on');

    t = timer;
    t.StartDelay = 2;
    t.TimerFcn = @(myTimerObj, thisEvent)set(handles.channelinfo,'visible','off');
    start(t)
    
end


% Channel 8
%
function eight_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to eight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && tv.tv == true)
    tv.channel = true;

    setCurrChannel(8);
    
    set(handles.channelinfo,'String',strcat('CH ', num2str(getCurrChannel())));
    set(handles.channelinfo,'visible','on');

    t = timer;
    t.StartDelay = 2;
    t.TimerFcn = @(myTimerObj, thisEvent)set(handles.channelinfo,'visible','off');
    start(t)
    
end


% Channel 9
%
function nine_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to nine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && tv.tv == true)
    tv.channel = true;

    setCurrChannel(9);
    
    set(handles.channelinfo,'String',strcat('CH ', num2str(getCurrChannel())));
    set(handles.channelinfo,'visible','on');

    t = timer;
    t.StartDelay = 2;
    t.TimerFcn = @(myTimerObj, thisEvent)set(handles.channelinfo,'visible','off');
    start(t)
    
end


% Channel 0
%
function zero_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to zero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.on == true && tv.tv == true)
    tv.channel = true;

    setCurrChannel(0);
    
    set(handles.channelinfo,'String',strcat('CH ', num2str(getCurrChannel())));
    set(handles.channelinfo,'visible','on');

    t = timer;
    t.StartDelay = 2;
    t.TimerFcn = @(myTimerObj, thisEvent)set(handles.channelinfo,'visible','off');
    start(t)
    
end

% (c) fuTV 2016 | The future of television. Yes, so revolutionary, we just
% had to repeat it.