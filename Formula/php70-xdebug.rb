require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xdebug < AbstractPhp70Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "http://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.4.1.tgz"
  sha256 "23c8786e0f5aae67b1e5035972bfff282710fb84c483887cebceb8ef5bbdf8ef"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "6b47c9e984fe12d8b5eb59afe749ab8c68013d4086ccc3bb9806e78a7ed9c89f" => :el_capitan
    sha256 "258f01a930a8b4a21892d9e8f79f6545e18e8de2fcca6ee4d86e44958c9924c8" => :yosemite
    sha256 "cb2d279e4cd29796e751c7d3497a719fdf17436c14ec33ed76793186ef6ee219" => :mavericks
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
