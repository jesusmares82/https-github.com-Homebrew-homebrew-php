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
    sha256 "ddde738e3d62067285caf358ca499061f651962dc6359717cf33b388181c284a" => :el_capitan
    sha256 "8b0cebdba8b9cde37701012fdc0ac7d1faea5e82a44ec5c223a870a29af12599" => :yosemite
    sha256 "55ee1101863a8df95d07eb867838b2a2424c7f21dba39404a0c8bf5066926af6" => :mavericks
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
