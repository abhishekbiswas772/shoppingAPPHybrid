import 'package:username_generator/username_generator.dart';

class UserNameService {
  static var generator = UsernameGenerator();
  static String getGeneratedUserNameUsingEmailID(emailId) {
    return generator.generate(emailId.toString());
  }
}
