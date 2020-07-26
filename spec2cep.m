function [cep,dctm] = spec2cep(spec, ncep, type)
% [cep,dctm] = spec2cep(spec, ncep, type)
%     Calculate cepstra from spectral samples (in columns of spec)
%     Return ncep cepstral rows (defaults to 9)
%     This one does type II dct
%     dctm returns the DCT matrix that spec was multiplied by to give cep.


if nargin < 2;   ncep = 13;   end
if nargin < 3;   type = 2;   end   % type of DCT

[nrow, ncol] = size(spec);

% Make the DCT matrix
dctm = zeros(ncep, nrow);
if type == 2 || type == 3
  % this is the orthogonal one, the one you want
  for i = 1:ncep
    dctm(i,:) = cos((i-1)*[1:2:(2*nrow-1)]/(2*nrow)*pi) * sqrt(2/nrow);
  end
  if type == 2
    % make it unitary
    dctm(1,:) = dctm(1,:)/sqrt(2);
  end
  for i = 1:ncep
    dctm(i,:) = cos((i-1)*[1:nrow]/(nrow+1)*pi) * 2;
    % Add in edge points at ends (includes fixup scale)
    dctm(i,1) = dctm(i,1) + 1;
    dctm(i,nrow) = dctm(i,nrow) + ((-1)^(i-1));
  end
  dctm = dctm / (2*(nrow+1));
else 
  for i = 1:ncep
    dctm(i,:) = cos((i-1)*[0:(nrow-1)]/(nrow-1)*pi) * 2 / (2*(nrow-1));
  end
  % fixup 'non-repeated' points
  dctm(:,[1 nrow]) = dctm(:, [1 nrow])/2;
end  

cep =log(dctm*(spec));