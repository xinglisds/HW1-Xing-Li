clc
clear
%known information
dim=3; %dimension is 3
b=4; %number of bars
s=3*b+4; %number of strings
q=2*b; %number of free nodes 
p=0; %number of fixed nodes, there is no fixed nodes in this structure
degree_a=pi/2-pi/4;%twist angle
%we assume the top and bottom shapes are squares,and the twist angle is 45.
length=6;%edge length of square
height=12;%The height of the structure
diagonal=2^0.5*length;%diagonal of square
%Top square
%The nodes locations of the top square
Q(:,1)=[diagonal/2;0;height];
Q(:,2)=[0;diagonal/2;height];
Q(:,3)=[diagonal/2;diagonal;height];
Q(:,4)=[diagonal;diagonal/2;height];

%Bottom square
%The nodes locations of the bottom square
Q(:,5)=[diagonal/2-length/2;diagonal/2-length/2;0];
Q(:,6)=[diagonal/2+length/2;diagonal/2-length/2;0];
Q(:,7)=[diagonal/2+length/2;diagonal/2+length/2;0];
Q(:,8)=[diagonal/2-length/2;diagonal/2+length/2;0];
%There is no fixed node.
P=[];

%Connectivity matrix
%Bars connectivity
C(1,1)=1;C(1,7)=-1;
C(2,2)=1;C(2,6)=-1;
C(3,3)=1;C(3,5)=-1;
C(4,4)=1;C(4,8)=-1;

%Strings connectivity
C(5,1)=1;C(5,2)=-1;
C(6,2)=1;C(6,3)=-1;
C(7,3)=1;C(7,4)=-1;
C(8,4)=1;C(8,1)=-1;
C(9,5)=1;C(9,6)=-1;
C(10,5)=1;C(10,8)=-1;
C(11,8)=1;C(11,7)=-1;
C(12,7)=1;C(12,6)=-1;
C(13,1)=1;C(13,6)=-1;
C(14,2)=1;C(14,5)=-1;
C(15,3)=1;C(15,8)=-1;
C(16,4)=1;C(16,7)=-1;
C(17,1)=1;C(17,5)=-1;
C(18,2)=1;C(18,8)=-1;
C(19,3)=1;C(19,7)=-1;
C(20,4)=1;C(20,6)=-1;

%External force
U(1:dim,1:8)=0; U(2,1)=1; U(2,3)=-1;U(1,2)=1;U(1,4)=-1;%

%Using function to get the figure
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,1,0.08); grid on;




