import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluuuteer/pages/services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //firestore
  final FirestoreService firestoreService = FirestoreService();
  //text controller
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yusuf Sevinç kütüphane sistemi"),
        actions: const <Widget>[
          Icon(Icons.menu),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getKitapStream(),
        builder: (context, snapshot) {
          //eğer data varsa hepsini dosyadan çek
          if (snapshot.hasData) {
            List kitapList = snapshot.data!.docs;

            //ekranda bir liste
            return ListView.builder(
                itemCount: kitapList.length,
                itemBuilder: (context, index) {
                  // dosyadaki her bir elemanı getir
                  DocumentSnapshot dosya = kitapList[index];
                  String? dosID = dosya.id;

                  //dosyadan her bir kitabı getir
                  Map<String, dynamic> data =
                      dosya.data() as Map<String, dynamic>;
                  //ekrana kitabın hangi bilgilerini yazacaksın

                  String authorName = data['yazarAdi'];
                  String pageNumber = data['sayfaSayisi'].toString();
                  bool? checktask = data['check'];

                  if (checktask == true) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(70, 33, 149, 243),
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        //ana başlık
                        title: Text(
                          data['kitap_adi'],
                        ),
                        //altyazi kısmı
                        subtitle:
                            Text("yazar:$authorName, sayfa sayisi:$pageNumber"),

                        //sağdaki butonlar
                        trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text(
                                              "silmek istediğine emin misin"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  firestoreService
                                                      .deleteKitap(dosID);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("sil"))
                                          ],
                                        )),
                                icon: const Icon(Icons.delete),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EkleSayfasi(dosID: dosID)),
                                    );
                                  },
                                  icon: const Icon(Icons.edit))
                            ]),
                      ),
                    );
                  }
                  return null;
                });
          }

          // eğer return edecek data yoksa
          else {
            return const Text("Kitap yok");
          }
        },
      ),
//
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'kitaplar'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket_rounded), label: "satın al"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings')
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EkleSayfasi()),
          );
        },
      ),
    );
  }
}

class EkleSayfasi extends StatefulWidget {
  String? dosID;
  EkleSayfasi({super.key, this.dosID});

  @override
  State<EkleSayfasi> createState() => _EkleSayfasiState();
}

class _EkleSayfasiState extends State<EkleSayfasi> {
  bool isChecked = false;
  //firestore
  final FirestoreService firestoreService = FirestoreService();
  //text controller
  final TextEditingController textController = TextEditingController();
  String? textcontrol1;
  String? textcontrol2;
  String? textcontrol3;
  String? textcontrol4;
  int? textcontrol5;
  int? textcontrol6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('kitap ekle'),
          backgroundColor: Colors.red,
        ),
        body: Column(
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(50, 20, 0, 0)),

            //Kitap adı
            TextFormField(
              onChanged: (String value) {
                setState(() {
                  textcontrol1 = value;
                });
              },
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Kitap adı',
              ),
            ),
            //Yayınevi
            TextField(
              onChanged: (String value) {
                setState(() {
                  textcontrol2 = value;
                });
              },
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Yayınevi',
              ),
            ),
            TextField(
              onChanged: (String value) {
                setState(() {
                  textcontrol3 = value;
                });
              },
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Yazarlar',
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: DropdownButton(
                hint: const Text("Kategori"),
                items: ['Edebiyat', 'Roman', 'Şiir', 'Tarih', 'Ansiklopedi']
                    .map((String value1) {
                  return DropdownMenuItem(
                    value: value1,
                    child: Text(value1),
                  );
                }).toList(),
                onChanged: (String? value0) {
                  setState(() {
                    textcontrol4 = value0!;
                  });
                },
              ),
            ),

            // sayfa sayisi
            TextField(
              onChanged: (String value) {
                setState(() {
                  int X = int.parse(value);
                  textcontrol5 = X;
                });
              },
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Sayfa Sayısı',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            //Basım yılı
            TextField(
              onChanged: (String value) {
                setState(() {
                  int X = int.parse(value);
                  textcontrol6 = X;
                });
              },
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Basım yılı',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),

            //
            CheckboxListTile(
              title: const Text("Listede yayınlanacak mı?"),
              value: isChecked,
              activeColor: Colors.blue,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            Container(
                padding: const EdgeInsets.only(left: 12.1),
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                    onPressed: () {
                      if (textcontrol1 == null ||
                          textcontrol3 == null ||
                          textcontrol2 == null ||
                          textcontrol4 == null ||
                          textcontrol5 == null ||
                          textcontrol6 == null) {
                        showAlertDialog(context);
                      } else {
                        if (widget.dosID == null) {
                          firestoreService.addkitap(
                              textcontrol1!,
                              textcontrol3!,
                              textcontrol2!,
                              textcontrol4!,
                              textcontrol5!,
                              textcontrol6!,
                              isChecked);
                        } else {
                          firestoreService.kitapGuncelle(
                              widget.dosID!,
                              textcontrol1,
                              textcontrol3,
                              textcontrol2,
                              textcontrol4,
                              textcontrol5,
                              textcontrol6,
                              isChecked);
                        }
                      }
                    },
                    child: const Text("kaydet")))
          ],
        ));
  }

  showAlertDialog(BuildContext context) {
    Widget onayButon = ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("tamam"));
    AlertDialog alert = AlertDialog(
      title: const Text("Lütfen tüm seçenkleri eksiksiz doldurunuz."),
      actions: [onayButon],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
