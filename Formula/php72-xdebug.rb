require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Xdebug < AbstractPhp72Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://xdebug.org/files/xdebug-2.6.0RC2.tgz"
  sha256 "eea67ce63287fa6eb8fffbd7ed218295c2d649eaee245c114d10a6ebe4c0b019"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "907ec5ca617b56fad663b86d9ca752e934bdbc0a7fdfccaf27b1cac51bb4baa1" => :high_sierra
    sha256 "5c21f8514e09b4a53bfb69b5062a06665bc7534491a71b77451973506ae183d6" => :sierra
    sha256 "dbe254589561263528d7c23b0c82593193ac64f1cb7918f3c88672568354edcf" => :el_capitan
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
