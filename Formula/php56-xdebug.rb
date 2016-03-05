require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xdebug < AbstractPhp56Extension
  init
  desc "Provides debugging and profiling capabilities for PHP"
  homepage "http://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.4.0.tgz"
  sha256 "3c4dcb2709d1653534e7cfaa546307041afd298ac48a3670183a12cfdb5eee05"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8cda23facc8d761daa07f2807c621fe4ca41c1ab7e326898e0aa90e841e34bb9" => :el_capitan
    sha256 "d0fc25aa293255425cdd5580d962907d78e9c7bc6c74dd57f40798199192ecc6" => :yosemite
    sha256 "8c7f3d45b2416cc07fe3becc2a72499c369dc8cb0832b9440336ef456fb979f3" => :mavericks
  end

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "xdebug-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file if build.with? "config-file"
  end
end
