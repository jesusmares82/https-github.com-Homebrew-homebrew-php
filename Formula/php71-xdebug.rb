require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Xdebug < AbstractPhp71Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "http://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.0RC1.tgz"
  sha256 "4b67bde62a32068cb48eaa5c683a390721e919f6b762d7da7ba1d72cdd01721a"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "e007f2d22717111c24ee6011108e8d1323b7516094ebbf76a187c3a213a3a5bb" => :el_capitan
    sha256 "f5be4dd20fe3a8d71ab5b365de72fd9d1365c505ec360588cf29871b684e66e0" => :yosemite
    sha256 "afcdc0ec5d458d1797f32c9469086fde1911c88e7df3720ee04edbf2289c1207" => :mavericks
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
