require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pcntl < AbstractPhp72Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 9

  bottle do
    cellar :any_skip_relocation
    sha256 "3b06216834b15bf05e07fa0f6f02d052fa26b23d864a437f2fdbdc08c3b3a8e9" => :high_sierra
    sha256 "646e91f516e27ceba0ecc1333b5688427a1120dbf64858f52590b8e7428cd9eb" => :sierra
    sha256 "4052dbae32792555eb0e38d7c088a59a62f316332dcfd535b8c5e78ebae2c261" => :el_capitan
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
