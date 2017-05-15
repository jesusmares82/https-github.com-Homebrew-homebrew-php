require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xdebug < AbstractPhp56Extension
  init
  desc "Provides debugging and profiling capabilities for PHP"
  homepage "https://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.4.tgz"
  sha256 "300ca6fc3d95025148b0b5d0c96e14e54299e536a93a5d68c67b2cf32c9432b8"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7554b1519e0f484cfb28e6eadb74cb2d7562448e6b4a4e2a3333755cdcbb67dc" => :sierra
    sha256 "017c61059b67ba12715653a69dfeb21c660d68ffe7f48779d7e71cecf4fec3ba" => :el_capitan
    sha256 "cf6b7ef04cd2b50fc47d1839fb0d2ffc904d3e82b8bb0716640a9a7e62239420" => :yosemite
  end

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "xdebug-#{version}" unless build.head?

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
