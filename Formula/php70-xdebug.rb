require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xdebug < AbstractPhp70Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "http://xdebug.org"
  url "http://xdebug.org/files/xdebug-2.4.0beta1.tgz"
  version "2.4.0beta1"
  sha256 "169ac5dc5fe8a06d75467c83a495940472b8d139b2d2204d8859127e6494f0d9"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "811641c2198f8a5fc98e5e4bdaf97b6185da928703b6c93d778115fdea321a61" => :el_capitan
    sha256 "c5ec25cba65c58cf9d36a77af32ce46dc10dec95b0cef458673298f021b660ba" => :yosemite
    sha256 "ef45e4ca3c7eda30096bcf54479d212f09c9fcd22242bb11d58442ef8d0f6a1e" => :mavericks
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
