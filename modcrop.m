function imgs = modcrop(imgs, modulo)
% ʹͼƬ����Ϊscale�ı��������ǵ�ʱ����ȥ�Ҳ���²��������ء�
if size(imgs,3)==1
    sz = size(imgs);
    sz = sz - mod(sz, modulo);
    imgs = imgs(1:sz(1), 1:sz(2));
else % ����֮ǰ�������3ά������1�����������else��������
    tmpsz = size(imgs);
    sz = tmpsz(1:2);
    sz = sz - mod(sz, modulo);
    imgs = imgs(1:sz(1), 1:sz(2),:);
end

