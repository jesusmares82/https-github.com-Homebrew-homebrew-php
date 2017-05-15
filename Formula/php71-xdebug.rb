require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Xdebug < AbstractPhp71Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.4.tgz"
  sha256 "300ca6fc3d95025148b0b5d0c96e14e54299e536a93a5d68c67b2cf32c9432b8"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "e4a23cc4b52d25eebccd5547a818121329ba7061c4b4049cad6490e67ac678fb" => :sierra
    sha256 "029ed9c15f6ef1243dd95ac6049266791f4997d21e6ead7a314a7ca0cff64b2a" => :el_capitan
    sha256 "6862b7922d0987cb2730f06b063f6a44ddb113a6f0a757e882fad706de669f13" => :yosemite
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
