function [centroids] = racunanje_centroida_zadanih_objekata(niz_spoji,masks)
%ova funkcija će izračunati centroide tijela koja treba spojiti
niz_centroida=[];



for i=1:length(niz_spoji)
    for j=1:length(masks)
        if niz_spoji(i)==masks(j).Label
            novi_centroid=centroid_calculator_fcn(masks(j).Mask);
            niz_centroida=[niz_centroida;novi_centroid];
        end
    end 
end
centroids=niz_centroida;
end