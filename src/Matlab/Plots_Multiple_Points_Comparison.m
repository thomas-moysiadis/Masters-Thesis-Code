clear
clc

%Define Constants
R1 = 32*10^(-3); %m
R2 = 16*10^(-3); %m
R3 = 16*10^(-3); %m
L2 = 25*10^(-3); %m
L3 = 25*10^(-3); %m
r = 7850; %kg/m^3
m1 = r*4/3*pi*R1^3; %kg
m2 = r*pi*R2^2*L2; %kg
m3 = r*pi*R3^2*L3; %kg
t1 = 0; %Nm
t2 = 0; %Nm
t3 = 0; %Nm
t4 = 0; %Nm

%Read Python Data
y1 = readmatrix("data_points_1.xlsx");
y2 = readmatrix("data_points_2.xlsx");
y3 = readmatrix("data_points_3.xlsx");
y4 = readmatrix("data_points_4.xlsx");
y5 = readmatrix("data_points_5.xlsx");
y = zeros(1496, 18);
y(1:299,:) = y1(2:end,:);
y(299+1:2*299,:) = y2(2:end,:);
y(2*299+1:3*299,:) = y3(2:end,:);
y(3*299+1:4*299,:) = y4(2:end,:);
y(4*299+1:end,:) = y5(2:end,:);
time1 = linspace(0,3,300);
time2 = linspace(3,6,300);
time3 = linspace(6,9,300);
time4 = linspace(9,12,300);
time5 = linspace(12,15,300);
t = zeros(1,1496);
t(1:299) = time1(1:end-1);
t(299+1:2*299) = time2(1:end-1);
t(2*299+1:3*299) = time3(1:end-1);
t(3*299+1:4*299) = time4(1:end-1);
t(4*299+1:end) = time5;

%Read MotionView Data
Y1 = readmatrix("theta.csv");
Y2 = readmatrix("phi.csv");
Y3 = readmatrix("psi.csv");
Y4 = readmatrix("Wx_1.csv");
Y5 = readmatrix("Wy_1.csv");
Y6 = readmatrix("Wz_1.csv");
Y7 = readmatrix("Ax_1.csv");
Y8 = readmatrix("Ay_1.csv");
Y9 = readmatrix("Az_1.csv");
Y10 = readmatrix("theta_r2.csv");
Y11 = readmatrix("theta_p2.csv");
Y12 = readmatrix("theta_r2_dot.csv");
Y13 = readmatrix("theta_p2_dot.csv");
Y14 = readmatrix("Wx_2.csv");
Y15 = readmatrix("Wy_2.csv");
Y16 = readmatrix("Wz_2.csv");
Y17 = readmatrix("theta_r2_dot_dot.csv");
Y18 = readmatrix("theta_p2_dot_dot.csv");
Y19 = readmatrix("Ax_2.csv");
Y20 = readmatrix("Ay_2.csv");
Y21 = readmatrix("Az_2.csv");
Y22 = readmatrix("theta_r3.csv");
Y23 = readmatrix("theta_p3.csv");
Y24 = readmatrix("theta_r3_dot.csv");
Y25 = readmatrix("theta_p3_dot.csv");
Y26 = readmatrix("Wx_3.csv");
Y27 = readmatrix("Wy_3.csv");
Y28 = readmatrix("Wz_3.csv");
Y29 = readmatrix("theta_r3_dot_dot.csv");
Y30 = readmatrix("theta_p3_dot_dot.csv");
Y31 = readmatrix("Ax_3.csv");
Y32 = readmatrix("Ay_3.csv");
Y33 = readmatrix("Az_3.csv");
Y34 = readmatrix("Tx_1_2.csv");
Y35 = readmatrix("Tx_1_3.csv");
Y36 = readmatrix("Ty_1_2.csv");
Y37 = readmatrix("Ty_1_3.csv");
Y38 = readmatrix("Tz_1_2.csv");
Y39 = readmatrix("Tz_1_3.csv");
Y40 = readmatrix("Tx_2.csv");
Y41 = readmatrix("Ty_2.csv");
Y42 = readmatrix("Tz_2.csv");
Y43 = readmatrix("Tx_3.csv");
Y44 = readmatrix("Ty_3.csv");
Y45 = readmatrix("Tz_3.csv");

