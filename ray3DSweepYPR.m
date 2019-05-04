function ray3DSweep
% Establish default dimensions
yawDeg = 0;
yaw = yawDeg*pi/180;

roomSizeX = 10;         %Room length X-coordinate
roomSizeY = 10;         %Room width Y-coordinate
roomSizeZ = 10;         %Room height Z-coordinate
lightSource = [5,5,10]; %Location of LightSource
lightIntensity = 100;   %Light Intensity value

wallHeight = 1;         %Wall Height
wallWidth = 1;          %Wall Width
wall2diDist = 0.25;     %Ditance from wall to diode

xlin = linspace(0,roomSizeX+1,roomSizeX+1);
ylin = linspace(0,roomSizeY+1,roomSizeY+1);
[xx,yy] = meshgrid(xlin,ylin);
syms t;

% Sweep system throughout room
for z = 0:roomSizeZ             %Z-position of wall
    for y = 0:roomSizeY         %Y-position of wall
        for x = 0:roomSizeX     %X-position of wall 
            %Center coordinate for diodes
            di1 = [x-wall2diDist*cos(yaw),y+wall2diDist*sin(yaw),z];  %Moving position of diode 1
            di2 = [x+wall2diDist*cos(yaw),y-wall2diDist*sin(yaw),z];  %Moving position of diode 2

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
            tA = [x-(wallWidth/2)*sin(yaw),y-(wallWidth/2)*cos(yaw),z+wallHeight];  %triangle1 PointA
            tB = [x-(wallWidth/2)*sin(yaw),y-(wallWidth/2)*cos(yaw),z];             %triangle1&2 PointB 
            tC = [x+(wallWidth/2)*sin(yaw),y+(wallWidth/2)*cos(yaw),z+wallHeight];  %triangle1&2 PointC
            tD = [x+(wallWidth/2)*sin(yaw),y+(wallWidth/2)*cos(yaw),z];             %triangle2 PointD

            %rayIntersect checks if ray intersects with Triangle 1 or 2
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
            
            %Depending on intersection, assign intensity to X,Y coordinate
            if (intersect_d1Ray0==1)        %If intersect occurs    
                I1_0(x+1,y+1) = 0;          %Intensity = 0        
            else                            %If intersect does not occur
                I1_0(x+1,y+1) = lightIntensity/norm(d1_0);  %Assign intensity 
            end
            if (intersect_d1Ray1==1)       
                I1_1(x+1,y+1) = 0;        %Intensity = 0        
            else                        
                I1_1(x+1,y+1) = lightIntensity/norm(d1_1);   
            end
            if (intersect_d1Ray2==1)       
                I1_2(x+1,y+1) = 0;        %Intensity = 0        
            else                        
                I1_2(x+1,y+1) = lightIntensity/norm(d1_2);   
            end
            if (intersect_d1Ray3==1)       
                I1_3(x+1,y+1) = 0;        %Intensity = 0        
            else                        
                I1_3(x+1,y+1) = lightIntensity/norm(d1_3);   
            end
            if (intersect_d1Ray4==1)       
                I1_4(x+1,y+1) = 0;        %Intensity = 0        
            else                        
                I1_4(x+1,y+1) = lightIntensity/norm(d1_4);   
            end
            if (intersect_d2Ray0==1)       
                I2_0(x+1,y+1) = 0;        %Intensity = 0        
            else                        
                I2_0(x+1,y+1) = lightIntensity/norm(d2_0);   
            end
            if (intersect_d2Ray1==1)       
                I2_1(x+1,y+1) = 0;        %Intensity = 0        
            else                        
                I2_1(x+1,y+1) = lightIntensity/norm(d2_1);   
            end
            if (intersect_d2Ray2==1)       
                I2_2(x+1,y+1) = 0;        %Intensity = 0        
            else                        
                I2_2(x+1,y+1) = lightIntensity/norm(d2_2);   
            end
            if (intersect_d2Ray3==1)       
                I2_3(x+1,y+1) = 0;        %Intensity = 0        
            else                        
                I2_3(x+1,y+1) = lightIntensity/norm(d2_3);   
            end
            if (intersect_d2Ray4==1)       
                I2_4(x+1,y+1) = 0;        %Intensity = 0        
            else                        
                I2_4(x+1,y+1) = lightIntensity/norm(d2_4);   
            end
        end
    end
    I1 = (I1_0 + I1_1 + I1_2 + I1_3 + I1_4)/5;  %Calculate average of intensity of 5 diode1 points
    I2 = (I2_0 + I2_1 + I2_2 + I2_3 + I2_4)/5;  %Calculate average of intensity of 5 diode2 points
    IRatio = abs(I2-I1)./max(I1,I2); %Intensity difference between the two diodes
    
    %Plot X,Y Intensities for each increasing Z coordinate
    %This if condition only plots even Z values
    if (mod(z,2)==1)   %Z is even
        figure (1)
        %Diode 1 Intesities
        subplot(5,2,z);
        surf(xx,yy,transpose(I1));
        title(['Intensity at Diode 1; Z = ',num2str(z)]);
        xlabel('X-coordinate');
        ylabel('Y-Coordinate');
        zlabel('Intensity of Diode 1');
        
        %Diode 2 Intensities
        subplot(5,2,z+1);
        surf(xx,yy,transpose(I2));
        title(['Intensity at Diode 2; Z = ',num2str(z)])
        xlabel('X-coordinate');
        ylabel('Y-Coordinate');
        zlabel('Intensity of Diode 2');
        
        figure (2)
        %Intensity Ratios
        subplot(5,2,z+1);
        surf(xx,yy,transpose(IRatio));
        title(['Difference Intensity at Diode 2 - Diode 1; Z = ',num2str(z)]);
        xlabel('X-coordinate');
        ylabel('Y-Coordinate');
        zlabel('Intensity of Diode 1');
    end  
