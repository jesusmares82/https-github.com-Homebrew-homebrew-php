require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xdebug < AbstractPhp56Extension
  init
  homepage "http://xdebug.org"
  url "http://xdebug.org/files/xdebug-2.2.7.tgz"
  sha256 "4fce7fc794ccbb1dd0b961191cd0323516e216502fe7209b03711fc621642245"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "69e293502680af6281d918d2d96021216507912a34bc1c81ece129bb083bbd79" => :yosemite
    sha256 "760ae90945ebd69046deb3c5b36cb9bfe6ade1d8f6743620c5082c87fc118a10" => :mavericks
    sha256 "1fd7bbf3fccf197529c91bf72f1411707436b96eb5fd207b27827ff6d22fe405" => :mountain_lion
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

  test do
    shell_output("php -m").include?("Xdebug")
  end
end
