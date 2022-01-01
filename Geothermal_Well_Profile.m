%Plotting Well Profile for geothermal reservoir characterization using
%elevation, measureable temperature and  measureable pressure data
%Mohammad Rheza Zamani
format long;
clc;
clear all;
d = importdata('Well A.dat');
elev = d(:,1); % Elevation in m unit
temp = d(:,2); %Measurable temperature in degree celcius unit
press = d(:,3); %Measurable pressure in bar unit
%BPD (Hass,1971)
depth_Hass = [0	4.5	10.4	18.2	28.2	40.9	56.8	76.4	100.5	129.7	164.7	206.8	256.4	314.9	383.3	462.9	555.2	661.8	784.6	925.6	1088	1273	1487	1732	2017	2350	2746	3243];
temp_Hass = [100	110	120	130	140	150	160	170	180	190	200	210	220	230	240	250	260	270	280	290	300	310	320	330	340	350	360	370];
press_Hass = [1	1.4	2	2.7	3.6	4.8	6.2	7.9	10	12.6	15.6	19.1	23.2	28	33.5	39.8	46.9	55.1	64.2	74.4	85.9	98.7	116	128.6	146.1	165.4	186.7	210.5];
%Convert elevation to depth 
for i = 1 : length(elev)
    depth(i) = abs(elev(i) - elev(1));
end
%Calculated Hidrostatic Pressure in bar Absolute unit
for j = 1 : length(depth)
    pressH(j) = 0.1897.*((depth(j)).^0.8719) + 1.01325; 
end
%Calculated Hidrostatic Temperature  degree celcius  in  unit
for k = 1 : length(pressH)
    tempH(k) = 102.23.*(pressH(k)).^(0.2519);
end
%Temperature and pressure total
Temp_tot = temp' + tempH;
Press_tot = press' + pressH;

%Plotting data
%Temperature
figure(1)
subplot(2,1,1)
hold on
plot(temp,depth,'LineWidth',2)
plot(tempH,depth,'LineWidth',2)
plot(Temp_tot,depth,'LineWidth',2)
plot(temp_Hass,depth_Hass,'LineWidth',2)
set(gca,'Ydir','reverse')
xlabel('Temperature (C^o)','Fontsize',10,'FontWeight','bold')
ylabel('Depth (m)','Fontsize',10,'FontWeight','bold')
title('Profile Temperature','Fontsize',10,'FontWeight','bold')
legend({'Profile Temperature','Profile Hydrostatic Temperature','Profile Total Temperature','BPD Temperature (Hass,1971)'},'Fontsize',7,'FontWeight','bold','location','southwest')
grid on
hold off
subplot(2,1,2)
hold on
plot(press,depth,'LineWidth',2)
plot(pressH,depth,'LineWidth',2)
plot(Press_tot,depth,'LineWidth',2)
plot(press_Hass,depth_Hass,'LineWidth',2)
set(gca,'Ydir','reverse')
xlabel('Pressure (b.a)','Fontsize',10,'FontWeight','bold')
ylabel('Depth (m)','Fontsize',10,'FontWeight','bold')
title('Profile Pressure','Fontsize',10,'FontWeight','bold')
legend({'Profile Pressure','Profile Hydrostatic Pressure','Profile Total Pressure','BPD Pressure (Hass,1971)'},'Fontsize',7,'FontWeight','bold','location','southwest')
grid on
set(gcf, 'Position', get(0, 'Screensize'));
hold off

saveas(figure(1),'Well Profile.png')