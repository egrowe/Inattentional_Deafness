%% Inattentional Deafness Experiment
%Will need to be 3 versions (possibly one 2) of this script:
%    1) No mention that the tone is present
%    2) Tell tone is present but no action is needed on tones
%    3) Tone is present, need to also report on the tone

%Written by Elise Rowe May 2017
%PhD Project in Tsuchiya t-lab Monash Neuroscience of Consciousness

%%% EXP Parameters %%%
%setup screens and assign number of trials
clear all;
%----------------------------------------------------------------------%
%-------------- PARTICIPANT DETAILS & BLOCK SELECTION ------------------%
%-----------------------------------------------------------------------%
%Set number of trials
noDiffTones = 4;
trialsWithTones = 1*noDiffTones;
noTrials = trialsWithTones*2;

%Load Experimental Parameters
expParameters_InAttDeaf_new;

%Change directory to where stimuli are held
cd('/Users/egrow1/Desktop/Inatt_Deafness_Exp/letterImages_tones')

%Priority of screen and keyboard/mouse functions
Priority(2); %set priority in Matlab to ensure timing precision
ListenChar(2); % prevent output from keypresses displayed in command window
HideCursor;

% Keyboard setup
KbName('UnifyKeyNames');
KbCheckList = [KbName('x'),KbName('z'), KbName('ESCAPE'), KbName('SPACE')];
responseKeys = {'z', 'x', 'ESCAPE', 'SPACE'};
for i = 1:length(responseKeys)
    KbCheckList = [KbName(responseKeys{i}),KbCheckList];
end
RestrictKeysForKbCheck(KbCheckList);

%% ---------------------------------------------------------------------%
%---------------- SETUP TRIAL STRUCTURES OF LETTERS --------------------%
%-----------------------------------------------------------------------%
%Setup one of letter arrays
targetIdx = (horzcat(ones(1,noTrials/2),zeros(1,noTrials/2)));
shuffleIdx = randperm(noTrials);
targetOrder = targetIdx(shuffleIdx)+1;

%Now setup the letter arrays
letterArray = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', ...
    'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'Y'};

targetRep = targetOrder+length(letterArray);

%Create the structures with each trials letters and targets
for ii = 1:noTrials
    useLetters(ii,:) = randperm(23,6);
    
    replaceIdx = randperm(6,1);
    useLetters(ii,replaceIdx) = targetRep(ii);
end

targetArray = {'x', 'z'};
for rr = 1:length(targetOrder);
    realTargetValue{rr,:} = targetArray{1,targetOrder(rr)};
end

%Target values as keyboard presses
%Record exact key press names
for tt = 1:length(realTargetValue)
    if realTargetValue{tt,:} == 'z'
    keyValsOfTargets(tt,:) = 122
    elseif realTargetValue{tt,:}== 'x'
        keyValsOfTargets(tt,:) = 120
    else
        keyValsOfTargets(tt,:) = 0
    end
end

% CREATE TEXTURES POINTER OF LETTERS TO DISPLAY
alphabetTextArray = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', ...
    'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'Y', 'X', 'Z'};

for ii = 1:length(alphabetTextArray)
    thisLetter = alphabetTextArray{ii};
    letter_data{ii} = imread(sprintf('%c.jpg', thisLetter));
end

%% ---------------------------------------------------------------------%
%---------------------- SETUP TONE ORDER (random) ----------------------%
%-----------------------------------------------------------------------%
%Setup randomly the trials (50%) when the tone is played at same time as the
%letter presentation (same time and duration)
toneIdx = (horzcat(ones(1,noTrials/2),zeros(1,noTrials/2)));
shuffleToneIdx = randperm(noTrials);
tonePresent = toneIdx(shuffleToneIdx);

%Dertermine which of the 4 tones will be played
trialsForEachTone = trialsWithTones/noDiffTones;

toneHzIdx = (horzcat(ones(1,trialsForEachTone),ones(1,trialsForEachTone)*2, ...
    ones(1,trialsForEachTone)*3, ones(1,trialsForEachTone)*4));
shuffleHzIdx = randperm(trialsWithTones);
toneHzOrder = toneHzIdx(shuffleHzIdx);

%% ---------------------------------------------------------------------%
%------------------------ Setup fixation cross -------------------------%
%-----------------------------------------------------------------------%
%Setup the fixation cross to begin trials
%Set colour, width, length etc.
Cfg.crossColour = [255];  %255 = white
Cfg.crossLength = 10;
Cfg.crossWidth = 1;

%Set start and end points of lines
crossLines = [-Cfg.crossLength, 0; Cfg.crossLength, 0; 0, -Cfg.crossLength; 0, Cfg.crossLength];
Cfg.crossLines = crossLines';

