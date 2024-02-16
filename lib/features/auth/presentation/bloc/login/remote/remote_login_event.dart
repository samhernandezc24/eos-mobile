abstract class RemoteLoginEvent {
  const RemoteLoginEvent();
}

class LoginStarted extends RemoteLoginEvent {
  const LoginStarted(this.email, this.password);

  final String email;
  final String password;
}
