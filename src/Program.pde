import java.util.Scanner;
import java.io.File;
import java.util.ArrayList;
//import java.lang.Object;
import java.io.*;

String sciezka;
boolean wsad=false;
ArrayList<CDostep> ladres = new ArrayList<CDostep>(); // Lista adresów plików synoptycznych
ArrayList<CDepesza> ldepesz = new ArrayList<CDepesza>(); //Lista z danymi depesz
ArrayList <ArrayList> lsort = new ArrayList<ArrayList>();   //Listy posortowane

//Dane startowe
int start_data = 20111203;       //20111203
int koniec_data = 20120220;      //20140219
int[] nrstacji={12375,12566,12424};


void setup(){
  size(50,50);
  background(0);
  noStroke();
  fill(102);

  // Podanie ścieżki z katalogami SYNOP
  println("PROGRAM DO DEKODOWANIA PLIKÓW SYNOP");
  println("\nWybierz folder z danymi\n");

  selectFolder("Wybierz folder z danymi:", "folderSelected");
}
  void folderSelected(File selection) {
    if (selection == null) {
      println("Okno zostało zamknięte.");
      wsad=false;
    } else {
      println("Wybrany folder " + selection.getAbsolutePath());
      sciezka = selection.getAbsolutePath();
      wsad=true;
    }
  
  //Sprawdzenie, czy załadowano dane. Gdy brak ścieżki to koniec programu
  if(wsad==false){
    println("Brak załadowanych danych\nNastąpi zamknięcie programu\nKONIEC\n");
    exit();
  }
  //Lista wykonywanych instrukcji//
  println("Załadowano dane");
  listaplikow(sciezka);
  println("Załadowano listę plików do analizy"); 
  przeszukiwanie(ladres,start_data,koniec_data,nrstacji);
  println("Znaleziono poszukiwane stacje synoptyczne");
  //test(ldepesz);
  sortowanie(ldepesz,nrstacji);
  println("Posortowano dane");
  analiza(lsort);
  println("Zaanalizowano dane\nWydrukowano dane");
  kasowanie();
  println("\nZAKOŃCZONO ANALIZĘ DANYCH SYNOPTYCZNYCH\nKONIEC\nWarszawa 2018");
  }

     
   


    
    
    
    
    
    
    
