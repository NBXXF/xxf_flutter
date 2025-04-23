import 'package:xxf_arch/src/hud/progress_hud.dart';
import 'package:xxf_arch/src/hud/progress_hud_impl.dart';

typedef HudHandler = ProgressHud Function();

HudHandler hudHandler = () {
  ///默认实现,业务可以复写
  return ProgressHudImpl();
};

extension HudFutureExtension<T> on Future<T> {
  ///自动处理加载,success,error等提示
  Future<T> bindProgressHud({
    String? loadingNotice,
    String? successNotice,
    String? errorNotice,
  }) {
    var progressHud = hudHandler();
    progressHud.showLoadingDialog(loadingNotice ?? "");
    return then((value) {
          progressHud.dismissLoadingDialogWithSuccess(successNotice ?? "");
          return Future.value(value);
        })
        .onError((error, stackTrace) {
          progressHud.dismissLoadingDialogWithFail(errorNotice ?? "$error");
          return Future.error(error ?? "", stackTrace);
        })
        .whenComplete(() {
          progressHud.dismissLoadingDialog();
        });
  }
}

extension HudStreamExtension<T> on Stream<T> {
  ///自动处理加载,success,error等提示
  Stream<T> bindProgressHud({
    String? loadingNotice,
    String? successNotice,
    String? errorNotice,
  }) {
    var progressHud = hudHandler();
    progressHud.showLoadingDialog(loadingNotice ?? "");
    return map((value) {
      progressHud.dismissLoadingDialogWithSuccess(successNotice ?? "");
      return value;
    }).handleError((error, stackTrace) {
      progressHud.dismissLoadingDialogWithFail(errorNotice ?? "$error");
      return Stream.error(error, stackTrace);
    });
  }
}
