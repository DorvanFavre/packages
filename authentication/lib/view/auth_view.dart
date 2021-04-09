part of '../authentication.dart';

class AuthView extends StatefulWidget {
  final AuthViewModel viewModel;

  AuthView({@required this.viewModel});

  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  DisplyedScreen displayedScreen = DisplyedScreen.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          displayedScreen == DisplyedScreen.login
              ? _LoginScreen(
                  viewModel: widget.viewModel,
                )
              : _RegisterScreen(authViewModel: widget.viewModel),
          // witch screen button
          Align(
            alignment: Alignment(0, 0.9),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: ShapeDecoration(
                  color: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(displayedScreen == DisplyedScreen.login
                      ? "Je n'ai pas de compte   "
                      : "J'ai déja un compte   "),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          displayedScreen == DisplyedScreen.login
                              ? displayedScreen = DisplyedScreen.register
                              : displayedScreen = DisplyedScreen.login;
                        });
                      },
                      child: Text(
                        displayedScreen == DisplyedScreen.login
                            ? "s'enregistrer"
                            : "se connecter",
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum DisplyedScreen { login, register }

// Login Screen
class _LoginScreen extends StatelessWidget {
  final AuthViewModel viewModel;
  final formKey = GlobalKey<FormState>();

  _LoginScreen({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Inputs
        Padding(
          padding: EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // Title
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Se connecter',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                SizedBox(height: 30),

                // Address email
                inputText(
                  context: context,
                  hintText: 'Email',
                  controller: viewModel.emailLoginController,
                  icon: Icons.email,
                  validator: (String str) {
                    return str.contains('@')
                        ? null
                        : 'Entrez une adresse email valide';
                  },
                ),
                // Password
                inputText(
                  context: context,
                  hintText: 'Mot de passe',
                  obscure: true,
                  controller: viewModel.passwordLoginController,
                  icon: Icons.lock_outline_rounded,
                  validator: (String str) {
                    return str.length > 0 ? null : 'Entrez un mot de passe';
                  },
                ),
              ],
            ),
          ),
        ),

        Align(
          alignment: Alignment(0, 0.6),
          child: TextButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  viewModel.login().then((result) {
                    if (result is Success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login succeed !')));
                    } else if (result is Failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result.message)));
                    }
                  });
                }
              },
              child: Text(
                'Login',
              )),
        ),
      ],
    );
  }
}

// Register Screen
class _RegisterScreen extends StatelessWidget {
  final AuthViewModel authViewModel;
  final formKey = GlobalKey<FormState>();

  _RegisterScreen({@required this.authViewModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Inputs
        Padding(
          padding: EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                //Title
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "S'enregistrer",
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                SizedBox(height: 30),
                // Address email
                inputText(
                  context: context,
                  hintText: 'Email',
                  controller: authViewModel.emailRegisterController,
                  icon: Icons.email,
                  validator: (String str) {
                    return str.contains('@')
                        ? null
                        : 'Entrez une adresse email valide';
                  },
                ),

                // Password
                inputText(
                  context: context,
                  hintText: 'Mot de passe',
                  obscure: true,
                  controller: authViewModel.passwordRegisterController,
                  icon: Icons.lock_outline_rounded,
                  validator: (String str) {
                    return str.length > 0 ? null : 'Entrez un mot de passe';
                  },
                ),
                // Password
                inputText(
                  context: context,
                  hintText: 'Répétez le mot de passe',
                  obscure: true,
                  controller: authViewModel.repeatePasswordRegisterController,
                  icon: Icons.lock_outline_rounded,
                  validator: (String str) {
                    return str ==
                            authViewModel.repeatePasswordRegisterController.text
                        ? null
                        : 'Les mots de passes de correspondent pas';
                  },
                ),
              ],
            ),
          ),
        ),

        Align(
          alignment: Alignment(0, 0.6),
          child: OutlinedButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  authViewModel.register().then((result) {
                    if (result is Success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login succeed !')));
                    } else if (result is Failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result.message)));
                    }
                  });
                }
              },
              child: Text(
                'Register',
              )),
        )
      ],
    );
  }
}

Widget inputText({
  bool obscure = false,
  @required TextEditingController controller,
  @required String hintText,
  @required IconData icon,
  @required Function(String) validator,
  @required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            fillColor: Theme.of(context).cardColor,
            filled: true,
            hintText: hintText,
            /*prefixIcon: Icon(
              icon,
              color: kTextColor,
            ),*/
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none)),
        validator: validator),
  );
}
