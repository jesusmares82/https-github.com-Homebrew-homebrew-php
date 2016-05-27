require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pcntl < AbstractPhp55Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any_skip_relocation
    revision 8
    sha256 "295280901c766c49edfac031124f30dd7454579a01aaa29bfebf2983999373e4" => :el_capitan
    sha256 "5be149b10dd19e94b787bf8a7a1d1cd4c1e859a062ccccca5f9eb3075bdd0a32" => :yosemite
    sha256 "db91cae97a29fcf86aab197da9b0ff585c1b121ace69f711e708c16cd2e1b900" => :mavericks
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






