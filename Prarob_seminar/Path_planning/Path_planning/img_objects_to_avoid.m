function [img] = img_objects_to_avoid(niz_zaobidi,masks)
%ova će funkcija napraviti img od maski koje moramo zaobilaziti
masks_sum=0;

for i=1:length(niz_zaobidi)
      for j=1:length(masks)
          if niz_zaobidi(i)==masks(j).Label
              masks_sum=masks_sum+masks(j).Mask;
          end
      end
end
img=masks_sum;
end
     
  

