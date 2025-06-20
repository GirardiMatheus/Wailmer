<div align="center">
  <img src="./assets/Wailmer.png" width="70" height="70" alt="Wailmer logo">
  
  <h1>Wailmer</h1>

  <p>Este projeto contém um script shell que remove a política de reinício automático de todos os containers Docker em sua máquina. Isso garante que, após reiniciar o sistema, nenhum container seja iniciado automaticamente.</p>

  <p>
    <img src="https://img.shields.io/badge/Shell_Script-100%25-brightgreen" alt="Shell">
    <img src="https://img.shields.io/badge/docker-257bd6?style=flat&logo=docker&logoColor=white" alt="Docker">
    <img src="https://img.shields.io/badge/license-MIT-blue" alt="License">
  </p>
</div>

---

## Estrutura
```
Wailmer/
├── docker-disable-restart.sh
└── README.md
```

## Como usar

### 1. Torne o script executável

```bash
chmod +x docker-disable-restart.sh
```

### 2. Execute manualmente (se desejar)

```bash
./docker-disable-restart.sh
```

Este comando percorre todos os containers Docker existentes e remove suas políticas de reinício (--restart=no).

## Automação com systemd

Você pode configurar o script para ser executado automaticamente toda vez que o sistema for iniciado.

### 1. Crie um serviço systemd

```bash
sudo nano /etc/systemd/system/docker-disable-restart.service
```

### 2. Cole o seguinte conteúdo

⚠️ Substitua /home/SEU_USUARIO/Wailmer/docker-disable-restart.sh pelo caminho real do script.

```bash
[Unit]
Description=Desativa restart automático de containers Docker
After=docker.service
Requires=docker.service

[Service]
Type=oneshot
ExecStart=/home/SEU_USUARIO/Wailmer/docker-disable-restart.sh

[Install]
WantedBy=multi-user.target
```

### 3. Recarregue e ative o serviço

```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable docker-disable-restart.service
```

## Verificando o serviço

Para testar se o serviço funciona corretamente:

```bash
sudo systemctl start docker-disable-restart.service
```

Verifique o status:

```bash
systemctl status docker-disable-restart.service
```

## Dica

Se você quiser que o script também pare containers que iniciaram automaticamente, abra um pull request ou modifique o script adicionando o seguinte trecho no final:

```bash
docker stop $(docker ps -q)
```