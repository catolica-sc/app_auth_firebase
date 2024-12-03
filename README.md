# Autenticação Firebase com Google

### Avaliação N3 Dispositivos Moveis
## Alunos:
- Santhiago Chapiewski
- Pedro Henrique dos Santos
- Vinicius Froes

## Listagem de funções por telas

### Tela de login

- Faz conexão com o FirebaseAuth
- Função Login:
  - Tenta autenticar no banco através do autenticação do Google e redireciona para a tela Home
  - Caso não der certo, faz o tratamento é realizado pela propria Google



### Tela Home

- Exibe um texto informando que está na tela Home
- Exibe um botão com a função de Logout:
  - Tenta fazer logout, avisa o usuário que desconectou e redireciona para a tela de Login
  - Caso contrário, exibe um erro imprimindo a mensagem informativa.

## Listagem de dependências utilizadas

 - cupertino_icons: ^1.0.8
 - firebase_core: ^3.8.0
 - firebase_auth: ^5.3.3
 - google_sign_in: ^6.2.2
 - provider: ^6.1.2
 - cloud_firestore: ^5.5.0

## Instruções para configuração/importação do projeto

### Versões utilizadas do Flutter e Dart

- Flutter 3.24.4 
- Dart 3.5.4

### Versão mínima do SDK

- minSdk = 23

### Importando o projeto

- Baixe o código-fonte do projeto
- No Android Studio, abra o projeto baixado
- Vá em Settings e verifique se em "Languages e Frameworks > Flutter" a configuração "Flutter SDK path" contém o caminho correto para acessar o SDK que está no seu computador
- Abra o arquivo "pubspec.yaml" e clique em "Pub get" para baixar as dependências do projeto
- Inicie um emulador e execute o projeto
- Para testar, clique no login Google 

#

# Gerando um APK no Flutter

Este guia detalha os passos necessários para gerar um APK de um aplicativo Flutter.

---

## 1. Após o desenvolvimento do app, Atualize o Número da Versão:

```yaml
version: 1.0.0+1
```

- O formato é major.minor.patch+build.

### 2. Configure a Assinatura do Aplicativo:

- Para distribuir o aplicativo na Google Play Store, é necessário assiná-lo digitalmente.
- Crie um arquivo de chave (keystore) executando:

```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

- Siga as instruções para definir uma senha e outras informações.
- Crie um arquivo key.properties no diretório android do seu projeto com o seguinte conteúdo:

```properties
storePassword=senha_definida
keyPassword=senha_definida
keyAlias=upload
storeFile=caminho/para/upload-keystore.jks
```
- No arquivo android/app/build.gradle, adicione as seguintes linhas:

```groovy
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    ...
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled false
            shrinkResources false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```
- Para mais detalhes sobre a assinatura de aplicativos, consulte a documentação oficial: [Assinatura de Aplicativos Android](https://docs.flutter.dev/deployment/android#signing-the-app).

### 3. Compilar o APK em Modo Release:

- No terminal, execute: 

```bash
flutter build apk --release
```

- O APK gerado estará localizado em build/app/outputs/flutter-apk/app-release.apk.

### 4. Distribuição do APK

- O APK gerado pode ser instalado manualmente em dispositivos Android.
- Para distribuir o APK na Google Play Store, siga o processo de publicação do Google Play Console.

