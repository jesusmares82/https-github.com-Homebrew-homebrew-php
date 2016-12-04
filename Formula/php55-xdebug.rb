require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xdebug < AbstractPhp55Extension
  init
  desc "Provides debugging and profiling capabilities for PHP"
  homepage "http://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.0.tgz"
  sha256 "8bd6ad1e64948308e3e3a7437292f154b11e25acaf31b0d59d83bda18af0890d"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "a22f7ddf023aee3febd1ab806c9953fb41d0a7a6e6780ee5aa16aef0789eb543" => :sierra
    sha256 "24b3360cac5ab4313c9e329a8e06737d3643435c44dd16183010476e4f205294" => :el_capitan
    sha256 "35bf2bb4f0792d4dee99d26b66a24b698ccb8a29688cc00c6029ec6bcc037bf3" => :yosemite
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
