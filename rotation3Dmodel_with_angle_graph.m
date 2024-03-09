
run('datamat.m')

%% Завантаження 3D-моделі літального апарату
[model] = stlread('Airplane B002854 file stl free download 3D Model for CNC and 3d printer.stl');
%% Переводимо значення кутів в радіани
Roll = deg2rad(Roll);
Pitch = deg2rad(Pitch);
Yaw = deg2rad(Yaw);
%% Час моделювання
t = 0:1:length(Roll)-1;
% затримка
delay = 0.0001;
% Параметри моделювання ЛА
edge_distance = 50; % Відстань від краю моделі
%
% Знаходження вершини на краю моделі
[max_z, max_z_idx] = min(model.Points(:, 1));
edge_vertex = model.Points(max_z_idx, :);

% Зсув вершин моделі відносно вершини на краю моделі
shifted_vertices = model.Points - edge_vertex;
% Візуалізація моделі

figure;
% subplot(3,2,1)
axis equal;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Fligth Aircraft');
view(3);
grid on;
hold on;

% Позначення вершини на краю моделі
scatter3(edge_vertex(1), edge_vertex(2), edge_vertex(3), 50, 'r', 'filled');
%% Моделювання графіків відображення кутів
% Крен
figure
subplot(3,1,1);
plot(t,rad2deg(Roll),'k-'); grid on;
hold on;
pr = plot(t(1),rad2deg(Roll(1)),'rv','MarkerSize',3,'LineWidth',2);
title("Roll");
hold off;
% Тангаж
subplot(3,1,2);
plot(t,rad2deg(Pitch),'k-'); grid on;
hold on;
pp = plot(t(1),rad2deg(Pitch(1)),'rv','MarkerSize',3,'LineWidth',2);
title("Pitch");
hold off;
% Курс
subplot(3,1,3);
plot(t,rad2deg(Yaw),'k-'); grid on;
hold on;
py = plot(t(1),rad2deg(Yaw(1)),'rv','MarkerSize',3,'LineWidth',2);
title("Yaw");
hold off;
%% Цикл проведення анімації
for i = 8000:length(Roll)
    roll_angle = Roll(i); % Отримання кута крена з вектора
    pitch_angle = Pitch(i); % Отримання кута тангажа з вектора
    yaw_angle = Yaw(i); % Отримання кута рискання з вектора
    % Задаємо матриці обертання моделі по 3-м осям
    %%
    roll_matrix = [1,0,0;
                   0, cos(roll_angle), -sin(roll_angle);
                   0, sin(roll_angle), cos(roll_angle);];
    %%           
    pitch_matrix = [cos(pitch_angle), 0, sin(pitch_angle);
                    0, -1, 0;
                    -sin(pitch_angle), 0, cos(pitch_angle);];
    %%
    yaw_matrix = [cos(yaw_angle), -sin(yaw_angle), 0;
                  sin(yaw_angle), cos(yaw_angle), 0;
                  0, 0, 1;];
    %%
    rotation_matrix = yaw_matrix * pitch_matrix * roll_matrix; % матриця повороту
    % Обертання вершин навколо краю моделі
    rotated_vertices = shifted_vertices * rotation_matrix';
    
    % Повернення вершин у початкове положення
    restored_vertices = rotated_vertices + edge_vertex;
    
    % Очищення попереднього візуалізаційного об'єкта
    if exist('h', 'var')
        delete(h);
    end
    
    % Візуалізація моделі
    h = patch('Vertices', restored_vertices, 'Faces', model.ConnectivityList, 'FaceColor', 'cyan', 'EdgeColor', 'k');
    set(pr, 'XData', t(i), 'YData', rad2deg(Roll(i)));
    set(pp, 'XData', t(i), 'YData', rad2deg(Pitch(i)));
    set(py, 'XData', t(i), 'YData', rad2deg(Yaw(i)));
    drawnow;
    pause(delay); % Пауза між кадрами
end
