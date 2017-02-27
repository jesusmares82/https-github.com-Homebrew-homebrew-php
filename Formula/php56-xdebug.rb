require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xdebug < AbstractPhp56Extension
  init
  desc "Provides debugging and profiling capabilities for PHP"
  homepage "https://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.1.tgz"
  sha256 "7fda9020fd5a2c549ae5a692fcabbb00f74e39dda81d53d25e622bdab4880ec2"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2be3b6ce3e36144c61f6d3cae7c9664d04a423231cb690ce73e78cf985e30476" => :sierra
    sha256 "62045a6352c3eaf4eb2d1b93571b459b0b11bf9ae8c95f96d0ba68bc8ec770b7" => :el_capitan
    sha256 "50bd0f6ca0b810ce7c2fa015662e7baf4612f3c52549ae454529184cab26eb71" => :yosemite
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
