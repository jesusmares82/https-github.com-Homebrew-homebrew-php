require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Yaz < AbstractPhp55Extension
  init
  desc "This extension implements a Z39.50/SRU client for PHP using the YAZ toolkit and the ZOOM framework."
  homepage "http://www.indexdata.com/phpyaz"
  url "https://pecl.php.net/get/yaz-1.1.6.tgz"
  sha256 "dd9b919ba3b2a09a9c77c847407f106512fe75979cc0689ebccef08c80719eee"

  bottle do
    sha256 "9c08b7228b976f4b3433d5f7abd6f676fcd6c93be074333d1995a1d12e2e0c0c" => :el_capitan
    sha256 "181705173bddc5a65419a6b4098f63a1d0db469eb12a124b01c49a455f6fb950" => :yosemite
    sha256 "2073312556427088bf4f5a9ab77fe5f261221f8743b00142bc4948e216e6ac1c" => :mavericks
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
