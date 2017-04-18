require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Xdebug < AbstractPhp71Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.3.tgz"
  sha256 "4cce3d495243e92cd2e1d764a33188d60c85f0d2087d94d4203c354ea03530f4"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1e7e5d3c4d2ad733cb1337bee663d230f55beafa78e734e7246008be790d07a0" => :sierra
    sha256 "bf6b3c10035cea0d29d57a512cb3215c403a696cd0457874e8178924c2f6943c" => :el_capitan
    sha256 "5254c228a4f6099bfb03d0e61478ef8076504fc7dfa157e0190662852a912337" => :yosemite
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
