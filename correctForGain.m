function correctForGainAndRmLineNoise(subID,dataset)

switch dataset
    case 'localizer'
        subSpecsIowaFaceLocalizer
    case 'CFS'
        subSpecsIowaCFS
    case 'BM'
        subSpecsIowaBM
end


for iSession = 1:SUB.nSession
    
    for iChan = 1:SUB.nChan
        
        filename = 
        
        if isinteger(tmpChan.dat)
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
            tmpChan.dat = denoiseContinuous(tmpChan.dat,fs);
        end
        
        save( 
    end
end
