void main() {
  AuthenticateDialog dialog = AuthenticateDialog();
  dialog.loginOrRegisterCheckBox!.onCheck();
}

abstract class Mediator {
  notify(Component sender, String event);
}

class AuthenticateDialog implements Mediator {
  String? title;
  CheckBox? loginOrRegisterCheckBox;
  TextBox? usernameTextBox,
      loginUserName,
      loginPassword,
      registrationUserName,
      registrationPassword,
      registrationConfirmPassword;
  Button? okButton, cancelButton;

  AuthenticateDialog() {
    title = "Login";
    loginOrRegisterCheckBox = CheckBox(this);
    usernameTextBox = TextBox(this);
    loginUserName = TextBox(this);
    loginPassword = TextBox(this);
    registrationUserName = TextBox(this);
    registrationPassword = TextBox(this);
    registrationConfirmPassword = TextBox(this);
    okButton = Button(this);
    cancelButton = Button(this);
  }

  @override
  notify(Component sender, String event) {
    if (sender == loginOrRegisterCheckBox && event == 'check') {
      if (loginOrRegisterCheckBox!.isChecked) {
        title = 'Login';
        print('Log in');
      } else {
        title = 'Register';
        print('Register');
      }
    }
    if (sender == okButton && event == 'click') {
      if (loginOrRegisterCheckBox!.isChecked) {
        title = 'found';
        print('Found');
      } else {
        title = 'not found';
        print('Not found');
      }
    }
  }
}

abstract class Component {
  Component(this.dialog);
  Mediator dialog;
}

class Button extends Component {
  Button(Mediator dialog) : super(dialog);
  onPress() => dialog.notify(this, 'buttonPress');
}

class TextBox extends Component {
  TextBox(Mediator dialog) : super(dialog);
  onEdit() => dialog.notify(this, 'text');
}

class CheckBox extends Component {
  CheckBox(Mediator dialog) : super(dialog);
  bool isChecked = true;
  onCheck() => dialog.notify(this, 'check');
}
