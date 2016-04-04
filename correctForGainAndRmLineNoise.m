function correctForGainAndRmLineNoise(subID,EXP,dataset)

rmLineNoise=0;

switch dataset
    case 'localizer'
        subSpecs_IowaLocalizer
    case 'CFS'
        subSpecs_IowaCFS
    case 'BM'
        subSpecs_IowaBM
    case 'DF'
        subSpecs_IowaDF
end  

for iSession = SUB.vSession
    disp(['session ' num2str(iSession)])
    rawDir = [DIR.rawData '/' getfilenum(SUB.session(iSession),3) '/rawEachChan/'];
    correctDir = [DIR.rawData '/' getfilenum(SUB.session(iSession),3) '/correctEachChan/'];
    
    if isempty(dir(correctDir))
        mkdir(correctDir)
    end
    
    for iChan = SUB.chan_uni
        disp(['chan ' num2str(iChan) ' ' datestr(now)])

        val = ['li' num2str(iChan)];
        
        filename = [getfilenum(SUB.session(iSession),3) '_' val];
        if exist([correctDir filename '.mat'],'file')
%             continue
        end
        load([rawDir filename])
        eval(['tmpChan = ' val ';'])
        if isinteger(tmpChan.dat) || strcmpi(dataset,'DF') 
            disp('correct for gain')
            tmpChan.dat = (tmpChan.dat)./20; %Christophers email: I double checked TDT circuits,
            %and the data stored as integer were scaled by a factor of 1e6.
            %This is on top of the 20x amplification of the preamp,
            %so to that dividing the value by 20 ought to give microvolts.
        end
        
        if rmLineNoise
            % noise removal
            disp('removing line noise')
            tmpChan.dat = denoiseContinuous(double(tmpChan.dat),fs);
        else
            tmpChan.dat = double(tmpChan.dat);
        end
        
        eval([val ' = tmpChan' ';'])

        save([correctDir filename '.mat'],['li' num2str(iChan)],'rmLineNoise')
    end
end