%Prepare MotionView Data
Y = [Y1(:,2) Y2(:,2) Y3(:,2) Y4(:,2)/pi*180 Y5(:,2)/pi*180 Y6(:,2)/pi*180 Y7(:,2)/pi*180 Y8(:,2)/pi*180 Y9(:,2)/pi*180 Y10(:,2) Y11(:,2) Y12(:,2)/pi*180 Y13(:,2)/pi*180 Y14(:,2)/pi*180 Y15(:,2)/pi*180 Y16(:,2)/pi*180 Y17(:,2)/pi*180 Y18(:,2)/pi*180 Y19(:,2)/pi*180 Y20(:,2)/pi*180 Y21(:,2)/pi*180 Y22(:,2) -Y23(:,2) Y24(:,2)/pi*180 -Y25(:,2)/pi*180 Y26(:,2)/pi*180 Y27(:,2)/pi*180 Y28(:,2)/pi*180 Y29(:,2)/pi*180 -Y30(:,2)/pi*180 Y31(:,2)/pi*180 Y32(:,2)/pi*180 Y33(:,2)/pi*180];
T = Y4(:,1)';

%Compute Global Angular Velocity and Acceleration for Sphere from Python Data
Wx = y(:,2) + sin(y(:,3)).*y(:,6);
Wy = cos(y(:,1)).*y(:,4) - cos(y(:,3)).*sin(y(:,1)).*y(:,6);
Wz = sin(y(:,1)).*y(:,4) + cos(y(:,3)).*cos(y(:,1)).*y(:,6);
Ax = ((5/2/m1/R1*(y(:,18)-y(:,15).*sin(y(:,3)).*cos(y(:,3)).*cos(y(:,1))+y(:,16).*cos(y(:,3)).*sin(y(:,3)).*sin(y(:,1))-y(:,17).*sin(y(:,3)).*cos(y(:,3)).*cos(y(:,1))-y(:,18).*sin(y(:,3)).^2)+sin(y(:,3)).*cos(y(:,3)).*y(:,4).*y(:,2)-cos(y(:,3)).*y(:,4).*y(:,6))./(1-sin(y(:,3)).^2)) + cos(y(:,3)).*y(:,6).*y(:,4) + sin(y(:,3)).*((5/2/m1/R1*(y(:,15).*cos(y(:,3)).*cos(y(:,1))-y(:,16).*cos(y(:,3)).*sin(y(:,1))+y(:,17).*cos(y(:,3)).*cos(y(:,1)))-cos(y(:,3)).*y(:,4).*y(:,2)+sin(y(:,3)).*cos(y(:,3)).*y(:,4).*y(:,6))./(1-sin(y(:,3)).^2));
Ay = -sin(y(:,1)).*y(:,4).*y(:,2) + cos(y(:,1)).*(5/2/m1/R1*(y(:,15).*sin(y(:,1))+y(:,16).*cos(y(:,1))+y(:,17).*sin(y(:,1)))+cos(y(:,3)).*y(:,2).*y(:,6)) + sin(y(:,3)).*sin(y(:,1)).*y(:,4).*y(:,6) - cos(y(:,3)).*cos(y(:,1)).*y(:,6).*y(:,2) - cos(y(:,3)).*sin(y(:,1)).*((5/2/m1/R1*(y(:,15).*cos(y(:,3)).*cos(y(:,1))-y(:,16).*cos(y(:,3)).*sin(y(:,1))+y(:,17).*cos(y(:,3)).*cos(y(:,1)))-cos(y(:,3)).*y(:,4).*y(:,2)+sin(y(:,3)).*cos(y(:,3)).*y(:,4).*y(:,6))./(1-sin(y(:,3)).^2));
Az = cos(y(:,1)).*y(:,2).*y(:,4) + sin(y(:,1)).*(5/2/m1/R1*(y(:,15).*sin(y(:,1))+y(:,16).*cos(y(:,1))+y(:,17).*sin(y(:,1)))+cos(y(:,3)).*y(:,2).*y(:,6)) - sin(y(:,3)).*cos(y(:,1)).*y(:,4).*y(:,6) - cos(y(:,3)).*sin(y(:,1)).*y(:,6).*y(:,2) + cos(y(:,3)).*cos(y(:,1)).*((5/2/m1/R1*(y(:,15).*cos(y(:,3)).*cos(y(:,1))-y(:,16).*cos(y(:,3)).*sin(y(:,1))+y(:,17).*cos(y(:,3)).*cos(y(:,1)))-cos(y(:,3)).*y(:,4).*y(:,2)+sin(y(:,3)).*cos(y(:,3)).*y(:,4).*y(:,6))./(1-sin(y(:,3)).^2));
%Sphere Angular Displacement, Velocity and Acceleration Plots
f1 = figure;
a1 = tiledlayout(3,1);
nexttile
hold on
plot(t,y(:,1)/pi*180,"r");
plot(T,Y(:,1),"b--");
ylabel("θ (deg)");
grid on
hold off

nexttile
hold on
plot(t,y(:,3)/pi*180,"r");
plot(T,Y(:,2),"b--");
ylabel("φ (deg)");
grid on
hold off

nexttile
hold on
plot(t,y(:,5)/pi*180,"r");
plot(T,Y(:,3),"b--");
ylabel("ψ (deg)");
grid on
hold off

