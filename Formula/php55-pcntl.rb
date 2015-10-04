require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pcntl < AbstractPhp55Extension
  init
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any_skip_relocation
    revision 2
    sha256 "b1a5f711d563cddb9fb2241cb31b8290db7a6e2a46e65b86352a9d8b754f9b7d" => :el_capitan
    sha256 "3533499f68c5221bd5e1cd030e6b864e2a8ab0e77b347b415a50f1cb6d4bfda1" => :yosemite
    sha256 "c8501fd8451a2e9988676ecd97448242f3304b65bfb28ad522ed902023eb1321" => :mavericks
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
