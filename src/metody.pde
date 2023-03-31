

//Lista katalogów w bibliotece SYNOP oraz lista plików SYNOP//    
public void listaplikow(String sciezka){
   File temp = new File(sciezka);
   if(temp.isDirectory()){
     File[] lkatalog = listFiles(sciezka);
     for(int i=0;i<lkatalog.length;i++){
      CDostep element = new CDostep();
      element.pliki(lkatalog[i],i);
      ladres.add(element);       
      }
   }
   return;
}



void przeszukiwanie(ArrayList<CDostep> lista, int start_data, int koniec_data,int[] nrstacji){
  println("Rozpoczęto poszukiwanie wybranych stacji");
  for(int i=0;i<lista.size();i++){                          
    String sciezka = ((lista.get(i)).adres).getPath();      //Wyszukiwanie ścieżek dostępowych do katalogów
    String [] czlony = split(sciezka,char(92));             //Podział Stringa na grupy (char(92)=="\"
    int dl = czlony.length-1;                               //Znalezienie długości Stringa[], interesująca wartość jest w ostatniej komórce
    int data = int(czlony[dl]);                              //Konwersja Stringa daty do liczby
    
    if(data>=start_data && data<=koniec_data){              //sprawdzenie zakresu analizowanych dat
      //println(data);
      for(int j=0;j<(lista.get(i)).lzawartosc.length;j++){                  //przeszukiwanie katalogu o danej dacie
        String dostep = ((lista.get(i)).lzawartosc[j]).getPath();           //dostęp do ścieżki pliku z dnej godziny
        String [] czlonydostep = split(dostep,".");                         //podział Stringa
        char godzina = czlonydostep[0].charAt(czlonydostep[0].length()-1);  //odczytanie godziny 
 
        
        for(int k=0;k<nrstacji.length;k++){                                 //iteracja stacji 
          
            int stacja=nrstacji[k];
            CDepesza depesza = new CDepesza(data,stacja,godzina);             //stworzenie obiektu CDepesza
            depesza.analiza(dostep,stacja);                                  //wywołanie funkcji analizującej plik synop
            ldepesz.add(depesza);
        }       
      }
    }   
  }
  return;
}

void sortowanie(ArrayList<CDepesza> ldepesz, int[]nrstacji){      //funkcja sortująca nieuporządkowaną listę danych synoptycznych na kilka list odpowiadających stacjom i godzinom
  int ilosc = nrstacji.length;
  for(int i=0;i<ilosc;i++){
   int stacja = nrstacji[i];
   for(int j=0;j<4;j++){
     ArrayList<CDepesza> lista = new ArrayList<CDepesza>();
     int godzina=j;
     switch (godzina){
       case 0: godzina=00;
       break;
       case 1:godzina=06;
       break;
       case 2:godzina=12;
       break;
       case 3:godzina=18;
       break;
       } 
       for(int k=0;k<ldepesz.size();k++){
         if(ldepesz.get(k).godzina==godzina && ldepesz.get(k).nr_stacji==stacja){
           lista.add(ldepesz.get(k));        
         }
       }
       lsort.add(lista);    
   }
  }
  return;
}


