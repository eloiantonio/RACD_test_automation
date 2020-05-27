// Processing application that demonstrates the Button class by creating a button
// Draws a square in the window when the mouse cursor is over the button
// Writes to the Processing IDE console pane when the button is clicked
// 3 July 2015    http://startingelectronics.org
import processing.serial.*;       // Importa as bibliotecas para comunicação de Serie
import java.awt.event.KeyEvent;   // Importa as bibliotecas para ler a informação da entrada de serie
import java.io.IOException;

Button on_button;  // start button
Button on_button_2; // stop button
Button_2 seta_preta;
Button_2 seta_colorida_1;
Button_2 seta_colorida_2;
Button_2 seta_colorida_3;
int clk = 1;       // number of times the button is clicked
int clk_2 = 1;
boolean colorido=false;

boolean frame2Exit;
SecondApplet sa;
boolean sa_em_execucao=false;
String[] args = {"TwoFrameTest"};


//OtherSketch win;
void settings() {
  size(150, 400);
  smooth();
}

void setup() {
  surface.setResizable(true);
  // create the button object
  on_button = new Button("Start", 20, 20, 100, 50, 200, 0, 0, 260);
  on_button_2 = new Button("Stop program", 20, 90, 100, 50, 0, 200, 0, 260);
  seta_preta = new Button_2("", 20, 170, 40, 40, 0, 0, 0, 0);
  seta_colorida_1 = new Button_2("", 80, 170, 13.3333, 40, 0, 0, 360, 0);
  seta_colorida_2 = new Button_2("", 93.3333, 170, 13.3333, 40, 360, 360, 0, 0);
  seta_colorida_3 = new Button_2("", 106.6667, 170, 13.3333, 40, 0, 360, 0, 0);
}

void draw() {
  // draw a square if the mouse curser is over the button
  
  if (on_button.MouseIsOver()) {
      on_button = new Button("Start", 20, 20, 100, 50, 360, 0, 0, 100);
  }
  else { 
    if (on_button_2.MouseIsOver()) {
      on_button_2 = new Button("Stop program", 20, 90, 100, 50, 0, 360, 0, 100);
      
    }   // hide the square if the mouse cursor is not over the button
    else{
      on_button = new Button("Start", 20, 20, 100, 50, 200, 0, 0, 260); 
      on_button_2 = new Button("Stop program", 20, 90, 100, 50, 0, 200, 0, 260);
      //BOTÕES DE CORES VÃO AQUI
    }
  }
  if(colorido==true){
    seta_preta = new Button_2("", 20, 170, 40, 40, 0, 0, 0, 0);
    seta_colorida_1 = new Button_2("", 80, 170, 13.3333, 40, 0, 0, 360, 500);
    seta_colorida_2 = new Button_2("", 93.3333, 170, 13.3333, 40, 360, 360, 0, 500);
    seta_colorida_3 = new Button_2("", 106.6667, 170, 13.3333, 40, 0, 360, 0, 500);    
  }
  else{
    seta_preta = new Button_2("", 20, 170, 40, 40, 40, 40, 40, 500);
    seta_colorida_1 = new Button_2("", 80, 170, 13.3333, 40, 0, 0, 360, 0);
    seta_colorida_2 = new Button_2("", 93.3333, 170, 13.3333, 40, 360, 360, 0, 0);
    seta_colorida_3 = new Button_2("", 106.6667, 170, 13.3333, 40, 0, 360, 0, 0);
  }

  // draw thon_button_2 = new Button("Stop", 20, 90, 100, 50, 0, 200, 260);e button in the window
  on_button.Draw();
  on_button_2.Draw();
  seta_preta.Draw();
  seta_colorida_1.Draw();
  seta_colorida_2.Draw();
  seta_colorida_3.Draw();
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

  }
  else if (seta_colorida_1.MouseIsOver() || seta_colorida_2.MouseIsOver() || seta_colorida_3.MouseIsOver()){
    colorido=true;
  
  }
  
}
void frame2Start(boolean colorido, boolean sa_em_execucao) {
  //if (sa_em_execucao==false){
    sa = new SecondApplet(colorido, sa_em_execucao);
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
int total_time;
int tempo_ultima_pass;
float serial;
boolean com_presenca; //indica 'true' quando o corredor passa pelo sensor
boolean com_presenca_anterior; //indica 'true' se o corredor, no instante anterior, já tinha passado pelo sensor
int time_0;
int it=0;
int contador=0;
boolean colorido;
boolean porta_ocupada;

SecondApplet(boolean c, boolean p) {  
    // values 
    colorido=c;
    porta_ocupada=p;
  }


void setup() {
  surface.setResizable(true);
  background(255,255,255);
  // Creating a custom PShape as a square, by
  // specifying a series of vertices.
  com_presenca = false;
  com_presenca_anterior=false;
  // Aqui tem um detalhe importante:
  // onde tem 'Serial.list()[0]', caso dê algum erro
  // troque isso pela porta que se Arduino está tipo "COM3" ok?
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
  else{
    cor=3;
  }

  /*do {
    fundo = round(random(-0.5,2.4999)); //seleção de uma cor aleatória para o fundo
  } while (fundo == cor);*/
  //println(rot);
  s =  new Seta(rot, cor, /*fundo,*/ width, height); //criação do layout
}

void draw(){
    //O condicional abaixo identifica se é a primeira vez que o corredor passou pelo sensor
    //Se fosse identificada apenas a presença, a interface seria alterada a cada iteração.
    if (Porta_serial.available() > 0){
      serialEvent(Porta_serial);
    }
    
    //println(serial, " ", com_presenca, " ", com_presenca_anterior);
    if (com_presenca==true){
        if(com_presenca_anterior==false){
          time_0=millis();
          contador=contador+1;
          if(contador%2==0){
            update();
            shape(s.obj(),width/2,height/2);
            Porta_serial.clear();
            
          }
          tempo_ultima_pass=millis();
          
        } 
        
    } 
    com_presenca_anterior=com_presenca;
    time=millis();
    if((time-time_0)>=1000){ 
        background(245,245,245);
        time=0;
    }
    total_time=millis() - tempo_ultima_pass;
    println(total_time);
    if (total_time>6000){
      Porta_serial.clear();
    }
  
}

/*void serialEvent (Serial Porta_serial) {
  //if (Porta_serial.available()>0){
      serial = Porta_serial.read();
      println(serial);
      if (serial>10){
        com_presenca=true;
      }
      else {
        com_presenca=false;
      }  
  //}
}*/

void serialEvent(Serial p) {
  // get message till ';')

  String message = p.readStringUntil(';');
  if (message != null) {
  
  message=message.substring(0,message.length()-1);
  //rintln(message);
  
      it=it+1;
      serial=float(message);

/*      if (message == "1"){
        serial = 1;
      }
      else{
        serial = 0;
      }*/
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
