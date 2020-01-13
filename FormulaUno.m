function varargout = FormulaUno(varargin)
% FORMULAUNO MATLAB code for FormulaUno.fig
%      FORMULAUNO, by itself, creates a new FORMULAUNO or raises the existing
%      singleton*.
%
%      H = FORMULAUNO returns the handle to a new FORMULAUNO or the handle to
%      the existing singleton*.
%
%      FORMULAUNO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FORMULAUNO.M with the given input arguments.
%
%      FORMULAUNO('Property','Value',...) creates a new FORMULAUNO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FormulaUno_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FormulaUno_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FormulaUno

% Last Modified by GUIDE v2.5 04-Dec-2019 21:24:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FormulaUno_OpeningFcn, ...
                   'gui_OutputFcn',  @FormulaUno_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before FormulaUno is made visible.
function FormulaUno_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FormulaUno (see VARARGIN)
    im=imread('auto.jpg');
    imshow(im);
% Choose default command line output for FormulaUno
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FormulaUno wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FormulaUno_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global opc;
opc=str2double(get(hObject,'String'))
% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global potencia1;
global opc;
%Grada A
x_1=linspace(715.784,795.784); %´Puntos x donde se encuentra las gradas
y_1=linspace(3203.914,3213.914); %´Puntos y donde se encuentra las gradas
y1_1=3203.914; % Parte superior de la grada con respecto al eje y
y2_1=3213.914; % Parte inferior de la grada con respecto al eje y
x1_1=715.784; % Lado izquierdo de la grada con respecto al eje x
x2_1=795.784; % Lado derecho de las gradas con respecto al eje x

%Grada B
x_2=linspace(2107.401,2187.401); %´Puntos x donde se encuentra las gradas
y_2=linspace(899.459,909.459); %´Puntos y donde se encuentra las gradas
y1_2=899.459; % Parte superior de la grada con respecto al eje y
y2_2=909.459; % Parte inferior de la grada con respecto al eje y
x1_2=2107.401; % Lado izquierdo de la grada con respecto al eje x
x2_2=2187.401; % Lado derecho de la grada con respecto al eje x

opcion = opc; %Variable que determina si el coche sale por la tangente (2), la perpendicular(3), o sigue la trayectoria normal (1)

x = 300:10:3700; %Creamos un arreglo de 300 a 2600, con paso de 1....
xAtras = 300:50:2600;
maxX = 2300; %Delimitamos nuestro arreglo

potencia = potencia1; %Definimos la potencia inicial (La cual debe ser brindada por el usuario)
potencia = potencia*0.8;
eperdida = potencia*0.2;
potMax = 358080; %Establecemos la potencia máxima (considerando el 20% perdido en la transmisión a las llantas)
m = 820; %kg
D = 0.7206; %Coeficiente de arrastre de fuerza del aire.
B = 1.990625; %Coeficiente de sustentación. 
g = 9.81; %Valor de la gravedad.
peralte = 0.0996583; %Angulo en radianes. 
us = 1.18; %Coeficiente de fricción cinética.
eu = 0; %Energía cinética inicial


vImpulso = (potencia/D)^(1/3); %AVelocidad que tendrá al inicio, con la potencia brindada por el usuario. 
vMaxCurva = 0; %Inicializamos la velocidad máxima de curva. 

vMax = (potMax/D)^(1/3); %Calculamos la velocidad máxima con la potencia máxima.

estoyEnCurva = false; %Inicializo mi booleano (Que determina si el coche está en la curva)
saliendoPista= false;

%-------------Ecuación (Para determinar radio de la curvatura)
syms xPos; %Variable simbolica que nos permite derivar la posición con respecto a esta. 
y = ((1/597707).*(xPos.^3)) - ((79/10843).*(xPos.^2)) + ((1116/137).*(xPos)) + (60211/129); %%Ecuación Y1 de la gráfica
d1 = diff(y,xPos); %Primera derivada (Velocidad)
d2 = diff(d1, xPos); %Segunda derivada -Derivada de derivada- (Aceleración)

%Arreglo de velocidad
velocidades = []; %Establecemos un arreglo de velocidades.
velocidades(1) = vImpulso; %Establecemos que la velocidad inicial es igual a la velocidad de impulso.

%Arreglo de potencia
potenciales = [];
%Establecemos que la primera potencia, será la potencia que brinde el
%usuario.
potenciales(1) = potencia;

%Inicializo el valor de radio. 
radio = 0;

