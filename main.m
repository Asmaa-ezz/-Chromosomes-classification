% Welcome in  Chromosomes Classification Project
% Create by Asmaa Al-madhoun and Abeer abuzayed

%Insert five images
img1 = imread('G3.bmp');
img2 = imread('O3.bmp');
img3 = imread('T3.bmp');
img4 = imread('C53.bmp');
img5 = imread('C5-53.bmp');

level = 0.99;

img1 = im2bw(img1,level);
img1 = imcomplement(img1);
img1 = imfill(img1, 'holes');

img2 = im2bw(img2,level);
img2 = imcomplement(img2);
img2 = imfill(img2, 'holes');

img3 = im2bw(img3,level);
img3 = imcomplement(img3);
img3 = imfill(img3, 'holes');

img4 = im2bw(img4,level);
img4 = imcomplement(img4);
img4 = imfill(img4, 'holes');

img5 = im2bw(img5,level);
img5 = imcomplement(img5);
img5 = imfill(img5, 'holes');


% Insert the logic table
A = xlsread('Table.xlsx');
input = A(:, [2:6]);
output=  eye(25);
in = input';
out= output';

net = newff(in,out,25);
view(net)
net.divideParam.trainRatio = 1;
net.divideParam.testRatio = 0;
net.divideParam.valRatio = 0;
net.trainParam.lr=0.1;
net.trainParam.min_grad=1e-26;
net.trainParam.goal=0;
net.trainParam.epochs=100;
net = train(net,in,out)

y = net(in);

im = ones(400,500,3);

for i=1:400
   for j=1:400
       vector = [img1(i,j),img2(i,j),img3(i,j),img4(i,j),img5(i,j)];
       n = uint8( net(vector') );
       num = find(n == 1 ); 
       switch num(1)
            case 1
                im(i,j,1)=0;
            case 2
                im(i,j,2)=0;
            case 3
                im(i,j,3)=0;
            case 4
                im(i,j,[1 2])=0;
            case 5
                im(i,j,[1 2])=0.4;
            case 6
                im(i,j,[1 2])=0.7;
            case 7
                im(i,j,[1 3])=0;
            case 8
                im(i,j,[1 3])=0.4;
            case 9
                im(i,j,[1 3])=0.7;
            case 10
                im(i,j,[2 3])=0;
            case 11
                im(i,j,[2 3])=0.4;
            case 12
                im(i,j,[2 3])=0.7;
            case 13
                im(i,j,[1 2 3])=0;
            case 14
                im(i,j,[1 2 3])=0.4;
            case 15
                im(i,j,[1 2 3])=0.7;
            case 16
                im(i,j,[1 [1 3]])=0.2;
                im(i,j,[1 [1 2]])=0.5;
            case 17
                im(i,j,[2 [2 3]])=0.2;
                im(i,j,[2 [2 1]])=0.7;
            case 18
                im(i,j,[3 [3 1]])=0.2;
                im(i,j,[3 [3 2]])=0.7;
            case 19
                im(i,j,[[1 2] 1])=0.6;
            case 20
                im(i,j,[[2 3] 2])=0.8;
                im(i,j,[[3 1] 3])=0.5;
            case 21
                im(i,j,[[3 1] 3])=0.1;
                im(i,j,[[3 2] 3])=0.9;
            case 22
                im(i,j,[1 [2 1]])=0.7;
                im(i,j,[1 [3 1]])=0.2;
            case 23
                im(i,j,[2 [3 2]])=0.5;
                im(i,j,[2 [1 2]])=0.1;
            case 24
                im(i,j,[3 [2 3]])=0.8;
                im(i,j,[3 [1 3]])=0.1;
            case 25 
                 im(i,j,:)=1;
            otherwise
                disp('Erro value')
        end
   end
end
imshow(im)

% ^_^

 