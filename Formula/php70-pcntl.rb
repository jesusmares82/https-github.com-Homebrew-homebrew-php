require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    revision 4
    sha256 "85694d4349b257165d7c98a2e5047b122fa72358c47e3ee84687ef0749dfc3ed" => :el_capitan
    sha256 "215fb3cf394041ef50ce5e3fa443954754d80fc185f5a19a65b10f8d4608844b" => :yosemite
    sha256 "46972f295fded1e220420887fe9828973d78cc5e7db4597645fb0aae0ce9f0df" => :mavericks
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
