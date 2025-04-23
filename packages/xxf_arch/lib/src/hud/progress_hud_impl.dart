import 'package:xxf_arch/src/hud/progress_hud.dart';
import '../toast/toast_utils.dart';

class ProgressHudImpl implements ProgressHud {
  CancelFunction? cancelFunction;

  @override
  void dismissLoadingDialog() {
    cancelFunction?.call();
  }

  @override
  void dismissLoadingDialogWithFail(String notice) {
    cancelFunction?.call();
  }

  @override
  void dismissLoadingDialogWithSuccess(String notice) {
    cancelFunction?.call();
  }

  @override
  void showLoadingDialog(String notice) {
    cancelFunction = ToastUtils.showLoading();
  }

  @override
  void updateStateText(String notice) {
    // TODO: implement updateStateText
  }
}
