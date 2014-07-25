require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Yrmcds < AbstractPhp54Extension
  init
  homepage 'https://github.com/cybozu/php-yrmcds'
  url 'https://github.com/cybozu/php-yrmcds/archive/v1.0.2.tar.gz'
  sha1 'eeb6689822071aa7d7705a5e838a341af3976484'
  head 'https://github.com/cybozu/php-yrmcds.git'

  def patches
    return [
        "https://gist.githubusercontent.com/KonstantinKuklin/4cebe58997e2152cdc35/raw/09a5c4cd1a2739d2d9e0e38338d4e9d01058f914/patch_php-yrmcds_mac.patch"
    ]
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/yrmcds.so"
    write_config_file if build.with? "config-file"
  end
end
