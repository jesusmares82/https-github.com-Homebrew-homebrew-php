require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xdebug < AbstractPhp56Extension
  init
  desc "Provides debugging and profiling capabilities for PHP"
  homepage "http://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.0.tgz"
  sha256 "8bd6ad1e64948308e3e3a7437292f154b11e25acaf31b0d59d83bda18af0890d"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "6ab9b43daaa91f68c76c04a558f8c5f924910c8c0b2a8bc6d3a60b31c736449f" => :el_capitan
    sha256 "9822b1e5f0175613f8cc0fedc7573e299641f25424bc5986e844d56a53ccb137" => :yosemite
    sha256 "664b1ba5fa8c37d5fda694f38d9d85130417581cc6eea45359fc9027b145c604" => :mavericks
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
