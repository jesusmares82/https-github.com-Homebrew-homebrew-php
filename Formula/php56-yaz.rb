require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Yaz < AbstractPhp56Extension
  init
  desc "This extension implements a Z39.50/SRU client for PHP using the YAZ toolkit and the ZOOM framework."
  homepage "http://www.indexdata.com/phpyaz"
  url "https://pecl.php.net/get/yaz-1.1.9.tgz"
  sha256 "9dd4da2fd6042b37a1811972134f852c94a6f6b85ca4ec5ed5d766eb27a6c401"

  bottle do
    sha256 "3d322874af51751f45a38dbdca50b1403fe290ef5b475a73e75abc2f7e831b06" => :el_capitan
    sha256 "0d2527b509d0c12b33d6facd9e304780d93f0465d661725d99d9bb783ce04f6a" => :yosemite
    sha256 "eba4f213ed6d85cf6d00c84bcb1012633fa578ea6f2c335df1e74772f2233409" => :mavericks
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
