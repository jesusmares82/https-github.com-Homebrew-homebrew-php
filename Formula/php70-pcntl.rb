require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    revision 14
    sha256 "01166e880a41067075a9a3321a8e2588779d83adf2c4fd1da3bd7cb1c401d86a" => :el_capitan
    sha256 "b6977d1346351e7d7d6ad3fa6be14860e3d760e0e67640023c35285be609920b" => :yosemite
    sha256 "361e43377a25306f7d2a05592bc3b3d3bbec0e36cf184b35983658e174654d28" => :mavericks
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







