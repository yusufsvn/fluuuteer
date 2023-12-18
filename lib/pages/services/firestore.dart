
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  final CollectionReference kitaplar = FirebaseFirestore.instance.collection('kitaplar');

  //create
  Future<void> addkitap(String kitap,String yazar,String kategori,String yayinevi,int sayfaSayisi,int basimYili,bool check){
    return kitaplar.add({
      'kitap_adi':kitap,
      'yazarAdi':yazar,
      'kategori':kategori,
      'yayinEvi':yayinevi,
      'sayfaSayisi':sayfaSayisi,
      'basimYili':basimYili,
      'check': check
    });

  }
  //read
  
  Stream<QuerySnapshot> getKitapStream(){
    final kitapStream = kitaplar.orderBy('kitap_adi',descending: true).snapshots();
    
    return kitapStream;
  }
  //uptade
   Future<void> kitapGuncelle(String dosID,String? kitapAdi, String? yazar, String? yayinevi,String? kategori,int? basimYili,int? sayfaSayisi,bool? check){
    
    return kitaplar.doc(dosID).update({
      'kitap_adi':kitapAdi,
      'yazarAdi':yazar,
      'yayinEvi':yayinevi,
      'kategori':kategori,
      'sayfaSayisi':sayfaSayisi,
      'basimYili':basimYili,
      'check':check

    });
    
    
    
  }

  //delete
  Future<void> deleteKitap(String dosID){
    return kitaplar.doc(dosID).delete();
  }

}