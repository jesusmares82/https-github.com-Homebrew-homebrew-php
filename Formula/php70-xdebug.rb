require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xdebug < AbstractPhp70Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "http://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.4.1.tgz"
  sha256 "23c8786e0f5aae67b1e5035972bfff282710fb84c483887cebceb8ef5bbdf8ef"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "6d8449481d1117229e3494403fc50a2ba33be81a8e72600f1f53d6eb5a0d07b1" => :el_capitan
    sha256 "5b5e5970f6fbd14af604b38d27ed8eb5414822cefa01f2d2c5672541f906c2f3" => :yosemite
    sha256 "7069bfa43a1ea21c53e7d8f44518deddb1f4c730081aec72dd8633617f203520" => :mavericks
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
