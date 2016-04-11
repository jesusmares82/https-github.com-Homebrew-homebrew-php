require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Yaz < AbstractPhp56Extension
  init
  desc "This extension implements a Z39.50/SRU client for PHP using the YAZ toolkit and the ZOOM framework."
  homepage "http://www.indexdata.com/phpyaz"
  url "https://pecl.php.net/get/yaz-1.1.9.tgz"
  sha256 "9dd4da2fd6042b37a1811972134f852c94a6f6b85ca4ec5ed5d766eb27a6c401"
  revision 1

  bottle do
    sha256 "5281761c3f003f948897282b81c123c69847a940c5f7c371b915ac6cc93ef527" => :el_capitan
    sha256 "2b4c5b1bb1587df84d73463e5aa5d7441d4a1c235d52144ffa8590248db1fc1e" => :yosemite
    sha256 "f06ba395cfc80f899f63052ea39fdd99006d8673873f797d252368a0b7efc4ae" => :mavericks
  end

  depends_on "yaz"

  def install
    Dir.chdir "yaz-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaz.so"
    write_config_file if build.with? "config-file"
  end
end
