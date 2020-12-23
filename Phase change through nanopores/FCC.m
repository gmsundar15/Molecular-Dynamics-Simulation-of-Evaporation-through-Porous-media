clear;
close all;
clc;
%Atom is copper. mass = 63.546, Lattice constant = 3.597, lattice type is
%FCC
lat_pram = 3.597;

%base of reservoir
x_len = 100;
y_len = 100; 
z_len = 4; 
[X_base,Y_base,Z_base] = FCC_coord(lat_pram,x_len,y_len,z_len);

%top of reservoir
% x_len = 100;
% y_len = 100;
% z_len = 4;
% [X_top,Y_top,Z_top] = FCC_coord(lat_pram,x_len,y_len,z_len);
% 
height = 50;
% Z_top = Z_top + height;

%opening for nanotubule at top
X_top = [];
Y_top = [];
Z_top = [];
%coordinates of all Cu atoms
X_Cu = [X_base;X_top];
Y_Cu = [Y_base;Y_top];
Z_Cu = [Z_base;Z_top];
coordinate = [X_Cu,Y_Cu,Z_Cu];
ID = ones(length(X_Cu),1);
coordinate = [ID , coordinate]; %appending ID to coordinate

%coordinates of water

[X_O,Y_O,Z_O,X_H,Y_H,Z_H,coord] = Water_coord(0, x_len, 0, y_len, z_len, height/2);
    
%plot atoms
hold on
%scatter3(X_Cu,Y_Cu,Z_Cu,'filled','red');
scatter3(X_O,Y_O,Z_O,'filled','blue');
scatter3(X_H,Y_H,Z_H,'filled','yellow');
set(gca,'XLim',[-20 30],'YLim',[-20 30],'ZLim',[0 105])
xlabel('X');
ylabel('Y');
zlabel('Z');





