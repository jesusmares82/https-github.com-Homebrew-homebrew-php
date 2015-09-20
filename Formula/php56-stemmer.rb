require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Stemmer < AbstractPhp56Extension
  init
  homepage 'https://github.com/hthetiot/php-stemmer'
  url 'https://github.com/hthetiot/php-stemmer/archive/0f32673f89e72049a6c43a4d5966a88b81aff039.tar.gz'
  sha256 'a3e2769afc0473d85f6d097596e3897a48ee294f071edc8d197fa04c6fc30b9f'
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
