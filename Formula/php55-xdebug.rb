require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xdebug < AbstractPhp55Extension
  init
  desc "Provides debugging and profiling capabilities for PHP"
  homepage "http://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.4.1.tgz"
  sha256 "23c8786e0f5aae67b1e5035972bfff282710fb84c483887cebceb8ef5bbdf8ef"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "e67394a60091bac1ab7de5bc2371904cb59a12af93472fa4b9d2729eb3992c01" => :el_capitan
    sha256 "d100df675ee8f3e562752719c15ee9dd13820812e7057a1660bb4e5871d997c0" => :yosemite
    sha256 "b64fc8aa8c72c5dc45b398e879908bc5d28bbeba6c0727c9d1e39d0baba8bd0e" => :mavericks
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
