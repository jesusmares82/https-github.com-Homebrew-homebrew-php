require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xdebug < AbstractPhp55Extension
  init
  desc "Provides debugging and profiling capabilities for PHP"
  homepage "https://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.3.tgz"
  sha256 "4cce3d495243e92cd2e1d764a33188d60c85f0d2087d94d4203c354ea03530f4"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "494421de9f86472ab01ef76e6fb6b38295ffb859e3396dedd5af70374d23522f" => :sierra
    sha256 "725a66651ba47d24bb77f830bf97dee6cbd1bc6a993c66754b39fc2398164c29" => :el_capitan
    sha256 "4ee909b9aa6819274eda5061329f6618eaadf5bc6173bb4cbc4b070ecd48bda9" => :yosemite
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
