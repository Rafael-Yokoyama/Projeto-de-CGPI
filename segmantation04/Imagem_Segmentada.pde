void setup() {
  size(480, 600);
  noLoop();
}

void draw() {
  PImage img = loadImage("223.jpg"); 
  PImage aux = createImage(img.width, img.height, RGB);

  //Escala de Cinza
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int pos = y * img.width + x;
      int media = int((red(img.pixels[pos]) + green(img.pixels[pos]) + blue(img.pixels[pos]))/3);
      aux.pixels[pos] = color(media);
    }
  }

  //filtro de média com janela deslizante
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int pos = y * img.width + x;
      int jan = 0, qtde = 0;
      float media = 0;

      for (int i = jan * (-1); i <= jan; i++) {
        for (int j = jan * (-1); j <= jan; j++) {
          int ny = y + i;
          int nx = x + j;
          if (ny >= 0 && ny < img.height &&
            nx >= 0 && nx < img.width) {
            int npos = ny * img.width + nx;
            float valor = red(img.pixels[npos]);
            media += valor; // media = media + valor;
            qtde++;
          }
        }
      }
      media = media / qtde;
      aux.pixels[pos] = color(media);
    }
  }
  //Limizarização
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int pos = y * img.width + x;
      color r = int(red(img.pixels[pos]));
      color g = int(green(img.pixels[pos]));
      color b = int(blue(img.pixels[pos]));
      if (red(aux.pixels[pos]) > 130 && y < 500) {
        aux.pixels[pos] = color(r,g,b);
      } else {
        aux.pixels[pos] = color(0);
      }
      
    }
  }image (aux,0,0);
   save ("223.jpg");
}