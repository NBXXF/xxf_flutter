import 'package:xxf_arch/src/hud/progress_hud.dart';
import 'package:xxf_arch/src/hud/progress_hud_impl.dart';
import 'package:xxf_flow/xxf_flow.dart';

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
    return doOnData((value) {
          progressHud.dismissLoadingDialogWithSuccess(successNotice ?? "");
        })
        .doOnError((error, stackTrace) {
          progressHud.dismissLoadingDialogWithFail(errorNotice ?? "$error");
        })
        .doOnDone(() {
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
    return doOnData((value) {
          progressHud.dismissLoadingDialogWithSuccess(successNotice ?? "");
        })
        .doOnError((error, stackTrace) {
          progressHud.dismissLoadingDialogWithFail(errorNotice ?? "$error");
        })
        .doOnDone(() {
          progressHud.dismissLoadingDialog();
        });
  }
}
