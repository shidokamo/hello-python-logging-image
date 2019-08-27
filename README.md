# Hello Python Logging Image
Python の logging モジュールを利用して、ファイルにログを吐き続けるイメージです。
fluentd 等と併用して、ログストーリムのテストに使用することを想定しています。
[hello-python-loggin](https://github.com/shidokamo/hello-python-logging)のコードを再利用し改善を行なっています。

* ログを標準出力とファイルの両方に吐きます。それぞれに違う敷居値を設定しています。
* ファイルへのログは、5秒ごとにローテートされます。

## ローカルでのプログラムのデバック方法
```bash
pipenv install
make log
```
ログローテートにより、ローカルにファイルがバックアップが保存されていくのを確認してください。

## ローカルでプログラムを fluentd とテストする方法
```bash
gem install fluentd
gem install fluent-plugin-insert-id
fluentd -c ./fluent.conf

# Open another terminal
make log LOG_INTERVAL=0.5   # Slow rate log injection
make log                    # Max rate log injection
```
* fluentd がログローテートを検出できることを確認してください。
* fluentd がログを構造化することを確認してください。

## イメージのビルドとローカルテスト
```bash
make build
make run    # バックグラウンドでイメージが実行されます。
make login  # コンテナにログインします。ログが書き込まれローテートされていることを確認できます。
make kill   # コンテナを削除します。
```