%Creo un ciclo que corre por todos los elementos de mi arreglo de
%posiciones.
for i=1:maxX
    if(i == 231) %Si nos encontramos en la ultima posicion, entonces...
        fprintf("Acabamos\n") 
        break; %Rompemos el ciclo (Porque el auto habrá llegado a su fin)
    end
    y = ((1/597707).*(xAtras.^3)) - ((79/10843).*(xAtras.^2)) + ((1116/137).*(xAtras)) + (60211/129);
    y1 = ((1/597707).*(x(i).^3)) - ((79/10843).*(x(i).^2)) + ((1116/137).*(x(i))) + (60211/129);
    %Si la velocidad en el intervalo es menor o mayor a la velocidad
    %máxima, entonces...
    if(velocidades(i)< vMax || velocidades(i)> vMax)
        %Calculamos la aceleración  
        aceleracion = (vMax^2 - (velocidades(i))^2)/(2*(x(i+100) - x(i)));
        
    elseif(velocidades(i) == vMax)
        aceleracion = 0;
    end
    
    if(((x(i) >= 540 && x(i) <= 1017) || (x(i) >= 1040 && x(i) <= 2336)) && (opcion == 1 || opcion == 3))
        estoyEnCurva = true;
        eu = m*9.81*1.2;
        radio = obtenerRadio(x(i),d1,d2);
        if(opcion == 1)
            vMaxCurva = sqrt(radio*9.81*((sin(0.0996583)+(1.18*cos(0.0996583)))/((cos(0.0996583)-(1.18*sin(0.0996583)))))); %5.71
        else
            vMaxCurva = 39;
        end
        
        if(velocidades(i) < vMaxCurva || velocidades(i) > vMaxCurva)
            aceleracion = ((vMaxCurva)^2 - (velocidades(i))^2)/(2*(x(i+100) - x(i)));     
        elseif((velocidades(i) == vMaxCurva))
            aceleracion = 0;
        end
    
    else
        estoyEnCurva = false;
        eu = 0;
    end
    
    velocidades(i+1) = ((velocidades(i).^2)+2*(aceleracion*(x(i+100)-(x(i))))).^(1/2);
    
    if(velocidades(i+1) == vMax)
        aceleracion = 0;
        
        
    elseif(velocidades(i+1)>= vMax)
        
        if(estoyEnCurva == true)
            if(vMax > vMaxCurva && opcion == 1)
               velocidades(i+1) = vMaxCurva;
            
            elseif(vMax < vMaxCurva)
                velocidades(i+1) = vMax;
            end
            
        else
            velocidades(i+1) = vMax;
        end
        
        aceleracion = ((velocidades(i+1)^2 - (velocidades(i))^2)/(2*(x(i+100) - x(i))));
        
    end
    
    potenciales(i+1) = (D*(velocidades(i+1).^2)+m*aceleracion)*velocidades(i+1);
    ek = (.5)*(m)*((velocidades(i))^2);
    ePerdida = (potenciales(i+1))*0.2;
    
    if(opcion == 1)
        %Calcula la posición del coche con la ecuación de la curva
        y1 = ((1/597707).*(x(i).^3)) - ((79/10843).*(x(i).^2)) + ((1116/137).*(x(i))) + (60211/129);
  
    elseif(opcion == 2 && x(i) >= 720)
        y1 = 0.256367.*x(i)+2994.781;
        saliendoPista= true;
        str8 = ['Evento de emergencia'];
        t8 = text (1000,1500,str8,'Fontsize',22,'Color','r');
    elseif(opcion == 3 && x(i) >= 720)
        y1=-(1/0.256367).*x(i)+5987.84;
        saliendoPista= true;
        str9 = ['Evento de emergencia'];
        t9 = text (1000,1500,str9,'Fontsize',22,'Color','r');
    end
    
    fprintf("Posición: %f\n", x(i));
    fprintf("Potencia: %f\n", potenciales(i+1));
    fprintf("Velocidad: %f\n", velocidades(i+1));
    fprintf("Aceleración: %f\n", aceleracion);
    fprintf("Radio crítico %f\n", radio);
    fprintf("Energía cinética: %f\n", ek);
    fprintf("Energía potencial: %f\n", eu);
    fprintf("Energía perdida: %f\n", ePerdida);
    fprintf("---------------------------------");
     
    figure (1)
    str = ['Posicion: (',num2str(x(i)),')']; 
    str1 =['Potencia: (', num2str(potenciales(i+1)),')'];
    str2 =['Velocidad: (', num2str(velocidades(i+1)), ')'];
    str3 =[ 'Aceleracion: (', num2str(aceleracion), ')'];
    str4 =[ 'Radio critico: (', num2str(radio), ')'];
    str5 =['Energia cinetica: (', num2str(ek), ')'];
    str6 =['Energia potencial: (', num2str(eu), ')'];
    str7= ['Energia perdida: (', num2str(ePerdida), ')'];
    t = text(1500,3200,str);
    t1 = text(1500,3000,str1);
    t2 = text(1500,2800,str2);
    t3 = text(1500,2600,str3);
    t4 = text(1500,2400,str4);
    t5 = text(1500,2200,str5);
    t6 = text(1500,2000,str6);
    t7 = text(1500,1800,str7);
    pause (0.002);
    plot(xAtras,y,x(i),y1,'s',x_1,y1_1,'r.',x_1,y2_1,'r.',x1_1,y_1,'r.',x2_1,y_1,'r.',x_2,y1_2,'g.',x_2,y2_2,'g.',x1_2,y_2,'g.',x2_2,y_2,'g.');
    axis ([300 2600 700 3500])
        delete(t)
    delete(t1)
    delete(t2)
    delete(t3)
    delete(t4)
    delete(t5)
    delete(t6)
    delete(t7)
    
end
set(handles.edit1,'String',potencia1);
set(handles.edit3,'String',opc);
    







% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global potencia1;
potencia1=str2double(get(hObject,'String'))
% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
