require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Yaz < AbstractPhp55Extension
  init
  desc "This extension implements a Z39.50/SRU client for PHP using the YAZ toolkit and the ZOOM framework."
  homepage "http://www.indexdata.com/phpyaz"
  url "https://pecl.php.net/get/yaz-1.1.9.tgz"
  sha256 "9dd4da2fd6042b37a1811972134f852c94a6f6b85ca4ec5ed5d766eb27a6c401"
  revision 1

  bottle do
    sha256 "6836b5b5b4098a8bc991e608152a12bb426a4a958dfeada54b451e669511f6bb" => :el_capitan
    sha256 "abbbb1b89f1316c4ace5ee3f5017bd637309e765fbcc2700892d7594d6e8a68c" => :yosemite
    sha256 "6e2991f94d7a65a2330d32bbc5e9ad6a0c5273743e91374e56208208da8b66f9" => :mavericks
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