title(a1, "Comparison of Angular Displacement for Sphere");
xlabel(a1, "Time t (s)");
lg_1 = legend(["Python Simulation", "MotionView Simulation"]);
lg_1.Layout.Tile = "North";

f2 = figure;
a2 = tiledlayout(3,1);
nexttile
hold on
plot(t,Wx/pi*180,"r");
plot(T,Y(:,4),"b--");
ylabel("Wx1 (deg/s)");
grid on
hold off

nexttile
hold on
plot(t,Wy/pi*180,"r");
plot(T,Y(:,5),"b--");
ylabel("Wy1 (deg/s)");
grid on
hold off

nexttile
hold on
plot(t,Wz/pi*180,"r");
plot(T,Y(:,6),"b--");
ylabel("Wz1 (deg/s)");
grid on
hold off

title(a2, "Comparison of Global Angular Velocity for Sphere");
xlabel(a2, "Time t (s)");
lg_2 = legend(["Python Simulation", "MotionView Simulation"]);
lg_2.Layout.Tile = "North";

f3 = figure;
a3 = tiledlayout(3,1);
nexttile
hold on
plot(t,Ax/pi*180,"r");
plot(T,Y(:,7),"b--");
ylabel("Ax1 (deg/s^2)");
grid on
hold off

nexttile
hold on
plot(t,Ay/pi*180,"r");
plot(T,Y(:,8),"b--");
ylabel("Ay1 (deg/s^2)");
grid on
hold off

nexttile
hold on
plot(t,Az/pi*180,"r");
plot(T,Y(:,9),"b--");
ylabel("Az1 (deg/s^2)");
grid on
hold off

title(a3, "Comparison of Global Angular Acceleration for Sphere");
xlabel(a3, "Time t (s)");
lg_3 = legend(["Python Simulation", "MotionView Simulation"]);
lg_3.Layout.Tile = "North";

%Compute Global Angular Velocity and Acceleration for Cylinder 1 from Python Data
Wx_1 = y(:,8);
Wy_1 = cos(y(:,7)).*y(:,10);
Wz_1 = sin(y(:,7)).*y(:,10);
Ax_1 = t1/(1/4*m2*R2^2+1/12*m2*L2^2)*ones(length(t),1);
Ay_1 = -sin(y(:,7)).*y(:,10).*y(:,8) + cos(y(:,7)).*(2/m2/R2*(t2/R2*ones(length(t),1)+y(:,15).*sin(y(:,7))+y(:,16).*cos(y(:,7))));
Az_1 = cos(y(:,7)).*y(:,10).*y(:,8) + sin(y(:,7)).*(2/m2/R2*(t2/R2*ones(length(t),1)+y(:,15).*sin(y(:,7))+y(:,16).*cos(y(:,7))));
%Cylinder 1 Angular Displacement, Velocity and Acceleration Plots
f4 = figure;
a4 = tiledlayout(2,1);
nexttile
hold on
plot(t,y(:,7)/pi*180,"r");
plot(T,Y(:,10),"b--");
ylabel("θr2 (deg)");
grid on
hold off

nexttile
hold on
plot(t,y(:,9)/pi*180,"r");
plot(T,Y(:,11),"b--");
ylabel("θp2 (deg)");
grid on
hold off

title(a4, "Comparison of Angular Displacement for Cylinder 1");
xlabel(a4, "Time t (s)");
lg_4 = legend(["Python Simulation", "MotionView Simulation"]);
lg_4.Layout.Tile = "North";

f5 = figure;
a5 = tiledlayout(3,1);
nexttile
hold on
plot(t,Wx_1/pi*180,"r");
plot(T,Y(:,14),"b--");
ylabel("Wx2 (deg/s)");
grid on
hold off

nexttile
hold on
plot(t,Wy_1/pi*180,"r");
plot(T,Y(:,15),"b--");
ylabel("Wy2 (deg/s)");
grid on
hold off

nexttile
hold on
plot(t,Wz_1/pi*180,"r");
plot(T,Y(:,16),"b--");
ylabel("Wz2 (deg/s)");
grid on
hold off

title(a5, "Comparison of Global Angular Velocity for Cylinder 1");
xlabel(a5, "Time t (s)");
lg_5 = legend(["Python Simulation", "MotionView Simulation"]);
lg_5.Layout.Tile = "North";

f6 = figure;
a6 = tiledlayout(3,1);
nexttile
hold on
plot(t,Ax_1/pi*180,"r");
plot(T,Y(:,19),"b--");
ylabel("Ax2 (deg/s^2)");
grid on
hold off

nexttile
hold on
plot(t,Ay_1/pi*180,"r");
plot(T,Y(:,20),"b--");
ylabel("Ay2 (deg/s^2)");
grid on
hold off

