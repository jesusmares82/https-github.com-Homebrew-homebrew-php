require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xdebug < AbstractPhp55Extension
  init
  homepage "http://xdebug.org"
  url "http://xdebug.org/files/xdebug-2.3.2.tgz"
  sha1 "2b32d15880d88a084d9d50929b9f6904bf091fc4"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    cellar :any
    sha256 "2ddbb8f446fac2d6a7f34b99985d4bf802fb70e5dcd631e6487c8f52fcfe2a27" => :yosemite
    sha256 "e3203ffc3e7521f3f1ec08cbf61bcfc61d071233f3763491c62a4073e03f3aa0" => :mavericks
    sha256 "739860a129b3181a3fe9ecca5de9faa75b78f7f3107f90388e6822a39046e04e" => :mountain_lion
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
