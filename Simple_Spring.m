clc;
clear;
syms p s Q;
% In this poject, we make a model for simulating an SMA spring
% with change in elongation as an excitement (Not force). the main
% concept is that we  first, develope an approximation for martensit
% fraction in spring's crosssection, with that in hand, we proceede
% to find the equivalent (shear) stress in the crosssection and the 
% respective force in spring's end

% Reference for spring's mathematical model: 10.1088/0964-1726/23/8/085018

% Brinson's model (1993) for superelastic loadings.
% Loadings are in the form of strains (Not Force)
% Code by abbas jafarpour

% Initiate the material properties and variables
% In this section we pass the initial values to necessay arguments. Each part is for a
% paper. The DOI of each paper is included as a comment in each section.
% Also the necessary description for every section is provided. Note that
% in some papers the value of CM and CA are different for loading and
% unloading. In this code i have provided a way to address this as well.
% the four variables S_M_finish, S_M_start, S_A_finish, S_A_start are 1X2
% matrices. the first column is for loading and the secon column is for 
% unloading. if these values are the same for loading and unloading the 
% two columns are identical.

% Also note that the first 3 datas are for SMA wires and the rest are for
% the springs. if you use the 3 first datas, some changes for the code are
% necessary that are explained in the README. Note that the experimental
% datas in the references are digitized and the simulation and experimental
% datas are compared when the simulation ends

% Change this to use different springs for simulation!
X = 7;

if X == 1
    % Wire
    % Reference : 10.1177/1045389X16682839
    Mf = -50; Ms = -45; As = -1; Af = 15;

    CA_Loading = 5.6; CA_Unloading = 5.6;
    CM_Loading = 6  ; CM_Unloading = 6  ; 
    critStressFinish = 100; critStressStart = 35;

    Ea = 35e3; Em = 20e3; eL = 0.067;
    T = 20;

    S_M_finish_Loading = critStressFinish + CM_Loading*(T-Ms); S_M_finish_Unloading = critStressFinish + CM_Unloading*(T-Ms);
    S_M_start_Loading = critStressStart + CM_Loading*(T-Ms); S_M_start_Unloading = critStressStart + CM_Unloading*(T-Ms);
    S_A_start_Loading = CA_Loading*(T-As); S_A_start_Unloading = CA_Unloading*(T-As);
    S_A_finish_Loading = CA_Loading*(T-Af); S_A_finish_Unloading = CA_Unloading*(T-Af);

    S_M_finish = [S_M_finish_Loading S_M_finish_Unloading];
    S_M_start = [S_M_start_Loading S_M_start_Unloading];
    S_A_start = [S_A_start_Loading S_A_start_Unloading];
    S_A_finish = [S_A_finish_Loading S_A_finish_Unloading];

elseif X == 2
    % Wire
    % Reference : 10.1177/1045389X9300400213
    Mf = 9; Ms = 18.4; As = 34.5; Af = 49;

    CA_Loading = 13.8; CA_Unloading = 13.8;
    CM_Loading = 8   ; CM_Unloading = 8   ; 
    critStressFinish = 170; critStressStart = 100;

    Ga = 67e3; Gm = 26.3e3; eL = 0.067;
    T = 60;

    S_M_finish_Loading = critStressFinish + CM_Loading*(T-Ms); S_M_finish_Unloading = critStressFinish + CM_Unloading*(T-Ms);
    S_M_start_Loading = critStressStart + CM_Loading*(T-Ms); S_M_start_Unloading = critStressStart + CM_Unloading*(T-Ms);
    S_A_start_Loading = CA_Loading*(T-As); S_A_start_Unloading = CA_Unloading*(T-As);
    S_A_finish_Loading = CA_Loading*(T-Af); S_A_finish_Unloading = CA_Unloading*(T-Af);

    S_M_finish = [S_M_finish_Loading S_M_finish_Unloading];
    S_M_start = [S_M_start_Loading S_M_start_Unloading];
    S_A_start = [S_A_start_Loading S_A_start_Unloading];
    S_A_finish = [S_A_finish_Loading S_A_finish_Unloading];

elseif X == 3 
    % Wire
    % Reference : 10.1106/104538902022599
    Mf = 42; Ms = 55; As = 52; Af = 65;

    CA_Loading = 8; CA_Unloading = 8;
    CM_Loading = 12   ; CM_Unloading = 12   ; 
    critStressFinish = 172; critStressStart = 138;

    Ga = 45e3; Gm = 20.3e3; eL = 0.067;
    T = 80;

    S_M_finish_Loading = critStressFinish + CM_Loading*(T-Ms); S_M_finish_Unloading = critStressFinish + CM_Unloading*(T-Ms);
    S_M_start_Loading = critStressStart + CM_Loading*(T-Ms); S_M_start_Unloading = critStressStart + CM_Unloading*(T-Ms);
    S_A_start_Loading = CA_Loading*(T-As); S_A_start_Unloading = CA_Unloading*(T-As);
    S_A_finish_Loading = CA_Loading*(T-Af); S_A_finish_Unloading = CA_Unloading*(T-Af);

    S_M_finish = [S_M_finish_Loading S_M_finish_Unloading];
    S_M_start = [S_M_start_Loading S_M_start_Unloading];
    S_A_start = [S_A_start_Loading S_A_start_Unloading];
    S_A_finish = [S_A_finish_Loading S_A_finish_Unloading];

