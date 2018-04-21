clear;
clc;

im  = imread('Set5\head_GT.bmp');
up_scale = 3;
model = 'model\9-5-5(ImageNet)\x3.mat';
im = rgb2ycbcr(im);
im1 = im(:, :, 1);
im2 = im(:, :, 2);
im3 = im(:, :, 3);

im_gnd = modcrop(im, up_scale); % 去除不需要的边缘
im_gnd = single(im_gnd)/255;  %4字节，归一化

im_l = imresize(im_gnd, 1/up_scale, 'bicubic'); % 低分辨率图像
im_b = imresize(im_l, up_scale, 'bicubic'); % 用双三次插值算法后的高分辨率图片

im_h1 = SRCNN(model, im_b(:,:,1)); % SR算法后的高分辨率图像
im_h2 = SRCNN(model, im_b(:,:,2));
im_h3 = SRCNN(model, im_b(:,:,3));
%33.730196
im_h = cat(3, uint8(im_h1*255), uint8(im_h2*255), uint8(im_h3*255)); % ycbcr空间,2、3通道也使用了SR
%im_h = cat(3, uint8(im_h1*255), uint8(im_b(:,:,2)*255), uint8(im_b(:,:,3)*255)); %2、3通道使用双三次插值算法


im_rgb = ycbcr2rgb(im_h);
figure, imshow(im_rgb); title('SRCNN Reconstruction');

psnr_srcnn = compute_psnr(uint8(im_gnd(:,:,1)*255),im_h(:,:,1));
fprintf('PSNR for SRCNN Reconstruction: %f dB\n', psnr_srcnn);
