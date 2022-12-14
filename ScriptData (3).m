%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: /MATLAB Drive/Datos.txt
%
% Auto-generated by MATLAB on 13-Jul-2022 22:55:10

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 3);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Age1", "Baseline", "TUG"];
opts.VariableTypes = ["double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
Datos = readtable("/MATLAB Drive/Datos.txt", opts);

%% Convert to output type
Age1 = Datos.Age1;
Baseline = Datos.Baseline;
TUG = Datos.TUG;

%% Clear temporary variables
clear Datos opts

%Etradas
ageF=transpose(Age1);
bl=transpose(Baseline);

%Datos
DatosInit=[ageF;bl];

%70% de los datos para entrenar
%RDatos = DatosInit(:,1:13);

%Datos objetivos
tugReal=transpose(TUG);
%t= transpose(TUG)
%t=t(:,1:13);

%Creación de la red
net = feedforwardnet(10,'trainbr');
[net,tr] = train(net,DatosInit,tugReal);

%Testing
%testX = X(:,tr.testInd);
%testT = T(:,tr.testInd);

%testY = net(testX);

%perf = mse(net,testT,testY)

Y = net(DatosInit)

%Figura del error
e = tugReal - Y;
plot(e)
max(e)

%Valor del MSE
mse1 = (1/length(e))*sum(e.^2)


%Regresión
figure
plotregression(tugReal,Y)

%Histograma
figure
ploterrhist(e)

%Error cuadrático por MatLab
perf=mse(net,tugReal,Y)

%Desempeño de la red
figure
plotperform(tr)

