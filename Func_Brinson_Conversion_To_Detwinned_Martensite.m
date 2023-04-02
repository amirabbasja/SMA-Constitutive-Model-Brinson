function [z,zS,zT] = Func_Brinson_Conversion_To_Detwinned_Martensite(T,stress,Ms,zS0,zT0, S_M_finish, S_M_start, S_A_finish, S_A_start)
    %This function returns the amount of stress induced and tempreature induced
    %Martensite in the process of SMA's conversion to detwinned martensite.
    %The brinson's 1993 constitutive relation has been used
    %z0 : martensite ration in the beginning of loading cycle
    %zT0 : temprature induced martensite ration in the beginning of loading cycle
    %zS0 : Stress induced martensite ration in the beginning of loading cycle
    %Note that Ms < T
    %Note that this relation stands true only if: 
    %criticalStressStart + CM*(T-Ms) < stress < criticalStressFinisg + CM*(T-Ms)
    %Also note that phase transformation from austenite to detwinned martensite
    %happens only when specimen is in the "Loading" phase and stress is
    %increasing (0 < zDot)

    % Update: in this update we removed the criticalStressStart and
    % criticalStressFinish from the required arguments. the user has to
    % only provide S_M_start and S_M_finish (Critical stress that
    % conversion to austenite starts and ends respectivelt). the user has
    % to calculate these parameters and pass them to method. In some papers
    % there is no criticalStress provided (unlike the brinson's model. we use
    % this method to make the function more friendly for implementing other
    % papaers)
    if (Ms < T) && (S_M_start < stress && stress < S_M_finish)
        zS = (1-zS0)/2*cos(pi/(S_M_start - S_M_finish) * (stress - S_M_finish)) + (1 + zS0)/2;
        zT = zT0 - zT0 / (1-zT0) * (zS - zS0);
        z = zS + zT;
    else
        zS = zS0;
        zT = zT0;
        z = zS + zT;
    end
end

