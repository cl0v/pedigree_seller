abstract class IAuthentication {
  Future login(String email, String senha);
  Future logout();
  Future register(String email, String senha);
}
