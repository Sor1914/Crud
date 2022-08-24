import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Employee');

class FirebaseCrud {
  //agregar empleado
  static Future<Response> addEmployee({
    required String name,
    required String position,
    required String contactno,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "employee_name": name,
      "position": position,
      "contact_no": contactno
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Succesfully added to database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }

  //leer empleado
  static Stream<QuerySnapshot> readEmployee() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }

  //Actualizar Empleado
  static Future<Response> updateEmployee({
    required String name,
    required String position,
    required String contactno,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "employee_name": name,
      "position": position,
      "contact_no": contactno
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Se actualizó correctamente";
    }).catchError((e) {
      response.code = 500;
      response.code = e;
    });

    return response;
  }

  //Eliminar registro
  static Future<Response> deleteEmployee({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Se eliminó correctamente";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
