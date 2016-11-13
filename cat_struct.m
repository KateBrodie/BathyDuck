function S3 = cat_struct(S1, S2)
% function S3 = cat_struct(S1, S2)
%
% 19 Dec 2014 - Kent Hathaway
% Work in progress
%
% Concatenates structures S1 ansd S2. 
% Initially created for wavedat's, but hopefully generic enough for other data sets.
%
% Some things may not be perfect in this "generic" version. Such as concatenating structures,
% like meta and meta metaNum - this is an exception that is handeled here but other case
% will arrise.
% Had to make a few checks based on name - in case vector length % matched length of 
% time (like 90 directions and 90 times) - see vecNames.
%
% Assumes there's a time field
% Loops all fields, skips meta, then processes meta last

% Vectors not to concat - not time vectors.  Meta numbers (mn and metaNum) are but handle 
% separately

% Rev 18 Jan 2015 - kkh - some fixes to the merging of meta counter (e.g., metaNum) where ther's NaNs
% Rev 30 Oct 2015 - kkh - added concatentation of matricies and checking field lengths for both
%   structures to determine if the field is more likly a 'time' dimension.  Also a char array could
%   be a time dimension.  Also fixed the concatention of meta and metaNum.
% Rev 31 Dec 2015 - kkh - fixed the parsing of metaNum
% Rev 29 Feb 2016 - kkh - added calling cat_struct again for structure fields.  Added S3 and retain 
%    S1 for easier debugging.
% Rev 6 Mar 2016 - KKH - fixed things I broke in the last revision. 

S3 = S1;   % initialize
if (isfield(S3,'meta'))
	S3 = rmfield(S3, 'meta')
end

vecNames=char('dwdeg', 'dwfhz', 'freq', 'metaNum');
metaNumNames=char('mn','metaNum');

flds1=fieldnames(S1);
flds2=fieldnames(S2);
fn1=length(flds1);         % number of fields in S1
fn2=length(flds2);         % number of fields in S2

T1=getfield(S1,'time');
if (isempty(T1)) 
	disp '<EE> cat_struct: No time field for first structure'
	return
end
  
T2=getfield(S2,'time');
if (isempty(T2)) 
	disp '<EE> cat_struct: No time field for second struct'
	return
end

% number of times in S1 and S2
tnt1=length(T1);         % total number of times, guessing if it's a variable(t)
tnt2=length(T2);         % total number of times, guessing if it's a variable(t)

% assume fn1 has the most fields 
fn=fn1;                    % number of fields

% check if the number of fileds differ
fldNames=flds1;
if (fn1 ~= fn2)
	disp '<WW> cat_struct: Different number of fields in S1 and S2'
	if (fn2 > fn1); 
		fldNames=flds2;
		fn=fn2;
	end
end

% Loop through fields and concat whats necessary, do meta separately
for ii=1:fn
	fldName=char(fldNames(ii,:));
	if (strmatch(fldName, 'meta'))             % just get index and process after loop
		if (isfield(S1, 'metaNum'))
			mn1=S1.metaNum;                         % index of meta field, struct1
		else
			disp '<EE> Missing metaNum field in first data structure'
		end
		if (isfield(S1, 'metaNum'))
			mn2=S2.metaNum;                         % index of meta field, struct1
		else
			disp '<EE> Missing metaNum field in second data structure'
		end
		continue;
	end
	
	fld1=getfield(S1, fldName);
	fld2=getfield(S2, fldName);
	if (isempty(fld2)); continue; end;             % S2 is missing this field, skip
	if (isempty(fld1))
		S3=setfield(S3, fldName, fld2);             % S1 is missing this field, add it
		continue
	end                            
	
	if (isstruct(fld1))
		if (~strcmp(fldName, 'meta'))                                % do meta and meta counter below
			twoStruct = cat_struct(fld1, fld2);
			S3=setfield(S3, fldName, twoStruct);  % cat all
		end
		% Test for ischar and that the char is not a time array
	elseif (isscalar(fld2) | (ischar(fld2) & length(fld1) ~= tnt1 & length(fld2) ~= tnt2) )         % Like a name or lat/lon/obsyear...
		% in the case where there's only one metaNum

	elseif (isvector(fld1))
		if (isempty(strmatch(fldName, vecNames)))                               % not a time variable
			disp(['<DD> concat ' fldName])
			if  (length(fld1) == tnt1 & length(fld2) == tnt2)            % probably a time variable
				S3=setfield(S3, fldName, [fld1 fld2]);                    % cat all, time vectors
			end
		end

	elseif (iscell(fld2))
			S3=setfield(S3, fldName, [fld1 fld2]);  % cat all

	elseif (ismatrix(fld2))
		disp(['<DD> have matrix: ' fldName])
		if  (length(fld1) == tnt1 & length(fld2) == tnt2)                  % probably a time variable, concatenate
			disp(['<DD> matrix ' fldName ' appears to be a time variable'])
			if (size(fld2,2) == tnt2)
				disp(['<DD> cat matrix: ' fldName])
				S3=setfield(S3, fldName, [fld1 fld2]);  % cat all
			else
				disp(['<DD> cat matrix transposed: ' fldName])
				S3=setfield(S3, fldName, [fld1' fld2']);  % cat all
			end
		end
		
	elseif (isempty(fld2))
		disp(['<II>  Do nothing with ' fldName])
	else
		disp(['<WW> cat_struct: Did not recognize this field type: ' fldName])
		return
	end
end

if (isfield(S3, 'size'))
	S3=setfield(S3, 'size', length(S3.time));  % cat all
end

disp '<II> cat_struct: Checking for meta data'

% Was there meta?
if ( isfield(S1, 'meta') + isfield(S2, 'meta') == 1)     % there's meta but only in one struct
	disp '<EE> Only find meta in one structrure, skipping'
	return
end

% Make new meta structure and counter
S3.meta = [];

if (isfield(S1, 'meta'))               % yes, there's meta 
	fld1=getfield(S1, 'meta');          % get S1 meta
	fld2=getfield(S2, 'meta');          % get S2 meta

	mc=1;
	S3.metaNum = ones(1, length(S3.time));      % initialize
	
	for ii=1:length(fld1)          % loop first meta's
		if (isempty(fld1{ii}))       % shouldn't need this for clean data sets
			continue;
		end

		if (mc ==1)                      % look for changes in meta before incrementing counter
			lastMeta=fld1{ii};
			S3.meta{mc} = fld1{ii};
		end
		mi = find(S1.time >= fld1{ii}.time);
		S3.metaNum(mi) = mc;

		% Remove time before comparing meta structs
		metaStr=rmfield(fld1{ii},'time');
		metaStrLast=rmfield(lastMeta,'time');
		
		if (~isequal(metaStr, metaStrLast))             % a new meta structure
			lastMeta = fld1{ii};
			mc = mc+1;
			S3.meta{mc} = fld1{ii};
		end
	end
	
	% Do meta for second structure
	for ii=1:length(fld2)          % loop first meta's
		if (isempty(fld2{ii}))       % shouldn't need this for clean data sets
			continue;
		end

		if (fld2{ii}.time < lastMeta.time)   % meta time must increase
			continue
		end
		mi = find(S1.time >= fld2{ii}.time);
		S3.metaNum(mi) = mc;

		metaStr=rmfield(fld2{ii},'time');
		metaStrLast=rmfield(lastMeta,'time');

		if (~isequal(metaStr, metaStrLast))             % a new meta structure
			lastMeta = fld2{ii};
			mc = mc+1;
			S3.meta{mc} = fld2{ii};
		end
	end
end
