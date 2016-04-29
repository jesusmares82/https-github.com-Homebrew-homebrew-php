require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any_skip_relocation
    revision 9
    sha256 "77c79b0ab03661f59061e969dc6b688c97ee29b1defef8c854bf70b9e2f4b923" => :el_capitan
    sha256 "faa1d95ca6b3cb0f0fd9ead0c56f0bac68d606ddea7f697de34cd83d6cadd860" => :yosemite
    sha256 "70776fd803c573be89d20ad1c3d8e765c5a57d85132c142ed631a36966df9a9d" => :mavericks
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





