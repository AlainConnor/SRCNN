function imgs = modcrop(imgs, modulo)
% 使图片正好为scale的倍数，不是的时候舍去右侧和下侧多余的像素。
if size(imgs,3)==1
    sz = size(imgs);
    sz = sz - mod(sz, modulo);
    imgs = imgs(1:sz(1), 1:sz(2));
else % 由于之前处理过第3维不等于1的情况，所以else不会运行
    tmpsz = size(imgs);
    sz = tmpsz(1:2);
    sz = sz - mod(sz, modulo);
    imgs = imgs(1:sz(1), 1:sz(2),:);
end

