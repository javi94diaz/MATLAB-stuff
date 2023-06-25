function [digito] = digit_display(k)
    
    load Trainnumbers.mat
    for i=1:28
        for j=1:28
            digito(i,j)=Trainnumbers.image((i-1)*28+j,k);
        end
    end
    
    imshow(digito);
end