elseif X == 4
    % Spring
    % Reference : 10.3390/s19010050
    % Numerical Simulation and Experimental Study of a Simplified Force-Displacement Relationship in Superelastic SMA Helical Springs
    % Data for SMA-S1
    % pivotPoints = [0 60 0 70 0 80 0 90 0 100 0]
    d0 = 1; r0 = d0/2; % Wire diameter/Radius (mm)
    D0 = 12.8; R0 = D0/2; % Coil diameter/Radius (mm) 
    l0 = 22; % Initial length of spring l0 (mm) 
    N = 7; % Number of coils 
    alpha0 = atan(l0 / (2 * pi * N * R0) ); % Initial helix angle
    L = sqrt(l0^2 + (2 * pi * N * R0)^2); % The total length of the spring

    % No Mf is provided butit has very little effect on the diagrams so we
    % extrapolate and assign 0 to it
    Mf = 0; Ms = 4; As = 7; Af = 17;

    CA_Loading = 11; CA_Unloading = 11;
    CM_Loading = 6.8 ; CM_Unloading = 6.8; 
    critStressFinish = 527/sqrt(3); critStressStart = 99/sqrt(2);

    Ga = (72e3)/2.66; Gm = (60e3)/2.66; eL = 0.037;
    T = 25;

    S_M_finish_Loading = critStressFinish + CM_Loading*(T-Ms); S_M_finish_Unloading = critStressFinish + CM_Unloading*(T-Ms);
    S_M_start_Loading = critStressStart + CM_Loading*(T-Ms); S_M_start_Unloading = critStressStart + CM_Unloading*(T-Ms);
    S_A_start_Loading = CA_Loading*(T-As); S_A_start_Unloading = CA_Unloading*(T-As);
    S_A_finish_Loading = CA_Loading*(T-Af); S_A_finish_Unloading = CA_Unloading*(T-Af);

    % Coefficients to fit the analytical data to experimental data
    % Done by myself, Not the paper
    b = [.6 1 .8 .5];

    S_M_start = [S_M_start_Loading * b(1) S_M_start_Unloading * b(1)];
    S_M_finish = [S_M_finish_Loading * b(2) S_M_finish_Unloading * b(2)];
    S_A_start = [S_A_start_Loading * b(3) S_A_start_Unloading * b(3)];
    S_A_finish = [S_A_finish_Loading * b(4) S_A_finish_Unloading * b(4)];

    ExperimentalDataPath = "Datas\4-SMA-S1.xlsx";

elseif X == 5
    % Reference: http://dx.doi.org/10.1088/0964-1726/24/3/035012
    % Nonlinear geometric influence on the mechanical behavior of shape memory alloy helical spring
    % The data is insufficient. It is not temperature dependant and ca and cm are
    % not provided
    %S-Spring
    d0 = 1.7; r0 = d0/2; % Wire diameter/Radius (mm)
    D0 = 13.8; R0 = D0/2; % Coil diameter/Radius (mm) 
    l0 = 10; % Initial length of spring l0 (mm) 
    N = 5; % Number of coils 
    alpha0 = atan(l0 / (2 * pi * N * R0) ); % Initial helix angle
    L = sqrt(l0^2 + (2 * pi * N * R0)^2); % The total length of the spring

%     %W-Spring
%     d0 = 1.7; r0 = d0/2; % Wire diameter/Radius (mm)
%     D0 = 10.5; R0 = D0/2; % Coil diameter/Radius (mm) 
%     l0 = 6; % Initial length of spring l0 (mm) 
%     N = 3; % Number of coils 
%     alpha0 = atan(l0 / (2 * pi * N * R0) ); % Initial helix angle
%     L = sqrt(l0^2 + (2 * pi * N * R0)^2); % The total length of the spring

    Mf = 9.1; Ms = 24.8; As = 15.7; Af = 30.2;
    CA_Loading = 0; CA_Unloading = 0;
    CM_Loading = 0 ; CM_Unloading = 0; 

    critStressFinish = 0/sqrt(3); critStressStart = 0/sqrt(3);
    Ga = (17.7e3); Gm = (22e3); eL = 0.07/sqrt(3);
    T = 50;

    S_M_finish_Loading =  772/sqrt(3); S_M_finish_Unloading =  772/sqrt(3);
    S_M_start_Loading = 297/sqrt(3); S_M_start_Unloading = 297/sqrt(3);
    S_A_start_Loading = 306/sqrt(3); S_A_start_Unloading = 306/sqrt(3);
    S_A_finish_Loading = 78/sqrt(3); S_A_finish_Unloading = 78/sqrt(3);

    S_M_finish = [S_M_finish_Loading S_M_finish_Unloading];
    S_M_start = [S_M_start_Loading S_M_start_Unloading];
    S_A_start = [S_A_start_Loading S_A_start_Unloading];
    S_A_finish = [S_A_finish_Loading S_A_finish_Unloading];

    ExperimentalDataPath = "Datas\5-S-Spring-45mm.xlsx";
    % ExperimentalDataPath = "Datas\5-S-Spring-100mm.xlsx";
    % ExperimentalDataPath = "Datas\5-W-Spring-25mm.xlsx";
    % ExperimentalDataPath = "Datas\5-W-Spring-40mm.xlsx";

