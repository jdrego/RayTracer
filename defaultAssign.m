function [X,Y,Z,lightSource,lightIntensity] = defaultAssign(n)
switch n
    case 0
        X = [];
        Y = [];
        Z = [];
        lightSource = [];
        lightIntensity = []; 
    case 1
        X = -100;
        Y = [];
        Z = [];
        lightSource = [];
        lightIntensity = [];
          
    case 2
        X = -100;
        Y = -100;
        Z = [];
        lightSource = [];
        lightIntensity = [];
    case 3
        X = -100;
        Y = -100;
        Z = -100;
        lightSource = [];
        lightIntensity = [];
    case 4
        X = -100;
        Y = -100;
        Z = -100;
        lightSource = -100;
        lightIntensity = [];
    case 5
        X = -100;
        Y = -100;
        Z = -100;
        lightSource = -100;
        lightIntensity = -100;
    otherwise
        error('Too many inputs, max 5 inputs: WallX,WallY,WallZ,lightSourceLocation,LightIntensity.');
end

if isempty(X)
    X = 0;
    disp(strcat('Default WallXLocation=',num2str(X)));   
end
if isempty(Y)
    Y = 0;
    disp(strcat('Default WallYLocation=',num2str(Y)));
end
if isempty(Z)
    Z = 0;
    disp(strcat('Default WallZLocation=',num2str(Z)));
end
if isempty(lightSource)
    lightSource = [5,5,10];
    disp(strcat('Default lightSourceLocation= [',num2str(lightSource), ']'));
end
if isempty(lightIntensity)
    lightIntensity = 100;
    disp(strcat('Default lightIntensity=',num2str(lightIntensity)));
end