require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xdebug < AbstractPhp70Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "http://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.0.tgz"
  sha256 "8bd6ad1e64948308e3e3a7437292f154b11e25acaf31b0d59d83bda18af0890d"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "319224de1b8b692c0b896a5c8eb89d64d79974442a99c8d5bde58788bea27e70" => :sierra
    sha256 "9f361e8671bdd256e48d61ae42c5a82a0392d87bed6897ae80b02bda0d90f2a1" => :el_capitan
    sha256 "8aafc23e5e9ffc2e0f95fb06dd458a1b54555c1b33f735f14044613c3107ee5a" => :yosemite
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
