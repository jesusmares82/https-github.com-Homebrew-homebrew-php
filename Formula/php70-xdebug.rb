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
    sha256 "7ad008f78c8dce752becb885c0271dfae5783921224ec3601be940d27169ec9c" => :el_capitan
    sha256 "b2f0e6af81424b134385a673dda0df885745bec4781f153d9f794070e07851cb" => :yosemite
    sha256 "1e4fd7383d9bf2f970f368f9f7b07799853fe711eee7c92d5a065cccc3ed0aa2" => :mavericks
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
