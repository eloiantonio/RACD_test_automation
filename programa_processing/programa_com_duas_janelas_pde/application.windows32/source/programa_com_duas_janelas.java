import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 
import java.awt.event.KeyEvent; 
import java.io.IOException; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class programa_com_duas_janelas extends PApplet {

// Processing application that demonstrates the Button class by creating a button
// Draws a square in the window when the mouse cursor is over the button
// Writes to the Processing IDE console pane when the button is clicked
// 3 July 2015    http://startingelectronics.org
       // Importa as bibliotecas para comunicação de Serie
   // Importa as bibliotecas para ler a informação da entrada de serie


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
public void settings() {
  size(150, 400);
  smooth();
}

public void setup() {
  surface.setResizable(true);
  // create the button object
  on_button = new Button("Start", 20, 20, 100, 50, 200, 0, 0, 260);
  on_button_2 = new Button("Stop program", 20, 90, 100, 50, 0, 200, 0, 260);
  seta_preta = new Button_2("", 20, 170, 40, 40, 0, 0, 0, 0);
  seta_colorida_1 = new Button_2("", 80, 170, 13.3333f, 40, 0, 0, 360, 0);
  seta_colorida_2 = new Button_2("", 93.3333f, 170, 13.3333f, 40, 360, 360, 0, 0);
  seta_colorida_3 = new Button_2("", 106.6667f, 170, 13.3333f, 40, 0, 360, 0, 0);
}

public void draw() {
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
    seta_colorida_1 = new Button_2("", 80, 170, 13.3333f, 40, 0, 0, 360, 500);
    seta_colorida_2 = new Button_2("", 93.3333f, 170, 13.3333f, 40, 360, 360, 0, 500);
    seta_colorida_3 = new Button_2("", 106.6667f, 170, 13.3333f, 40, 0, 360, 0, 500);    
  }
  else{
    seta_preta = new Button_2("", 20, 170, 40, 40, 40, 40, 40, 500);
    seta_colorida_1 = new Button_2("", 80, 170, 13.3333f, 40, 0, 0, 360, 0);
    seta_colorida_2 = new Button_2("", 93.3333f, 170, 13.3333f, 40, 360, 360, 0, 0);
    seta_colorida_3 = new Button_2("", 106.6667f, 170, 13.3333f, 40, 0, 360, 0, 0);
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
public void mousePressed()
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
public void frame2Start(boolean colorido, boolean sa_em_execucao) {
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


public void setup() {
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
  Porta_serial.bufferUntil('\n');                             // Lê o Serial Monitor até a troca de linha
}

public void update(){
  background(255,255,255);
  rot = round(random(-0.5f,2.4999f)); //seleção de um sentido aleatório para a seta
  if(colorido==true){
    cor= round(random(-0.5f,2.4999f));  //seleção de uma cor aleatória para a seta
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

public void draw(){
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
          }
        } 
        
    } 
    com_presenca_anterior=com_presenca;
    time=millis();
    if((time-time_0)>=1000){ 
        background(245,245,245);
        time=0;
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

public void serialEvent(Serial p) {
  // get message till line break (ASCII > 13)
  String message = p.readStringUntil(ENTER);
  //rintln(message);
  if (message != null) {
      it=it+1;
      serial=PApplet.parseFloat(message);

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
public void exit(){
  {
    dispose();
    sa = null;
    sa_em_execucao=false;
  }
}
}
class Button {
  String label;
  float x;    // top left corner x position
  float y;    // top left corner y position
  float w;    // width of button
  float h;    // height of button
  int rf;
  int gf;
  int bf;
  int s;
  
  Button(String labelB, float xpos, float ypos, float widthB, float heightB, int green_fill, int red_fill, int blue_fill, int number_stroke) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
    rf = red_fill;
    gf = green_fill;
    bf = blue_fill;
    s = number_stroke;
  }

  
  public void Draw() {
    fill(rf,gf,bf);
    stroke(s);
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    fill(0);
    text(label, x + (w / 2), y + (h / 2));
  }
  
  public boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
}

class Button_2 {
  String label;
  float x;    // top left corner x position
  float y;    // top left corner y position
  float w;    // width of button
  float h;    // height of button
  int rf;
  int gf;
  int bf;
  int s;
  
  Button_2(String labelB, float xpos, float ypos, float widthB, float heightB, int green_fill, int red_fill, int blue_fill, int number_stroke) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
    rf = red_fill;
    gf = green_fill;
    bf = blue_fill;
    s = number_stroke;
  }

  
  public void Draw() {
    fill(rf,gf,bf);
    stroke(0,0,s);
    rect(x, y, w, h, 0);
    textAlign(CENTER, CENTER);
    fill(0);
    text(label, x + (w / 2), y + (h / 2));
  }
  
  public boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
}
class Seta { 
  PShape s;
  float rotacao; // 0 <= rotacao <= 2
  int cor_seta; // 0 <= cor_seta <= 2
  //int cor_fundo; // 0 <= cor_fundo <= 2
  int largura; 
  int altura;
  
  Seta (int r, int cs, /*int cf, */int w, int h) {  
    rotacao = r;
    cor_seta=cs;
    //cor_fundo=cf; //0 -> vermelho, 1 -> verde, 2 -> azul
    largura=w;
    altura=h;
  }
  
  public PShape obj() {
    
    /*if (cor_fundo == 0) { background(255,0,0); }
    else if (cor_fundo == 1) { background(0,255,0); }
    else if (cor_fundo == 2) { background(0,0,255); }*/
    background(255,255,255);
    
    // Creating a custom PShape as a square, by
    // specifying a series of vertices.
    s = createShape();
    s.beginShape();
    s.noStroke();
    if (rotacao==0){
      s.vertex(-0.3704f*altura, -0.1481f*altura);
      s.vertex(-0.3704f*altura, 0.1481f*altura);
      s.vertex(0, 0.1481f*altura);
      s.vertex(0 , 0.2962f*altura);
      s.vertex(0.3704f*altura,0);
      s.vertex(0, -0.2962f*altura);
      s.vertex(0, -0.1481f*altura); 
    }
    else if (rotacao==1){
      s.vertex(-0.1481f*altura, 0.3704f*altura);
      s.vertex(0.1481f*altura, 0.3704f*altura);
      s.vertex(0.1481f*altura, 0);
      s.vertex(0.2962f*altura, 0);
      s.vertex(0, -0.3704f*altura);
      s.vertex(-0.2962f*altura, 0);
      s.vertex(-0.1481f*altura, 0);
    }
    else if (rotacao==2){
      s.vertex(0.3704f*altura, -0.1481f*altura);
      s.vertex(0.3704f*altura, 0.1481f*altura);
      s.vertex(0, 0.1481f*altura);
      s.vertex(0 , 0.2962f*altura);
      s.vertex(-0.3704f*altura,0);
      s.vertex(0, -0.2962f*altura);
      s.vertex(0, -0.1481f*altura);
    }
    if (cor_seta == 0) { s.fill(255,0,0); }
    else if (cor_seta == 1) { s.fill(0,255,0); }
    else if (cor_seta==2){ s.fill(0,0,255); }
    else { s.fill(0,0,0); }
   
   /* if (rotacao == 0) { 
        translate(0,0); 
    }
    else if (rotacao == 1) { 
        translate(0,altura);
    }
    else  if (rotacao == 2){ 
        translate(largura,altura); 
    }
    
    rotate(2*PI - rotacao*(PI/2));
    if (rotacao == 1) { 
        translate(-(largura-altura)/2,(largura-altura)/2);
    }*/
    s.endShape(CLOSE);

    return s;

    
  } 
  
} 
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "programa_com_duas_janelas" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