nexttile
hold on
plot(t,Az_1/pi*180,"r");
plot(T,Y(:,21),"b--");
ylabel("Az2 (deg/s^2)");
ylim([-600 300]);
grid on
hold off

title(a6, "Comparison of Global Angular Acceleration for Cylinder 1");
xlabel(a6, "Time t (s)");
lg_6 = legend(["Python Simulation", "MotionView Simulation"]);
lg_6.Layout.Tile = "North";

%Compute Global Angular Velocity and Acceleration for Cylinder 2 from Python Data
Wx_2 = -cos(y(:,11)).*y(:,14);
Wy_2 = y(:,12);
Wz_2 = sin(y(:,11)).*y(:,14);
Ax_2 = sin(y(:,11)).*y(:,14).*y(:,12) - cos(y(:,11)).*(2/m3/R3*(t4/R3*ones(length(t),1)+y(:,17).*sin(y(:,11))-y(:,18).*cos(y(:,11))));
Ay_2 = t3/(1/4*m3*R3^2+1/12*m3*L3^2)*ones(length(t),1);
Az_2 = cos(y(:,11)).*y(:,14).*y(:,12) + sin(y(:,11)).*(2/m3/R3*(t4/R3*ones(length(t),1)+y(:,17).*sin(y(:,11))-y(:,18).*cos(y(:,11))));
%Cylinder 2 Angular Displacement, Velocity and Acceleration Plots
f7 = figure;
a7 = tiledlayout(2,1);
nexttile
hold on
plot(t,y(:,11)/pi*180,"r");
plot(T,Y(:,22),"b--");
ylabel("θr3 (deg)");
grid on
hold off

nexttile
hold on
plot(t,y(:,13)/pi*180,"r");
plot(T,Y(:,23),"b--");
ylabel("θp3 (deg)");
grid on
hold off

title(a7, "Comparison of Angular Displacement for Cylinder 2");
xlabel(a7, "Time t (s)");
lg_7 = legend(["Python Simulation", "MotionView Simulation"]);
lg_7.Layout.Tile = "North";

f8 = figure;
a8 = tiledlayout(3,1);
nexttile
hold on
plot(t,Wx_2/pi*180,"r");
plot(T,Y(:,26),"b--");
ylabel("Wx3 (deg/s)");
grid on
hold off

nexttile
hold on
plot(t,Wy_2/pi*180,"r");
plot(T,Y(:,27),"b--");
ylabel("Wy3 (deg/s)");
grid on
hold off

nexttile
hold on
plot(t,Wz_2/pi*180,"r");
plot(T,Y(:,28),"b--");
ylabel("Wz3 (deg/s)");
grid on
hold off

title(a8, "Comparison of Global Angular Velocity for Cylinder 2");
xlabel(a8, "Time t (s)");
lg_8 = legend(["Python Simulation", "MotionView Simulation"]);
lg_8.Layout.Tile = "North";

f9 = figure;
a9 = tiledlayout(3,1);
nexttile
hold on
plot(t,Ax_2/pi*180,"r");
plot(T,Y(:,31),"b--");
ylabel("Ax3 (deg/s^2)");
grid on
hold off

nexttile
hold on
plot(t,Ay_2/pi*180,"r");
plot(T,Y(:,32),"b--");
ylabel("Ay3 (deg/s^2)");
grid on
hold off

nexttile
hold on
plot(t,Az_2/pi*180,"r");
plot(T,Y(:,33),"b--");
ylabel("Az3 (deg/s^2)");
grid on
hold off

title(a9, "Comparison of Global Angular Acceleration for Cylinder 2");
xlabel(a9, "Time t (s)");
lg_9 = legend(["Python Simulation", "MotionView Simulation"]);
lg_9.Layout.Tile = "North";

%Compute Mechanical - Kinetic Energy from Python Data
T1_1 = 1/5*m1*R1^2*(y(:,2)+sin(y(:,3)).*y(:,6)).^2 + 1/5*m1*R1^2*(cos(y(:,1)).*y(:,4)-cos(y(:,3)).*sin(y(:,1)).*y(:,6)).^2 + 1/5*m1*R1^2*(sin(y(:,1)).*y(:,4)+cos(y(:,3)).*cos(y(:,1)).*y(:,6)).^2;
T2_1 = 1/4*m2*R2^2*y(:,10).^2 + (1/8*m2*R2^2+1/24*m2*L2^2)*y(:,8).^2;
T3_1 = 1/4*m3*R3^2*y(:,14).^2 + (1/8*m3*R3^2+1/24*m3*L3^2)*y(:,12).^2;
T_1 = T1_1 + T2_1 + T3_1;

