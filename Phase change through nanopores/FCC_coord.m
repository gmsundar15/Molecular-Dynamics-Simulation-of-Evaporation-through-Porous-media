function [X_coord,Y_coord,Z_coord] = FCC_coord(lat_pram,x_len,y_len,z_len)

len = max([x_len,y_len,z_len]);
N = ceil(len/lat_pram);

%code to generate xy, yz and zx face positions for each unit cell
Xfac = 0.5*lat_pram:lat_pram:(N+0.5) * lat_pram;
Yfac = 0.5*lat_pram:lat_pram:(N+0.5) * lat_pram;
Zfac = 0.5*lat_pram:lat_pram:(N+0.5) * lat_pram;

%code to generate corner positions for each unit cell
Xcon = 0:lat_pram:N * lat_pram;
Ycon = 0:lat_pram:N * lat_pram;
Zcon = 0:lat_pram:N * lat_pram;

%code to generate corners using intersection of face positions
[X,Y,Z] = meshgrid(Xcon,Ycon,Zcon);
Xpos = X(:);
Ypos = Y(:);
Zpos = Z(:);

%code to generate face atom positions
[X,Y,Z] = meshgrid(Xfac,Yfac,Zcon); %xy face
Xpos = [Xpos, X(:)];
Ypos = [Ypos, Y(:)];
Zpos = [Zpos, Z(:)];

[X,Y,Z] = meshgrid(Xcon,Yfac,Zfac); %yz face
Xpos = [Xpos, X(:)];
Ypos = [Ypos, Y(:)];
Zpos = [Zpos, Z(:)];

[X,Y,Z] = meshgrid(Xfac,Ycon,Zfac); %zx face
Xpos = [Xpos, X(:)];
Ypos = [Ypos, Y(:)];
Zpos = [Zpos, Z(:)];


X = Xpos(:);
Y = Ypos(:);
Z = Zpos(:);

coordinate = [X,Y,Z];
X_del  = find(coordinate(:,1)>x_len);
coordinate(X_del,:) = [];
Y_del  = find(coordinate(:,2)>y_len);
coordinate(Y_del,:) = [];
Z_del  = find(coordinate(:,3)>z_len);
coordinate(Z_del,:) = [];

X_coord = coordinate(:,1);
Y_coord = coordinate(:,2);
Z_coord = coordinate(:,3);


end

