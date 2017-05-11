

for tr = 1 : nTrials
    
    % define trial types targetTrialType = (0:All L's, 1:All T's, 2: All L's & 1T, 3: All T's & 1L)
    setTrials = rand(1);
    if setTrials <=0.25;
        TR(tr).targetTrialType = 0;
    elseif setTrials >= 0.25 && setTrials <= 0.5;
        TR(tr).targetTrialType = 1;
    elseif setTrials >= 0.75;
        TR(tr).targetTrialType = 3;
    else
        TR(tr).targetTrialType = 4;
    end
    
    % Varibale set up for the main central screen (letter task)
    
    % Random selection of rotation angle
    TR(tr).ang = randperm(360);
    
    %Sets up the letters to display dependent on pre-defined
    %targetTrialType
    if TR(tr).targetTrialType == 0
        TR(tr).xTexture = L_texture;
        
    elseif TR(tr).targetTrialType == 1
        TR(tr).xTexture = T_texture;
        
    elseif TR(tr).targetTrialType == 2
        TR(tr).xTexture = L_texture;
        
    else
        TR(tr).xTexture = T_texture;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%  MAIN SETUP   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %BASIC SET UP OF THE EXPERIMENT
    TR(tr).nTrials = nTrials; %total number of trials
    
    %%%%%%%%% !! Important !! Set cSOA as [] blank for dual task and as
    %%%%%%%%% value for runCentralTask %%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    TR(tr).cSOA = 7; % In frames! 60hz... therefore, 30 = 500ms
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    TR(tr).pSOA = 10; % In frames! 60hz... therefore, 30 = 500ms
    TR(tr).screenInterval = 30; % In frames! 60hz... therefore, 30 = 500ms
    TR(tr).letterSize = 20; % size of the central task letters (same for L, T and F's)
    TR(tr).noLetters = 5; % number of letters to place around circle (and 1 centre)
    TR(tr).noPeriphPoints = 20; %no of points (from which one is chosen) to display peripheral face
    TR(tr).crosstrialDur = 120; %In frames! 60hz... therefore, 90 = 1500ms
    TR(tr).intertrialInt = 90; % In frames! 60hz... therefore, 60 = 1sec
    TR(tr).imageHeight = 40;
    imageJust = TR(tr).imageHeight/2;
    TR(tr).F_texture = F_texture;
    TR(tr).T_texture = T_texture;
    TR(tr).L_texture = L_texture;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%  CENTRAL TASK   %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Find centre of screen for central letter presentation
    centreLeft = Cfg.xCentre - imageJust;
    centreTop = Cfg.yCentre - imageJust;
    centreRight = centreLeft + TR(tr).imageHeight;
    centreBottom = centreTop + TR(tr).imageHeight;
    TR(tr).centreLetterRect = [centreLeft, centreTop, centreRight, centreBottom];
    
    %Set coordinates for circle to present images around in the main screen
    A = rand(2);
    radius = 80;
    anglesMain = linspace(0,2*pi,TR(tr).noLetters);
    ptsMain =[cos(anglesMain);sin(anglesMain)];
    ptsMain = ptsMain*radius;
    
    newpt1=ptsMain(1,:)+(Cfg.xCentre);
    newpt2=ptsMain(2,:)+(Cfg.yCentre);
    TR(tr).ptsMain=vertcat(newpt1, newpt2);
    
    TR(tr).anglesMain = anglesMain;
    
    %Turn these point coordinates into rects for the image to be displayed in
    plus = TR(tr).ptsMain+imageJust;
    minus = TR(tr).ptsMain-imageJust;
    rectsMain = vertcat(minus, plus);
    TR(tr).rectsMain = rectsMain';
    
    %Set the position for the L or T to be written as the opposite letter
    %(trial conditions 2 and 3)
    R = randperm(TR(tr).noLetters); %randomly select one position index
    TR(tr).reWriteLetterPos = R(3); %pull the 3rd positioned number from this randperm and write it below
end