require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Xdebug < AbstractPhp71Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.5.tgz"
  sha256 "72108bf2bc514ee7198e10466a0fedcac3df9bbc5bd26ce2ec2dafab990bf1a4"
  head "https://github.com/xdebug/xdebug.git"

  devel do
    url "https://xdebug.org/files/xdebug-2.6.0beta1.tgz"
    sha256 "49de661e1e18cbbd739fc9fb7a014a36f97a84d2c4a89417c358dd258340527d"
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "2a6d04b32d3c688b2ff163992d00fa9d23c41d35b248c95df7f0f5380096fe01" => :sierra
    sha256 "418e6879cef7f6a0b78faecd6640bf559b462af67eaafd036d7520b40b6903a2" => :el_capitan
    sha256 "87c1d5aaa0aa5cceb8f63cb89ae768541d401be397dffa621396eec461585f27" => :yosemite
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
