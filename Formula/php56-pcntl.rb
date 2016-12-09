require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  bottle do
    cellar :any_skip_relocation
    sha256 "4a2a2c20f1677806182276996270c0fa14e4c3743b75a47cc3600f1ad35552f3" => :sierra
    sha256 "48851c19004264faffe3247b89b61a457f33c2cdbb492ed3797f4b3de8491280" => :el_capitan
    sha256 "6269334fb7056835f7de005497cb6e96940379e9bac72ffdf591819a139589be" => :yosemite
  end

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
