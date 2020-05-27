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
  
  PShape obj() {
    
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
      s.vertex(-0.3704*altura, -0.1481*altura);
      s.vertex(-0.3704*altura, 0.1481*altura);
      s.vertex(0, 0.1481*altura);
      s.vertex(0 , 0.2962*altura);
      s.vertex(0.3704*altura,0);
      s.vertex(0, -0.2962*altura);
      s.vertex(0, -0.1481*altura); 
    }
    else if (rotacao==1){
      s.vertex(-0.1481*altura, 0.3704*altura);
      s.vertex(0.1481*altura, 0.3704*altura);
      s.vertex(0.1481*altura, 0);
      s.vertex(0.2962*altura, 0);
      s.vertex(0, -0.3704*altura);
      s.vertex(-0.2962*altura, 0);
      s.vertex(-0.1481*altura, 0);
    }
    else if (rotacao==2){
      s.vertex(0.3704*altura, -0.1481*altura);
      s.vertex(0.3704*altura, 0.1481*altura);
      s.vertex(0, 0.1481*altura);
      s.vertex(0 , 0.2962*altura);
      s.vertex(-0.3704*altura,0);
      s.vertex(0, -0.2962*altura);
      s.vertex(0, -0.1481*altura);
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
