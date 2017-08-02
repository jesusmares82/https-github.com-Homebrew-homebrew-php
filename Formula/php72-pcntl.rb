require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pcntl < AbstractPhp72Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 3

  bottle do
    cellar :any_skip_relocation
    sha256 "d97470c3b311cfeb2b5896faea4285f22fea52a4b41710fca0f593bf5bea3608" => :sierra
    sha256 "9cbbb60eb8c2df579c11c66663d9161550503693e54f67609ccdb0b2318b5039" => :el_capitan
    sha256 "4c83a9eb8283be92f6be7eb1b13f6bf46798927043bac62b10423299fa75d247" => :yosemite
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