elseif X == 6
    % Reference: 10.1016/j.compstruc.2004.03.025
    % Finite element analysis of superelastic, large deformation behavior of shape memory alloy helical springs
    % In this article a parameter b has been introduced which increases the
    % accuracy of the curves. b is equal to 0.15 in this study


    % Short stroke
    d0 = 1; r0 = d0/2; % Wire diameter/Radius (mm)
    D0 = 7.3; R0 = D0/2; % Coil diameter/Radius (mm) 
    l0 = 5; % Initial length of spring l0 (mm) 
    N = 5; % Number of coils
    alpha0 = atan(l0 / (2 * pi * N * R0) ); % Initial helix angle
    L = sqrt(l0^2 + (2 * pi * N * R0)^2); % The total length of the spring 


    Mf = 0; Ms = 0; As = 0; Af = 0; 
    CA_Loading = 0; CA_Unloading = 0;
    CM_Loading = 0 ; CM_Unloading = 0; 
    
    critStressFinish = 0/sqrt(3); critStressStart = 0/sqrt(3);
    Ga = (12753); Gm = (10690); eL = 0.047;
    T = 50;
    b = .15;

    S_M_finish_Loading =  542.8/sqrt(3) * (1); S_M_finish_Unloading =  542.8/sqrt(3) * (1);
    S_M_start_Loading = 427.8/sqrt(3) * (1); S_M_start_Unloading = 427.8/sqrt(3) * (1);
    S_A_start_Loading = 210.5/sqrt(3) * (1+b); S_A_start_Unloading = 210.5/sqrt(3) * (1+b);
    S_A_finish_Loading = 110.4/sqrt(3) * (1); S_A_finish_Unloading = 110.4/sqrt(3) * (1);

    S_M_finish = [S_M_finish_Loading S_M_finish_Unloading];
    S_M_start = [S_M_start_Loading S_M_start_Unloading];
    S_A_finish = [S_A_finish_Loading S_A_finish_Unloading];
    S_A_start = [S_A_start_Loading S_A_start_Unloading];

    ExperimentalDataPath = "Datas/6-Short_Spring.xlsx";
end

if S_M_start(1) < S_A_start(2)
    fprintf("********\nError, S_A_start has to be bigger than S_M_start.\n If you dont solve it, it may cause the code to be unstable when unloading starts sooner than S_A_start\n*******\n")
end

%Printing the simulation message for user
fprintf("Starting the simulation\n Austenite to martensite transformation region (Loading): [%.2f  %.2f]\n " + ...
    "Martensite to Austenite transformation region (Loading): [%.2f  %.2f]\n", S_M_start(1), S_M_finish(1), S_A_start(1), S_A_finish(1) );

%Initial conditions
e0 = 0;         % Strain
eDot0 = 1;      % Direction of force (+1 for loading and -1 for unloading)
T0 = T;         % Temprature
zS0 = 0;        % Initial stress induced martensite ration
zT0 = 0;        % Initial temprature induced martensite ration
z0 = zS0 + zT0; % Initial martensite ration


% There are two methods to pass the elongation data for the simulation,
% First method is via pivot points, the second method is via experimental data.
method = 2;
if method == 1
    % Determine the loading process as pivot points
    % Remember that elongation should be in millimeters. 
    pivotPoints = [0 60 0 70 0 80 0 90 0 100 0]; % X = 4
    stressIncrementStep = .1; %Remember that strain should not be in Percentage
    e_Elongation = getLoadingProcess(pivotPoints, stressIncrementStep);
    e_Shear = zeros(1,length(e_Elongation));
elseif method == 2
    % Read the required data for comparison
    Temp = readmatrix(ExperimentalDataPath);
    % First column has to be X axis
    e_Elongation = double(transpose(Temp(:,1)));
    e_Shear = zeros(1,length(e_Elongation));
end

verbose = true; % If true, the program will print the progress on the console
plotExperimental = true; % If true, the profram will plot the experimental data as well
timer = true; % Display the elapsed time

% The initial parameters needed fo solving the stress-strain equations on
% transformation.
n = 100; % Number of parts that the transformation range will be devided to (Stress wise)
q_A2M = linspace(S_M_finish(1),S_M_start(1),n)'; % The stress range of transformation divided to n parts
q_M2A = linspace(S_A_start(1),S_A_finish(1),n)'; % The stress range of transformation divided to n parts

% This structure saves some necessary variables that will be passed into
% many functions. Despite it's low speed, I used this to increase the
% readability of the code. You can change this to an array for further
% optimizations but note that ALOT of functions will need to be updated.
params = struct();
params.Gm = Gm; 
params.Ga = Ga;
params.eL = eL;
params.z0 = z0;
params.zS0 = zS0;
params.S_M_finish = S_M_finish(1);
params.S_M_start = S_M_start(1);
params.S_A_finish = S_A_finish(1);
params.S_A_start = S_A_start(1);
params.zDivide = linspace(0, 1, 1000); % Dividing the martensite ratio for further use

[A2M_CORE, M2A_CORE] = martensiteRatio_CORE(params, q_A2M, q_M2A);
strainTable = strainTableGenerator(A2M_CORE, M2A_CORE, q_A2M, q_M2A, params);
stressTable = table(q_A2M,q_M2A,A2M_CORE,M2A_CORE);

q_Force = zeros(1,length(e_Elongation)); % For saving force
q_stress = zeros(1,length(e_Elongation)); % For saving stress

phase = -1;
previousePahse = -1;
reverse = false; phaseChange = false;

synthZ = params.zDivide;
A2M_StressSTrainGrid = zeros(n, length(synthZ));
M2A_StressSTrainGrid = zeros(n, length(synthZ));


