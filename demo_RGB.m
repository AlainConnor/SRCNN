clear;
clc;

im  = imread('Set5\head_GT.bmp');
up_scale = 3;
model = 'model\9-5-5(ImageNet)\x3.mat';
im = rgb2ycbcr(im);
im1 = im(:, :, 1);
im2 = im(:, :, 2);
im3 = im(:, :, 3);

im_gnd = modcrop(im, up_scale); % ȥ������Ҫ�ı�Ե
im_gnd = single(im_gnd)/255;  %4�ֽڣ���һ��

im_l = imresize(im_gnd, 1/up_scale, 'bicubic'); % �ͷֱ���ͼ��
im_b = imresize(im_l, up_scale, 'bicubic'); % ��˫���β�ֵ�㷨��ĸ߷ֱ���ͼƬ

im_h1 = SRCNN(model, im_b(:,:,1)); % SR�㷨��ĸ߷ֱ���ͼ��
im_h2 = SRCNN(model, im_b(:,:,2));
im_h3 = SRCNN(model, im_b(:,:,3));
%33.730196
im_h = cat(3, uint8(im_h1*255), uint8(im_h2*255), uint8(im_h3*255)); % ycbcr�ռ�,2��3ͨ��Ҳʹ����SR
%im_h = cat(3, uint8(im_h1*255), uint8(im_b(:,:,2)*255), uint8(im_b(:,:,3)*255)); %2��3ͨ��ʹ��˫���β�ֵ�㷨


im_rgb = ycbcr2rgb(im_h);
figure, imshow(im_rgb); title('SRCNN Reconstruction');

psnr_srcnn = compute_psnr(uint8(im_gnd(:,:,1)*255),im_h(:,:,1));
fprintf('PSNR for SRCNN Reconstruction: %f dB\n', psnr_srcnn);
