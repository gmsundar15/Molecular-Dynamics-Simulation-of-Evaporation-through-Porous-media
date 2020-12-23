function [X_O,Y_O,Z_O,X_H,Y_H,Z_H,coordinate] = Water_coord(x_min,x_max,y_min,y_max,z_min,z_max)
%code to generate random positions for water molecules

% model is SPC/E
% O mass = 15.9994
% H mass = 1.008
% O charge = -0.820
% H charge = 0.410
% LJ  of OO = 0.1553
% LJ  of OO = 3.166
% LJ of OH, HH = 0.0
% OH bond = 1.0
% HOH angle = 109.47

%%min and max for boundary are inputs
molecular_mass = 15.9994 + 1.008 * 2;
volume = (x_max - x_min) * (y_max - y_min) * (z_max - z_min);
density = 0.997e-24; %density in gram per cubic armstrong %%water vapour
N_mol = density * volume / molecular_mass; %number of moles of water
N = N_mol * 6.022e23; %number of molecules
N = ceil(N);
%random positions for Oxygen atoms
X_O = x_min + rand(N,1) * (x_max-x_min);
Y_O = y_min + rand(N,1) * (y_max-y_min);
Z_O = z_min + rand(N,1) * (z_max-z_min);

coordinate_O = [X_O,Y_O,Z_O,ones(N,1)]; %homogeneous coordinates of O

HOH = 109.47*pi/180; %bond angle in degrees
OH = 1; %bond length in armstrong

alpha = HOH/2; %half bond angle

%code to produce H1 and H2 coordinates for a molecule in XY plane
Transform_H1 = [1 0 0 OH*sin(alpha);
                0 1 0 OH*cos(alpha);
                0 0 1 0;
                0 0 0 1]; %affine transformation matrix for H1
Transform_H2 = [1 0 0 -1*OH*sin(alpha);
                0 1 0 OH*cos(alpha);
                0 0 1 0;
                0 0 0 1]; %affine transformation matrix for H2
            
coordinate_H1 = Transform_H1 * (coordinate_O.');
coordinate_H2 = Transform_H2 * (coordinate_O.');

coordinate_H1 = coordinate_H1.';
coordinate_H2 = coordinate_H2.';

coordinate_H1 = coordinate_H1(:,1:3); %convert to non homogeneous
coordinate_H2 = coordinate_H2(:,1:3);
coordinate_O = coordinate_O(:,1:3);

ID = ones(N,1);
ID = ID + 1;
coordinate_O = [ID,coordinate_O];
ID = ID - 1;
coordinate_H1 = [ID,coordinate_H1];
coordinate_H2 = [ID,coordinate_H2];

Molecule_ID = 1:1:N;
Molecule_ID = Molecule_ID.';
coordinate_O = [Molecule_ID,coordinate_O];
coordinate_H1 = [Molecule_ID,coordinate_H1];
coordinate_H2 = [Molecule_ID,coordinate_H2];

X_H = [coordinate_H1(:,3);coordinate_H2(:,3)];
Y_H = [coordinate_H1(:,4);coordinate_H2(:,4)];
Z_H = [coordinate_H1(:,5);coordinate_H2(:,5)];
size = 3*N;
coordinate = zeros(size,5);
i = 1;
while i <= size 
    ind = (i+2)/3;
    coordinate(i,:) = coordinate_O(ind,:);
    coordinate(i+1,:) = coordinate_H1(ind,:);
    coordinate(i+2,:) = coordinate_H2(ind,:);
    i = i+3;
end
coordinate_H2O = coordinate(:,2:5);
end