hold on;

for i = 1:length(synthZ)
    params.z0 = synthZ(i);
    params.zS0 = synthZ(i);
    tbl = strainTableGenerator(A2M_CORE, M2A_CORE, q_A2M, q_M2A, params);
    A2M_StressSTrainGrid(:,i) = tbl.strain_A2M;
    M2A_StressSTrainGrid(:,i) = tbl.strain_M2A;
end


if timer; tic; end % Start timer
for i=1:1:size(e_Elongation,2)
    if i ==1
        eDot = eDot0;
        prevStrainDot = eDot;
        prevStress = q_stress(1);

        % Calculating the spring diameter change
        alpha = asin( e_Elongation(i) / L + sin(alpha0) );
        R = R0 * cos(alpha) / cos(alpha0);

        shearStrain = e_Elongation(i) * r0 / (2 * pi * N * R^2) * (3/4); % the (3/4) at the end is an approximation for the entire crosssection
        e_Shear(i) = shearStrain;

        [z0,z,previousePahse,q_stress(i),strainTable] = MAIN(z0,z0,previousePahse,shearStrain,eDot0, eDot0, prevStress,T,eL,Gm,Ga,Ms,As, S_M_finish, S_M_start, S_A_finish, S_A_start, verbose, stressTable, strainTable, A2M_StressSTrainGrid, M2A_StressSTrainGrid, params);
        
        % despite this formula gives us the shear strain, we need force so we can get force by this conversion (see ref in X=4)
        q_Force(i) = q_stress(i) * 2 * pi * r0 ^ 3 / 3 / R;
    else
        if verbose ;disp("/////////////////"); end
        prevStrainDot = eDot;
        prevStress = q_stress(i-1);

        % Calculating the spring diameter change
        alpha = asin( e_Elongation(i) / L + sin(alpha0) );
        R = R0 * cos(alpha) / cos(alpha0);


        eDot = sign( (e_Elongation(i) - e_Elongation(i-1)) / e_Elongation(i) );
        shearStrain = e_Elongation(i) * r0 / (2 * pi * N * R^2) * (3/4); % the (3/4) at the end is an approximation for the entire crosssection
        e_Shear(i) = shearStrain;

        [z0,z,previousePahse,q_stress(i),strainTable] = MAIN(z0,z,previousePahse,shearStrain,eDot, prevStrainDot, prevStress, T,eL,Gm,Ga,Ms,As, S_M_finish, S_M_start, S_A_finish, S_A_start, verbose, stressTable, strainTable, A2M_StressSTrainGrid, M2A_StressSTrainGrid, params);

        % despite this formula gives us the shear strain, we need force so we can get force by this conversion (see ref in X=4)
        q_Force(i) = q_stress(i) * 2 * pi * r0 ^ 3 / 3 / R;

        if verbose  ;fprintf("%d- q = %.5f || e = %.5f || z0 = %.5f || z = %.5f|| strainDot = %d|| shearStrain = %f\n",i,q_Force(i),e_Elongation(i),z0,z,eDot,shearStrain), end
         
    end
end
if timer; toc; end % End timer

hold on;
grid off;

% Plotting: in this part we plot the stress strain curve; we want every
% loading cycle to have a spacial color so we seperate the q matrix to
% different loading cycles and plot them seperately with "hold on"

plot(e_Elongation,q_Force,"r")

% Write the chart data to excel
% writematrix([transpose(e) transpose(q)],"Datas\Results.xlsx")

