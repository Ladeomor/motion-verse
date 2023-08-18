import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:montion_verse/models/dictionary_model.dart';
import 'package:montion_verse/models/dictionary_provider.dart';

class SignLanguageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SignLanguageModel _signLanguageModel;

  SignLanguageService(this._signLanguageModel);

  Future<void> getSignLanguages() async {
    List<SignLanguage> signLanguages = [];

    try {
      QuerySnapshot querySnapshot = await _firestore.collection('SignLanguages').get();

      for (var document in querySnapshot.docs) {
        SignLanguage signLanguage = SignLanguage(
          signLanguage: document['alphabet'],
          signLanguageImage: document['imageUrl'],
          signLanguageTranslation: document['details'],
        );
        signLanguages.add(signLanguage);
      }
      signLanguages.sort((a, b) => a.signLanguage.compareTo(b.signLanguage)); // Add this line to sort

      _signLanguageModel.setSignLanguages(signLanguages);
    } catch (e) {
      print('Error fetching sign language data: $e');
    }
  }
}