%% ---------------------------------------------------------------------%
%----------------------- PRESENT INSTRUCTIONS --------------------------%
%-----------------------------------------------------------------------%

%Blank screen (clear previous text)
Screen('FillRect', Cfg.windowPtr, 0);
for m = 1 : 45 % In Frames! (eg 60hz = 15 = 250ms)
    Screen('Flip', Cfg.windowPtr, [], Cfg.aux_buffer);
end

%Give instructions to participants about which ear to attend depending on which trial type is selected
DrawFormattedText(Cfg.windowPtr, 'Pay attention to the letters. A "Z" or "X" will be present in each trial.', ...
    'center', Cfg.yCentre, [255 255 255]);
Screen('Flip', Cfg.windowPtr, [], Cfg.aux_buffer);
WaitSecs(3);

%Blank screen (clear previous text)
Screen('FillRect', Cfg.windowPtr, 0);
for m = 1 : 60 % In Frames! (eg 60hz = 15 = 250ms)
    Screen('Flip', Cfg.windowPtr, [], Cfg.aux_buffer);
end

%Give instructions to participants about which ear to attend depending on which trial type is selected
DrawFormattedText(Cfg.windowPtr, 'At the end of each trial, press the "Z" or "X" key to indicate your answer.', ...
    'center', Cfg.yCentre, [255 255 255]);
Screen('Flip', Cfg.windowPtr, [], Cfg.aux_buffer);
WaitSecs(3);

%Blank screen (clear previous text)
Screen('FillRect', Cfg.windowPtr, 0);
for m = 1 : 60 % In Frames! (eg 60hz = 15 = 250ms)
    Screen('Flip', Cfg.windowPtr, [], Cfg.aux_buffer);
end

%Ready screen
DrawFormattedText(Cfg.windowPtr, ['Ready...' '\n\n\n (Press SPACEBAR to Begin)'], 'center', Cfg.yCentre, [255 255 255]);
Screen('Flip', Cfg.windowPtr, [], Cfg.aux_buffer);
KbWait();

%Blank screen
Screen('FillRect', Cfg.windowPtr, 0);
for m = 1 : 30 % In Frames! (eg 60hz = 15 = 250ms)
    Screen('Flip', Cfg.windowPtr, [], Cfg.aux_buffer);
end

%% ---------------------------------------------------------------------%
%----------------------- SETUP AUDIO PART OF EXP -----------------------%
%-----------------------------------------------------------------------%
freqTone = [500, 1000, 1500, 2000];
[toneA, sampRateA] = audioread(sprintf('%dHz.wav',freqTone(1))); toneData{1} = [toneA, toneA];
[toneB, FsB] = audioread(sprintf('%dHz.wav',freqTone(2))); toneData{2} = [toneB, toneB];
[toneC, FsC] = audioread(sprintf('%dHz.wav',freqTone(3))); toneData{3} = [toneC, toneC];
[toneD, FsD] = audioread(sprintf('%dHz.wav',freqTone(4))); toneData{4} = [toneD, toneD];

if sampRateA ~= FsB || sampRateA ~= FsB || sampRateA ~= FsB
    msg = 'Sampling rates different. Check audio files are correct to ensure correct playback timing'
    error(msg)
end

pahandle = PsychPortAudio('Open', [], [], 2, sampRateA, 2); %sampling rate of the pure tones (Hz)

