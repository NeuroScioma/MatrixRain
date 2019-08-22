function matrixRain(done)

% usage: matrix rain command line progress bar
% done: percentage of progress in each cycle of a loop, from 0 to 1
% example:
%   for iCal = 1:1000
%       myCalculaiont(xx)
%       pause(0.05)
%       matrixRain(iCal/1000)
%   end

% All who interested can use and modify this code freely, as long as the original author is
% referenced and attributed.

% Programmed by Koorosh Mirpour: contact by mirpour at gmail
% V: 1.1 ,190817

% Set the parameters to change the visual effect:

%charRange = [900 1000]; % characters that are used in the rain
charRange = [12353: 12438, 12992:13000]; % for japanese (?) character

nRows = 100; % Number of rows
nCols = 40; % Number of columns
minSpeed = 1; % columns have different speeds, here is min
maxSpeed = 3; % and max
txSpSizeMax = [20, 22]; % the max size of the empty space and the text block
txSpSizeMin = [10, 12]; % % the min size of the empty space and the text block
persistent prevDone
persistent colSpd
persistent mainString
persistent countDown
persistent txSp
persistent iRow
persistent SWITCH
%persistent aString
persistent indLoc

%%
spaceChar = char(12288);
increment = done - prevDone;
if isempty(SWITCH) | done < 0.01
    SWITCH = 1;
    iRow = 0;
    colSpd = randi([minSpeed, maxSpeed], [1, nCols]);
    mainString = repmat(spaceChar, nRows, nCols);
    countDown = randi([txSpSizeMin(1), txSpSizeMax(1)], [nCols, 1]) - 1;
    txSp = randi(2, [nCols, 1]);
    prevDone = done;
    
end

%% for calculation of the bar
prevDone = done;
cyclesLeft = (1 - done) ./ increment;
singleString = repmat(spaceChar, nRows, 1);

for iCol = 1:nCols
    singleString = mainString(:, iCol);
    if countDown(iCol) == 0
        %txSp(iCol) = randi(2,1);
        txSp(iCol) = 3 - txSp(iCol);
        countDown(iCol) = randi([txSpSizeMin(txSp(iCol)), txSpSizeMax(txSp(iCol))], 1);
        if cyclesLeft < (nRows + txSpSizeMax(2))
            txSp(iCol) = 1;
        end
    end
    nRem = colSpd(iCol); %randi(maxSpeed(iCol),1);
    singleString(end-nRem+1:end) = [];
    if txSp(iCol) == 2
        indChar = randi(length(charRange), [nRem, 1]);
        addStr = char(charRange(indChar)');
        if nRem > txSpSizeMax(2)
            exTx = nRem - txSpSizeMax(2);
            addStr(1:exTx) = char(12288);
        end
        singleString = [addStr; singleString];
    else
        singleString = [char(repmat(12288, [nRem, 1])); singleString];
    end
    countDown(iCol) = countDown(iCol) - 1;
    %pause(0.001)
    mainString(:, iCol) = singleString;
end

dispMain = mainString;
clc;

aString = dispMain(end, :);
trinStr = (aString ~= spaceChar);
indSt = find(movsum(trinStr, 2) == 2) - 0;
aString(:) = spaceChar;
for iP = 1:size(indSt, 2)
    prTx = [sprintf('%3d', round(done*100)), '%'];
    aString(indSt(iP):indSt(iP)+3) = prTx;
end

disp(dispMain)
disp(aString)