if plotExperimental
    % Read the required data for comparison
    T = readmatrix(ExperimentalDataPath);
    % First column has to be X axis
    exX = T(:,1);
    % Second column has to be Y axis
    exY = T(:,2);
    plot(exX,exY,"blue");
    
    legend("Simulation", "Experiment")
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% The functions %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [z0,z,phase,stress,strainTable] = MAIN(z0,z,previousePahse,strain,strainDot, prevStrainDot, prevStress,T,eL,Gm,Ga,Ms,As, S_M_finish, S_M_start, S_A_finish, S_A_start, verbose, stressTable, strainTable, A2M_StressSTrainGrid, M2A_StressSTrainGrid, params)
    %This function with strain as an input and some other inputs, returns
    %stress and some other variables (These variables are used as inputs for the next iteration)
    %This function helps us avoide doing the calculations inside the loop
    %INPUTS:
    %z0: The martensite ratio at start of previouse phase
    %z: The martensite ratio of previouse iteration (It is different form z0)
    %prevPhase: The phase of previouse iteration
    %strain: Current strain
    %strainDot: Current strain rate

    %Only pseudoelastic
    zT = 0; zT0 = 0;

    %When we reverse in the middle of phase transformation, we need to
    %update z0, but due to us not having the stress, we cant know if we
    %have changed phase (phaseFinder function needs stress as an input)
    %to solve this error, we know if we have reversed if previose eDot
    %is not equal to current eDot. when they are not equal, we update
    %the value of z0
    reverse = false;
    if prevStrainDot ~= strainDot
        reverse = true;
    end

    if reverse
        zS0 = z;
        z0 = z;
    end
    
    % Passing different critical stress's to required functions for loading
    % and unlaoding. This helps us to adopt for the simulations that CM and
    % CA are different for loading and unloading
    if 0 <= strainDot
        i = 1;
    else
        i = 2;
    end

    if (previousePahse == 22 && strainDot == 1) 
        A2M_j = find(stressTable.q_A2M > abs(prevStress), 1, "last");
        tempArr = A2M_StressSTrainGrid(A2M_j:end,:);
        [~,cc] = find(abs(strain) < tempArr, 1, "first");
        zT = 0;
        z  = params.zDivide(cc);
        z0 = params.zDivide(cc);
        params.z0 = z0;
        params.zS0 = z;
        strainTable = strainTableGenerator(stressTable.A2M_CORE, stressTable.M2A_CORE, stressTable.q_A2M, stressTable.q_M2A, params);
    elseif (previousePahse == 55 && strainDot == -1)
        M2A_j = find(stressTable.q_M2A > abs(prevStress), 1, "last");
        tempArr = M2A_StressSTrainGrid(1:M2A_j,:);
        [~,cc] = find(abs(strain) > tempArr, 1, "last");
        zT = 0;
        z  = params.zDivide(cc);
        z0 = params.zDivide(cc);
        params.z0 = z0;
        params.zS0 = z;
        strainTable = strainTableGenerator(stressTable.A2M_CORE, stressTable.M2A_CORE, stressTable.q_A2M, stressTable.q_M2A, params);
    end

    stress = stressFinder(previousePahse, strain, strainDot, T, eL, Gm, Ga, z0, zT, S_M_finish(i), S_M_start(i), S_A_finish(i), S_A_start(i), verbose, stressTable, strainTable);
    phase = phaseFinder(previousePahse,  stress, strainDot,z,z0, S_M_finish(i), S_M_start(i), S_A_finish(i), S_A_start(i), verbose);

    if previousePahse ~= phase
        phaseChange = true;
    else
        phaseChange = false;
    end
    
    % When we finsh phase 2 and go to phase 3 z is not exactly equal to
    %1, this causes errors in stressFinder function, so by this line we
    %fix this
    if (previousePahse == 2 && phase == 3) || (previousePahse == 222 && phase == 3) 
        z = 1;
    elseif (previousePahse == 5 && phase == 6) 
        z = 0;
    end
    
    if phaseChange
        % If the phase changes, update the z0 and zS0. We also need to
        % update the strain table aswell, because the initial martensite
        % ratio changes.
        zS0 = z;
        z0 = z;

        params.z0 = z0;
        params.zS0 = zS0;
        strainTable = strainTableGenerator(stressTable.A2M_CORE, stressTable.M2A_CORE, stressTable.q_A2M, stressTable.q_M2A, params);
    end

    %The get_z function cant process negative stresses, so we multiply the
    %stress by -1 and at the end we change it back
    if(strain < 0)
        NEGATIVESTRAIN = true;
        stress = stress * -1;
    end

    z = get_z(stress,strainDot,T,Ms,As,z0,zT,z, S_M_finish(i), S_M_start(i), S_A_finish(i), S_A_start(i));

    
    if(strain < 0)
        NEGATIVESTRAIN = true;
        stress = stress * -1;
    end
end

function [stress] = stressFinder(prevPhase, strain, strainDot, T, eL, Gm, Ga, z0, zT0, S_M_finish, S_M_start, S_A_finish, S_A_start, verbose, stressTable, strainTable)
    %In this Function we try to get the stress with strain as an input. the
    %logic is: First we assume we are not in transformation phase and try
    %to solve the equation, if no answers were found, our assumption was
    %wrong and we are in transformation phase
    
    %z0 is the z at the start of new phase, but z is the previouse step's
    %martnsite ratio. this comes handy when we are decreasing the strain
    zS0 = z0 - zT0;
    
