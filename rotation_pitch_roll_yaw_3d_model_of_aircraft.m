run('datamat.m')
% Завантаження 3D-моделі з файлу STL
[model] = stlread('Airplane B002854 file stl free download 3D Model for CNC and 3d printer.stl');


% [model] = stlread('NACA0010_229.stl');


%% Кути моделювання
angle_of_roll = deg2rad(AHR2(:,3));
angle_of_pitch = deg2rad(AHR2(:,4));
angle_of_yaw = deg2rad(AHR2(:,5));
Lat = 10^7*Lat;
Lng = 10^7*Lng;
Alt;

%% Параметри моделювання 
edge_distance = 50; % Відстань від краю моделі
%
% Знаходження вершини на краю моделі
[max_z, max_z_idx] = min(model.Points(:, 1));
edge_vertex = model.Points(max_z_idx, :);

% Зсув вершин моделі відносно вершини на краю моделі
shifted_vertices = model.Points - edge_vertex;
%% Візуалізація моделі

figure;
axis equal;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Анімація зміни кута крену моделі з моделюванням від краю');
view(3);
grid on;
hold on;
% plot3(Lat,Lng,Alt)
% Позначення вершини на краю моделі
scatter3(edge_vertex(1), edge_vertex(2), edge_vertex(3), 50, 'r', 'filled');

%% Проведення анімації
for i = 1:length(angle_of_roll)
   
    roll_angle = angle_of_roll(i); % Отримання кута крена з вектора
    pitch_angle = angle_of_pitch(i); % Отримання кута тангажа з вектора
    yaw_angle = angle_of_yaw(i); % Отримання кута рискання з вектора
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
    
    pause(0.05); % Пауза між кадрами
end