# 🎣 Simulação de Ataque de Phishing com SEToolkit – Facebook

> **Propósito estritamente educacional e autorizado.** Este projeto foi desenvolvido em ambiente de laboratório isolado (rede virtual) como parte do curso de Cibersegurança da DIO. Nenhuma credencial real foi coletada sem consentimento.

## 📌 Objetivo

Demonstrar, na prática, como um ataque de phishing pode ser realizado utilizando o **Social-Engineer Toolkit (SET)** no Kali Linux, clonando a página de login do Facebook para capturar credenciais. O projeto inclui análise técnica do ataque e contramedidas defensivas.

## 🧪 Ambiente utilizado

| Componente         | Especificação                                      |
|--------------------|----------------------------------------------------|
| Atacante           | Kali Linux 2024.1 (VirtualBox) - IP 192.168.56.101 |
| Vítima simulada    | Windows 10 (VirtualBox) - mesmo segmento de rede   |
| Ferramenta         | SEToolkit versão 8.0.3 (incluída no Kali)          |
| Rede               | VirtualBox Host-Only (192.168.56.0/24)             |

## 🔧 Passo a passo executado

### 1. Inicialização do SEToolkit

```bash
sudo setoolkit
```

2. Navegação nos menus

Opção Seleção
Social-Engineering Attacks 1
Website Attack Vectors 2
Credential Harvester Attack Method 3
Site Cloner 2

3. Configuração do ataque

· IP para POST back: 192.168.56.101 (IP do Kali)
· URL a clonar: https://www.facebook.com

O SET baixa automaticamente os recursos da página original, modifica o formulário de login para enviar os dados para o IP do atacante e sobe um servidor web na porta 80.

4. Simulação da vítima

Na máquina Windows, abrimos o navegador e acessamos http://192.168.56.101. A página do Facebook clonada foi exibida normalmente (sem HTTPS, o que geraria um aviso no navegador moderno).

5. Captura de credenciais

O usuário "vítima" digitou:

· Email/Telefone: vítima_teste@email.com
· Senha: senha123

No terminal do Kali, o SET registrou:

```
[*] WEBSERVER: POST from 192.168.56.102:80
[*] PARAM: email=v%C3%ADtima_teste%40email.com&pass=senha123
```

📸 Evidências

(As imagens estão na pasta /images)

1. setoolkit_menu.png – Navegação pelos menus.
2. cloned_facebook_page.png – Página clonada sendo acessada pela vítima.
3. captured_credentials.png – Credenciais aparecendo no terminal do atacante.

🧠 Explicação técnica do funcionamento

· Clonagem: O SET baixa o HTML/CSS/JS da URL alvo e substitui o atributo action do formulário pelo IP do atacante.
· Harvester: Um servidor HTTP (em Python/Flask) escuta na porta 80, captura qualquer requisição POST e extrai os parâmetros (usuário/senha).
· Limitação crítica: A página clonada opera em HTTP puro, enquanto o Facebook real usa HTTPS. Navegadores modernos exibem um aviso "Não seguro" ou bloqueiam o envio de formulários em Mixed Content. Para contornar isso em laboratório, desabilitamos temporariamente a verificação HTTPS ou usamos um certificado autoassinado (não feito aqui por simplicidade).

🔁 Melhorias propostas (nível sênior)

· Evitar Mixed Content: Servir o clone via HTTPS com openssl e -ssl no SET (requer configuração adicional).
· Evitar detecção: Usar Evilginx2 para funcionar como proxy reverso, capturando tokens 2FA e cookies de sessão.
· Escalabilidade: Automatizar o processo com script Bash (ver /scripts/auto_phish.sh).
· Persuasão: Usar técnicas de typosquatting (ex: faceb00k.com) ou engenharia social via e-mail.

🛡️ Contramedidas defensivas (Blue Team)

Ameaça Defesa
Clonagem de página Verificar sempre o cadeado HTTPS e o domínio (não só o conteúdo visual)
Captura de credenciais Ativar 2FA – impossibilita uso da senha sozinha
Servidor HTTP falso Soluções de filtro web (ex: Cisco Umbrella, Pi-hole com listas)
Engenharia social Treinamento periódico com simulações de phishing (ex: GoPhish)

📚 Referências

· SEToolkit oficial
· OWASP Phishing Guide
· Lei 12.737/2012 – Crimes cibernéticos no Brasil

👤 Autor

Desafio do curso Formação Cibersegurança – DIO
Adaptado e aprimorado por [Seu nome aqui]
Data: Junho/2026

```

---
