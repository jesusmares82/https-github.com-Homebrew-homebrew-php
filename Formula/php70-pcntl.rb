require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    revision 16
    sha256 "976f3880c1cef1f41f90d55f83dccc20c16050a24fe6aacde1df17054a956c93" => :el_capitan
    sha256 "1c38831b1d2e41a152dbfd94373e128fb79f6f95e1af70ed276d1bf5b8b888e6" => :yosemite
    sha256 "7377a1f7581c55228be3877b44e8deedca57ef2a2f696b1d508364e3eb65bcd5" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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









