import '../../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(context)
{
  CacheHelper.remove(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context: context, widget: LoginScreen());
    }
  });

}

 String? token ;
 String? uId;