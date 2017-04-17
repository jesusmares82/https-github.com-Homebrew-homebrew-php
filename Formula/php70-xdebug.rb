require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xdebug < AbstractPhp70Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.3.tgz"
  sha256 "4cce3d495243e92cd2e1d764a33188d60c85f0d2087d94d4203c354ea03530f4"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "96fd79b272fcbd865b6b95c53dff9bd7e135e9f4f36ccbca26c5933ff293f06c" => :sierra
    sha256 "a8c29f5f3de25ce67195e789f12e01bfa8431239912b12c5d5d111165b96017c" => :el_capitan
    sha256 "a87cc018b6848254d57542be9a24a14a744b497f7e91306325b751909b76973e" => :yosemite
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
