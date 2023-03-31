//klasa odpowiedzialna za tworzenie ścieżek dostępowych do plików synoptycznych

import java.io.File;

class CDostep{
 public File adres;
 public File [] lzawartosc;
 public int numer;
 
  CDostep(){
  }
    
  void pliki(File ad,int nr){
     if(ad.isDirectory()){
       lzawartosc = listFiles(ad);
       adres=ad;
       numer=nr;
   }   
  }
}
