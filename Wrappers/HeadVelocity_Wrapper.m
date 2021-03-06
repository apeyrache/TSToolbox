function [angVel,epClock,epAnti] = HeadVelocity(ang)

% Loads and computes angular head velocity.
%
% USAGE
%     [angVel,epClock,epAnti] = HeadDirectionWhl(fbasename)
%     
% INPUT:
%     fbasename: session file basename
%	
% OUTPUT
%     angVel: a tsd object of angular values
%     epClock: intervalSet object of clockwise rotation epochs
%     epAnti: intervalSet object of anticlockwise rotation epochs

% Adrien Peyrache 2011

da = diff(Data(ang));
da(da<-pi) = da(da<-pi)+2*pi;
da(da>pi) = da(da>pi)-2*pi;

dt = median(diff(Range(ang,'s')));

angVel = tsd(Range(ang),[0;gausssmooth(da,15)/dt]);

epClock = thresholdIntervals(angVel,0.1,'Direction','Above');
epAnti = thresholdIntervals(angVel,-0.1,'Direction','Below');

epClock = dropShortIntervals(epClock,0.2);
epAnti = dropShortIntervals(epAnti,0.2);
