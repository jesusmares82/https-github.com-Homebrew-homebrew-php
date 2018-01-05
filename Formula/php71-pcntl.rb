require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 19

  bottle do
    cellar :any_skip_relocation
    sha256 "4ddf53eb7ddfbdd204aa0153c908889761c4331baf43e7fe6b3bf65627f6623b" => :high_sierra
    sha256 "3d20381ab195d09cc1d069d81ddbae208e29e1fce0808a09cfa040e06a3ad173" => :sierra
    sha256 "14f52a0689544de42137490d0c2028286544a7b0aa97ebe0a14193a44454c451" => :el_capitan
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