%     %Defining the phase transformation as function handlers
%     %1.Martensite percentage for austenite to martensite
%     Z_A2M = @(stress) ((1-zS0)/2*cos(pi/(S_M_start - S_M_finish) * (stress - S_M_finish)) + (1 + zS0)/2);
%     %2.Martensite percentage for martensite to austenite
%     Z_M2A = @(stress) (z0/2*(cos( pi/(S_A_start-S_A_finish)*(stress-S_A_start) )+1));


    % The logic for solving the equations: When we are in the linear parts
    % of the loading process, we avoide using vpasolve and in the new
    % update, we substitute the parameters in the stress equation and solve
    % for stress. For the non-linear parts, Again, we have avodied using
    % vpasolve. We divide the transformation regions(A->M and m->A) in to 
    % equal parts and then we finde the respective strain for each stress.
    % Then when we want to solve the transformation stress for each strain, 
    % we use the data acquired previousely. This causes the app's speed to
    % increas like 20 times without any loss of generality.

    %UPDATE: some times, we have negative strain. In order for this
    %function to handle that, we define This constant. if it is true, all
    %the calculations will be in positive numbers but at the end they will
    %be multiplied by -1
    NEGATIVESTRAIN = false;
    
    if(strain < 0)
        NEGATIVESTRAIN = true;
        strain = strain * -1;
    end

    if 0 <= strainDot
        % If stress/strain is increasing search like this
        % 1. Assume no transformation
        if z0 == 0
            r_ = Func_SMA_Shear_Modulus(z0,Gm,Ga,1) * (strain - eL*z0);
            if (0 <= r_) && (r_ <= S_M_start); s = [r_]; else s = []; end
        elseif z0 == 1
            r_ = Func_SMA_Shear_Modulus(z0,Gm,Ga,1) * (strain - eL*z0);
            if (S_M_finish <= r_) && (r_ <= inf); s = [r_]; else s = []; end
        elseif 0 < z0 && z0 < 1
            r_ = Func_SMA_Shear_Modulus(z0,Gm,Ga,1) * (strain - eL*z0);
            if (0 <= r_) && (r_ <= S_M_start); s = [r_]; else s = []; end
        end
        
        if(size(s,1) == 0)
            %2.No answers found, Try phase transformation
    
            % **Note**: I dont know why, but when we use (Func_SMA_Shear_Modulus(Z_A2M(q),Gm,Ga,1)^-1)
            % instead of (Z_M2A(q)/Gm + (1-Z_M2A(q))/Ga) in the relation below, vpasolve has some
            % convergance issues. 
            s = stressFromStrainArray(strain, strainDot, strainTable.strain_A2M, strainTable.strain_M2A, stressTable.q_A2M, stressTable.q_M2A);

            if(size(s,1) == 0)
                % No answers found. Some times this occurs when we finish phase
                % transformation and continue lineraly in the same
                % direction. At the point of transition two problems occur. 
                % first z never reaches exactly to 1 (despite how close it may be) 
                % ,so we cant really know when the transformation ends. 
                % but when iteration  through e(i)'s we reach a point where no
                % answer is found from vpasolve. This is where we know we
                % have passed the transformation level. second is that we
                % have to update z0 to continue iteration, but we have to
                % do it without breaking the iteration loop. so we use
                % recursion to solve this matter.
                if(prevPhase == 2 || prevPhase == 222 )
                    stress = stressFinder(prevPhase, strain, strainDot,T,eL,Gm,Ga,1,zT0, S_M_finish, S_M_start, S_A_finish, S_A_start);
                else
                    if verbose; disp("No answers found! Transformation"); end
                    if verbose; fprintf("strain = %.5f  || z0 = %.5f || prevPhase = %.1f|| strainDot = %.1f\n",strain,z0,prevPhase,strainDot); end
                end
        
            elseif(size(s,1) == 1)
                %Only one answer found
                stress = s(1);
                if verbose;  disp("One answer found! Transformation"); end
            else
                %More than one answer found! 
                %Print an Error message!
                if verbose; disp("#########ERROR##########\nMore than one answer found! Transformation"); end
                stress = -1;
            end
    
        elseif(size(s,1) == 1)
            %Only one answer found
            stress = s(1);
        else
            %More than one answer found! 
            %Print an Error message!
            if verbose; disp("#########ERROR##########\nMore than one answer found!"); end
            stress = -1;
        end


    
    elseif strainDot < 0
        % If stress/strain is decreasing search like this

        % 1.Assume no transformation
        if z0 == 0
            r_ = Func_SMA_Shear_Modulus(z0,Gm,Ga,1) * (strain - eL*z0);
            if (0 <= r_) && (r_ <= S_A_finish); s = [r_]; else s = []; end

            % When the wire turns back at phase 1 with z=0; the code would
            % think its in transformation phase. we add this line to solve
            % this problem. It has been added as a quick fix and its stability 
            % has to be checked more. 
            if prevPhase == 1 || prevPhase == 11
                r_ = Func_SMA_Shear_Modulus(z0,Gm,Ga,1) * (strain - eL*z0);
                if (0 <= r_) && (r_ <= S_M_start); s = [r_]; else s = []; end
            end
        elseif z0 == 1
            r_ = Func_SMA_Shear_Modulus(z0,Gm,Ga,1) * (strain - eL*z0);
            if (S_A_start <= r_) && (r_ <= inf); s = [r_]; else s = []; end
        elseif 0 < z0 && z0 < 1
            r_ = Func_SMA_Shear_Modulus(z0,Gm,Ga,1) * (strain - eL*z0);
            if (S_A_start <= r_) && (r_ <= inf); s = [r_]; else s = []; end
        end
    
        if(size(s,1) == 0)
            %2.No answers found, Try phase transformation
    
            % **Note**: I dont know why, but when we use (Func_SMA_Shear_Modulus(Z_A2M(q),Gm,Ga,1)^-1)
            % instead of (Z_M2A(q)/Gm + (1-Z_M2A(q))/Ga) in the relation below, vpasolve has some
            % convergance issues. 
            s = stressFromStrainArray(strain, strainDot, strainTable.strain_A2M, strainTable.strain_M2A, stressTable.q_A2M, stressTable.q_M2A);
    
%             s = vpasolve( strain == ((Z_M2A(q)/Gm + (1-Z_M2A(q))/Ga)) * q + eL * Z_M2A(q) , q, [S_A_finish S_A_start]);
            
            if(size(s,1) == 0)
                %No answers found. Some times this occurs when we finish phase
                % transformation and continue lineraly in the same
                %direction. At the point of transition two problems occur. 
                % first z never reaches exactly to 1 (despite how close it may be) 
                %,so we cant really know when the transformation ends. 
                % but when iteration  through e(i)'s we reach a point where no
                %answer is found from vpasolve. This is where we know we
                %have passed the transformation level. second is that we
                %have to update z0 to continue iteration, but we have to
                %do it without breaking the iteration loop. so we use
                %recursion to solve this matter.
                if(prevPhase == 5)
                    stress = stressFinder(prevPhase, strain, strainDot,T,eL,Gm,Ga,0,zT0, S_M_finish, S_M_start, S_A_finish, S_A_start);
                else
                    if verbose; disp("No answers found! Transformation"); end
                    if verbose; fprintf("strain = %.5f  || z0 = %.5f || prevPhase = %.1f|| strainDot = %.1f\n",strain,z0,prevPhase,strainDot); end
                end
        
            elseif(size(s,1) == 1)
                %Only one answer found
                stress = s(1);
                if verbose; disp("One answer found! Transformation"); end
            else
                %More than one answer found! 
                %Print an Error message!
                if verbose; disp("#########ERROR##########\nMore than one answer found! Transformation"); end
                stress = -1;
            end
    
        elseif(size(s,1) == 1)
            %Only one answer found
            stress = s(1);
        else
            %More than one answer found! 
            %Print an Error message!
            if verbose; disp("#########ERROR##########\nMore than one answer found!"); end
            stress = -1;
        end

    end
    
    if NEGATIVESTRAIN
        stress = stress * -1;
    end

