require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pcntl < AbstractPhp72Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 4

  bottle do
    cellar :any_skip_relocation
    sha256 "203e0731dbefb3d68ab4893b7b20881598459b99fdda6460d4e9b1a4ec207771" => :sierra
    sha256 "cf127e24a575b7e38dcb753e3d0c837e83f4f025b2cedd06a9f93f941423ed58" => :el_capitan
    sha256 "1d3d4c5bb5fb851d836dcadc6ca4d276e6644079eec8b83cb804bbfd6dd06fde" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
