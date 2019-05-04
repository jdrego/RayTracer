function [I1,I2] = rayTrace3D(x,y,z,lightSource,lightIntensity)
%rayTrace3D 
% Establish default dimensions
%Room Dimensions
roomSizeX = 10;         %Room length X-coordinate
roomSizeY = 10;         %Room width Y-coordinate
roomSizeZ = 10;         %Room height Z-coordinate
fprintf('Room Dimension X,Y,Z = %d, %d, %d\n',roomSizeX,roomSizeY,roomSizeZ);
t = 0.25
% Wall Dimensions
wallWidth = 1;          %Wall width Y-Coordinate
wallHeight = 1;         %Wall height Z-Coordinate
wall2diDist = 0.25;     %Distance from wall to diode

% Assign default values if not input
[defMat(1,1),defMat(1,2),defMat(1,3),defMat(1:3,4),defMat(1,5)] = defaultAssign(nargin);
for i = 1:5
    if defMat(1,i) ~= -100
        switch i
            case 1
                x = defMat(1,i);
            case 2
                y = defMat(1,i);
            case 3
                z = defMat(1,i);
            case 4
                lightSource = transpose(defMat(1:3,i));
            case 5
                lightIntensity = defMat(1,i);
        end
    end
end

% Define diode location, Ray direction vectors, and wall triangles
%Center coordinate for diodes
di1 = [x-wall2diDist,y,z];  %Moving position of diode 1
di2 = [x+wall2diDist,y,z];  %Moving position of diode 2

%Direction vectors from lightSource to diodes.
d1_0 = di1-lightSource;             %Center point on diode1
d1_1 = di1+[0,.1,0]-lightSource;    %Top point on diode1
d1_2 = di1+[0,-.1,0]-lightSource;   %Bottom point on diode1
d1_3 = di1+[.1,0,0]-lightSource;    %Right point on diode1
d1_4 = di1+[-.1,0,0]-lightSource;   %Left point on diode1
d2_0 = di2-lightSource;             %Center point on diode2
d2_1 = di2+[0,.1,0]-lightSource;    %Top point on diode2
d2_2 = di2+[0,-.1,0]-lightSource;   %Bottom point on diode2
d2_3 = di2+[.1,0,0]-lightSource;    %Right point on diode2
d2_4 = di2+[-.1,0,0]-lightSource;   %Left point on diode2
            
%Triangle coordinates. Triangle1 = ABC, Triangle2 = BCD
tA = [x,y-(wallWidth/2),z+wallHeight];            %triangle1 PointA
tB = [x,y-(wallWidth/2),z];                       %triangle1&2 PointB 
tC = [x,y+(wallWidth/2),z+wallHeight];  %triangle1&2 PointC
tD = [x,y+(wallWidth/2),z];             %triangle2 PointD
            
% rayIntersect checks if ray intersects with Triangle 1 or 2
intersect_d1Ray0 = rayIntersect(tA,tB,tC,tD,lightSource,d1_0);
intersect_d1Ray1 = rayIntersect(tA,tB,tC,tD,lightSource,d1_1);
intersect_d1Ray2 = rayIntersect(tA,tB,tC,tD,lightSource,d1_2);
intersect_d1Ray3 = rayIntersect(tA,tB,tC,tD,lightSource,d1_3);
intersect_d1Ray4 = rayIntersect(tA,tB,tC,tD,lightSource,d1_4);
intersect_d2Ray0 = rayIntersect(tA,tB,tC,tD,lightSource,d2_0);
intersect_d2Ray1 = rayIntersect(tA,tB,tC,tD,lightSource,d2_1);
intersect_d2Ray2 = rayIntersect(tA,tB,tC,tD,lightSource,d2_2);
intersect_d2Ray3 = rayIntersect(tA,tB,tC,tD,lightSource,d2_3);
intersect_d2Ray4 = rayIntersect(tA,tB,tC,tD,lightSource,d2_4);

% Depending on intersection, assign intensity to X,Y coordinate
if (intersect_d1Ray0==1)        %If intersect occurs
    I1_0 = 0;          %Intensity = 0
else                            %If intersect does not occur
    I1_0 = lightIntensity/norm(d1_0);  %Assign intensity
end
if (intersect_d1Ray1==1)       
    I1_1 = 0;        %Intensity = 0        
else                        
    I1_1 = lightIntensity/norm(d1_1);   
end
if (intersect_d1Ray2==1)       
    I1_2 = 0;        %Intensity = 0        
else                        
    I1_2 = lightIntensity/norm(d1_2);   
end
if (intersect_d1Ray3==1)       
    I1_3 = 0;        %Intensity = 0        
else                        
    I1_3 = lightIntensity/norm(d1_3);   
end
if (intersect_d1Ray4==1)       
    I1_4 = 0;        %Intensity = 0        
else                        
    I1_4 = lightIntensity/norm(d1_4);   
end
if (intersect_d2Ray0==1)       
    I2_0 = 0;        %Intensity = 0        
else                        
    I2_0 = lightIntensity/norm(d2_0);   
end
if (intersect_d2Ray1==1)       
    I2_1 = 0;        %Intensity = 0        
else                        
    I2_1 = lightIntensity/norm(d2_1);   
end
if (intersect_d2Ray2==1)       
    I2_2 = 0;        %Intensity = 0        
else                        
    I2_2 = lightIntensity/norm(d2_2);   
end
if (intersect_d2Ray3==1)       
    I2_3 = 0;        %Intensity = 0        
else                        
    I2_3 = lightIntensity/norm(d2_3);   
end
if (intersect_d2Ray4==1)       
    I2_4 = 0;        %Intensity = 0        
else                        
    I2_4 = lightIntensity/norm(d2_4);   
end
I1 = (I1_0 + I1_1 + I1_2 + I1_3 + I1_4)/5;  %Calculate average of intensity of 5 diode1 points
I2 = (I2_0 + I2_1 + I2_2 + I2_3 + I2_4)/5;  %Calculate average of intensity of 5 diode2 points
IRatio = abs(I2_0-I1_0)./max(I1_0,I2_0);
disp('diode 1 Intensity = ');
disp(I1_0);
disp('diode 2 Intensity = ');
disp(I2_0);
disp('Difference = ');
disp(IRatio);







