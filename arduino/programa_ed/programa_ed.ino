//RACD test automation - Arduino Nano code
#include <avr/wdt.h>

int saida_preto = A0;

int val_s=0;
int vetores_saida[5];
int d_p;
bool presenca;
int t=0;
int it=0;
unsigned long startMillis;
unsigned long currentMillis;

void setup(){
  Serial.begin(9600);
  wdt_enable(WDTO_8S);
  startMillis = millis();
}

void loop()
{

  delay(5);

  val_s=analogRead(saida_preto);
  vetores_saida[it%5]=val_s;
  //d_p=abs(val_s-val_g);
  it=it+1;
  //Serial.println(val_s);
  presenca=false;
  for (int i = 0; i < 5; i++) {
    presenca=true;
    if (vetores_saida[i]>5){
      presenca=false;
      break;
    }
  }
  wdt_reset();


  Serial.print(presenca);
  Serial.println(";");
  /*
  Serial.print(presenca);
  currentMillis = millis();
  Serial.print(";   ");
  Serial.println(currentMillis-startMillis);
  */
  if(presenca==true){
    delay(500); //Este valor altera o tempo entre leituras, em milissegundos
  }
  
}