void analiza(ArrayList<ArrayList> lista){            //funckja analizująca dane w depeszy synoptycznej
  for(int a=0;a<lista.size();a++){
  ArrayList<CDepesza> ldepesz = lista.get(a);
  ArrayList<CDane> ldanych = new ArrayList<CDane>();
  for(int b=0;b<ldepesz.size();b++){
    CDepesza element = ldepesz.get(b);
    int data=element.data;
    int godzina=element.godzina;
    int nr_stacji=element.nr_stacji;
    float temperatura=0;
    float cisnienie=0;
    float wiatr=0;
    float wilgotnosc=0;
    float rosa=0;
    String[]czlony=split(element.depesza," ");
    int c=1;
    boolean koniec=false;
    int twiatr=0;

    while(koniec==false){
      String czlon=czlony[c];
      if(czlon.charAt(0)<48 || czlon.charAt(0)>57){
        koniec=true;
      }
      if(c==1){
        twiatr=czlon.charAt(4)-'0';        
      }
      if(c==4){
        int w1=czlon.charAt(3)-'0';
        int w2=czlon.charAt(4)-'0';
        if(twiatr==0 || twiatr==1){
          wiatr=w1*10+w2;
        }else{
          wiatr=(w1*10+w2)*0.514444;
        }
      }
      if(c>4){
        int temp = (int)czlon.charAt(0)-'0';
        
        switch(temp){
          case 0: int temp2=(int)czlon.charAt(1)-'0';
            if(temp2==0){
              int w1=(int)czlon.charAt(2)-'0';
              int w2=(int)czlon.charAt(3)-'0';
              int w3=(int)czlon.charAt(4)-'0';
              if(twiatr==0 || twiatr==1){
                wiatr=w1*100+w2*10+w3;
              }else{
                wiatr=(w1*100+w2*10+w3)*0.514444;
              }
            }
           break;
           case 1: 
            int t1=(int)czlon.charAt(1)-'0';
            int t2=(int)czlon.charAt(2)-'0';
            int t3=(int)czlon.charAt(3)-'0';
            int t4=(int)czlon.charAt(4)-'0';
            if(t1==0){
              temperatura = t2*10+t3+t4*0.1;
            }else{
              temperatura = (-1)*(t2*10+t3+t4*0.1);
            }
          break;
          case 2:
            int r1=(int)czlon.charAt(1)-'0';
            int r2=(int)czlon.charAt(2)-'0';
            int r3=(int)czlon.charAt(3)-'0';
            int r4=(int)czlon.charAt(4)-'0';
            if(r1==9){
              wilgotnosc=r2*100+r3*10+r4;
            }else if(r1==1){
              rosa=(-1)*(r2*10+r3+r4*0.1);
            }else{
              rosa=r2*10+r3+r4*0.1;
            }
          break;
          case 3:
            int p1=(int)czlon.charAt(1)-'0';
            int p2=(int)czlon.charAt(2)-'0';
            int p3=(int)czlon.charAt(3)-'0';
            int p4=(int)czlon.charAt(4)-'0';
            if(p1==9||p1==8){
              cisnienie=p1*100+p2*10+p3+p4*0.1;
            }else{
              cisnienie=1000+p1*100+p2*10+p3+p4*0.1;
            }
          break;
        }
        if(temp>3){
          koniec=true;
        }
        }
        if(c==czlony.length){
          koniec=true;
        }
        c++;
      }
      CDane dane = new CDane(data,godzina,nr_stacji,temperatura,cisnienie, wiatr,wilgotnosc,rosa);
      ldanych.add(dane);
      }
    wydruk(ldanych); 
    lista.clear();
  }
  return;
}
  
void wydruk(ArrayList<CDane> lista){    //funkcja drukująca gotowe dane do plików .csv
  //funkcja tworzenia cvs
  String []nazwa = new String[2];
  Table table = new Table();
  String temp1 = new String();
  String temp2 = new String();
  String nazwapliku;
  table.addColumn("l.p");
  table.addColumn("data");
  table.addColumn("temperatura");
  table.addColumn("ciśnienie");
  table.addColumn("prędkość wiatru");
  table.addColumn("wilgotność");
  table.addColumn("temperatura punktu rosy");
  temp1=Integer.toString(lista.get(0).nr_stacji);
  nazwa[0]=temp1;
  temp2=Integer.toString(lista.get(0).godzina);
  nazwa[1]=temp2;
  nazwapliku=join(nazwa,"_"); 
 
  for(int i=0;i<lista.size();i++)
  {
    TableRow newRow = table.addRow();
    newRow.setInt("l.p", table.getRowCount());
    newRow.setInt("data",lista.get(i).data);
    newRow.setFloat("temperatura",lista.get(i).temperatura);
    newRow.setFloat("ciśnienie",lista.get(i).cisnienie);
    newRow.setFloat("prędkość wiatru",lista.get(i).wiatr);
    newRow.setFloat("wilgotność",lista.get(i).wilgotnosc);
    newRow.setFloat("temperatura punktu rosy",lista.get(i).rosa);
  }
  
  saveTable(table,"dane/Plik"+nazwapliku+".csv");
  return;
}


void kasowanie(){      //kasowanie list 
    ladres.clear();
    ldepesz.clear();
    lsort.clear();
    return;
}
      
