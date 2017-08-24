# Dockerの稼働環境構築に必要なコマンド
# コンテナへのリンク、など
$setup = <<SCRIPT
# 必要なパッケージの導入
yum -y groupinstall "Development Tools"
# epel導入 
yum install -y epel-release
yum clean metadata && yum upgrade ca-certificates --disablerepo=epel
yum install -y ansible sshpass
SCRIPT

# VM再起動時に実施されるコマンド
$start = <<SCRIPT
# 遅いPCでやった際にIPが付かない問題が発生する。その場合のための対応
nmcli connection reload
systemctl restart network.service

# ansibleプレイブックの実行
ansible-playbook -i localhost, -c local /app/ansible/playbook/common.yml

cd /app/docker/
/usr/local/bin/docker-compose down
/usr/local/bin/docker-compose build
/usr/local/bin/docker-compose up -d --remove-orphans
SCRIPT
# Windows Mac判定用
$is_windows = RbConfig::CONFIG['host_os'] =~ /mswin|msys|mingw|cygwin|bccwin/i
$is_osx = RbConfig::CONFIG['host_os'] =~ /darwin/i

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure("2") do |config|
  # cent os 7
  config.vm.box = "centos/7"
  # 共有フォルダの設定 /vagrantは入れておかないとWindowsでエラー
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  config.vm.synced_folder ".", "/app", type: "virtualbox"

  config.ssh.guest_port = 22
  # 構築に必要なリソース
  # VirtualboxのGUI上で見える名前など設定
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
    v.name = "django"
  end

  # プライベートネットワークを設定
  config.vm.network "private_network", ip: "192.168.254.10"

  # VM初回作成時に実施するコマンド
  config.vm.provision "shell", inline: $setup

  # WindowsとMacで違う処理をしたい時
  if $is_windows
    config.vm.provision "shell", inline: <<-SHELL
    SHELL
  else
    config.vm.provision "shell", inline: <<-SHELL
    SHELL
  end

  # VM起動時に常に実行したいコマンド
  config.vm.provision "shell", run: "always", inline: $start

  # djangoのプロジェクトをstartする。既にファイルがあるとエラーとなるのでVagrant側で判定する
  if !File.exist?('./core/manage.py')
    config.vm.provision "shell", run: "always", inline: "cd /app/docker/init_django && docker build -t init_django . && docker run --rm -v /app:/code init_django django-admin startproject core"
  end

  # 構築時最終処理
  config.vm.provision "shell", inline: <<-SHELL

  SHELL
  end