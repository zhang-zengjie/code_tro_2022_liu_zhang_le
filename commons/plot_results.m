function plot_results(SIM_PARAM, REGION_CONFIG, CONTROL_PARAM, botZ, botCz, botPose, botCost, botInput, v, c, t_scale_full)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Zengjie Zhang
% Date: July 20, 2022

% Run main.m in individual folders to perform the simulation.
% Run plot_results to plot the data.

sz = size(botPose);

t_scale = t_scale_full(1: sz(3));

CostColor = [0, 51, 153]/255;
CostColor_milky = [204, 221, 255]/255;

Color_H = linspace(0,1,SIM_PARAM.N_AGENT+1)';
Pcolor_hsl = [Color_H(1:SIM_PARAM.N_AGENT), ones(SIM_PARAM.N_AGENT, 1)*0.6, ones(SIM_PARAM.N_AGENT, 1)*0.6 ];

Pcolor_dark_hsl = Pcolor_hsl;
Pcolor_dark_hsl(:,3) = ones(SIM_PARAM.N_AGENT, 1)*0.05;

Pcolor_dark_2_hsl = Pcolor_hsl;
Pcolor_dark_2_hsl(:,3) = ones(SIM_PARAM.N_AGENT, 1)*0.3;

Pcolor_milky_hsl = Pcolor_hsl;
Pcolor_milky_hsl(:,3) = ones(SIM_PARAM.N_AGENT, 1)*0.95;

Pcolor = hsl2rgb(Pcolor_hsl);
Pcolor_dark = hsl2rgb(Pcolor_dark_hsl);
Pcolor_dark_2 = hsl2rgb(Pcolor_dark_2_hsl);
Pcolor_milky = hsl2rgb(Pcolor_milky_hsl);



%% Plot the cost
figure();

hold on;
plot(t_scale, botCost,'LineWidth',1.5,'LineStyle','-.','Color', CostColor);
fill([t_scale, SIM_PARAM.SIM_TIME,0], [botCost,0,0], CostColor_milky);
ylabel('$V(\mathcal{Z})$','Interpreter','latex', 'FontSize', 9);
grid on;
set(gca,'GridLineStyle','-.', 'FontSize', 9);
xlabel('time (s)','Interpreter','latex', 'FontSize', 10);
xlim([0 t_scale(end)]);
x0=500;
y0=200;
width=320;
height=160;

set(gcf,'position',[x0,y0,width,height]);
hold off;

%% Plot the input
figure();

hold on;
for i = 1:SIM_PARAM.N_AGENT
    plot(t_scale, botInput(i,:)-CONTROL_PARAM.W_ORBIT(i),'LineWidth',1.5,'LineStyle','-.','Color', Pcolor(i,:));
end
ylabel('{\boldmath{$u$}}$_k(t) - ${\boldmath{$\omega$}}$_0$','Interpreter','latex', 'FontSize', 9);
grid on;
set(gca,'GridLineStyle','-.', 'FontSize', 9);
xlabel('time (s)','Interpreter','latex', 'FontSize', 10);
xlim([0 t_scale(end)]);
x0=500;
y0=200;
width=320;
height=160;

set(gcf,'position',[x0,y0,width,height]);
hold off;

%% Plot the locus
figure();

hold on;

line(REGION_CONFIG.BOUNDARIES_VERTEXES(:,1), REGION_CONFIG.BOUNDARIES_VERTEXES(:,2), 'LineWidth',1.5,'LineStyle','-.','Color', [0,0,0]);
for i = 1:SIM_PARAM.N_AGENT
    line(v(c{i},1), v(c{i},2), 'LineWidth',1.5,'LineStyle',':','Color', [0,0,0]);
    fill(v(c{i},1), v(c{i},2), Pcolor_milky(i,:));
end

for i = 1:SIM_PARAM.N_AGENT
    
    botPoseX = reshape(botPose(i, 1, 1), [1, 1]);
    botPoseY = reshape(botPose(i, 2, 1), [1, 1]);
    plot(botPoseX, botPoseY,'x','LineWidth',1,'MarkerSize',10, 'Color', Pcolor(i,:));
    botPoseX = reshape(botPose(i, 1, :), [1, SIM_PARAM.MAX_ITER]);
    botPoseY = reshape(botPose(i, 2, :), [1, SIM_PARAM.MAX_ITER]);
    plot(botPoseX, botPoseY,'LineWidth',1,'LineStyle','-', 'Color', Pcolor(i,:));
    botPoseX = reshape(botPose(i, 1, end), [1, 1]);
    botPoseY = reshape(botPose(i, 2, end), [1, 1]);
    plot(botPoseX, botPoseY,'o','LineWidth',1,'MarkerSize',10, 'Color', Pcolor(i,:));
    
    botZX = reshape(botZ(i, 1, 1), [1, 1]);
    botZY = reshape(botZ(i, 2, 1), [1, 1]);
    plot(botZX, botZY,'x', 'LineWidth',2,'MarkerSize',10, 'Color', Pcolor_dark(i,:));
    botZX = reshape(botZ(i, 1, :), [1, SIM_PARAM.MAX_ITER]);
    botZY = reshape(botZ(i, 2, :), [1, SIM_PARAM.MAX_ITER]);
    plot(botZX, botZY, 'LineWidth',2,'LineStyle',':', 'Color', Pcolor_dark(i,:));
    botZX = reshape(botZ(i, 1, end), [1, 1]);
    botZY = reshape(botZ(i, 2, end), [1, 1]);
    plot(botZX, botZY,'o','LineWidth',2,'MarkerSize',10, 'Color', Pcolor_dark(i,:));
    
    botCzX = reshape(botCz(i, 1, 1), [1, 1]);
    botCzY = reshape(botCz(i, 2, 1), [1, 1]);
    plot(botCzX, botCzY,'x', 'LineWidth',2,'MarkerSize',10, 'Color', Pcolor_dark_2(i,:));
    botCzX = reshape(botCz(i, 1, :), [1, SIM_PARAM.MAX_ITER]);
    botCzY = reshape(botCz(i, 2, :), [1, SIM_PARAM.MAX_ITER]);
    plot(botCzX, botCzY, 'LineWidth',2, 'LineStyle','-.', 'Color', Pcolor_dark_2(i,:));
    botCzX = reshape(botCz(i, 1, end), [1, 1]);
    botCzY = reshape(botCz(i, 2, end), [1, 1]);
    plot(botCzX, botCzY,'o', 'LineWidth',2,'MarkerSize',10, 'Color', Pcolor_dark_2(i,:));
%    color = get(H, 'Color');
end
axis([0, max(REGION_CONFIG.BOUNDARIES_VERTEXES(:,1)), 0, max(REGION_CONFIG.BOUNDARIES_VERTEXES(:,2))]);
ag = gca();
grid on;
set(gca,'GridLineStyle','-.', 'FontSize', 9);

x0=500;
y0=200;
width=320;
height=220;

set(gcf,'innerposition',[x0,y0,width,height]);
hold off;

