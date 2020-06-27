//Program for RACD test visual command display

import processing.serial.*;       // Importa as bibliotecas para comunicação de Serie
import java.awt.event.KeyEvent;   // Importa as bibliotecas para ler a informação da entrada de serie
import java.io.IOException;

Button on_button;  // start button
Button on_button_2; // stop button
Button_2 seta_preta;
Button_2 seta_colorida_1;
Button_2 seta_colorida_2;
Button_2 seta_colorida_3;
Button_2 seta_colorida_4;
Button_2 seta_colorida_5;
Button_2 seta_colorida_6;
Button_2 seta_colorida_7;

int clk = 1;       // número de vezes que o botão é clicado
int clk_2 = 1;
boolean colorido=false;
boolean colorido_e_pb=false;

boolean frame2Exit;
SecondApplet sa;
boolean sa_em_execucao=false;
String[] args = {"TwoFrameTest"};


//OtherSketch win;
void settings() {
  size(360, 500);
  smooth();
}

void setup() {
  surface.setResizable(true);
  background(150,150,150);
  // create the button object
  on_button = new Button("START", 20, 20, 320, 120, 200, 0, 0, 260);
  on_button_2 = new Button("STOP AND CLOSE", 20, 180, 320, 80, 0, 200, 0, 260);
  seta_preta = new Button_2("", 20, 170, 80, 80, 0, 0, 0, 0);
  seta_colorida_1 = new Button_2("", 140, 340, 26.6667, 80, 0, 0, 360, 0);
  seta_colorida_2 = new Button_2("", 166.6667, 340, 26.6667, 80, 360, 360, 0, 0);
  seta_colorida_3 = new Button_2("", 193.3333, 340, 26.6667, 80, 0, 360, 0, 0);
  seta_colorida_4 = new Button_2("", 260, 340, 40, 40, 0, 0, 0, 0);
  seta_colorida_5 = new Button_2("", 260, 380, 40, 40, 0, 0, 360, 0);
  seta_colorida_6 = new Button_2("", 300, 340, 40, 40, 360, 360, 0, 0);
  seta_colorida_7 = new Button_2("", 300, 380, 40, 40, 0, 360, 0, 0);
}

void draw() {
  // draw a square if the mouse curser is over the button
  
  if (on_button.MouseIsOver()) {
      on_button = new Button("START", 20, 20, 320, 120, 360, 0, 0, 100);
  }
  else { 
    if (on_button_2.MouseIsOver()) {
      on_button_2 = new Button("STOP AND CLOSE", 20, 180, 320, 120, 0, 360, 0, 100);
      
    }   // hide the square if the mouse cursor is not over the button
    else{
      on_button = new Button("START", 20, 20, 320, 120, 200, 0, 0, 260); 
      on_button_2 = new Button("STOP AND CLOSE", 20, 180, 320, 120, 0, 200, 0, 260);
      //BOTÕES DE CORES VÃO AQUI
    }
  }
  if(colorido==true){
    seta_preta = new Button_2("", 20, 340, 80, 80, 0, 0, 0, 0);
    seta_colorida_1 = new Button_2("", 140, 340, 26.6667, 80, 0, 0, 360, 500);
    seta_colorida_2 = new Button_2("", 166.6667, 340, 26.6667, 80, 360, 360, 0, 500);
    seta_colorida_3 = new Button_2("", 193.3333, 340, 26.6667, 80, 0, 360, 0, 500);
    seta_colorida_4 = new Button_2("", 260, 340, 40, 40, 0, 0, 0, 0);
    seta_colorida_5 = new Button_2("", 260, 380, 40, 40, 0, 0, 360, 0);
    seta_colorida_6 = new Button_2("", 300, 340, 40, 40, 360, 360, 0, 0);
    seta_colorida_7 = new Button_2("", 300, 380, 40, 40, 0, 360, 0, 0);
  }
  else if (colorido_e_pb==true){
    seta_preta = new Button_2("", 20, 340, 80, 80, 0, 0, 0, 0);
    seta_colorida_1 = new Button_2("", 140, 340, 26.6667, 80, 0, 0, 360, 0);
    seta_colorida_2 = new Button_2("", 166.6667, 340, 26.6667, 80, 360, 360, 0, 0);
    seta_colorida_3 = new Button_2("", 193.3333, 340, 26.6667, 80, 0, 360, 0, 0);    
    seta_colorida_4 = new Button_2("", 260, 340, 40, 40, 0, 0, 0, 500);
    seta_colorida_5 = new Button_2("", 260, 380, 40, 40, 0, 0, 360, 500);
    seta_colorida_6 = new Button_2("", 300, 340, 40, 40, 360, 360, 0, 500);
    seta_colorida_7 = new Button_2("", 300, 380, 40, 40, 0, 360, 0, 500);
  }  
  else {
    seta_preta = new Button_2("", 20, 340, 80, 80, 40, 40, 40, 1000);
    seta_colorida_1 = new Button_2("", 140, 340, 26.6667, 80, 0, 0, 360, 0);
    seta_colorida_2 = new Button_2("", 166.6667, 340, 26.6667, 80, 360, 360, 0, 0);
    seta_colorida_3 = new Button_2("", 193.3333, 340, 26.6667, 80, 0, 360, 0, 0);
    seta_colorida_4 = new Button_2("", 260, 340, 40, 40, 0, 0, 0, 0);
    seta_colorida_5 = new Button_2("", 260, 380, 40, 40, 0, 0, 360, 0);
    seta_colorida_6 = new Button_2("", 300, 340, 40, 40, 360, 360, 0, 0);
    seta_colorida_7 = new Button_2("", 300, 380, 40, 40, 0, 360, 0, 0);
  }

  // draw thon_button_2 = new Button("Stop", 20, 90, 100, 50, 0, 200, 260);e button in the window
  on_button.Draw();
  on_button_2.Draw();
  seta_preta.Draw();
  seta_colorida_1.Draw();
  seta_colorida_2.Draw();
  seta_colorida_3.Draw();
  seta_colorida_4.Draw();
  seta_colorida_5.Draw();
  seta_colorida_6.Draw();
  seta_colorida_7.Draw();
}

