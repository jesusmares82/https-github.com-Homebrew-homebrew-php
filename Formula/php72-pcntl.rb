require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pcntl < AbstractPhp72Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 10

  bottle do
    cellar :any_skip_relocation
    sha256 "4e7da20efd517eda67d5a668f47cc80426f1f8e7ba715a6f49d7add4705d2cac" => :high_sierra
    sha256 "eb48f84f53e3655a40481fd9cc18358eb52b7a2e1561f113f3a48da1cc54ec5e" => :sierra
    sha256 "a500099d09849f67d3e2a9837493a622108de23e6ac64b141bc6472e9d83b3bb" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  def install
    Dir.chdir "ext/pcntl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
