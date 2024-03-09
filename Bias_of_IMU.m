%% load file of fligth
clear sys
datamat;
%% angles of Euler
figure;
subplot(3,1,1 );
% check of AHR2 data
if(exist('AHR2','var'))
    plot(AHR2(:,1)-t0,AHR2(:,3),'k');
    hold on
end
plot(Time,XKF1_0(:,4),'r');
hold off; grid on;
ylim([-180,180]); xlabel('Час, с'); ylabel('Крен, град');
title('Оцінка кутів Ейлера/ AHR2 - чорний, EKF - червоний');
subplot(3,1,2);
if (exist('AHR2','var'))
    plot(AHR2(:,1)-t0,AHR2(:,4),'k');
    hold on;
end
plot(Time,XKF1_0(:,5),'r');
hold off;
grid on;
ylim([-180 180]);
xlabel('Час, с');ylabel('Тангаж, град');
subplot(3,1,3);
if (exist('AHR2','var'))
    plot(AHR2(:,1)-t0,AHR2(:,5),'k');
    hold on;
end
plot(Time,XKF1_0(:,6),'r');
hold off;
grid on;
ylim([0 360]);
xlabel('Час, с');ylabel('Курс, град');
%% Gyro Bias
figure; 
subplot(3,1,1);
title('оцінка похибок гіроскопа');
plot(Time,XKF1_0(:,14),'k');
grid on; xlabel('Час, с'); ylabel('Зміщення нуля по осі X, град/с');
hold on 
subplot(3,1,2);
plot(Time,XKF1_0(:,15),'k');
grid on; xlabel('Час, с'); ylabel('Зміщення нуля по осі Y, град/с');
hold on
subplot(3,1,3);
plot(Time,XKF1_0(:,16),'k');
grid on; xlabel('Час, с'); ylabel('Зміщення нуля по осі Z, град/с');
hold off