%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%  SET UP OF TRIAL CONDITIONS AND VARIABLES %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Set up all experimental parameters for each screen and type of stimuli
% Basic Set up of Trials
Gral.subjNo = '[]';  %enter a subject number %%% CHANGE THIS IS REQ. INPUT
Gral.subjID = '[]';  %enter subject initials
Gral.exptotalDuration = [];
Cfg.aux_buffer = 1;

%% ---------------------------------------------------------------------%
%------------------------- INITIALISE SCREEN ---------------------------%
%-----------------------------------------------------------------------%
Screen('Preference', 'SkipSyncTests', 1);
[windowPtr, rect] = Screen('OpenWindow', 0, 1);%, [0 0 800 800]);
Cfg.windowPtr = windowPtr;
Cfg.winRect = rect; Cfg.width = rect(3); Cfg.height = rect(4);
Cfg.xCentre = rect(3)/2; Cfg.yCentre = rect(4)/2; Cfg.black = [0 0 0];
Cfg.WinColor = [0 0 0]; Cfg.white = [255 255 255]; Cfg.gray = [130 130 130];

%%%% Reset random number generator by the clock time %%%%%
t = clock;
rng(t(3) * t(4) * t(5),'twister')

%% Set up the structures containing the info on Trials (TR), Configuration
Cfg.xCentre = rect(3)/2;
Cfg.yCentre = rect(4)/2;

%% Create trials definition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%  MAIN SETUP   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tr = 1
%BASIC SET UP OF THE EXPERIMENT
TR(tr).nTrials = noTrials; %total number of trials

%%%%%%%%% !! Important !! Set cSOA as [] blank for dual task and as
%%%%%%%%% value for runCentralTask %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TR(tr).cSOA = 6; % In frames! 60hz... therefore, 30 = 500ms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TR(tr).screenInterval = 30; % In frames! 60hz... therefore, 30 = 500ms
TR(tr).letterSize = 20; % size of the central task letters (same for L, T and F's)
TR(tr).noLetters = 6; % number of letters to place around circle (and 1 centre)
TR(tr).noPeriphPoints = 20; %no of points (from which one is chosen) to display peripheral face
TR(tr).crosstrialDur = 60; %In frames! 60hz... therefore, 90 = 1500ms
TR(tr).intertrialInt = 90; % In frames! 60hz... therefore, 60 = 1sec
TR(tr).imageHeight = 60;
TR(tr).imageWidth = 45;
imageJustUp = TR(tr).imageHeight/2;
imageJustDown = TR(tr).imageWidth/2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%  CENTRAL TASK   %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Set coordinates for circle to present images around in the main screen
radius = 120;
anglesMain = linspace(0,2*pi,((TR(tr).noLetters)+1));
ptsMain =[cos(anglesMain);sin(anglesMain)];
ptsMain = ptsMain*radius;
ptsMain(:,end) = [];

newpt1=ptsMain(1,:)+(Cfg.xCentre);
newpt2=ptsMain(2,:)+(Cfg.yCentre);
TR(tr).ptsMain=vertcat(newpt1, newpt2);

TR(tr).anglesMain = anglesMain;

%Turn these point coordinates into rects for the image to be displayed in
plus = TR(tr).ptsMain+imageJustUp;
minus = TR(tr).ptsMain-imageJustDown;
rectsMain = vertcat(minus, plus);
TR(tr).rectsMain = rectsMain';

%Set the position for the L or T to be written as the opposite letter
%(trial conditions 2 and 3)
R = randperm(TR(tr).noLetters); %randomly select one position index
TR(tr).reWriteLetterPos = R(3); %pull the 3rd positioned number from this randperm and write it below

%Leave blank the output variables that will be returned
TR(tr).mouseResponsesMain = [];
TR(tr).key_responseMain = [];
TR(tr).mouseResponsesPer = [];
TR(tr).key_responsePer = [];