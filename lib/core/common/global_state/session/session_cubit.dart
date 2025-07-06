import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> with ChangeNotifier {
  late final StreamSubscription _sessionSubscription;

  SessionCubit() : super(SessionState.unknown()) {
    _sessionSubscription = Supabase.instance.client.auth.onAuthStateChange
        .listen((data) {
          final session = data.session;
          if (session != null) {
            emit(SessionState.authenticated());
          } else {
            emit(SessionState.unauthenticated());
          }
          notifyListeners();
        });
  }

  @override
  Future<void> close() {
    _sessionSubscription.cancel();
    return super.close();
  }
}
