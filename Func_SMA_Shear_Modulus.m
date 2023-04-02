function [G] = Func_SMA_Shear_Modulus(z,Gm,Ga, method)
    %FUNC_SMA_SHEAR_MODULUS 
    % in this function we get martensite fraction, (Percentage of martensite in alloy) to
    % outPut SMA's Shear's modulus. 
    % option 1 => We use Reuss scheme (Auricchio and Sacco, 1999): G = (z/Gm + (1-z)/Ga)^-1
    % option 2 => We use Linear destribution: G = Ga+ z*(Gm - Ga)
    % Gm: martensit's Young's modulus
    % Ga: austenite's Young's modulus
    % ** Note that 0 < z < 1 **


    %**NOTE** using method 2 for calculation, has some convergance issues.
    %use method 1 in the code
    
    if (method == 1)
        G = (z/Gm+(1-z)/Ga)^(-1);
    elseif (method == 2)
        G = Ga+ z*(Gm - Ga);
    else
        disp("ERROR in calculating shear modulus, wrong option entered!")
        G = -1;
    end
    
end

