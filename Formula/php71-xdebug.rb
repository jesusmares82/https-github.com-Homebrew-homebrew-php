require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Xdebug < AbstractPhp71Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "http://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.0RC1.tgz"
  sha256 "4b67bde62a32068cb48eaa5c683a390721e919f6b762d7da7ba1d72cdd01721a"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "03e4a06c32b2a31dbf7dec5ae2dd2ec30fbc6b01a774fcccf1cd32144fa9cda8" => :sierra
    sha256 "8ab277f24f5656c9225b5d255451db2d87ab1d8a67128d9c3344fd5d5e2e5d8b" => :el_capitan
    sha256 "2b3e85db5de8c168da5fee067a63a1ba32c8cee53b8dc3dfd47d122529c54432" => :yosemite
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
