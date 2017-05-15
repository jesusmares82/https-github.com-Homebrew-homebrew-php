require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xdebug < AbstractPhp55Extension
  init
  desc "Provides debugging and profiling capabilities for PHP"
  homepage "https://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.4.tgz"
  sha256 "300ca6fc3d95025148b0b5d0c96e14e54299e536a93a5d68c67b2cf32c9432b8"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "4ad47b6ed91413cb8d39050a0f53b1a9b4bd16f655511f04c1456fdf714abff2" => :sierra
    sha256 "946916cbedd762306db829e2e1ad9f69638e4cc05b4c76c2ddfe894ae0a12a61" => :el_capitan
    sha256 "cc12a07a6acd4364d18a78ac4510e9d0b32ad5e14c242abf5376914a64a26863" => :yosemite
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
