function aligned=cleanUpCue(aligned)

% Settings

% This is the fraction of range above the min to use as cut-off threshold
% for cue on
thresh=0.75; 

% If this is 1, subtract off LED distractor, because there is contamination
% of cue zone from LED distractor
subtractDistract=1;

cueZone=aligned.cueZone;
if subtractDistract==1
    cueZone=cueZone-(range(cueZone)*aligned.movie_distractor);

temp=nan(size(cueZone));
isOn=cueZone>(thresh*range(cueZone))+min(cueZone);
temp(isOn)=1;
temp(~isOn)=0;
aligned.cueZone_onVoff=temp;

figure();
plot(aligned.cueZone,'Color','k'); 
hold on;
line([0 length(aligned.cueZone)],[(thresh*range(aligned.cueZone))+min(aligned.cueZone) (thresh*range(aligned.cueZone))+min(aligned.cueZone)],'Color','r');
title('Cleaning up cue from movie');