# Hello Python Logging Image
Python の logging モジュールを利用して、ファイルにログを吐き続けるイメージです。
fluentd 等と併用して、ログストーリムのテストに使用することを想定しています。
[hello-python-loggin](https://github.com/shidokamo/hello-python-logging)のコードを再利用し改善を行なっています。

* ログを標準出力とファイルの両方に吐きます。それぞれに違う敷居値を設定しています。
* ファイルへのログは、20秒ごとにローテートされます。

## ローカルでのデバック方法
```
pipenv install
make log
```

## イメージのビルドとテスト

