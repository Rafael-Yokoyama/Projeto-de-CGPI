void setup() {
  size(1372, 2056);
  noLoop();
}


// verificar pixels
void verificarPixel(){
  
  PImage original = loadImage("seg04-bg.png");
  PImage novaImage = loadImage("seg04-final.png");
  
  int count = 0;
  int falsoN = 0,falsoP = 0, verdadeiro = 0;
  float percentFN = 0,percentFP = 0,percentV = 0;
  
  if(original.height == novaImage.height && original.width == novaImage.width){
 println("IMAGENS DE DIMENSÕES IGUAIS");
  int posO, posN;
  int pAuxO, pAuxN;
  
  
  for (int y = 0; y < original.height; y++) {
    for (int x = 0; x < original.width; x++) {
       
      count++;
      posO = (y)*original.width + (x);
      posN = (y)*novaImage.width + (x);
      pAuxO = parseInt(blue(original.pixels[posO]));
      pAuxN = parseInt(blue(novaImage.pixels[posN]));
      
      if(pAuxO == 255 && pAuxN == 0){        
      //falso negativo
       falsoN ++;
      
      }else if(pAuxO == 0 && pAuxN == 255){
      //falso positivo
      falsoP ++;
      
      }else verdadeiro++;
        
    }
   
  }
  
  percentFN = (falsoN * 100) / count;
  percentFP = (falsoP * 100) / count;
  percentV = (verdadeiro * 100) / count;
  
  }else println("IMAGENS DE DIMENSÕES DIFERENTES");
  

  
  println(count);
  println(falsoN);
  println(falsoP);
  println(verdadeiro);
  println(percentFN);
  println(percentFP);
  println(percentV); 
}


void draw() {
  PImage img = loadImage("./223.jpg");
  PImage aux = createImage(img.width, img.height, RGB);
  PImage aux2 = createImage(img.width, img.height, RGB);
 
  // Filtro escala de cinza
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {

      int pos = (y)*img.width + (x);
      aux.pixels[pos] = color(blue(img.pixels[pos]));
    }
  }
  
  // Filtro de Média com Janela Deslizante
  for (int y = 0; y < aux.height; y++) {
    for (int x = 0; x < aux.width; x++) {
      int jan = 5;
      int pos = y*aux.width + x; /* acessa o ponto em forma de vetor */

      float media = 0;
      int qtde = 0;

      for (int i = jan*(-1); i <= jan; i++) {
        for (int j = jan*(-1); j <= jan; j++) {
          int disy = y+i;
          int disx = x+j;
          if (disy >= 0 && disy < aux.height &&
            disx >= 0 && disx < aux.width) {
            int pos_aux = disy * img.width + disx;
            float r = blue(aux.pixels[pos_aux]);
            media += r;
            qtde++;
          }
        }
      }
      media = media / qtde;
      aux2.pixels[pos] = color(media);
    }
  }
  
  
  // Filtro de limiarização
  for (int y = 0; y < aux2.height; y++) {
    for (int x = 0; x < aux2.width; x++) {
      int pos = (y)*aux2.width + (x);
      if(blue(aux2.pixels[pos]) > 120 && y < 550) aux2.pixels[pos] = color(0);
      else aux2.pixels[pos] = color(255);
    }
  }
  
  
  //image(aux2,0,0);
  verificarPixel();
}