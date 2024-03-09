% Створення фігури для графіка
figure;
axis equal;
% Встановлення меж для осей
axis([0 10 0 10 0 10]);

% Радіус сфери
sphereRadius = 0.5;

% Початкові координати сфери
startX = 1;
startY = 1;
startZ = 1;

% Ініціалізація сфери
[X, Y, Z] = sphere;
sphereHandle = surf(X * sphereRadius + startX, Y * sphereRadius + startY, Z * sphereRadius + startZ);
set(sphereHandle, 'FaceColor', [1, 0, 0]);
set(sphereHandle, 'EdgeColor', 'none');

% Кінцеві координати сфери
endX = 9;
endY = 9;
endZ = 9;

% Кількість кадрів анімації
numFrames = 100;

% Генерування анімації
for frame = 1:numFrames
    % Обчислення проміжних координат
    interpX = startX + (endX - startX) * frame / numFrames;
    interpY = startY + (endY - startY) * frame / numFrames;
    interpZ = startZ + (endZ - startZ) * frame / numFrames;
    
    % Оновлення положення сфери
    set(sphereHandle, 'XData', X * sphereRadius + interpX);
    set(sphereHandle, 'YData', Y * sphereRadius + interpY);
    set(sphereHandle, 'ZData', Z * sphereRadius + interpZ);
    
    % Пауза для анімації
    pause(0.1);
end
