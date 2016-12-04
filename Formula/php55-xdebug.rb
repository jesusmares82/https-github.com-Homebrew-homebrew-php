require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xdebug < AbstractPhp55Extension
  init
  desc "Provides debugging and profiling capabilities for PHP"
  homepage "http://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.0.tgz"
  sha256 "8bd6ad1e64948308e3e3a7437292f154b11e25acaf31b0d59d83bda18af0890d"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "723b41551be36ef82142923876ee1e4da3079fa88eaee25248083f9bee254c3a" => :el_capitan
    sha256 "45d8b4f799b0b906735baecd790f8ebe8602b9d472cd555a16300ca07023620d" => :yosemite
    sha256 "71a79d2128fba089a9c8094244813bdf64cd78ed302e712c22ce27a2943aed96" => :mavericks
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
