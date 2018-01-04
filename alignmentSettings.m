function settings=alignmentSettings()

% Settings for getAlignment.m
% Note that microSD (Arduino) output is timed in ms
% Whereas video is timed in frames per sec

% Need to resample movie and arduino data so that indices represent
% matching times
settings.arduino_fs=1000; % arduino data sampling rate in Hz
settings.movie_fs=30; % movie data sampling rate in Hz
settings.scale_factor=floor(settings.arduino_fs/settings.movie_fs);

% Choose the following two numbers based on approximate relationship between
% sampling rate of arduino data and sampling rate of movie data.
% For example, if movie rate is 30 frames per second and arduino data is
% timed in ms, 1000 ms/30 ms = 33 ... scale factor is 33.
settings.arduino_dec=settings.scale_factor;
settings.movie_dec=1;

% Throw out distractor LED durations in movie or arduino less than this
% many ms
settings.useDistractorThresh=175; % in ms

% If, for example, experimenter forget to include LED in movie frame at beginning of
% experiment, but Arduino was on, need to discard beginning of arduino
% distractor LED. Discard this much time from the beginning of arduino
% distractor LED.
% settings.discardTimeArduinoLED=80; % in seconds

% The following values help the alignment by giving an estimate of when
% the movie fits into the arduino data.
% If isInSecondHalf is false, the code will start looking for an appropriate
% alignment of the movie data at the beginning of the arduino data.
% If, in fact, the movie comes in the second half of the arduino data
% stream, indicate this by setting isInSecondHalf to true.
settings.isInSecondHalf=false; % set this to true if movie matches a later section of arduino data stream

% For fractionThroughArduino ...
% Where in the arduino data stream does the movie begin? 
% If isInSecondHalf is 1, we will discard the first nth of the arduino data
% stream before looking for an alignment with the movie, where n is
% fractionThroughArduino.
% This helps code find the correct alignment.
% For example, if the movie begins 75% of the way through the arduino data
% stream, set fractionThroughArduino to 3/4.
settings.fractionThroughArduino=1/8; 

% The code will try different scalings of the movie data onto the arduino
% data. An initial guess at the correct scaling will be chosen based on a
% preliminary alignment. The code will then try to further refine this
% estimate (called guess_best_scale) by trying different scalings similar 
% to this best guess. The code will try all scalings between
% tryscales=guess_best_scale+try_scale1:tryinc:guess_best_scale+try_scale2
settings.tryinc=0.00005; % this is the increment for trying different scalings of movie onto arduino data
settings.try_scale1=0.1;
settings.try_scale2=0.15; 
% If the preliminary alignment seems to produce an under-scaling of movie
% data with respect to arduino data, increase try_scale1 and try_scale2.
% If the preliminary alignment seems to produce an over-scaling of movie
% data with respect to arduino data, decrease try_scale1 and try_scale2.

% Similarly, the code will try different delays of the movie data with
% respect to the arduino data. An initial guess at the correct delay is
% chosen based on a preliminary alignment. The code will then try to
% further refine this estimate (called guess_best_delay) by trying
% different delays similar to this best guess. The code will try all delays
% between
% trydelays=guess_best_delay+try_delay1:guess_best_delay+try_delay2;
settings.try_delay1=-200;
settings.try_delay2=200;

% The movie DVR occasionally skips. For final alignment, code will subtly 
% shift sub-sections of movie data to better match arduino data 
% settings.alignSegments=600; % how many indices in each sub-section to independently align
settings.alignSegments=1300; % how many indices in each sub-section to independently align
% For more precise local alignment, decrease alignSegments. For more
% precise global alignment, increase alignSegments.

% The code will automatically align the distractor and cue
% Here we specify additional data to align
% These data types are from arduino
% Align all fields with fieldname alignField(i).name
% Any field named 'cue' or 'falseCueOn' will be automatically aligned (no
% need to include the cue in this list)
settings.alignField(1).name='pelletLoaded';
settings.alignField(1).fromarduino=1;
settings.alignField(2).name='pelletPresented';
settings.alignField(2).fromarduino=1;
settings.alignField(3).name='optoOn';
settings.alignField(3).fromarduino=1;
settings.alignField(4).name='interlockSamples';
settings.alignField(4).fromarduino=1;
settings.alignField(5).name='solenoidOn';
settings.alignField(5).fromarduino=1;
% These data types are from movie
% Note that the names for these should match the names of fields in
% zoneVals
settings.alignField(6).name='optoZone';
settings.alignField(6).fromarduino=0;
settings.alignField(7).name='lickZone';
settings.alignField(7).fromarduino=0;

% How many frames does it take for LED to turn on?
% This will depend on the movie frame rate
settings.maxNFramesForLEDtoChange=2; % LED takes, at most, this many frames to turn on in movie

end