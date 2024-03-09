run('datamat.m');
% Відображення часу
t = 0:1:length(Roll)-1;
% Затримка
delay = 0.01;
% Створення окремого вікна
figure
%% Крен
subplot(3,1,1);
plot(t,Roll,'g-'); grid on;
hold on;
pr = plot(t(1),Roll(1),'r*');
title("Roll");
hold off;
%% Тангаж
subplot(3,1,2);
plot(t,Pitch,'b-'); grid on;
hold on;
pp = plot(t(1),Pitch(1),'r*');
title("Pitch");
hold off;
%% Курс
subplot(3,1,3);
plot(t,Yaw,'k-'); grid on;
hold on;
py = plot(t(1),Yaw(1),'r*');
title("Yaw");
hold off;
%% Додаємо анімацію для точки
for i = 1:length(t)
     set(pr, 'XData', t(i), 'YData', Roll(i));
     set(pp, 'XData', t(i), 'YData', Pitch(i));
     set(py, 'XData', t(i), 'YData', Yaw(i));
     drawnow;
     pause(delay);
end