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
    sha256 "cfd8bca2c3c6817fac7179622fab66cbd2d0d10471fc9cb656e3090d52178781" => :sierra
    sha256 "90a46f0240a34277f291bdd1ab6acbdaae02b51355c34b87e55e9a4fa7aed522" => :el_capitan
    sha256 "704e2cda010fb81c62bca74563ac86a64f18a9bfa36cc75d402afbdcd2e4dae2" => :yosemite
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
