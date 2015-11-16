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
    revision 2
    sha256 "236ec1fa7d8f3190b4f2fd9073d7aeaefc8566d04b8fca3e76481474b34913e5" => :el_capitan
    sha256 "7c08c220b749fd72a4de4031df6838182b468908ee54fde465170c93bf58c32a" => :yosemite
    sha256 "eda016f24b97ce0e0bded3693537e3253ac4849eea7ad4048a66026d7a13bdc2" => :mavericks
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