end
%%
%         Ray1 = lightSource+t*(d1_0);
%             Ray2 = lightSource+t*(d2_0);
%             P2 = di1 + t*(di1);
%             P3 = di2 + t*(di2);
%             t1 = tA+t*(tB-tA);
%             t2 = tA+t*(tC-tA);
%             t3 = tB+t*(tC-tB);
%             t4 = tD+t*(tB-tD);
%             t5 = tD+t*(tC-tD);

%           if x==2 && y==2 && z==0
%                 figure(3)
%                 R1=ezplot3(Ray1(1),Ray1(2),Ray1(3),[0,1]);
%                 R1.LineWidth = 2;
%                 xlim([0,roomSizeX]);
%                 ylim([0,roomSizeY]);
%                 hold on
%                 R2=ezplot3(Ray2(1),Ray2(2),Ray2(3),[0,1]);
%                 R2.LineWidth = 2;
%                 p1 = ezplot3(Ray1(1),Ray1(2),Ray1(3),[0,0.1]);
%                 p1.LineWidth = 10;
%                 viscircles([x-wall2diDist*cos(yaw),y+wall2diDist*sin(yaw)],0.2,'Color', 'b');
%                 viscircles([x+wall2diDist*cos(yaw),y-wall2diDist*sin(yaw)],0.2,'Color', 'r');
%                 %p2 = ezplot3(P2(1),P2(2),P2(3),[0,0.1]);
%                 %p2.LineWidth = 12;
%                 %p3 = ezplot3(P3(1),P3(2),P3(3),[0,0.1]);
%                 %p3.LineWidth = 12;
%                 T1 = ezplot3(t1(1),t1(2),t1(3),[0,1]);
%                 T1.LineWidth = 1;
%                 T1.Color = 'k';
%                 T2 = ezplot3(t2(1),t2(2),t2(3),[0,1]);
%                 T2.LineWidth = 1;
%                 T2.Color = 'k';
%                 T3 = ezplot3(t3(1),t3(2),t3(3),[0,1]);
%                 T3.LineWidth = 1;
%                 T3.Color = 'k';
%                 T4 = ezplot3(t4(1),t4(2),t4(3),[0,1]);
%                 T4.LineWidth = 1;
%                 T4.Color = 'k';
%                 T5 = ezplot3(t5(1),t5(2),t5(3),[0,1]);
%                 T5.LineWidth = 1;
%                 T5.Color = 'k';
%                 legend('Ray1 light to diode1','Ray2, light to diode2','lightSource','Diode1','Diode2','Wall');
%                 title('Ray Trace. x=2, y=2, z=0');
%                 hold off
%             end
%%
%     elseif(z>5) %Z = 6-10
%         if z==6
%             k=0;    %Use reset k values for subplot iterations
%         end
%         figure (2)
%         %Diode 1 Intensities
%         subplot(5,2,2*k+1);
%         surf(xx,yy,transpose(I1));
%         title(['Intensity at Diode 1; Z = ',num2str(z)]);
%         xlabel('X-coordinate');
%         ylabel('Y-Coordinate');
%         zlabel('Intensity of Diode 1');
%         
%         %Diode 2 Intensities
%         subplot(5,2,2*k+2);
%         surf(xx,yy,transpose(I2));
%         title(['Intensity at Diode 2; Z = ',num2str(z)])
%         xlabel('X-coordinate');
%         ylabel('Y-Coordinate');
%         zlabel('Intensity of Diode 2');
%           
%         k=k+1;
%%
% Ray1 = lightSource+t*(d1_0);
%             Ray2 = lightSource+t*(d2_0);
%             P2 = di1 + t*(di1);
%             P3 = di2 + t*(di2);
%             if x==2 && y==2 && z==0
%                 figure(3)
%                 R1=ezplot3(Ray1(1),Ray1(2),Ray1(3),[0,1]);
%                 R1.LineWidth = 2;
%                 xlim([0,roomSizeX]);
%                 ylim([0,roomSizeY]);
%                 hold on
%                 R2=ezplot3(Ray2(1),Ray2(2),Ray2(3),[0,1]);
%                 R2.LineWidth = 2;
%                 p1 = ezplot3(Ray1(1),Ray1(2),Ray1(3),[0,0.1]);
%                 p1.LineWidth = 10;
%                 p2 = ezplot3(P2(1),P2(2),P2(3),[0,0.1]);
%                 p2.LineWidth = 12;
%                 p3 = ezplot3(P3(1),P3(2),P3(3),[0,0.1]);
%                 p3.LineWidth = 12;
%                 legend('Ray1 light to diode1','Ray2, light to diode2','lightSource','Diode1','Diode2');
%                 title('Ray Trace. x=2, y=2, z=0');
%                 annotation('textbox',[.8 .7 .5 .1],'String','lightSource = [5,5,10]','EdgeColor','none')
%                 hold off
%                 disp(di1)
%                 disp(di2)
%             end
%% 
%             figure (2)
%             subplot(6,1,z+1);
%             surf(xx,yy,transpose(IRatio));
%             title(['Difference Intensity at Diode 2 - Diode 1; Z = ',num2str(z)]);
%             xlabel('X-coordinate');
%             ylabel('Y-Coordinate');
%             zlabel('Intensity of Diode 1');
%%
% figure
% plot(I1, 'r')
% hold on
% plot(I2, 'g')
% hold off
% title('Intensity at Diode vs. X-Location');
% xlabel('X-coordinate');
% ylabel('Intensity');
% legend('Intensity of Diode 1 - Red','Intensity of Diode 2 - Green');

%%
% figure
% subplot(2,1,1);
% surf(xx,yy,transpose(I1));
% title('Intensity at Diode vs. Location');
% xlabel('X-coordinate');
% ylabel('Y-Coordinate');
% zlabel('Intensity of Diode 1');
% subplot(2,1,2);
% surf(xx,yy,transpose(I2));
% xlabel('X-coordinate');
% ylabel('Y-Coordinate');
% zlabel('Intensity of Diode 2');