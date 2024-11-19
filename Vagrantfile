Vagrant.configure("2") do |config|
  # Ubuntu 20.04 (focal64) box
  config.vm.box = "ubuntu/focal64"
  
  config.vm.network "forwarded_port", guest: 7000, host: 7000

  # CPU ve RAM ayarları
  config.vm.provider "virtualbox" do |vb|
  
    vb.memory = "2048"
    vb.cpus = 2
  end

  # Hostname ayarı
  config.vm.hostname = "husosan"

  # Provision script'i çalıştırma
  config.vm.provision "shell", path: "provision.sh"

  # SSH anahtarlarını otomatik olarak ekle
  config.ssh.insert_key = true

end
