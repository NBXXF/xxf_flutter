
abstract class ProgressHud {
  /// 展示加载对话框
  ///
  /// @param notice
  void showLoadingDialog(String notice);

  /// 结束展示对话框
  void dismissLoadingDialog();

  /// 加载成功的提示
  ///
  /// @param notice
  /// @param delayTime 延迟时间 毫秒
  void dismissLoadingDialogWithSuccess(String notice);

  /// 加载失败的提示
  ///
  /// @param notice
  /// @param delayTime 延迟时间 毫秒
  void dismissLoadingDialogWithFail(String notice);

  /// 更新提示文案
  ///
  /// @param notice
  void updateStateText(String notice);
}
