# 概要
くろーんしてぽちーでかいはつかんきょうあげたい
## 前提
VitualboxとVagrantがインストールされていること

- [virtualbox](https://www.virtualbox.org/)
- [vagrant](https://www.vagrantup.com/downloads.html)

## WindowsとOSXで同等の環境を提供するためにVagrantのプラグインを導入する必要あり

コマンドプロンプト(Windows) or ターミナル(OSX)で実行
```
// GuestAdditionを自動で入れるプラグイン.
vagrant plugin install vagrant-vbguest
```

## Vagrantを使用してローカル開発環境用VMを構築する
```
# このファイルが存在するディレクトリまでcdした後で実施すること
# Windowsはコマンドプロンプト(管理者権限はNG)で実施です。
vagrant up
```

## Vagrantで上げたVMにアクセスするには
```
# windowsはsshクライアントをコマンドプロンプトに追加していない場合は接続情報が表示されるのでsshクライアントでアクセスしてください
vagrant ssh

# VMに入れてrootユーザになりたい場合(vagrantユーザにはsudo no passwordついてます)
sudo su -
```

# ALLOWED_HOSTS設定とdb 設定を書き換える
```python:core/core/settings.py
ALLOWED_HOSTS = ['vm.django']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'postgres',
        'USER': 'postgres',
        'HOST': 'postgres',
        'PORT': 5432,
    }
}
```

# ブラウザからアクセス出来るようにWindows・OSXのhostsに設定を追加する
```
# djangoローカル開発環境
192.168.254.10 vm.django
```

