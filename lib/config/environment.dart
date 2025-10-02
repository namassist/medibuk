enum EnvType { staging, production }

class Environment {
  final EnvType envType;
  final String baseUrl;
  final String nodeUrl;
  final String logoPath;
  final String node;

  Environment._({
    required this.envType,
    required this.baseUrl,
    required this.nodeUrl,
    required this.logoPath,
    required this.node,
  });

  factory Environment.staging() {
    return Environment._(
      envType: EnvType.staging,
      baseUrl: 'https://devkss.idempiereonline.com/api/v1',
      nodeUrl: 'https://medibook.medital.id/api',
      logoPath: 'assets/logo-kehamilan-sehat-website.png',
      node: 'dev',
    );
  }

  factory Environment.production() {
    return Environment._(
      envType: EnvType.production,
      baseUrl: 'https://ksslive.idempiereonline.com/api/v1',
      nodeUrl: 'https://medibook.medital.id/api',
      logoPath: 'assets/logo-kehamilan-sehat-website.png',
      node: 'live',
    );
  }
}

class EnvManager {
  late final Environment config;
  EnvManager._private();
  static final EnvManager _instance = EnvManager._private();
  static EnvManager get instance => _instance;

  void initialize(Environment env) {
    config = env;
  }
}
