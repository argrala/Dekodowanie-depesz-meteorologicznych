//klasa odpowiedzialna za przechowywanie gotowych danych synoptycznych

class CDane{
  public int data;
  public int godzina;
  public int nr_stacji;
  public float temperatura;
  public float cisnienie;
  public float wiatr;
  public float wilgotnosc;
  public float rosa;
  
  CDane(){
  }
  CDane(int data,int godzina, int nr_stacji,float temperatura,float cisnienie, float wiatr, float wilgotnosc, float rosa){
    this.data=data;
    this.godzina=godzina;
    this.nr_stacji = nr_stacji;
    this.temperatura = temperatura;
    this.cisnienie = cisnienie;
    this.wiatr = wiatr;
    this.wilgotnosc = wilgotnosc;
    this.rosa = rosa;
  }
}
