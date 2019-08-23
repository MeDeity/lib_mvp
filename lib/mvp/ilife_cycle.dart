
///
/// 生命周期
/// create by fengwenhua at 2019-7-24 15:08:42
///
abstract class ILifeCycle{
  void initState();

  void didChangeDependencies();

  void didUpdateWidgets<W>(W oldWidget);

  void deactivate();

  void dispose();
}