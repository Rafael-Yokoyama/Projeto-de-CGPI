void setup() {
  size(640, 640);
  noLoop();
}

void draw() {
  PImage img = loadImage("55.jpg");
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
  
  
  // Filtro de Imagem Segmentada
  for (int y = 0; y < aux2.height; y++) {
    for (int x = 0; x < aux2.width; x++) {
      int pos = (y)*aux2.width + (x);
      color r = int(red(img.pixels[pos]));
      color g = int(green(img.pixels[pos]));
      color b = int(blue(img.pixels[pos]));
      if(blue(aux2.pixels[pos]) > 115 && y < 550) aux2.pixels[pos] = color(0);
      else aux2.pixels[pos] = color(r,g,b);
    }
  }
  
  
  image(aux2,0,0);
}