end

function [phase] = phaseFinder(prevPhase, stress, strainDot,z,z0, S_M_finish, S_M_start, S_A_finish, S_A_start, verbose)
    %Note that due to nature of my project zT is always equal to zero and we can use z instead of zS

    %This function returns the SMA's phase number in pseudoelastic a
    %procedure with Brinsons's (1993 and 1996) constitutive modeling
    %Phase Numbering:
    %loading before phase change : 1  || loading with phase change : 2  || loading after phase change : 3 
    %unloading before phase change : 4  || unloading with phase change : 5  || unloading after phase change : 6 
    %Phases for handeling inner loops are:
    %Loading while in middle of Martensite->Austenite phase change: 8
    %Loading when below martensit transformation start stress while  z != 0: 9
    %Loading while coming back into austenite phase Chaneg area while  z !=0: 10
    %**Note that the phases that are caused from reversals in loading in the middle of  a phase are repeated numers (e.g. 77 or 11)
    %Unloading before Austenite has changed to martensite (reversing in middle of phase 1):11
    %Unloading while in middle of Austenite->Martensite phase change: 22
    %Reversing phase 7 and continuing loading:77
    %Reversing in middle of phase 5 and continuing loading:55
    %
    %
    %For defining the inner loops we also need to know where we came from,
    %so we need the previous step's direction (loading or unloading)
    %* Note that stressDot is the direction of loading, +1 for loading and
    %-1 for unloading

    %UPDATE: some times, we have negative strain. In order for this
    %function to handle that, we define This constant. if it is true, all
    %the calculations will be in positive numbers but at the end they will
    %be multiplied by -1
    NEGATIVESTRAIN = false;
    
    if(stress < 0)
        NEGATIVESTRAIN = true;
        stress = stress * -1;
    end

    phase = -1;
    if (S_M_start < stress && stress < S_M_finish) && 0 < strainDot && z0 == 0
        phase = 2;
    elseif not(S_M_start < stress && stress < S_M_finish) && (stress < S_M_start) && 0 < strainDot && z == 0
        phase = 1;
    elseif not(S_M_start < stress && stress < S_M_finish) && (S_M_finish < stress) && 0 < strainDot
        phase = 3;
    elseif not( S_A_finish < stress && stress < S_A_start  ) && strainDot < 0 && (S_A_start < stress)  && z == 1
        phase = 4;
    elseif ( S_A_finish < stress && stress < S_A_start  ) && strainDot < 0 && 0 < z
        phase = 5;
    elseif not( S_A_finish < stress && stress < S_A_start  ) && strainDot < 0  && (stress < S_A_finish) && prevPhase ~= 11
        %Some times we start unloading while in phase 1, so to
        %differenciate this with phase 6, we have to make a new phase and
        %"&& prevPhase ~= 1" condition as well. to avoid devision by zero
        %add
        phase = 6;
    elseif not(S_M_start < stress && stress < S_M_finish) && (stress < S_M_start) && strainDot < 0 && z == 0
        %Unloading before Austenite has changed to martensite (reversing in middle of phase 1)
        phase = 11;
    elseif (z0 < 1) && (stress < S_M_finish) && (S_A_start < stress) && strainDot < 0
        %Inner loop: Unloading while in middle of Austenite->Martensite phase change
        phase = 22;
    elseif ( S_A_finish < stress && stress < S_A_start  ) && 0 < strainDot && 0 < z
        phase = 55;
    elseif (0 < z0) && (z0 < 1) && (stress < S_M_finish) && (S_A_start < stress) && 0 < strainDot
        %Inner loop: Reversing phase 22 and continuing loading
        phase = 222;
    elseif ( S_A_finish < stress && stress < S_A_start  ) && strainDot < 0 && z < 1
        %Inner loop: Unloading Phase transform from a point where z < 1
        phase = 8;
    elseif (S_M_start < stress && stress < S_M_finish) && 0 < strainDot && 0 < z
        %Inner loop: Loading while coming back into austenite phase Chaneg area while  z !=0
        phase = 10;
    end

    if verbose; fprintf("Phase: %d\n", phase); end
end

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

function [q] = getLoadingProcess(pivotPoints, steps)
    %The user gives us a loading process like [0,450,200,400,0] then this
    %function devides each direction to equal steps and returns a loading
    %procedure.
    q = [];

    q(end+1) = pivotPoints(1);

    for i=1:1:size(pivotPoints,2)-1
        temp = [];
        
        if pivotPoints(i) < pivotPoints(i+1)
            temp = pivotPoints(i)+steps:steps:pivotPoints(i+1);
        else
            temp = pivotPoints(i)-steps:steps*-1:pivotPoints(i+1);
        end
        
        if(temp(end) ~= pivotPoints(i+1))
            temp = [temp pivotPoints(i+1)];
        end
        
        q = [q temp];
    end
