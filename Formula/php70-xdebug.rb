require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xdebug < AbstractPhp70Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "http://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.4.0RC2.tgz"
  sha256 "d09bf890f50178d083291288d9dea34a90a95bd8e9cbc9755d14a8e7ebe9d6d0"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f91b8c2f3fa76147f2b85134eafa9a2f5487cabd6201c54c94c2c3b15f8f7bbf" => :el_capitan
    sha256 "f7f8d7054b75cfd9a1edd6ac4b90a9a395a688b16ca2422d682841fd9df10e54" => :yosemite
    sha256 "b8906783a2336a1fd0e8d7fd064f0e83558c23419c167f8ea0b7c2b155795b1c" => :mavericks
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