%Compute Mechanical - Kinetic Energy from MotionView Data
T1_2 = 1/5*m1*R1^2*(Y(:,4)/180*pi).^2 + 1/5*m1*R1^2*(Y(:,5)/180*pi).^2 + 1/5*m1*R1^2*(Y(:,6)/180*pi).^2;
T2_2 = 1/4*m2*R2^2*(Y(:,13)/180*pi).^2 + (1/8*m2*R2^2+1/24*m2*L2^2)*(Y(:,12)/180*pi).^2;
T3_2 = 1/4*m3*R3^2*(Y(:,25)/180*pi).^2 + (1/8*m3*R3^2+1/24*m3*L3^2)*(Y(:,24)/180*pi).^2;
T_2 = T1_2 + T2_2 + T3_2;
%Mechanical - Kinetic Energy Plot
f10 = figure;
hold on
plot(t,T_1,"r");
plot(T,T_2,"b--");
xlabel("Time t (s)");
ylabel(" Mechanical - Kinetic Energy (J)");
title("Comparison of Mechanical - Kinetic Energy");
legend(["Python Simulation", "MotionView Simulation"]);
grid on
hold off

%Compute Constraints Torques from Python Data
CF1 = R1*y(:,18);
CF2 = R1*y(:,15).*sin(y(:,1)) + R1*y(:,16).*cos(y(:,1)) + R1*y(:,17).*sin(y(:,1));
CF3 = R1*y(:,15).*cos(y(:,3)).*cos(y(:,1)) - R1*y(:,16).*cos(y(:,3)).*sin(y(:,1)) + R1*y(:,17).*cos(y(:,3)).*cos(y(:,1)) + R1*y(:,18).*sin(y(:,3));
CF4 = zeros(length(t),1);
CF5 = R2*y(:,15).*sin(y(:,7)) + R2*y(:,16).*cos(y(:,7));
CF6 = zeros(length(t),1);
CF7 = R3*y(:,17).*sin(y(:,11)) - R3*y(:,18).*cos(y(:,11));
Txyz_1 = zeros(length(t),3);
Txyz_2 = zeros(length(t),3);
Txyz_3 = zeros(length(t),3);
for i = 1:length(t)
    Txyz_1(i,:) = ([CF1(i); 0; 0] + [1 0 0; 0 cos(y(i,1)) sin(y(i,1)); 0 -sin(y(i,1)) cos(y(i,1))]'*[0; CF2(i); 0] + [1 0 0; 0 cos(y(i,1)) sin(y(i,1)); 0 -sin(y(i,1)) cos(y(i,1))]'*[cos(y(i,3)) 0 -sin(y(i,3)); 0 1 0; sin(y(i,3)) 0 cos(y(i,3))]'*[0; 0; CF3(i)])';
    Txyz_2(i,:) = ([CF4(i); 0; 0] + [1 0 0; 0 cos(y(i,7)) sin(y(i,7)); 0 -sin(y(i,7)) cos(y(i,7))]'*[0; CF5(i); 0])';
    Txyz_3(i,:) = ([0; CF6(i); 0] + [cos(pi/2) sin(pi/2) 0; -sin(pi/2) cos(pi/2) 0; 0 0 1]'*[1 0 0; 0 cos(y(i,11)) sin(y(i,11)); 0 -sin(y(i,11)) cos(y(i,11))]'*[0; CF7(i,:); 0])';
end
%Constraints Torques Plots
f11 = figure;
hold on
plot(t,Txyz_1(:,1),"r");
plot(t,Txyz_1(:,2),"b");
plot(t,Txyz_1(:,3),"k");
plot(T,Y34(:,2)*10^(-3)+Y35(:,2)*10^(-3),"r--");
plot(T,Y36(:,2)*10^(-3)+Y37(:,2)*10^(-3),"b--");
plot(T,Y38(:,2)*10^(-3)+Y39(:,2)*10^(-3),"k--");
xlabel("Time t (s)");
ylabel("Torque (Nm)");
ylim([-50 50]);
title("Comparison of Constraint Torques for Sphere");
legend(["Tx (Python)", "Ty (Python)", "Tz (Python)", "Tx (MotionView)", "Ty (MotionView)", "Tz (MotionView)"]);
grid on
hold off

f12 = figure;
hold on
plot(t,Txyz_2(:,1),"r");
plot(t,Txyz_2(:,2),"b");
plot(t,Txyz_2(:,3),"k");
plot(T,Y40(:,2)*10^(-3),"r--");
plot(T,Y41(:,2)*10^(-3),"b--");
plot(T,Y42(:,2)*10^(-3),"k--");
xlabel("Time t (s)");
ylabel("Torque (Nm)");
ylim([-50 50]);
title("Comparison of Constraint Torques for Cylinder 1");
legend(["Tx (Python)", "Ty (Python)", "Tz (Python)", "Tx (MotionView)", "Ty (MotionView)", "Tz (MotionView)"]);
grid on
hold off

f13 = figure;
hold on
plot(t,Txyz_3(:,1),"r");
plot(t,Txyz_3(:,2),"b");
plot(t,Txyz_3(:,3),"k");
plot(T,Y43(:,2)*10^(-3),"r--");
plot(T,Y44(:,2)*10^(-3),"b--");
plot(T,Y45(:,2)*10^(-3),"k--");
xlabel("Time t (s)");
ylabel("Torque (Nm)");
ylim([-50 50]);
title("Comparison of Constraint Torques for Cylinder 2");
legend(["Tx (Python)", "Ty (Python)", "Tz (Python)", "Tx (MotionView)", "Ty (MotionView)", "Tz (MotionView)"]);
grid on
hold off

%Lagrange Multipliers Plot
f14 = figure;
a14 = tiledlayout(2,2);
nexttile
plot(t,y(:,15),"b");
xlabel("Time t (s)");
ylabel("λ1 (N)");
grid on

nexttile
plot(t,y(:,16),"b");
xlabel("Time t (s)");
ylabel("λ2 (N)");
grid on

nexttile
plot(t,y(:,17),"b");
xlabel("Time t (s)");
ylabel("λ3 (N)");
grid on

nexttile
plot(t,y(:,18),"b");
xlabel("Time t (s)");
ylabel("λ4 (N)");
grid on

title(a14, "Lagrange Multipliers");
xlabel(a14, "Time t (s)");

%Compute Constraints Values from Python Data
C1 = R1*sin(y(:,1)).*y(:,4) + R1*cos(y(:,3)).*cos(y(:,1)).*y(:,6) + R2*sin(y(:,7)).*y(:,10);
C2 = R1*cos(y(:,1)).*y(:,4) - R1*cos(y(:,3)).*sin(y(:,1)).*y(:,6) + R2*cos(y(:,7)).*y(:,10);
C3 = R1*sin(y(:,1)).*y(:,4) + R1*cos(y(:,3)).*cos(y(:,1)).*y(:,6) + R3*sin(y(:,11)).*y(:,14);
C4 = R1*y(:,2) + R1*sin(y(:,3)).*y(:,6) - R3*cos(y(:,11)).*y(:,14);
%Constraints Values Plot
f15 = figure;
hold on
plot(t,C1,"r");
plot(t,C2,"b");
plot(t,C3,"m");
plot(t,C4,"k");
xlabel("Time t (s)");
ylabel("Constraints (m/s)");
title("Constraints Diagram");
legend(["Constraint 1", "Constraint 2", "Constraint 3", "Constraint 4"]);
grid on
hold off

%3D Trajectory Animation
obj = VideoWriter("Animation_Multiple_Points_1.avi");
obj.FrameRate = 100;
open(obj);
f16 = figure;
for i = 1:length(t)
    plot3(y(1:i,1)/pi*180, y(1:i,3)/pi*180, y(1:i,5)/pi*180, 'marker', 'o', 'color', 'b', 'markerfacecolor', 'b', 'linewidth', 1);
    hold on
    scatter3([0, -90, 90, -90, 90], [0, -45, -45, 45, 45], [0, 0, 0, 0, 0], 100, "r", 'filled');
    xlabel("θ (deg)");
    ylabel("φ (deg)");
    zlabel("ψ (deg)");
    title("Euler Angles Plot");
    grid on
    view([1 -1 1]);
    hold off

    curr_time = ['Time = ', num2str(t(i))];
    time_disp = annotation(f16, 'textbox', [0.1 0.8 0.3 0.1], 'String', curr_time, 'FitBoxToText','on');
    axis([-100 100 -50 50 -1 1]);
    writeVideo(obj,getframe);
    [A, map] = rgb2ind(frame2im(getframe(f16)),256);
    if i == 1
        imwrite(A, map, 'Animation_Multiple_Points_1.gif', DelayTime = 2/100, LoopCount = inf);
    else
        imwrite(A, map, 'Animation_Multiple_Points_1.gif', WriteMode = 'append', DelayTime = 2/100);
    end

    if i ~= length(t)
        clf
    end

    %disp(i);
end
close(obj);

%3D Mechanism Animation
obj = VideoWriter("Animation_Multiple_Points_2.avi");
obj.FrameRate = 100;
open(obj);
[XS,YS,ZS] = sphere;
XSYSZS = 32*[XS; YS; ZS];
[XC1, YC1, ZC1] = cylinder(16);
ZC1 = 25*ZC1 - 25/2;
XC1YC1ZC1 = zeros(3*2,21);
RC1_x = [1 0 0; 0 0 1; 0 -1 0]';
for k = 1:3
    XC1YC1ZC1(k*2-1:k*2,:) = RC1_x(k,1)*XC1 + RC1_x(k,2)*YC1 + RC1_x(k,3)*ZC1;
end
[XC2, YC2, ZC2] = cylinder(16);
ZC2 = 25*ZC2 - 25/2;
XC2YC2ZC2 = zeros(3*2,21);
RC2_y = [0 0 -1; 0 1 0; 1 0 0]';
for k = 1:3
    XC2YC2ZC2(k*2-1:k*2,:) = RC2_y(k,1)*XC2 + RC2_y(k,2)*YC2 + RC2_y(k,3)*ZC2;
end

tracer = zeros(length(t),3);
Rx_1 = [1 0 0; 0 cos(-90/180*pi) sin(-90/180*pi); 0 -sin(-90/180*pi) cos(-90/180*pi)];
Ry_1 = [cos(-45/180*pi) 0 -sin(-45/180*pi); 0 1 0; sin(-45/180*pi) 0 cos(-45/180*pi)];
Rz_1 = [cos(0) sin(0) 0; -sin(0) cos(0) 0; 0 0 1];
R_1 = Rz_1*Ry_1*Rx_1;
R_1 = R_1';
target_point_1 = R_1*[0 0 R1*10^3+8]';
Rx_2 = [1 0 0; 0 cos(90/180*pi) sin(90/180*pi); 0 -sin(90/180*pi) cos(90/180*pi)];
Ry_2 = [cos(-45/180*pi) 0 -sin(-45/180*pi); 0 1 0; sin(-45/180*pi) 0 cos(-45/180*pi)];
Rz_2 = [cos(0) sin(0) 0; -sin(0) cos(0) 0; 0 0 1];
R_2 = Rz_2*Ry_2*Rx_2;
R_2 = R_2';
target_point_2 = R_2*[0 0 R1*10^3+8]';
Rx_3 = [1 0 0; 0 cos(-90/180*pi) sin(-90/180*pi); 0 -sin(-90/180*pi) cos(-90/180*pi)];
Ry_3 = [cos(45/180*pi) 0 -sin(45/180*pi); 0 1 0; sin(45/180*pi) 0 cos(45/180*pi)];
Rz_3 = [cos(0) sin(0) 0; -sin(0) cos(0) 0; 0 0 1];
R_3 = Rz_3*Ry_3*Rx_3;
R_3 = R_3';
target_point_3 = R_3*[0 0 R1*10^3+8]';
Rx_4 = [1 0 0; 0 cos(90/180*pi) sin(90/180*pi); 0 -sin(90/180*pi) cos(90/180*pi)];
Ry_4 = [cos(45/180*pi) 0 -sin(45/180*pi); 0 1 0; sin(45/180*pi) 0 cos(45/180*pi)];
Rz_4 = [cos(0) sin(0) 0; -sin(0) cos(0) 0; 0 0 1];
R_4 = Rz_4*Ry_4*Rx_4;
R_4 = R_4';
target_point_4 = R_4*[0 0 R1*10^3+8]';
Rx_5 = [1 0 0; 0 cos(0/180*pi) sin(90/180*pi); 0 -sin(0/180*pi) cos(0/180*pi)];
Ry_5 = [cos(0/180*pi) 0 -sin(0/180*pi); 0 1 0; sin(0/180*pi) 0 cos(0/180*pi)];
Rz_5 = [cos(0) sin(0) 0; -sin(0) cos(0) 0; 0 0 1];
R_5 = Rz_5*Ry_5*Rx_5;
R_5 = R_5';
target_point_5 = R_5*[0 0 R1*10^3+8]';

f17 = figure;
for i = 1:length(t)
    RS_1 = [1 0 0; 0 cos(y(i,1)) sin(y(i,1)); 0 -sin(y(i,1)) cos(y(i,1))];
    RS_2 = [cos(y(i,3)) 0 -sin(y(i,3)); 0 1 0; sin(y(i,3)) 0 cos(y(i,3))];
    RS_3 = [cos(y(i,5)) sin(y(i,5)) 0; -sin(y(i,5)) cos(y(i,5)) 0; 0 0 1];
    RS = RS_3*RS_2*RS_1;
    RS = RS';
    XSYSZS_new = zeros(3*21,21);
    RC1_1 = [1 0 0; 0 cos(y(i,7)) sin(y(i,7)); 0 -sin(y(i,7)) cos(y(i,7))];
    RC1_2 = [cos(y(i,9)) 0 -sin(y(i,9)); 0 1 0; sin(y(i,9)) 0 cos(y(i,9))];
    RC1 = RC1_2*RC1_1;
    RC1 = RC1';
    XC1YC1ZC1_new = zeros(3*2,21);
    RC2_1 = [1 0 0; 0 cos(y(i,13)) sin(y(i,13)); 0 -sin(y(i,13)) cos(y(i,13))];
    RC2_2 = [cos(y(i,11)) 0 -sin(y(i,11)); 0 1 0; sin(y(i,11)) 0 cos(y(i,11))];
    RC2 = RC2_1'*RC2_2;
    RC2 = RC2';
    XC2YC2ZC2_new = zeros(3*2,21);
    for k = 1:3
        XSYSZS_new(k*21-20:k*21,:) = RS(k,1)*XSYSZS(1:21,:) + RS(k,2)*XSYSZS(22:42,:) + RS(k,3)*XSYSZS(43:63,:);
        XC1YC1ZC1_new(k*2-1:k*2,:) = RC1(k,1)*XC1YC1ZC1(1:2,:) + RC1(k,2)*XC1YC1ZC1(3:4,:) + RC1(k,3)*XC1YC1ZC1(5:6,:);
        XC2YC2ZC2_new(k*2-1:k*2,:) = RC2(k,1)*XC2YC2ZC2(1:2,:) + RC2(k,2)*XC2YC2ZC2(3:4,:) + RC2(k,3)*XC2YC2ZC2(5:6,:);
    end
    tracer_point = RS*[0 0 R1*10^3+8]';
    tracer(i,:) = tracer_point';

    surf(XSYSZS_new(1:21,:), XSYSZS_new(22:42,:), XSYSZS_new(43:63,:));
    hold on
    view([-1, -1, 1]);
    curr_time = ['Time = ', num2str(t(i))];
    time_disp = annotation(f17, 'textbox', [0.1 0.8 0.3 0.1], 'String', curr_time, 'FitBoxToText','on');
    axis([-40 80 -40 80 -40 40]);
    xlabel("x axis (mm)");
    ylabel("y axis (mm)");
    zlabel("z axis (mm)");
    grid on
    surf(XC1YC1ZC1_new(1:2,:)+48, XC1YC1ZC1_new(3:4,:), XC1YC1ZC1_new(5:6,:));
    surf(XC2YC2ZC2_new(1:2,:), XC2YC2ZC2_new(3:4,:)+48, XC2YC2ZC2_new(5:6,:));
    scatter3([target_point_1(1) target_point_2(1) target_point_3(1) target_point_4(1) target_point_5(1)], [target_point_1(2) target_point_2(2) target_point_3(2) target_point_4(2) target_point_5(2)], [target_point_1(3) target_point_2(3) target_point_3(3) target_point_4(3) target_point_5(3)], 150, "k", 'filled');
    scatter3(tracer_point(1), tracer_point(2), tracer_point(3), 100, 'r', 'filled');
    scatter3([32 0], [0 32], [0 0], 100, 'm', 'filled');
    line(tracer(1:i-1,1), tracer(1:i-1,2), tracer(1:i-1,3), 'marker', 'o', 'color', 'b', 'markerfacecolor', 'b', 'linewidth', 1);
    hold off
    writeVideo(obj,getframe);
    [A, map] = rgb2ind(frame2im(getframe(f17)),256);
    if i == 1
        imwrite(A, map, 'Animation_Multiple_Points_2.gif', DelayTime = 2/100, LoopCount = inf);
    else
        imwrite(A, map, 'Animation_Multiple_Points_2.gif', WriteMode = 'append', DelayTime = 2/100);
    end
    %exportgraphics(gca,'Animation_Multiple_Points.gif', 'Append', true);
    %saveas(gcf,['Frame_', num2str(i), '.png']);
    
    %if i == 1
    %    saveas(gcf,'Path_2_2.png');
    %end
    
    if i ~= length(t)
        clf
    end

    %disp(i);
end
close(obj);

%Target Satisfaction
disp("Original Tracer Point:");
disp([0 0 R1*10^3+8]');
disp("Target Point 1:");
disp(target_point_1);
disp("Final Tracer Point 1:");
disp(tracer(300,:)');

disp("Original Tracer Point:");
disp([0 0 R1*10^3+8]');
disp("Target Point 2:");
disp(target_point_2);
disp("Final Tracer Point 2:");
disp(tracer(599,:)');

disp("Original Tracer Point:");
disp([0 0 R1*10^3+8]');
disp("Target Point 3:");
disp(target_point_3);
disp("Final Tracer Point 3:");
disp(tracer(898,:)');

disp("Original Tracer Point:");
disp([0 0 R1*10^3+8]');
disp("Target Point 4:");
disp(target_point_4);
disp("Final Tracer Point 4:");
disp(tracer(1197,:)');

disp("Original Tracer Point:");
disp([0 0 R1*10^3+8]');
disp("Target Point 5:");
disp(target_point_5);
disp("Final Tracer Point 5:");
disp(tracer(end,:)');
