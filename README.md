# lib_mvp

an achieve of mvp framework,


##thanks
Thanks to the [simplezhli -> flutter deer](https://github.com/simplezhli/flutter_deer) project,
this library is an MVP implementation separated from this project.

This is a strongly coupled tool library with the following open source libraries built in:
[dio](https://github.com/flutterchina/dio): ^2.1.13
[sprintf](https://github.com/Naddiseo/dart-sprintf): ^4.0.0
[rxdart](https://github.com/ReactiveX/rxdart): ^0.21.0
[oktoast](https://github.com/OpenFlutter/flutter_oktoast): ^2.1.8

## Getting Started

#### 一、 init OKToast:
```
  @override
  Widget build(BuildContext context) {
    return OKToast(//init OKToast
      child: MaterialApp(
        title: 'MVP Framework Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: IndexPage(),
      ),
    );
  }
```
#### 二、xxxPageState extends BasePageState ,Take IndexPage as an example
```
class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IndexPageState();
  }
}

class IndexPageState extends BasePageState<IndexPage, IndexPagePresenter> {

  @override
  IndexPagePresenter createPresenter() {
    return IndexPagePresenter();
  }

}

```

#### 三、Create xxxPagePresenter,Take IndexPagePresenter as an example
```
class IndexPagePresenter extends BasePagePresenter<IndexPageState>{

  void requestUserInfo(){
    requestNetwork(Method.get,
      url: Api.users,
      baseUrl: Api.baseUrl,
      onSuccess: (response){
        Map<String,dynamic> _map = json.decode(response?.data.toString());
        String result = json.encode(_map);
        ResponseUserInfoEntity entity = EntityFactory.generateOBJ(_map["data"]);
        view.updateResponseView(entity);
      },
    );
  }
}
```
Hope you enjoy it!!!!

Here is a [sample demo](https://github.com/MeDeity/flutter_mvp) show how to use this mvp framework,scan this qrcode to download android demo.
![android demo apk](https://fir.im/9ct2),Or It is especially recommended that you check out this open source project =>[simplezhli -> flutter deer](https://github.com/simplezhli/flutter_deer)

