function settings=setup_reach_coding_settings()

% Pairs with function setup_reach_coding.m
% Use these to get data from specific, user-defined zones in the movie

% Prompts to user
settings.prompt1='Pause movie at a frame with both paws on perch, cue/opto on, and, if possible, with pellet in final presented position. Then press "enter" at command line. Understood?';
settings.prompt2='Found frame? If not, set second argument to this function such that beginning of movie includes a useful frame.';
settings.framesPerChunk=500; % how many movie frames for setup_reach_coding.m

% Save results to file?
settings.save=1; % 1 if want to save zones data to movie directory, 0 otherwise

% What zones to define in movie
% Note that the location of these zones should not change during the movie
settings.zones(1).name='perch zone'; % zone name
settings.zones(1).prompt='Draw a polygon enclosing the perch zone on the image.'; % describe zone to user
settings.zones(1).takeImageValue='intensity'; % which value to get from this zone in movie
% takeImageValue can be one of the following:
% 'intensity' : get intensity from movie pixels
% 'red' : get red value from movie pixels
% 'green' : get green value from movie pixels
% 'blue' : get blue value from movie pixels

settings.zones(2).name='LED zone';
settings.zones(2).prompt='Draw a polygon enclosing the distractor LED zone on the image.';
settings.zones(2).takeImageValue='intensity';

settings.zones(3).name='reach zone';
settings.zones(3).prompt='Draw a polygon enclosing the area surrounding but NOT including the pellet.';
settings.zones(3).takeImageValue='intensity';

settings.zones(4).name='eat zone';
settings.zones(4).prompt='Draw a polygon enclosing the region where mouse paws go when mouse eats.';
settings.zones(4).takeImageValue='intensity';

settings.zones(5).name='pellet zone';
settings.zones(5).prompt='Draw a polygon enclosing the stopped pellet.';
settings.zones(5).takeImageValue='intensity';

settings.zones(6).name='cue zone';
settings.zones(6).prompt='Draw a polygon enclosing the area illuminated when the cue turns on.';
settings.zones(6).takeImageValue='blue';

settings.zones(7).name='opto zone';
settings.zones(7).prompt='Draw a polygon enclosing the area illuminated when the optogenetic stimulus turns on.';
settings.zones(7).takeImageValue='red';