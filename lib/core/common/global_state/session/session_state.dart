part of 'session_cubit.dart';

enum SessionStatus { unknown, authenticated, unauthenticated }

class SessionState {
  final SessionStatus status;

  const SessionState({required this.status});

  factory SessionState.unknown() =>
      const SessionState(status: SessionStatus.unknown);
  factory SessionState.authenticated() =>
      SessionState(status: SessionStatus.authenticated);
  factory SessionState.unauthenticated() =>
      SessionState(status: SessionStatus.unauthenticated);
}