// mouse button clicked
void mousePressed()
{
  if (on_button.MouseIsOver()) {
    // print some text to the console pane if the button is clicked
    //print("Start: ");
    //println(clk++);
    if (sa_em_execucao==false){
      frame2Start(colorido, sa_em_execucao);
      sa_em_execucao=true;
    }
    else{
      println("");
      println("A porta serial já está sendo utilizada");
    //win = new OtherSketch();
    }
  }
  else if (on_button_2.MouseIsOver()){

    //print("Stop: ");
    //println(clk_2++);
    exit();
  }
  else if (seta_preta.MouseIsOver()){
    colorido=false;
    colorido_e_pb=false;

  }
  else if (seta_colorida_1.MouseIsOver() || seta_colorida_2.MouseIsOver() || seta_colorida_3.MouseIsOver()){
    colorido=true;
    colorido_e_pb=false;
  }
  else if (seta_colorida_4.MouseIsOver() || seta_colorida_5.MouseIsOver() || seta_colorida_6.MouseIsOver() || seta_colorida_7.MouseIsOver() ){
    colorido=false;
    colorido_e_pb=true;
  }
}
void frame2Start(boolean colorido, boolean sa_em_execucao) {
  //if (sa_em_execucao==false){
    sa = new SecondApplet(colorido, colorido_e_pb, sa_em_execucao);
    PApplet.runSketch(args, sa);
    frame2Exit = false;
  //}
}

public class SecondApplet extends PApplet {

Serial Porta_serial;             // Define o objeto Serial


Seta s;  // The PShape object
int rot;
int cor;
//int fundo;
int time;
float serial;
boolean com_presenca; //indica 'true' quando o corredor passa pelo sensor
boolean com_presenca_anterior; //indica 'true' se o corredor, no instante anterior, já tinha passado pelo sensor
int time_0;
int it=0;
int contador=0;
boolean colorido;
boolean colorido_e_pb;
boolean porta_ocupada;
int tempo_ultima_passagem;
int tempo_atual;

SecondApplet(boolean c, boolean c_pb, boolean p) {  
    // values 
    colorido_e_pb=c_pb;
    colorido=c;
    porta_ocupada=p;
  }


void setup() {
  surface.setResizable(true);
  background(255,255,255);
   com_presenca = false;
  com_presenca_anterior=false;
  tempo_ultima_passagem=0;
  
  println("Portas seriais disponíveis: ");
  print(Serial.list());
  Porta_serial = new Serial(this,Serial.list()[2], 9600);   // Começa a comunicação Serie
  Porta_serial.bufferUntil(';');                             // Lê o Serial Monitor até a troca de linha
}

void update(){
  background(255,255,255);
  rot = round(random(-0.5,2.4999)); //seleção de um sentido aleatório para a seta
  if(colorido==true){
    cor= round(random(-0.5,2.4999));  //seleção de uma cor aleatória para a seta
  }
  else if(colorido_e_pb==true){
    cor= round(random(-0.5,3.4999));  //seleção de uma cor aleatória para a seta, incluindo a cor preta
  }
  else{
    cor=3; // a seta pode ter apenas a cor preta
  }

  s =  new Seta(rot, cor, /*fundo,*/ width, height); //criação do layout
}

void update_2(){
  Porta_serial.clear();
  Porta_serial.stop();
  Porta_serial = new Serial(this,Serial.list()[2], 9600);   // Começa a comunicação Serie
  Porta_serial.bufferUntil(';');                             // Lê o Serial Monitor até a troca de linha
  delay(20);
  println("new serial");
}  
void draw(){
    //O condicional abaixo identifica se é a primeira vez que o corredor passou pelo sensor
    //Se fosse identificada apenas a presença, a interface seria alterada a cada iteração.
    
    if (Porta_serial.available() > 0){
      serialEvent(Porta_serial);
    }
    
    //println(serial, " ", com_presenca, " ", com_presenca_anterior);
    if (com_presenca==true){
        tempo_ultima_passagem=millis();
        if(com_presenca_anterior==false){
          time_0=millis();
          contador=contador+1;
          if(contador%2==0){
            update();
            shape(s.obj(),width/2,height/2);
          }
        } 
        
    } 
    com_presenca_anterior=com_presenca;
    time=millis();
    if((time-time_0)>=1000){ 
        background(245,245,245);
        time=0;
    }
    tempo_atual=millis();
    if (tempo_atual-tempo_ultima_passagem>30000){
      update_2();
      tempo_ultima_passagem=millis();
    }
}

void serialEvent(Serial p) {
  // get message till ';')

  String message = p.readStringUntil(';');
  if (message != null) {
  //println(message);
  
  message=message.substring(0,message.length()-1);
  //println(message);
  
      it=it+1;
      serial=float(message);

      if (serial==1){
        com_presenca=true;
      }
      else {
        com_presenca=false;
      }

      
  }
}
void exit(){
  {
    dispose();
    sa = null;
    sa_em_execucao=false;
  }
}
}
