require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Graphdat < AbstractPhp55Extension
  init
  homepage 'http://www.graphdat.com/'
  url 'https://pecl.php.net/get/graphdat-1.0.3.tgz'
  sha1 'b49779825c37ccedeefbd7085aa5a8d7c89c6d52'
  head 'https://github.com/alphashack/graphdat-sdk-php.git'

  def install
    Dir.chdir "graphdat-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/graphdat.so"
    write_config_file if build.with? "config-file"
  end
end
