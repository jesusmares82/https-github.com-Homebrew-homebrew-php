require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pcntl < AbstractPhp72Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 11

  bottle do
    cellar :any_skip_relocation
    sha256 "a8ef6685c333537384623d9daf5afbd44cf99cf548c82142ae2c1300306f28b2" => :high_sierra
    sha256 "ea32ed6da058880b3850bd72079b308965196ea63b3f96f5d5d811c4563b44af" => :sierra
    sha256 "2de88b8067931e9e7b4cd0be406686e9f7144321941c74aefc4b42c5f1246e0f" => :el_capitan
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
