packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "amazon_linux" {
  ami_name         = "sample-app-packer-${uuidv4()}"
  ami_description  = "Amazon Linux 2 AMI with a Node.js sample app managed by PM2."
  instance_type    = "t3.micro"
  region           = "us-east-1"
  source_ami       = "ami-068c0051b15cdb816"
  ssh_username     = "ec2-user"
}

build {
  sources = ["source.amazon-ebs.amazon_linux"]

  # Copie ton fichier app.js sur l'instance
  provisioner "file" {
    source      = "app.js"
    destination = "/home/ec2-user/app.js"
  }

  # Installe Node.js, PM2 et démarre l'application
  provisioner "shell" {
    inline = [
      # Installation de Node.js 18.x
      "curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -",
      "sudo yum install -y nodejs",

      # Installation de Git (si nécessaire)
      "sudo yum install -y git",

      # Installation de PM2 globalement
      "sudo npm install -g pm2",

      # Démarrage de l'application avec PM2
      "pm2 start /home/ec2-user/app.js --name sample-app",

      # Sauvegarde la liste des processus PM2
      "pm2 save",

      # Configuration automatique de PM2 pour le démarrage au boot
      "sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ec2-user --hp /home/ec2-user",
      "pm2 save",

      # Attend 5 secondes pour s'assurer que tout est prêt
      "sleep 5"
    ]
    pause_before = "30s"
  }
}

