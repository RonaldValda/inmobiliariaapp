import 'package:inmobiliariaapp/domain/entities/property.dart';

import '../../../data/repositories/property/inmueble_note_repository.dart';

class UseCasePropertyNote{
  PropertyNoteRepository propertyNoteRepository=PropertyNoteRepository();
  Future<Map<String,dynamic>> searchPropertyNote(String propertyId,String userId){
    return propertyNoteRepository.searchPropertyNote(propertyId,userId);
  }
  Future<Map<String,dynamic>> savePropertyNote(String propertyId,String userId,PropertyClientNote propertyClientNote){
    return propertyNoteRepository.savePropertyNote(propertyId,userId,propertyClientNote);
  }
}