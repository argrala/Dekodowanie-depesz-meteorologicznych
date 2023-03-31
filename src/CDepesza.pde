//klasa odpowiedzialna za przechowywanie wydzielonych danych synoptycznych

class CDepesza{
  public int data;
  public int godzina;
  public int nr_stacji;
  public String depesza;
  
  CDepesza(){
  }
  CDepesza(int data, int stacja, int godzina){
    this.data=data;                                              //wpisanie danych
    this.nr_stacji=stacja;
            switch (godzina){
              case '0': this.godzina=00;
              break;
              case '6':this.godzina=06;
              break;
              case '2':this.godzina=12;
              break;
              case '8':this.godzina=18;
              break;
            } 
  }
  void analiza(String dostep, int stacja){                                //funkcja przeszukująca plik w celu znalezienia danych stacji
  String[] lines = loadStrings(dostep);                                   //załadowanie pliku jako tablicy Stringów (linie tekstu)
  for (int i = 0 ; i < lines.length; i++) {                               //iteracja linii tekstu
    String[] list = split(lines[i],' ');                                  //podział linii tekstu na pojedyncze wyrazy
    if(list.length>2 && list[0].length()==4 && list[0].charAt(0)=='A' && int(list[2])==stacja){   //sprawdzenie warunków istnienia linii tekstu i stacji synoptycznej lądowej
      this.depesza=lines[i];      
    }
  }
  return;
}
}
