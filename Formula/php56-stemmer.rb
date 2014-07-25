require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Stemmer < AbstractPhp56Extension
  init
  homepage 'https://github.com/hthetiot/php-stemmer'
  url 'https://github.com/hthetiot/php-stemmer/archive/0f32673f89e72049a6c43a4d5966a88b81aff039.tar.gz'
  sha1 'e26980062d5bc2e275eddaee46aef56ba25906c4'
  version '0f32673'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make -C libstemmer_c"
    system "make"
    prefix.install "modules/stemmer.so"
    write_config_file if build.with? "config-file"
  end
end
