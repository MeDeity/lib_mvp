
///
/// 生命周期
///
abstract class ILifeCycle{
  void initState();

  void didChangeDependencies();

  void didUpdateWidgets<W>(W oldWidget);

  void deactivate();

  void dispose();
}