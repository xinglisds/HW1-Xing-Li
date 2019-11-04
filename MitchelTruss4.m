clc
clear

%known information
dim=2;%dimension is 2
degree_a=pi/16;degree_b=pi/6;order=4; %degree of phi and beta
node_q=10;node_p=5;%number of free nodes and fixed nodes
b=10;%number of bars
s=10;%number of strings
a=sin(degree_b)/sin(degree_b+degree_a);%coefficient of radius
c=sin(degree_a)/sin(degree_b+degree_a);%coefficient of length, not use

%calculate the raduis
r=[];% list of each radius
r(1)=1;% we assume the longest radius is 1

%loop to calculate each radius
for l=1:order
    r(l+1)=a*r(l);
end

%fixed node location. The location is calculated by radius and degree.
P=zeros(dim,node_p);
initial_degree=-4*degree_a;
for i=1:node_p
    P(1,i)=r(5)*cos(initial_degree);
    P(2,i)=r(5)*sin(initial_degree);
    initial_degree=initial_degree+2*degree_a;
end

%free node location. The location is calculated by radius and degree.
Q=zeros(dim,node_q);
coloum_num=1;
for m=1:order
    initial_degree=(m-4)*degree_a;
    for n=1:(5-m)
        Q(1,coloum_num)=r(5-m)*cos(initial_degree);
        Q(2,coloum_num)=r(5-m)*sin(initial_degree);
        initial_degree=initial_degree+2*degree_a;
        coloum_num=coloum_num+1;
    end
end

%connectivity matrix The first 10 coloums are bars and others are strings
C=zeros(20,15);
C(1+10,1)=1;C(1+10,11)=-1;
C(2-1,1)=1;C(2-1,12)=-1;
C(3+9,2)=1;C(3+9,12)=-1;
C(4-2,2)=1;C(4-2,13)=-1;
C(5+8,3)=1;C(5+8,13)=-1;
C(6-3,3)=1;C(6-3,14)=-1;
C(7+7,4)=1;C(7+7,14)=-1;
C(8-4,4)=1;C(8-4,15)=-1;
C(9+6,5)=1;C(9+6,1)=-1;
C(10-5,5)=1;C(10-5,2)=-1;
C(11+5,6)=1;C(11+5,2)=-1;
C(12-6,6)=1;C(12-6,3)=-1;
C(13+4,7)=1;C(13+4,3)=-1;
C(14-7,7)=1;C(14-7,4)=-1;
C(15+3,8)=1;C(15+3,5)=-1;
C(16-8,8)=1;C(16-8,6)=-1;
C(17+2,9)=1;C(17+2,6)=-1;
C(18-9,9)=1;C(18-9,7)=-1;
C(19+1,10)=1;C(19+1,8)=-1;
C(20-10,10)=1;C(20-10,9)=-1;

%external force act on the node,which located on the longest radius.
U(1:dim,1:node_q)=0;
U(1,10)=0;U(2,10)=1;

%tensegrity_statics function to plot a figure
[c_bars,t_strings,V]=tensegrity_statics(b,s,node_q,node_p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,2.0); grid on;

    
