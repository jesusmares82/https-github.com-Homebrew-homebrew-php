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
    sha256 "ef72eb8c3c4e98cc2536e4e03b291c1732fa2965ee744bdbd51b14fe94357d2f" => :sierra
    sha256 "b99af47393da837fea59457f36ef6c74fa28925a9b92f1c638e6e61cc3e6908d" => :el_capitan
    sha256 "1a523e5241db667be892ad48e64073bc29ea0e6a7a5154b2a88977bc26980ffc" => :yosemite
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
