require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xdebug < AbstractPhp70Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "http://xdebug.org"
  url "http://xdebug.org/files/xdebug-2.4.0rc1.tgz"
  version "2.4.0RC1"
  sha256 "4ac1ff5521c683d6a437f2d3d9a7a2d26b7eac8c473b52560a48404cf75a9805"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    revision 3
    sha256 "42d130d9706938ad14748004a825e45aea6063aeced4bbb5510f44a160248fb0" => :el_capitan
    sha256 "b9d7ee3ee05bf5619a92f9d3696a0d946a0357d411f479e1fd64898d42421c2d" => :yosemite
    sha256 "05f53dddda6c298634310b4eb24e2e8dda699890ec0b0c88f9545ac74f0130af" => :mavericks
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
