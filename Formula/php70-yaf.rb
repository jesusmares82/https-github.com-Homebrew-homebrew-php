require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Yaf < AbstractPhp70Extension
  init
  desc "Yaf is a fast php framework written in c, built in php-ext"
  homepage "https://pecl.php.net/package/yaf"
  url "https://pecl.php.net/get/yaf-3.0.3.tgz"
  sha256 "431a7ad4d4cdd51877cc57b1382c4e27395628699fd065bd5140d2e6f70615e3"
  head "https://svn.php.net/repository/pecl/yaf/trunk/"

  depends_on "pcre"

  def install
    Dir.chdir "yaf-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/yaf.so"
    write_config_file if build.with? "config-file"
  end
end
