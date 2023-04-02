function [z,zS,zT] = Func_Brinson_Conversion_To_Austenite(T,stress,As,zS0,zT0,currZ, S_M_finish, S_M_start, S_A_finish, S_A_start)
    %This function returns the amount of stress induced and tempreature induced
    %Martensite in the process of SMA's conversion to austenite.
    %The brinson's 1993 constitutive relation has been used
    %z0 : martensite ration in the beginning of loading cycle
    %zT0 : temprature induced martensite ration in the beginning of loading cycle
    %zS0 : Stress induced martensite ration in the beginning of loading cycle
    %currZ: Current martensite ratio of the sample; thiw helps us to avoid
    %division by zero in phase 11
    %Note that Af < T
    %Note that this relation stands true only if: CA*(T-As) < stress < CA*(T-Af)
    %Also note that phase transformation from Martensite to Austenite
    %happens only when specimen is in the "Unloading" phase and stress is
    %decreasing (zDot < 0)

    % Update: in this update we removed the criticalStressStart and
    % criticalStressFinish from the required arguments. the user has to
    % only provide S_A_start and S_A_finish (Critical stress that
    % conversion to austenite starts and ends respectivelt). the user has
    % to calculate these parameters and pass them to method. In some papers
    % there is no criticalStress provided (unlike the brinson's model. we use
    % this method to make the function more friendly for implementing other
    % papaers)
    if (As < T) && (S_A_finish < stress && stress < S_A_start )
        if 0 < currZ
            z0 = zT0 + zS0;
            z = z0/2*(cos( pi/(S_A_start-S_A_finish)*(stress-S_A_start) )+1);
            zS = zS0 - zS0/z0*(z0-z);
            zT = zT0 - zT0/z0*(z0-z);
        else
            zS = zS0;
            zT = zT0;
            z = zS + zT;
        end
        
    else
        zS = zS0;
        zT = zT0;
        z = zS + zT;
    end
end

