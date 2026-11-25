clear; clc; close all;
%% 1. Lade- und Entladekurve im Zeitbereich
R = 1000; 
C = 1e-6;
tau_theorie = R * C * 1000; 
    fprintf("theoretische Zeitkonstante tau: %.2f ms\n", tau_theorie)

    Data = readmatrix("Draft1.txt"); 
        zeit = Data(:,1) * 1000
        U_ein = Data(:,2)
        U_konden = Data(:,3) 


U_max = max(U_ein);
U_tau = U_max * (tau_theorie - exp(-1));
index = find(U_konden >= U_tau, 1); %ersten gefundenen index zurückgeben

tau = zeit(index) %tau auslesen


figure(1);

plot(zeit, U_ein, zeit, U_konden, 'LineWidth', 1.5); title("RC-Tiefpass");  xlabel("Zeit [ms]"); ylabel("Spannung [V]") ; %linewidth um Die Graphen besser darzustellen

        hold on; %verhindern das löschen des Graphen

plot(tau,  U_konden(index), 'ro', 'MarkerSize',8, 'MarkerFaceColor','r');
        grid on;
        legend("Eingangsspannung (U_{Ein})", "Kondensatorspannung (U_{konden})", "tau (ms)"); %beschriftet die Graphen
        hold off;

%% 2.Frequenzgang/ Bode Diagramm

M = readmatrix("Bodediagramm.txt", "Delimiter",["\t", "(", "dB",",","°",")"]); %durch Delimiter wird zugewiesen, bei den gegebenen zeichen zu trennen, damit reine zahlen eingelesen werden 
frequenz = M(:,1);
v1 = M(:,3);
phase = M(:,4);
figure(2);

yyaxis right 
semilogx(frequenz,phase); 
xlabel("Frequenz f in [Hz]");
ylabel("[°]");
ylim([-90 0]);
yticks(-90:15:0); %geht in 15er- Schritten
ytickformat('%g°'); 

yyaxis left 
semilogx(frequenz,v1);
ylabel("[dB]");
title("Bode Diagramm");

grid on;
legend("Amplitudengang (dB)","Phasengang (°)","Frequenz f [Hz]");
