import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'dersHarfDegerleri.dart';
import 'dersKrediItemsListe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.purple.shade300,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dersAdi;
  int dersKredi = 1;
  double dersHarfDegeri = 4;
  List<Ders> tumDersler;
  var formKey = GlobalKey<FormState>();
  double ortalama = 0;
  static int sayac = 0;

  @override
  void initState() {
    // TODO: implement initState
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Ortalama Hesapla"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
        child: Icon(Icons.add),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return UygulamaGovdesi();
        } else
          return UygulamaGovdesiLandscape();
      }),
    );
  }

  Widget UygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //STATİK FORM TUTAN CONTAINER
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            //color: Colors.pink.shade200,
            child: Form(
              key: formKey,
              //gerekli form elamanına ulaşmak için yukarda degisken olarak tanımladıgımız global keyi Containeriminiz içine key=formKey olarak atadık..
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Ders Adı",
                      hintText: "Ders Adını giriniz",
                      hintStyle: TextStyle(fontSize: 18),
                      labelStyle: TextStyle(fontSize: 22),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.purple, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.purple, width: 2)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(color: Colors.purple, width: 2),
                      ),
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger.length > 0) {
                        return null;
                      } else {
                        return "Ders adı boş girilemez";
                      }
                    },
                    onSaved: (kaydedilecekDeger) {
                      //girilen degerleri tumdersle litemize adi harfdegeri ve kredisiini setstate içnide kaydediyoruz.
                      dersAdi = kaydedilecekDeger;
                      setState(() {
                        tumDersler
                            .add(Ders(dersAdi, dersHarfDegeri, dersKredi,rastgeleRenkOlustur()));
                        ortalama = 0;
                        ortalamaHesapla();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            items: dersKrediItems(),
                            value: dersKredi,
                            onChanged: (secilenKredi) {
                              setState(() {
                                dersKredi = secilenKredi;
                              });
                            },
                          ),
                        ),
                        padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<double>(
                            items: dersHarfDegerleriItems(),
                            value: dersHarfDegeri,
                            onChanged: (secilenHarf) {
                              setState(() {
                                dersHarfDegeri = secilenHarf;
                              });
                            },
                          ),
                        ),
                        padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 70,
            decoration: BoxDecoration(
                color: Colors.blue,
                border: BorderDirectional(
                  top: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  bottom: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                )),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: tumDersler.length == 0
                          ? " Lütfen Ders Ekleyin"
                          : "Ortalama: ",
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                  TextSpan(
                      text: tumDersler.length == 0
                          ? ""
                          : "${ortalama.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
          ),
          //DİNAMİK LİSTE TUTAN CONTAINER
          Expanded(
              child: Container(
                child: ListView.builder(
                  itemBuilder: _listeElamanlariniOlustur,
                  itemCount: tumDersler.length,
                ),
              )),
        ],
      ),
    );
  }

  Widget UygulamaGovdesiLandscape() {
    return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      //color: Colors.pink.shade200,
                      child: Form(
                        key: formKey,
                        //gerekli form elamanına ulaşmak için yukarda degisken olarak tanımladıgımız global keyi Containeriminiz içine key=formKey olarak atadık..
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Ders Adı",
                                hintText: "Ders Adını giriniz",
                                hintStyle: TextStyle(fontSize: 18),
                                labelStyle: TextStyle(fontSize: 22),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.purple, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.purple, width: 2)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide:
                                  BorderSide(color: Colors.purple, width: 2),
                                ),
                              ),
                              validator: (girilenDeger) {
                                if (girilenDeger.length > 0) {
                                  return null;
                                } else {
                                  return "Ders adı boş girilemez";
                                }
                              },
                              onSaved: (kaydedilecekDeger) {
                                //girilen degerleri tumdersle litemize adi harfdegeri ve kredisiini setstate içnide kaydediyoruz.
                                dersAdi = kaydedilecekDeger;
                                setState(() {
                                  tumDersler.add(
                                      Ders(dersAdi, dersHarfDegeri, dersKredi,rastgeleRenkOlustur()));
                                  ortalama = 0;
                                  ortalamaHesapla();
                                });
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<int>(
                                      items: dersKrediItems(),
                                      value: dersKredi,
                                      onChanged: (secilenKredi) {
                                        setState(() {
                                          dersKredi = secilenKredi;
                                        });
                                      },
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 4),
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    border:
                                    Border.all(color: Colors.purple, width: 2),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                Container(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<double>(
                                      items: dersHarfDegerleriItems(),
                                      value: dersHarfDegeri,
                                      onChanged: (secilenHarf) {
                                        setState(() {
                                          dersHarfDegeri = secilenHarf;
                                        });
                                      },
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 4),
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    border:
                                    Border.all(color: Colors.purple, width: 2),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                            border: BorderDirectional(
                              top: BorderSide(
                                color: Colors.blue,
                                width: 2,
                              ),
                              bottom: BorderSide(
                                color: Colors.blue,
                                width: 2,
                              ),
                            )),
                        child: Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: tumDersler.length == 0
                                      ? " Lütfen Ders Ekleyin"
                                      : "Ortalama: ",
                                  style:
                                  TextStyle(fontSize: 30, color: Colors.white)),
                              TextSpan(
                                  text: tumDersler.length == 0
                                      ? ""
                                      : "${ortalama.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold)),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                flex: 1),
            Expanded(
                child: Container(
                  child: ListView.builder(
                    itemBuilder: _listeElamanlariniOlustur,
                    itemCount: tumDersler.length,
                  ),
                )),
          ],
        ));
  }

//kayıdedilen onSaved in içindeki dersleri Card widgetinin içine leading ve subtitlein içine isteiğimize göre ekleyip textin içinde yazdırıyoruz.
  Widget _listeElamanlariniOlustur(BuildContext context, int index) {
    sayac++;
    debugPrint(sayac.toString());
    return Dismissible(
      key: Key(sayac.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          tumDersler.removeAt(index);
          ortalamaHesapla();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color:tumDersler[index].renk,width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(5),
        child: ListTile(
          leading: Icon(Icons.done, size: 36, color: tumDersler[index].renk),
          title: Text(tumDersler[index].ad),
          trailing: Icon(Icons.keyboard_arrow_right,color:tumDersler[index].renk),
          subtitle: Text(tumDersler[index].kredi.toString() +
              " kredi Ders Not Değeri: " +
              tumDersler[index].harfDegeri.toString()),
        ),
      ),
    );
  }

  void ortalamaHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;
    for (var oAnkiDers in tumDersler) {
      var kredivar = oAnkiDers.kredi;
      var harfDegerivar = oAnkiDers.harfDegeri;
      toplamNot += (harfDegerivar * kredivar);
      toplamKredi += kredivar;
    }
    ortalama = toplamNot / toplamKredi;
  }

  Color rastgeleRenkOlustur() {
    return Color.fromARGB(
        150+Random().nextInt(105), Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255));
  }
}

class Ders {
  String ad;
  double harfDegeri;
  int kredi;
  Color renk;

  Ders(this.ad, this.harfDegeri, this.kredi,this.renk);
}
