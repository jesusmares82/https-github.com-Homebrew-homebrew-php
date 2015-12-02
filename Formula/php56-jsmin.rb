require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Jsmin < AbstractPhp56Extension
  init
  desc "PHP extension for minifying JavaScript."
  homepage "https://pecl.php.net/package/jsmin"
  url "https://pecl.php.net/get/jsmin-1.1.0.tgz"
  sha256 "9cf4180a816bac08300c45083410ca536200bd4940db0174026b9a825161f159"
  head "https://github.com/sqmk/pecl-jsmin.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "e07731cde8542328cd347ee75a0ce62b9930394b535e01b773180ea2fb469436" => :el_capitan
    sha256 "034992d51155ed6f57d464f9ea062d5eea58dce69b9f8a72d215d86f4dd37d1b" => :yosemite
    sha256 "dbcda6a996e7cd84fb28a439084c119917b86349f59f6684751f3444b3c532af" => :mavericks
  end

  def install
    Dir.chdir "jsmin-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/jsmin.so"
    write_config_file if build.with? "config-file"
  end
end
