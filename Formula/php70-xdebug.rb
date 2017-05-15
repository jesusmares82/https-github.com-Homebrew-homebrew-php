require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xdebug < AbstractPhp70Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.4.tgz"
  sha256 "300ca6fc3d95025148b0b5d0c96e14e54299e536a93a5d68c67b2cf32c9432b8"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "4fc60ac72e8811143ffb888a1c82be87393e160f0514785d30a21e8cc523cf3c" => :sierra
    sha256 "7099356822a486d2b916061cb2f4e597e2beabee534832bf8adbf94eb97f3b06" => :el_capitan
    sha256 "1e28790f842f3bf1cadd657bfaa30ecc72fa965532b62969523b1bd7e5f38770" => :yosemite
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
