require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    sha256 "92ead37d4c2a11c6924a43393a07cf1733c1075f740470cebafb245adfc96ec8" => :sierra
    sha256 "9dcde846ccd04ea58050660cfd98c702c7ebfd21c4c34f1589fc96aa398c7b4e" => :el_capitan
    sha256 "501707fe75f3816ef4fbf6bbda231b671404432af07b73f3e63723df6747517e" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  def install
    Dir.chdir "ext/pcntl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
