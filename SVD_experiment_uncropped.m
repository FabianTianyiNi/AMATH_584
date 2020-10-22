n = 243;
m = 320;
filedir = '/Users/tianyini/Documents/University of Washington/AMATH 584/yalefaces_uncropped/yalefaces';

subfolder_candidates = dir(fullfile(filedir, '*'));
subfolders = setdiff({subfolder_candidates.name}, {'.', '..'});

flattenedFaces = uint8.empty(77760, 0);

for ii = 1:numel(subfolders)
    F = fullfile(filedir, subfolders{ii});
    singleFace = uint16(imread(F));
    flattenedSingleFace = singleFace(:);
    flattenedFaces = [flattenedFaces flattenedSingleFace];
end

flattenedFaces = double(flattenedFaces);
avgFace = mean(flattenedFaces, 2); % average face of all the faces in the file
X = flattenedFaces - avgFace*ones(1, size(flattenedFaces, 2)); % PCA pre-process the mean-substracted faces

[U, S, V] = svd(X, 'econ');

eigenFaces = zeros(n*8, m*8);
count = 1;
for i=1:8 % to print the first 8*8 eigenfaces from U
    for j=1:8
        eigenFaces(1+(i-1)*n:i*n,1+(j-1)*m: j*m) = reshape(U(:,count),n,m);
        count = count + 1;
    end
end

figure(1),axes('position',[0 0 1 1]), axis off
imagesc(eigenFaces), colormap('gray');

% -------------------------------test on the basis of PCA-------------------------------------------


twoFaces = double(zeros(n*m,0));
for ii = (numel(subfolders) - 1): numel(subfolders) % take the last two images 'yaleB38' and 'yaleB39' as the tests
    T_test = dir(fullfile(filedir,subfolders{ii},'*')); % improve by specifying the file extension.
    C_test = {T_test(~[T_test.isdir]).name}; % files in subfolder.
    testFaces = zeros(n*m, 1, 'uint16');
    for jj = 1:numel(C_test)
        F_test = fullfile(filedir,subfolders{ii},C_test{jj});
        singleTestFace = uint16(imread(F_test));
        singleTestFace = singleTestFace(:); % to flatten the single test face
        testFaces = testFaces + singleTestFace;
    end
    oneSingleTestFace = testFaces / numel(C_test); % average face within a sub-directory
    twoFaces = [twoFaces oneSingleTestFace];
end

testFace = twoFaces(:,1);
testFace = double(testFace);
specialFeature = testFace - avgFace;
index = 0;
figure
for r = [10, 50, 100, 150, 200, 250]
    index = index + 1;
    recon = avgFace + (U(:,1:r)*(U(:,1:r)'*specialFeature));
    subplot(2,2,index); imagesc(reshape(recon, n, m)); axis off 
    title(['r=', num2str(r,'%d')]); colormap('gray'); 
end


testFace = twoFaces(:,2);
testFace = double(testFace);
specialFeature = testFace - avgFace;
index = 0;
figure
for r = [10, 50, 100, 150, 200, 250]
    index = index + 1;
    recon = avgFace + (U(:,1:r)*(U(:,1:r)'*specialFeature));
    subplot(2,2,index); imagesc(reshape(recon, n, m)); axis off
    title(['r=', num2str(r,'%d')]); colormap('gray');
end

        