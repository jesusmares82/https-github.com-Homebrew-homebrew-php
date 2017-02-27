require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xdebug < AbstractPhp55Extension
  init
  desc "Provides debugging and profiling capabilities for PHP"
  homepage "https://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.1.tgz"
  sha256 "7fda9020fd5a2c549ae5a692fcabbb00f74e39dda81d53d25e622bdab4880ec2"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "33a1a48e75f6126a6ee87b8cd1b6686253148df6047a42b1b494e42d3776bea7" => :sierra
    sha256 "9ae9aa84b90036a8558fcf26214a5683d5716132429911adf179b11b286e6e80" => :el_capitan
    sha256 "89d1a6d86098c8c2a56b8147fc387497690455dc94500d4e033d43abae34324c" => :yosemite
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