countHz = 1;
rt = zeros(noTrials,1); %Setup empty array for reaction times
resp = zeros(noTrials,1); %Setup empty array for resp keys
%% ---------------------------------------------------------------------%
%------------------------ BEGIN THE EXPERIMENT -------------------------%
%-----------------------------------------------------------------------%
for trialNo = 1:8%noTrials    
    %% Determine if audio trial or not
    audioTrial = tonePresent(trialNo);
    
    %% Make textures of letters for this trial
    useTextures = letter_data(useLetters(trialNo,:));
    for ss = 1:TR(tr).noLetters
        letterTexture(ss) = Screen('MakeTexture', Cfg.windowPtr, useTextures{ss});
    end
    
    %Fill audio buffer with correct tone type if one is played on this trial
    if audioTrial == 1
        thisTone = (toneHzOrder(countHz))
        PsychPortAudio('FillBuffer', pahandle, toneData{thisTone}');
        countHz = countHz + 1;
    end
    
    % Draw Fixation Cross on Centre of Screen
    Screen('DrawLines', Cfg.windowPtr, Cfg.crossLines, Cfg.crossWidth, Cfg.crossColour, [Cfg.xCentre, Cfg.yCentre]);
    for m = 1 : (TR(tr).crosstrialDur) % In Frames! (eg 60hz = 15 = 250ms)
        Screen('Flip', Cfg.windowPtr, [], Cfg.aux_buffer);
    end
    
    Screen('FillRect', Cfg.windowPtr, 0);
    Screen('DrawLines', Cfg.windowPtr, Cfg.crossLines, Cfg.crossWidth, Cfg.crossColour, [Cfg.xCentre, Cfg.yCentre]);
    
    %% ---------------------------------------------------------------------%
    %------------------ Draw Letters Depending on Trial No -----------------%
    %-----------------------------------------------------------------------%  
    for i = 1:TR(tr).noLetters
        if i == 1
            Screen('DrawTexture', Cfg.windowPtr, letterTexture(i), [], [TR(tr).rectsMain(i,:)]);
        elseif i == 2
            Screen('DrawTexture', Cfg.windowPtr, letterTexture(i), [], [TR(tr).rectsMain(i,:)]);
        elseif i == 3
            Screen('DrawTexture', Cfg.windowPtr, letterTexture(i), [], [TR(tr).rectsMain(i,:)]);
        elseif i == 4
            Screen('DrawTexture', Cfg.windowPtr, letterTexture(i), [], [TR(tr).rectsMain(i,:)]);
        elseif i == 5
            Screen('DrawTexture', Cfg.windowPtr, letterTexture(i), [], [TR(tr).rectsMain(i,:)]);
        elseif i == 6
            Screen('DrawTexture', Cfg.windowPtr, letterTexture(i), [], [TR(tr).rectsMain(i,:)]);
        end
    end
    
    %Start tone if this is a trial with one
    if audioTrial == 1
        PsychPortAudio('Start', pahandle, [], [], 1);
    end
    
    %%%%%%%Show the screen for the present trial conditions (L's or T's) %%%%%%
    for m = 1 : TR(tr).cSOA ; % In frames! 60hz... therefore, 30 = 500ms
        Screen('Flip', Cfg.windowPtr, [], Cfg.aux_buffer);
    end
    
    %Blank screen before asking question
    Screen('FillRect', Cfg.windowPtr, 0);
    
    %% ---------------------------------------------------------------------%
    %---------------------- Get Participant Response -----------------------%
    %-----------------------------------------------------------------------%    
    DrawFormattedText(Cfg.windowPtr, '?', ...
        'center', Cfg.yCentre, [255 255 255]);
    Screen('Flip', Cfg.windowPtr, [], Cfg.aux_buffer);
    
    respStartTime = GetSecs %start of response time for participants
    trialTimeout = 1.9 %Time allowed to make a response

    while GetSecs - respStartTime < trialTimeout
        [keyIsDown,secs,keyCode] = KbCheck;
        respTime = GetSecs;
        pressedKeys = find(keyCode);
        
        % Check for response keys
        if ~isempty(pressedKeys)
            for keys = 1:length(responseKeys)
                if KbName(responseKeys{keys}) == pressedKeys(1)
                    resp(trialNo,:) = responseKeys{keys}
                    rt(trialNo,:) = respTime - respStartTime;
                end
            end
            break;
        end
    end
    
    Screen('FillRect', Cfg.windowPtr, 0);
    for m = 1 : TR(tr).screenInterval % In Frames! (eg 60hz = 15 = 250ms)
        Screen('Flip', Cfg.windowPtr, [], Cfg.aux_buffer);
    end
    
end

%% ---------------------------------------------------------------------%
%------------ Create Correct & Incorrect Response Structures -----------%
%-----------------------------------------------------------------------%
resultsMatrix = horzcat(keyValsOfTargets, resp, rt)
correctIdxs = find(keyValsOfTargets == resp)
incorrectIdxs = find(keyValsOfTargets ~= resp)

correctRespMatrix = resultsMatrix(correctIdxs,:)
incorrectRespMatrix = resultsMatrix(incorrectIdxs,:)

%Close the audio driver
PsychPortAudio('Close', pahandle);
ListenChar(0); % Turn responses back on at command window

ShowCursor; %Show the cursor again

%Blank screen at end of trial
Screen('FillRect', Cfg.windowPtr, 0);
for m = 1 : 60 % In Frames! (eg 60hz = 15 = 250ms)
    Screen('Flip', Cfg.windowPtr, [], Cfg.aux_buffer);
end

%% ---------------------------------------------------------------------%
%---------------- END EXPERIMENT: Clean up and go home -----------------%
%-----------------------------------------------------------------------%
%Thank you for participating screen
DrawFormattedText(Cfg.windowPtr, ['End of Experiment'  '\n\n Thanks for Participating'], 'center', Cfg.yCentre, [255 255 255]);
Screen('Flip', Cfg.windowPtr, [], Cfg.aux_buffer);
WaitSecs(2);

%filename = ['Elise_' num2str(trialsComplete) '_TrialsComplete.mat'] %% - CHANGE THIS!!!!!!
%save(filename)%, 'resultsMatrix')

% Clear all - viola! All done! (test for accuracy using getAccuracy_x.m)
sca
