require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Yaf < AbstractPhp70Extension
  init
  desc "Yaf is a fast php framework written in c, built in php-ext"
  homepage "https://pecl.php.net/package/yaf"
  url "https://pecl.php.net/get/yaf-3.0.3.tgz"
  sha256 "431a7ad4d4cdd51877cc57b1382c4e27395628699fd065bd5140d2e6f70615e3"
  head "https://github.com/laruence/yaf.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f362f2731fe4736da0394132ace5f750bb0573f78e113d4efb1ad6380d3a87f1" => :el_capitan
    sha256 "aa2c61a908313b2dce9ad43d088a89b4bef4f66cf03252e6a52b77f4f8e0746f" => :yosemite
    sha256 "0bcfd62d0d898dc3b128d72c38291f0c354e62ef45ae2787683ab0e27aa4f166" => :mavericks
  end

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