end

function [z] = get_z(stress,stressDot,T,Ms,As,zS0,zT0,currZ, S_M_finish, S_M_start, S_A_finish, S_A_start)
    %This function returns total martensite ratio
    z = -99;
    if 0 < stressDot
        %Loading
        [z,~,~] = Func_Brinson_Conversion_To_Detwinned_Martensite(T,stress,Ms,zS0,zT0, S_M_finish, S_M_start, S_A_finish, S_A_start);
    elseif stressDot == 0
        z = -9999999;
    elseif stressDot < 0
        %Unloading
        [z,~,~] = Func_Brinson_Conversion_To_Austenite(T,stress,As,zS0,zT0,currZ, S_M_finish, S_M_start, S_A_finish, S_A_start);
    end
end


function stress = stressFromStrainArray(strain, straindDot, strain_A2M, strain_M2A, q_A2M, q_M2A)
    % This function gets thestress for each strain with respect to
    % direction of the strain. This function is used instead of the vpasolve
    % in the previouse version. This causes the speed of the application to
    % increas roughly 20 times.

    % Args: 
    % strain: double: -
    % strainDot: +1 or -1: direction of the loading, if +1 austenite is
    %   changing to martensinte and vice versa
    % strain_A2M, strain_M2A, q_A2M, q_M2A: matrix: the stress and strains
    %   that the transformation happens

    % Returns: double: The stress for the strain.

    % ** Should run when we need to find stress when we have a change from
    
    if 0 <= straindDot
        % Austenite to martensite
        upperBoundIDX = find(strain < strain_A2M(:),1,"last");
        lowerBoundIDX = find(strain_A2M(:) <= strain, 1,"first");
        
        if isempty(upperBoundIDX) || isempty(lowerBoundIDX)  
            stress = [];
        else
            stress = q_A2M(lowerBoundIDX) + (q_A2M(upperBoundIDX) - q_A2M(lowerBoundIDX)) / (strain_A2M(upperBoundIDX) - strain_A2M(lowerBoundIDX)) * (strain - strain_A2M(lowerBoundIDX));
        end
        
    else
        % Martensite to austenite
        upperBoundIDX = find(strain < strain_M2A(:),1,"last");
        lowerBoundIDX = find(strain_M2A(:) <= strain, 1,"first");
    

        if isempty(upperBoundIDX) || isempty(lowerBoundIDX)  
            stress = [];
        else
            stress = q_M2A(lowerBoundIDX) + (q_M2A(upperBoundIDX) - q_M2A(lowerBoundIDX)) / (strain_M2A(upperBoundIDX) - strain_M2A(lowerBoundIDX)) * (strain - strain_M2A(lowerBoundIDX));
        end
    
    end
end

function tbl =  strainTableGenerator(A2M_CORE, M2A_CORE, q_A2M, q_M2A, params)
    % This function calculates the respective strain for each particular
    % stress. And make a matrix of each martensite ratio and its respective
    % stress for a particular (z0)
    % ** Should run every time z0 chanegs.

    % Args:
    % A2M_CORE, M2A_CORE: matrix: Matrices that contain the core of the
    %   calculations. cos(pi/(S_M_start - S_M_finish) * (stress - S_M_finish))
    %   for austenite to martensite transform and cos(pi/(S_M_start - S_M_finish) * (stress - S_M_finish))
    %   for martensite to austenite.
    % q_A2M, q_M2A: double: The stresses at which austenite to martensite phase transform happens
    % params: struct

    % Returns:
    % A table containig the respective strain for each stress in q_A2M or
    % q_M2A matrix.


    Z_A2M = (1-params.zS0)/2*A2M_CORE+(1+params.zS0)/2;
    strain_A2M = ((Z_A2M/params.Gm + (1-Z_A2M)/params.Ga)) .* q_A2M + params.eL * Z_A2M;
    
    Z_M2A = params.z0/2*M2A_CORE;
    strain_M2A = ((Z_M2A/params.Gm + (1-Z_M2A)/params.Ga)) .* q_M2A + params.eL * Z_M2A;

    tbl = table(strain_A2M, strain_M2A);
end

function [A2M_CORE, M2A_CORE] = martensiteRatio_CORE(params,q_A2M,q_M2A)
    % This function only calculates the part of the formulas that doesn't
    % have z0 in them. Because the z0 changes on every phase changes, by
    % this we avoide redundant calculations. This function has to be
    % complemented by "strainTableGenerator" function.
    % ** Should run on application initialization.

    % Args:
    % params: struct
    % q_A2M, q_M2A: matrix: The stresses at which austenite to martensite phase transform happens

    % Returns:
    % Two matrices containing the calculations

    
    % Defining the phase transformation as function handlers
    % 1.Martensite percentage for austenite to martensite
    Z_A2M_CORE = @(stress) cos(pi/(params.S_M_start - params.S_M_finish) * (stress - params.S_M_finish));
    % 2.Martensite percentage for martensite to austenite
    Z_M2A_CORE = @(stress) (cos( pi/(params.S_A_start-params.S_A_finish)*(stress-params.S_A_start) )+1);
    
    A2M_CORE = Z_A2M_CORE(q_A2M);
    M2A_CORE = Z_M2A_CORE(q_M2A);

end
